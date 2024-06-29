const express = require('express')
mongoose = require('mongoose')
const { Pool, Client } = require('pg')

const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'exchange',
    password: '#ihP4ever',
    port: '5432',
})

pool.connect().then(() => console.log('Postgre Connected'))

const { logs, orderbook } = require('./model')

const router = express.Router()

const catchAsync = (fn) => {
    return (req, res, next) => {
        fn(req, res, next).catch(next)
    }
}

router.get(
    '/otc/prices',
    catchAsync(async (req, res, next) => {
        const prices = await orderbook.aggregate([
            {
                $match: { orderType: 'otc' },
            },
            {
                $group: {
                    _id: { currency: '$currency', type: '$type' },
                    Prices: { $push: '$price' },
                },
            },
            {
                $sort: { '_id.currency': 1, '_id.type': 1 },
            },
        ])

        res.status(200).json({
            status: 'success',
            data: {
                prices,
            },
        })
    })
)

router.get(
    '/p2p/markets',
    catchAsync(async (req, res, next) => {
        const markets = await orderbook.aggregate([
            {
                $match: {
                    orderType: 'p2p',
                    //                , status: 'fill'// orders get traded and completed
                },
            },
            {
                $sort: { createdAt: 1 },
            },
            {
                $group: {
                    _id: { $toUpper: '$marketId' },
                    basePrice: { $last: '$price' },
                },
            },
        ])

        res.status(200).json({
            status: 'success',
            data: { markets },
        })
    })
)

router
    .route('/otc/orders')
    .get(
        catchAsync(async (req, res, next) => {
            const orders = await orderbook.find({
                ...req.query,
                orderType: 'otc',
            })
            res.status(200).json({
                status: 'success',
                data: { orders },
            })
        })
    )
    .post(
        catchAsync(async (req, res, next) => {
            const order = await orderbook.create({
                ...req.body,
                orderType: 'otc',
                status: 'Refusal to fill',
            })
            await logs.create({
                text: `Otc order with id: ${order._id} created.`,
            })
            res.status(200).json({
                message: 'success',
                data: {
                    orderId: order._id,
                    status: order.status,
                },
            })
        })
    )
    .delete(
        catchAsync(async (req, res, next) => {
            const order = await orderbook.findByIdAndUpdate(req.query.orderId, {
                status: 'cancelled',
            })
            await logs.create({
                text: `Otc order with id: ${order._id} cancelled.`,
            })
            res.status(200).json({
                status: 'success',
                data: {
                    orderId: order._id,
                    status: order.status,
                },
            })
        })
    )

router
    .route('/p2p/orders')
    .get(
        catchAsync(async (req, res, next) => {
            const orders = await orderbook.find({
                userId: req.query.userId,
                status: req.query.status,
                orderType: 'p2p',
            })
            res.status(200).json({
                status: 'success',
                data: {
                    orders,
                },
            })
        })
    )
    .post(
        catchAsync(async (req, res, next) => {
            const order = await orderbook.create({
                ...req.body,
                orderType: 'p2p',
                status: 'Refusal to fill',
            })
            await logs.create({
                text: `P2p order with id: ${order._id} created.`,
            })
            res.status(200).json({
                message: 'success',
                data: {
                    marketVolume: order.market_id,
                    orderId: order._id,
                    status: order.status,
                },
            })
        })
    )
    .delete(
        catchAsync(async (req, res, next) => {
            await orderbook.findByIdAndUpdate(req.query.orderId, {
                status: 'cancelled',
            })

            await logs.create({
                text: `P2p order with id: ${order._id} cancelled.`,
            })
            res.status(200).json({
                status: 'success',
                data: {
                    orderId: req.query.orderId,
                    status: 'cancelled',
                },
            })
        })
    )

router.get(
    '/wallets',
    catchAsync(async (req, res, next) => {
        const wallets = await pool.query(
            'SELECT wallet_id, owner_id, name, free_value FROM wallets JOIN cryptocurrencies ON wallets.crypto_id = cryptocurrencies.crypto_id WHERE owner_id = $1',
            [req.query.userId]
        )
        res.status(200).json({
            status: 'success',
            data: { array: wallets.rows },
        })
    })
)

router.get(
    '/transactions/history',
    catchAsync(async (req, res, next) => {
        const transactions = await pool.query(
            'WITH WALLETS_CRYPTO AS (SELECT OWNER_ID,WALLET_ID,NAME FROM WALLETS JOIN CRYPTOCURRENCIES ON WALLETS.CRYPTO_ID = CRYPTOCURRENCIES.CRYPTO_ID ) SELECT TRANSACTION_ID, FILL, DATE, SRC_WALLET.NAME , SRC_WALLET.OWNER_ID AS FROM_USER_ID, DST_WALLET.OWNER_ID AS TO_USER_ID  FROM TRANSACTIONS JOIN WALLETS_CRYPTO AS SRC_WALLET ON TRANSACTIONS.SOURCE_WALLET_ID = SRC_WALLET.WALLET_ID JOIN WALLETS_CRYPTO AS DST_WALLET ON TRANSACTIONS.DESTINATION_WALLET_ID = DST_WALLET.WALLET_ID WHERE SRC_WALLET.OWNER_ID = $1 OR DST_WALLET.OWNER_ID = $1 LIMIT $2 OFFSET $3',
            [req.query.userId, req.query.limit, req.query.offset]
        )
        res.status(200).json({
            status: 'success',
            data: { array: transactions.rows },
        })
    })
)

router.post(
    '/transactions',
    catchAsync(async (req, res, next) => {
        const src_wallet_id = await pool.query(
            'SELECT wallet_id, CRYPTOCURRENCIES.crypto_id FROm wallets JOIN CRYPTOCURRENCIES ON WALLETS.CRYPTO_ID = CRYPTOCURRENCIES.CRYPTO_ID WHERE name = $1 AND owner_id = $2',
            [req.body.currency, req.body.fromUserId]
        )
        const dst_wallet_id = await pool.query(
            'SELECT wallet_id, CRYPTOCURRENCIES.crypto_id FROm wallets JOIN CRYPTOCURRENCIES ON WALLETS.CRYPTO_ID = CRYPTOCURRENCIES.CRYPTO_ID WHERE name = $1 AND owner_id = $2',
            [req.body.currency, req.body.toUserId]
        )
        const transaction = await pool.query(
            'INSERT INTO transactions (source_wallet_id, destination_wallet_id, fill, wage,market_id) VALUES ($1, $2, $3, 5, $4) RETURNING TRANSACTION_ID, FILL',
            [
                src_wallet_id.rows[0].wallet_id,
                dst_wallet_id.rows[0].wallet_id,
                req.body.amount,
                src_wallet_id.rows[0].crypto_id,
            ]
        )
        const text = `${transaction.rows[0].fill} ${req.body.currency} transfered from userId: ${req.body.fromUserId} to userId: ${req.body.toUserId}`

        await logs.create({
            text,
        })

        res.status(200).json({
            status: 'success',
            data: {
                transaction_id: transaction.rows[0].transaction_id,
                text,
            },
        })
    })
)

module.exports = router
