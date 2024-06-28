const express = require('express')
const { orderbook, logs } = require('./model')

const router = express.Router()

router.get('/otc/prices', async (req, res) => {
    res.status(200).json({
        status: 'success',
        data: {},
    })
})

router.get('/p2p/markets', async (req, res) => {
    res.status(200).json({
        status: 'success',
        data: {},
    })
})

router
    .route('/otc/orders')
    .get(async (req, res) => {
        const orders = orderbook.find(req.query)
        res.status(200).json({
            status: 'success',
            data: {
                orders,
            },
        })
    })
    .post(async (req, res) => {
        // const order = await orderbook.create(req.body)
        res.status(200).json({
            message: 'success',
            data: {
                // orderId: order._id,
                // status: order.status,
            },
        })
    })
    .delete(async (req, res) => {
        res.status(200).json({
            status: 'success',
            data: {},
        })
    })

router
    .route('/p2p/orders')
    .get(async (req, res) => {
        const orders = orderbook.find(req.query)
        res.status(200).json({
            status: 'success',
            data: {
                orders,
            },
        })
    })
    .post(async (req, res) => {
        const order = await orderbook.create(req.body)
        res.status(200).json({
            message: 'success',
            data: {
                orderId: order._id,
                status: order.status,
            },
        })
    })
    .delete(async (req, res) => {
        res.status(200).json({
            status: 'success',
            data: {},
        })
    })

router.get('/wallets', async (req, res) => {
    res.status(200).json({
        status: 'success',
        data: {},
    })
})

router.get('/transactions/history', async (req, res) => {
    res.status(200).json({
        status: 'success',
        data: {},
    })
})

router.post('/transactions', async (req, res) => {
    res.status(200).json({
        status: 'success',
        data: {},
    })
})

module.exports = router
