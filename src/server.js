const express = require('express')
const nunjucks = require('nunjucks')
const methodOverride = require("method-override");
const cors = require("cors");

const app = express()

server.use(express.urlencoded({ extended: true })); server.use(express.urlencoded({ extended: true }));
app.use(express.static('public'))

app.set('view engine', 'njk')
app.set('views', './views')

nunjucks.configure("src/app/views", {
    express: app,
    autoescape: false,
    noCache: true
})

app.get("/", function (req, res) {
    res.render('index.njk')
})

const port = process.env.PORT || 5000
app.listen(port)
