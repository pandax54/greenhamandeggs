
const express = require('express');
const routes = express.Router();
const OrderController = require('../app/controllers/OrderController');

// middlewares
const { isLogged, onlyUsers } = require('../app/middlewares/session')

routes.get('/', onlyUsers, OrderController.index)

routes.get('/:id', onlyUsers, OrderController.show)


routes.post('/', onlyUsers, OrderController.post)


// routes.get('/orders', onlyUsers, (req, res) => {
//     res.render('orders/success')
// })
// routes.get('/orders/error', onlyUsers, (req, res) => {
//     res.render('orders/error')
// })


module.exports = routes 