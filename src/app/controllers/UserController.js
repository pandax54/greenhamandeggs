const User = require('../models/User')

// const LoadService = require('../services/LoadProductService');
// const { hash } = require("bcryptjs");

const user = require('../validators/user')



module.exports = {
    async index(req, res) {

        // pegar o id do usuário que está logado do session
        //let product = await Product.find(id)
        let users = await User.findAll()

        if (!users) return res.send("Users not found!")


        return res.render('users/index', { users })
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
    }
}
