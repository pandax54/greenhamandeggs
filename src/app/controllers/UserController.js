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

        users = users.map(user => ({
            ...user,
            profileImage: user.profile_image.replace(/(.*)(\/images.*)/, '$2')
        }))


        return res.render('users/index', { users })
    },
    registerForm(req, res) {
        return res.render('users/registration')
    },
    settings(req, res) {

        const { user } = req.session

        return res.render('users/settings', { user })
        // return res.render('users/account')
    },
    async show(req, res) {

        let user = await User.findOne({ where: { id: req.params.id } })

        if (!user) return res.send("User not found!")

        user.profileImage = user.profile_image.replace(/(.*)(\/images.*)/, '$2')


        let recipes = await LoadRecipeService.load('recipes', { where: { user_id: user.id } })

        if (recipes) {
            recipes = recipes.map(recipe => ({
                ...recipe,
                img: recipe.files[0].path.replace(/(.*)(\/images.*)/, '$2')
            }))
            user.recipes = recipes
        }

        // user.profileImage = user.profile_image.replace(/(.*)(\/images.*)/, '$2')
        console.log("this is the recipe", user.recipes[0])


        // return res.json(user)
        return res.render('users/profile', { user })
    },
    async post(req, res) {

        try {
            let { name, email, instagram, twitter, about, password, passwordRepeat } = req.body

            //hash of password
            // promise
            password = await hash(password, 8)


            const userId = await User.create({
                name,
                email,
                instagram,
                twitter,
                about: String(about).replace("'", "''"),
                profile_image: req.file.path,
                password
            })
            // profile_image: req.file.path.replace(/(.*)(\/images.*)/, '$2')
            // .replace(/(\d{3})(\d)/, '$1.$2')

            // agora temos acesso ao session por meio do req
            req.session.userId = userId
            console.log(userId)
            console.log(req.file)
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

            return res.redirect('/users')
            // return res.redirect(`/users/user/${userId}`)

        } catch (error) {
            console.error(error)
        }
    },
    async edit(req, res) {

        let user = await User.findOne({ where: { id: req.session.userId } })

        if (!user) return res.send("User not found!")

        user.profileImage = user.profile_image.replace(/(.*)(\/images.*)/, '$2')


        return res.render('users/settings', { user })
    },
    async put(req, res) {
        try {
            let { user } = req.session
            let { name, email, instagram, twitter, about, password, id } = req.body


            let results = await User.update(id, {
                name, email, instagram, twitter, about
            })

            updateUser = await User.findOne({ where: { id } })

            req.session.user = updateUser

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
    },
    async delete(req, res) {
        try {

            const user = await User.findOne({ where: { id: req.body.id } })
            const recipes = await Recipe.findAll({ where: { user_id: req.body.id } })


            // dos produtos, pegar todas as imagens
            const allFilesPromise = recipes.map(recipe =>
                Recipe.files(recipe.id))

            let promiseResults = await Promise.all(allFilesPromise)

            let profileImage = user.profile_image

            // rodar a remoção do usuário
            await User.delete(req.body.id)
            req.session.destroy()

            // remover as imagens da pasta public
            promiseResults.map(files => {
                files.map(file => {
                    try {
                        unlinkSync(file.path)
                    } catch (err) {
                        console.error(err)
                    }

                })
            })

            unlinkSync(profileImage)

            return res.render("session/login", {
                success: "Conta deletada com sucesso!"
            })

        } catch (error) {
            console.error(error)
            return res.render("users/settings", {
                user: req.body,
                error: "Erro ao tentar deletar sua conta"
            })
        }
    },
}
