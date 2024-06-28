const express = require('express')
const mongoose = require('mongoose')

mongoose
    .connect('mongodb://0.0.0.0:27017/exchange')
    .then(() => console.log('DB connected'))

const router = require('./router')

const app = express()

app.use(express.json())

app.use('/api', router)

app.listen(2000, () => {
    console.log(`App running on port 2000 ...`)
})
