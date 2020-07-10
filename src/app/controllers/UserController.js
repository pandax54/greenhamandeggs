const User = require('../models/User')

const LoadRecipeService = require('../services/LoadRecipeService')
const { hash } = require("bcryptjs");
const user = require('../validators/user')
const Recipe = require('../models/Recipe')



module.exports = {
    async index(req, res) {


        // pegar o id do usuário que está logado do session
        let users = await User.findAll()

        if (!users) return res.send("Users not found!")


        return res.render('users/index', { users })
    },
    registerForm(req, res) {
        return res.render('users/registration')
    },
    settings(req, res) {

        return res.render('users/account')
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
            let { name, email, instagram, twitter, about, password, passwordRepeat } = req.body

            //hash of password
            // promise
            password = await hash(password, 8)

            let profile_image = req.file.path


            const userId = await User.create({
                name,
                email,
                instagram,
                twitter,
                about,
                profile_image,
                password
            })

            // agora temos acesso ao session por meio do req
            req.session.userId = userId

            // console.log(req.file)
            // {
            //     fieldname: 'profile_image',
            //     originalname: 'Screen Shot 2020-07-05 at 12.55.20.png',
            //     encoding: '7bit',
            //     mimetype: 'image/png',
            //     destination: './public/images',
            //     filename: '1594340617728-Screen Shot 2020-07-05 at 12.55.20.png',
            //     path: 'public/images/1594340617728-Screen Shot 2020-07-05 at 12.55.20.png',
            //     size: 416871
            // }

            console.log(req.body)

            // return res.json(req.body)
            return res.redirect(`/users/user/${userId}`)

        } catch (error) {
            console.error(error)
        }
    },
    async edit(req, res) {

        let user = await User.findOne({ where: { id: req.session.userId } })

        if (!user) return res.send("User not found!")


        return res.render('users/settings', { user })
    },
    async put(req, res) {
        try {
            let { user } = req.session
            let { name, email, instagram, twitter, about, password, id } = req.body


            let results = await User.update(id, {
                name, email, instagram, twitter, about
            })

        } catch (err) {
            console.error(err)
            return res.render("users/settings", {
                user,
                error: "Algum erro aconteceu"
            })
        }


        return res.render(`users/user/${id}`, {
            user: req.body,
            success: "Conta atualizada com sucesso"
        })
    }
}
