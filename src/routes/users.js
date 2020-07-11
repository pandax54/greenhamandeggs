const express = require('express');
const routes = express.Router();
const SessionController = require('../app/controllers/SessionController')
const UserController = require("../app/controllers/UserController");
const UserValidator = require('../app/validators/user')

const { isLogged, onlyUsers } = require("../app/middlewares/session");
const multer = require('../app/middlewares/multer')
// var multer = require('multer')
// var upload = multer({ dest: 'uploads/' })

routes.get("/", UserController.index)

routes.get('/user/:id', UserController.show)

routes.get('/register', UserController.registerForm)
// form para criar o usuário 
// multer.array("photos", 6)
routes.post('/register', multer.single("profile_image"), UserValidator.post, UserController.post)
// criando usuário


// update user
routes.get('/settings', UserController.edit)
routes.put('/settings', onlyUsers, multer.single("profile_image"), UserValidator.update, UserController.put)
routes.delete('/settings', UserController.delete)


// SESSION PART 
const SessionValidator = require("../app/validators/session");

// Login - Logout
routes.get("/login", SessionController.loginForm);
routes.post("/login", SessionValidator.login, SessionController.login);
routes.post("/logout", onlyUsers, SessionController.logout);





module.exports = routes  