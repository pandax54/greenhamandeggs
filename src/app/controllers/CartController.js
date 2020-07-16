
const Cart = require('../../lib/cart');
const Product = require('../models/Product');
const LoadProductService = require('../services/LoadProductService');

module.exports = {

    async index(req, res) {

        try {

            let { cart } = req.session
            // https://flaviocopes.com/express-sessions/

            console.log("this is req.session: ", req.session)

            // gerenciador de carrinho que criamos na lib
            cart = Cart.init(cart)
            // const product = await LoadProductService.load('product', { where: { id: 1 } })
            // const product2 = await LoadProductService.load('product', { where: { id: 2 } })
            // cart.addOne(product)
            // cart.addOne(product2)

            return res.render("cart/index", { cart })

        } catch (error) {
            console.error(error)
        }

    },
    async addOne(req, res) {
        //pegar o id do produto
        const { id } = req.params

        // pegar o produto
        const product = await LoadProductService.load('product', { where: { id } })


        // pegar o carrinho da sessão
        let { cart } = req.session

        // adicionar o produto ao carrinho (usando nosso gerenciador de carrinho)
        cart = Cart.init(cart).addOne(product)

        // atualizar o carrinho da sessão
        req.session.cart = cart
        // redirecionar o usuário para a tela do carrinho
        return res.redirect("/cart")

    },
    removeOne(req, res) {
        const { id } = req.params

        let { cart } = req.session

        if (!cart) return res.redirect('/cart')

        cart = Cart.init(cart).removeOne(id)

        req.session.cart = cart

        return res.redirect("/cart")
    },
    delete(req, res) {
        const { id } = req.params

        let { cart } = req.session

        if (!cart) return res.redirect('/cart')

        cart = Cart.init(cart).delete(id)

        req.session.cart = cart

        return res.redirect("/cart")
    }

}