const express = require('express')
mongoose = require('mongoose')

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
        const sellOrders = await orderbook.aggregate([
            {
                $match: { orderType: 'otc', type: 'sell' },
            },
            {
                $group: {
                    _id: { $toUpper: '$currency' },
                    sellPrice: { $avg: '$price' },
                },
            },
        ])

        const buyOrders = await orderbook.aggregate([
            {
                $match: { orderType: 'otc', type: 'buy' },
            },
            {
                $group: {
                    _id: { $toUpper: '$currency' },
                    buyPrice: { $avg: '$price' },
                },
            },
        ])

        res.status(200).json({
            status: 'success',
            data: {
                sellOrders,
                buyOrders,
            },
        })
    })
)

router.get(
    '/p2p/markets',
    catchAsync(async (req, res, next) => {
        const markets = await orderbook.aggregate([
            {
                $match: { orderType: 'p2p' },
            },
            {
                $group: {
                    _id: { $toUpper: '$marketId' },
                    basePrice: { $avg: '$price' },
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
                status: 'Refusal to fill',
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
            await orderbook.findByIdAndUpdate(req.query.orderId, {
                status: 'cancelled',
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
            await orderbook.findByIdAndUpdate(req.query.orderId, {
                status: 'cancelled',
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
        res.status(200).json({
            status: 'success',
            data: {},
        })
    })
)

router.get(
    '/transactions/history',
    catchAsync(async (req, res, next) => {
        res.status(200).json({
            status: 'success',
            data: {},
        })
    })
)

router.post(
    '/transactions',
    catchAsync(async (req, res, next) => {
        res.status(200).json({
            status: 'success',
            data: {},
        })
    })
)

module.exports = router
