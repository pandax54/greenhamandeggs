const express = require('express')
const routes = express.Router();

const HomeController = require('../app/controllers/HomeController');

const users = require('./users');
routes.use('/users', users)

const recipes = require("./recipes")
routes.use("/recipes", recipes)



// Home
routes.get('/', HomeController.index)



module.exports = routes