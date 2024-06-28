const express = require('express')
const router = require('./router')

const app = express()

app.use(express.json())

app.use('/api', router)

app.listen(2000, () => {
    console.log(`App running on port 2000 ...`)
})
