// ------------------
const express = require('express')
const nunjucks = require('nunjucks')

const session = require('./config/session');
const routes = require('./routes') // NEW

const methodOverride = require("method-override");

const server = express()
// const videos = require("./data")



server.use(session)

// com o res.locals eu posso criar qualquer variável
// criaremos uma chamada session
// agora nosso req.session está disponível em toda nossa aplicação
server.use((req, res, next) => {
    res.locals.session = req.session
    next()
})

server.use(express.urlencoded({ extended: true })) // must be first otherwise it wont work!!!

server.use(express.static('public'))
server.use(methodOverride('_method'))
server.use(routes) // NEW


server.set("view engine", "njk")


nunjucks.configure("src/app/views", {
    express: server,
    autoescape: false,
    noCache: true
})


server.get("/", function (req, res) {
    // res.render('index.njk')
    return res.send("It's working")
})

server.listen(8000, function () {
    console.log("server is running")
})