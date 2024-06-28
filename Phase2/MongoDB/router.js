const express = require('express')

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
        //req.query.userId
        res.status(200).json({
            status: 'success',
            data: {},
        })
    })
    .post(async (req, res) => {
        res.status(200).json({
            status: 'success',
            data: {},
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
        res.status(200).json({
            status: 'success',
            data: {},
        })
    })
    .post(async (req, res) => {
        res.status(200).json({
            status: 'success',
            data: {},
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
