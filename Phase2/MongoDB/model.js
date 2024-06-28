mongoose = require('mongoose')

const orderbookSchema = new mongoose.Schema({
    userId: Number,
    ordertype: String,
    marketId: String,
    currency: String,
    amount: Number,
    price: Number,
    type: String,
    status: String,
})

const orderbook = mongoose.model('orderbook', orderbookSchema)

module.exports = orderbook

const logsSchema = new mongoose.Schema({
    text: String,
})

const logs = mongoose.model('logs', logsSchema)

module.exports = logs
