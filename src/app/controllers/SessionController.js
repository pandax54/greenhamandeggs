const crypto = require("crypto")
const User = require("../models/User")
const mailer = require("../../lib/mailer")
const { hash } = require("bcryptjs");
const { has } = require("browser-sync");

module.exports = {
    async loginForm(req, res) {
        return res.render("session/login")
    },
    async login(req, res) {
        // verificar se o usuárop está cadastrado
        // verificar se o password bate
        // essas etapas estão no validator -> session.js

        // depois colocar o usuário no req.session
        req.session.userId = req.user.id
        req.session.user = req.user


        return res.redirect("/users")
    },
    async logout(req, res) {
        req.session.destroy()
        return res.redirect("/")
    },
    async forgotForm(req, res) {
        return res.render("session/forgot-password")
    },
    async forgot(req, res) {
        // enviado pelo validator
        const user = req.user

        try {

            // criarum token para esse usuário
            const token = crypto.randomBytes(20).toString("hex")

            // criar uma expiração
            let now = new Date()
            now = now.setHours(now.getHours() + 1) // validade de uma hora


            await User.update(user.id, {
                reset_token: token,
                reset_token_expires: now
            })

            // enviar um email com um link de recuperação de senha
            await mailer.sendMail({
                to: user.email,
                from: "no-replay@launchstore.com.br",
                subject: "Password Recovery",
                html: `
                <h2>Forgot you password?</h2>
                <p>Click in this link and recover your password.</p>
                <p><a href="http://localhost:3000/users/password-reset?token=${token}" target="_blank">Password Recovery</a></p>
                `
            })

            // avisar o usuário que enviamos o email
            return res.render("session/forgot-password", {
                success: "Message sent successfully! We will send you an Email containing a link to reset your password!"
            })

        } catch (error) {
            console.error(error)
            return res.render("session/forgot-password", {
                error: "Error. Try again!"
            })
        }

    },
    async resetForm(req, res) {
        // pegar o token que veio na url
        return res.render("session/password-reset", { token: req.query.token })
    },
    async reset(req, res) {

        const user = req.user
        const { password, token } = req.body

        try {

            // procurar usuário
            // ver se a senha corresponde com o repeat
            // verificar se o token corresponde com o que tem na database
            // verificar se o token nao expirou
            // VALIDATOR -> session.js

            // criar novo hash de senha
            const newPassword = await hash(password, 8)

            // atualiza o usuário
            await User.update(user.id, {
                password: newPassword,
                reset_token: "",
                reset_token_expires: ""
            })

            // avisa o usuário que ele tem uma nova senha
            return res.render("session/login", {
                user: req.body,
                success: "Password updated!"
            })

        } catch (error) {
            console.error(error)
            res.render("session/password-reset", {
                user: req.body,
                token,
                error: "Error, please try again!"
            })
        }
    },
}