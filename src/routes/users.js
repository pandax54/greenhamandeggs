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
routes.delete('/settings', UserValidator.delete, UserController.delete)


// SESSION PART 
const SessionValidator = require("../app/validators/session");

// Login - Logout
routes.get("/login", SessionController.loginForm);
routes.post("/login", SessionValidator.login, SessionController.login);
routes.post("/logout", onlyUsers, SessionController.logout);


//================ reset and recover passwords ==============

// reset password/forgot SessionController.js
//-- forgot password form - preencher para pedir novo password
routes.get('/forgot-password', SessionController.forgotForm)
//-- forgot password form executa a ação para envio do token
routes.post('/forgot-password', SessionValidator.forgot, SessionController.forgot)

//-- formulário para escolher novo password
routes.get('/password-reset', SessionController.resetForm)
//-- executar a ação do form
routes.post('/password-reset', SessionValidator.reset, SessionController.reset)


routes.get('/', onlyUsers, UserValidator.show, UserController.show)
routes.put('/', UserValidator.update, UserController.update)
routes.delete('/', UserController.delete)



// test lottie animation
routes.get('/orders/success', onlyUsers, (req, res) => {
    res.render('orders/success')
})
routes.get('/orders/error', onlyUsers, (req, res) => {
    res.render('orders/error')
})



module.exports = routes  