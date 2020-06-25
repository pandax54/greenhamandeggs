const express = require('express')
// const HomeController = require('../app/controllers/HomeController');
const routes = express.Router();

const users = require('./users');
routes.use('/users', users)



// alias
routes.get('/', function (req, res) {
    return res.send("It's working")
})



module.exports = routes