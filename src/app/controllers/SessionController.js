// const crypto = require("crypto")
// const User = require("../models/User")
// const mailer = require("../../lib/mailer")
// const { hash } = require("bcryptjs");
// const { has } = require("browser-sync");

// module.exports = {
//     async loginForm(req, res) {
//         return res.render("session/login")
//     },
//     async login(req, res) {
//         // verificar se o usuárop está cadastrado
//         // verificar se o password bate
//         // essas etapas estão no validator -> session.js

//         // depois colocar o usuário no req.session
//         req.session.userId = req.user.id


//         return res.redirect("/users")
//     },
//     async logout(req, res) {
//         req.session.destroy()
//         return res.redirect("/")
//     },
//     async forgotForm(req, res) {
//         return res.render("session/forgot-password")
//     },
//     async forgot(req, res) {
//         // enviado pelo validator
//         const user = req.user

//         try {

//             // criarum token para esse usuário
//             const token = crypto.randomBytes(20).toString("hex")

//             // criar uma expiração
//             let now = new Date()
//             now = now.setHours(now.getHours() + 1) // validade de uma hora


//             await User.update(user.id, {
//                 reset_token: token,
//                 reset_token_expires: now
//             })

//             // enviar um email com um link de recuperação de senha
//             await mailer.sendMail({
//                 to: user.email,
//                 from: "no-replay@launchstore.com.br",
//                 subject: "Recuperação de senha",
//                 html: `
//             <h2>Esqueceu da sua senha?</h2>
//             <p>Clique no link abaixo para recuperar sua senha.</p>
//             <p><a href="http://localhost:3000/users/password-reset?token=${token}" target="_blank">Recuperar senha</a></p>
//             `
//             })

//             // avisar o usuário que enviamos o email
//             return res.render("session/forgot-password", {
//                 success: "Mensagem enviada com sucesso! Verifique seu email para resetar sua senha"
//             })

//         } catch (error) {
//             console.error(error)
//             return res.render("session/forgot-password", {
//                 error: "Erro inesperado. Tente novamente!"
//             })
//         }

//     },
//     async resetForm(req, res) {
//         // pegar o token que veio na url
//         return res.render("session/password-reset", { token: req.query.token })
//     },
//     async reset(req, res) {

//         const user = req.user
//         const { password, token } = req.body

//         try {

//             // procurar usuário
//             // ver se a senha corresponde com o repeat
//             // verificar se o token corresponde com o que tem na database
//             // verificar se o token nao expirou
//             // VALIDATOR -> session.js

//             // criar novo hash de senha
//             const newPassword = await hash(password, 8)

//             // atualiza o usuário
//             await User.update(user.id, {
//                 password: newPassword,
//                 reset_token: "",
//                 reset_token_expires: ""
//             })

//             // avisa o usuário que ele tem uma nova senha
//             return res.render("session/login", {
//                 user: req.body,
//                 success: "Senha atualizada! Faça o seu login"
//             })

//         } catch (error) {
//             console.error(error)
//             res.render("session/password-reset", {
//                 user: req.body,
//                 token,
//                 error: "Erro inesperado, tente novamente!"
//             })
//         }
//     },
// }