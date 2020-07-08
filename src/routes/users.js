const express = require('express');
const routes = express.Router();
const SessionController = require('../app/controllers/SessionController')
const UserController = require("../app/controllers/UserController");

const { isLogged, onlyUsers } = require("../app/middlewares/session");


routes.get("/", UserController.index)
// routes.post('/register', UserValidator.post, UserController.post)
routes.get('/user/:id', UserController.show)

routes.get('/register', UserController.registerForm)
// routes.post('/register', UserController.post)

// SESSION PART 
const SessionValidator = require("../app/validators/session");

// Login - Logout
routes.get("/login", SessionController.loginForm);
routes.post("/login", SessionValidator.login, SessionController.login);
routes.post("/logout", onlyUsers, SessionController.logout);

module.exports = routes 