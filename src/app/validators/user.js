const User = require('../models/User')
const { update } = require('../controllers/UserController')
const { compare } = require("bcryptjs")


function checkAllField(body) {
    // check if has all fields
    const keys = Object.keys(body)

    for (key of keys) {
        if (body[key] == "") {
            return {
                user: body,
                error: "Please fill all the fields"
            }
        }
    }
}

module.exports = {
    async show(req, res, next) {
        const { userId: id } = req.session

        const user = await User.findOne({ where: { id } })

        if (!user) {
            return res.render("session/login", {
                error: "Usuário não encontrado!"
            })
        }

        req.user = user

        next()
    },
    async update(req, res, next) {
        // check all fields
        const fillAllFields = checkAllField(req.body)
        if (fillAllFields) {
            return res.render("users/registration", fillAllFields)
        }

        const { id, password } = req.body

        if (!password) return res.render("users/registration", {
            user: req.body,
            error: "Coloque sua senha para atualizar seu cadastro"
        })

        const user = await User.findOne({ where: { id } })

        // password descriptografar
        const passed = await compare(password, user.password)

        if (!passed) return res.render("users/registration", {
            user: req.body,
            error: "Senha incorreta"
        })


        req.user = user
        next()

    },
    async post(req, res, next) {

        // check all fields
        const fillAllFields = checkAllField(req.body)
        if (fillAllFields) {
            return res.render("users/registration", fillAllFields)
        }

        console.log("filled all fields")

        // check if user exists [email unique]
        let { email, password, passwordRepeat } = req.body


        // pesquisar no banco de dados
        const user = await User.findOne({
            where: { email }
        })


        // enviar a mensagem de erro e os dados do user pra preencher os campos e nao apagar tudo
        // renderizar novamente a página
        if (user) return res.render("users/registration", {
            user: req.body,
            error: "Usuário já cadastrado"
        })

        // check if password match
        if (password !== passwordRepeat) {
            return res.render("users/registration", {
                user: req.body,
                error: 'Password Mismatch'
            })
            // res.send('Password Mismatch')
        }
        // if (!req.file) {
        //     return res.render("users/registration", {
        //         user: req.body,
        //         error: 'Please, send at least one image'
        //     })
        // }
        //return res.send("passed!")
        // caso todas as condições sejam validadas passar para o controller
        next()
    }

}