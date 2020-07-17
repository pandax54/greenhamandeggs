const express = require('express');
const routes = express.Router();

const CartController = require('../app/controllers/CartController');

// validators
// const UserValidator = require('../app/validator/user');
// const SessionValidator = require("../app/validator/session");

// middlewares
const { isLogged, onlyUsers } = require('../app/middlewares/session')


routes.get('/', CartController.index)

routes.post('/:id/add-one', CartController.addOne)

routes.post('/:id/remove-one', CartController.removeOne)

routes.post('/:id/delete', CartController.delete)

module.exports = routes 