const Product = require('../models/Product');
const { formatPrice, date, formatUSD } = require('../../lib/utils');
const ProductImage = require('../models/ProductImage');
const LoadProductService = require('../services/LoadProductService');
const User = require('../models/User');
const mailer = require('../../lib/mailer');
const Order = require('../models/Order');
const LoadOrder = require('../services/LoadOrderService')
const Invoice = require('../models/Invoice')
const LoadInvoiceService = require('../services/LoadInvoiceService')

const Cart = require("../../lib/cart")

// const email = (product, buyer, quantity, total) => `
//     <h2>${'Green Eggs and Ham Store'}</h2>
//     <p>Você tem um novo pedido de compra do seu produto</p>
//     <p>Produto: ${product.name} </p>
//     <p>Preço: ${product.formattedPrice} </p>
//     <p>Unidades: ${quantity} </p>
//     <p>Total order: ${total} </p>
//     <p></br></br></p>
//     <h3>Dados do comprador</h3>
//     <p>Nome: ${buyer.name}</p>
//     <p>Email: ${buyer.email}</p>
//     <p>Endereço: ${buyer.address}</p>
//     <p>Cep: ${buyer.cep}</p>
//     <p></br></br></p>
//     <p><strong>Entre em contato com o comprador para finalizar a venda!</strong></p>
//     <p></br></br></p>
//     <p>Atenciosamente, equipe Launchstore</p>
// `



module.exports = {
    async index(req, res) {

        const invoices = await LoadInvoiceService.load('invoices', { where: { user_id: req.session.userId } })

        console.log(invoices)

        return res.render("orders/index", { invoices })

    },
    async post(req, res) {

        try {
            // pegar todos os produtos do carrinho
            const cart = Cart.init(req.session.cart)
            const user_id = req.session.userId

            const filteredItems = cart.items.filter(item => item.product.user_id != req.session.userId)

            let ordersIds = []

            // criar o pedido
            const createOrdersPromise = filteredItems.map(async item => {
                let { product, price: total, quantity, formattedPrice } = item // o price é o total, o preço individual está no product
                const { price, id: product_id } = product
                const status = "open"

                const order = await Order.create({
                    user_id,
                    product_id,
                    price,
                    quantity,
                    total,
                    status
                })

                return order
            })

            const updateProdutcsPromise = filteredItems.map(async item => {
                let { product, price: total, quantity: unitsSold, formattedPrice } = item // o price é o total, o preço individual está no product
                const { price, id: product_id, quantity: stock } = product
                const status = "open"

                console.log("minus", stock - unitsSold)

                const result = await Product.update(product_id, {
                    quantity: (stock - unitsSold)
                })


                return result
            })

            // limpar o carrinho após a compra
            delete req.session.cart
            Cart.init()

            await Promise.all(updateProdutcsPromise)

            ordersIds = await Promise.all(createOrdersPromise)

            await Invoice.create({
                orders_id: `{ ${ordersIds.join(',')}}`,
                user_id
            })

            console.log("the orders id", ordersIds)

            return res.render("orders/success")
            // notificar o usuário com alguma mensagem de sucesso

        } catch (error) {
            return res.render("orders/error")
        }

    },
    async show(req, res) {
        const { id } = req.params

        const invoice = await LoadInvoiceService.load('invoice', { where: { id } })

        console.log(invoice)

        return res.render("orders/details", { invoice })
    },
    async status(req, res) {

        try {
            const { id, action } = req.params

            const acceptedActions = ["cancel", "close"]

            if (!acceptedActions.includes(action)) return res.send("can't do this action")

            const order = await LoadOrder.load('order', { where: { id } })
            if (!order) return res.send("Can't find this order")

            if (order.status != "open") return res.send("Other actions are not possible")


            const allStatus = {
                "cancel": "canceled",
                "close": "completed"
            }

            order.status = allStatus[action]

            await Order.update(id, {
                status: order.status
            })

            return res.redirect(`/orders`)

        } catch (error) {
            console.error(error)
        }

    }

}