const express = require('express');
const routes = express.Router();

const UserController = require("../app/controllers/UserController");

routes.get("/", UserController.index)


routes.get('/register', UserController.registerForm)
// routes.post('/register', UserValidator.post, UserController.post)
routes.get('/user/:id', UserController.show)

module.exports = routes 