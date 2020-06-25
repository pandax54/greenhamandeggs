const User = require('../models/User')

// const LoadService = require('../services/LoadProductService');
// const { hash } = require("bcryptjs");

const user = require('../validators/user')



module.exports = {
    async index(req, res) {

        // pegar o id do usuário que está logado do session

        return res.send("user working")
    },
    async post(req, res) {

        try {
            let { name, email, password } = req.body

            //hash of password
            // promise
            password = await hash(password, 8)

            const userId = await User.create({
                name,
                email,
                password,

            })

            // agora temos acesso ao session por meio do req
            req.session.userId = userId

            //return res.redirect('/users')
            return res.redirect('/users')

        } catch (error) {
            console.error(error)
        }
    },
    async show(req, res) {

        try {
            // a parte de validação foi removida e colocar em validators -> user.js
            const { user } = req

            return res.render("user/index", { user })

        } catch (error) {
            console.error(error)
        }
    },
}