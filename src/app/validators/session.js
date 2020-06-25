const User = require('../models/User')
const { compare } = require("bcryptjs")
const { forgot } = require('../controllers/SessionController')
const { date } = require('../../lib/utils')


module.exports = {
    async login(req, res, next) {

        const { email, password } = req.body

        // achar o user pelo email 
        const user = await User.findOne({ where: { email } })

        if (!user) {
            return res.render("session/login", {
                user: req.body,
                error: "Email não cadastrado!"
            })
        }

        const passed = await compare(password, user.password)

        if (!passed) return res.render("session/login", {
            user: req.body,
            error: "Senha incorreta"
        })


        req.user = user
        next()
    },
    async forgot(req, res, next) {
        const { email } = req.body

        try {

            let user = await User.findOne({ where: { email } })
            if (!user) {
                return res.render("session/forgot-password", {
                    user: req.body,
                    error: "Email não cadastrado!"
                })
            }

            req.user = user

            next()

        } catch (error) {
            console.error(error)
        }

    },
    async reset(req, res, next) {
        // procurar usuário
        const { email, passwordRepeat, password, token } = req.body

        try {
            let user = await User.findOne({ where: { email } })
            if (!user) {
                return res.render("session/password-reset", {
                    user: req.body,
                    token,
                    error: "Usuário não cadastrado!"
                })


            }

            // check if password match
            if (password !== passwordRepeat) {
                return res.render("session/password-reset", {
                    user: req.body,
                    token,
                    error: 'Password Mismatch'
                })
            }

            // verificar se o token corresponde com o que tem na database
            if (token != user.reset_token) {
                return res.render("session/password-reset", {
                    user: req.body,
                    token,
                    error: "Token inválido! Solicite uma nova recuperação de senha"
                })
            }

            // verificar se o token nao expirou
            let now = new Date()
            now = now.setHours(now.getHours())
            if (now > user.reset_token_expires) {
                return res.render("session/password-reset", {
                    user: req.body,
                    token,
                    error: "Token inválido! Expiração do token"
                })
            }

            req.user = user

            next()

        } catch (error) {
            console.error(error)

        }

    }
}