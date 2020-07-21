const express = require('express')
const routes = express.Router();

const HomeController = require('../app/controllers/HomeController');

const users = require('./users');
routes.use('/users', users)

const recipes = require("./recipes")
routes.use("/recipes", recipes)

const products = require('./products')
routes.use("/products", products)

const admin = require('./admin')
routes.use('/admin', admin)

const cart = require('./cart')
routes.use('/cart', cart)

const order = require('./order')
routes.use('/orders', order)



// Home
routes.get('/', HomeController.index)
routes.get('/about', HomeController.about)




module.exports = routes