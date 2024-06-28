const express = require('express')
const mongoose = require('mongoose')

mongoose
    .connect('mongodb://0.0.0.0:27017/exchange')
    .then(() => console.log('DB connected'))

const app = express()

app.use(express.json())

const router = require('./router')

app.use('/api', router)

app.use((err, req, res, next) => {
    console.log(err)
    err.statusCode = err.statusCode || 500
    err.status = err.status || 'error'

    res.status(err.statusCode).json({
        status: err.status,
        error: err,
        message: err.message,
        stack: err.stack,
    })
})

app.listen(2000, () => {
    console.log(`App running on port 2000 ...`)
})
