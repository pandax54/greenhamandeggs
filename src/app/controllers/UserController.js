const User = require('../models/User')

const LoadRecipeService = require('../services/LoadRecipeService')
// const { hash } = require("bcryptjs");
const user = require('../validators/user')
const Recipe = require('../models/Recipe')



module.exports = {
    async index(req, res) {

        // pegar o id do usuário que está logado do session
        //let product = await Product.find(id)
        let users = await User.findAll()

        if (!users) return res.send("Users not found!")


        return res.render('users/index', { users })
    },
    registerForm(req, res) {
        return res.render('users/registration')
    },
    async show(req, res) {

        let user = await User.findOne({ where: { id: req.params.id } })

        if (!user) return res.send("User not found!")

        let recipes = await LoadRecipeService.load('recipes', { where: { user_id: user.id } })

        if (recipes) {
            user.recipes = recipes
        }


        // return res.json(user)
        return res.render('users/profile', { user })
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
