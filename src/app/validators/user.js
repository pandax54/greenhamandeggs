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
            return res.render("user/register", {
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
            return res.render("user/index", fillAllFields)
        }

        const { id, password } = req.body

        if (!password) return res.render("user/index", {
            user: req.body,
            error: "Coloque sua senha para atualizar seu cadastro"
        })

        const user = await User.findOne({ where: { id } })

        // password descriptografar
        const passed = await compare(password, user.password)

        if (!passed) return res.render("user/index", {
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
            return res.render("user/register", fillAllFields)
        }

        // check if user exists [email, cpf_cnpj unique]
        let { email, password, passwordRepeat } = req.body


        // pesquisar no banco de dados
        const user = await User.findOne({
            where: { email }
        })

        // if (user) return res.send("User exists")
        // enviar a mensagem de erro e os dados do user pra preencher os campos e nao apagar tudo
        if (user) return res.render("user/register", {
            user: req.body,
            error: "Usuário já cadastrado"
        }) // renderizar novamente a página

        // check if password match
        if (password !== passwordRepeat) {
            return res.render("user/register", {
                user: req.body,
                error: 'Password Mismatch'
            })
            // res.send('Password Mismatch')
        }
        //return res.send("passed!")
        // caso todas as condições sejam validadas passar para o controller
        next()
    }

}