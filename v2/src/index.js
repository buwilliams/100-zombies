const express = require('express')
const app = express()
const path = require('path')

app.use(express.static(path.join(__dirname, 'public')))

app.use('/', express.static(path.join(__dirname, 'public', 'index.html')))

app.listen(3000, function () {
  console.log(`100 Zombie's on 3000!`)
})
