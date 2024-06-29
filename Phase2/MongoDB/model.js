mongoose = require('mongoose')

const orderbookSchema = new mongoose.Schema({
    userId: Number,
    orderType: String,
    marketId: String,
    currency: String,
    amount: Number,
    price: { type: Number, index: true },
    type: String,
    status: String,
    createdAt: {
        type: Date,
        default: Date.now,
    },
})

const orderbook = mongoose.model('orderbook', orderbookSchema)

const logsSchema = new mongoose.Schema({
    text: String,
})

const logs = mongoose.model('logs', logsSchema)

module.exports = { logs, orderbook }
