const Product = require('../models/Product');
const { formatPrice, date } = require('../../lib/utils');
const ProductImage = require('../models/ProductImage');
const LoadProductService = require('../services/LoadProductService');
const User = require('../models/User');
const mailer = require('../../lib/mailer');
const Order = require('../models/Order');
const LoadOrder = require('../services/LoadOrderService')

const Cart = require("../../lib/cart")

const email = (product, buyer, quantity, total) => `
    <h2>${'Green Eggs and Ham Store'}</h2>
    <p>Você tem um novo pedido de compra do seu produto</p>
    <p>Produto: ${product.name} </p>
    <p>Preço: ${product.formattedPrice} </p>
    <p>Unidades: ${quantity} </p>
    <p>Total order: ${total} </p>
    <p></br></br></p>
    <h3>Dados do comprador</h3>
    <p>Nome: ${buyer.name}</p>
    <p>Email: ${buyer.email}</p>
    <p>Endereço: ${buyer.address}</p>
    <p>Cep: ${buyer.cep}</p>
    <p></br></br></p>
    <p><strong>Entre em contato com o comprador para finalizar a venda!</strong></p>
    <p></br></br></p>
    <p>Atenciosamente, equipe Launchstore</p>
`



module.exports = {
    async index(req, res) {

        const allOrders = await Order.findAll({
            where: { user_id: req.session.userId }
        })

        const getOrderPromise = allOrders.map(async order => {
            console.log("the order", order)
            // detalhes do produto
            order.product = await LoadProductService.load("products", {
                where: { "products.id": order.product_id }
            })

            // detalhes do comprador
            order.buyer = await User.findOne({
                where: { id: order.user_id }
            })

            // formatação de preços
            order.formattedPrice = formatBRL(order.price)
            order.formattedTotal = formatBRL(order.total)

            // formatação do status ("open")
            const allStatus = {
                open: "Aberto",
                sold: "Vendido",
                canceled: "Cancelado"
            }
            order.formattedStatus = allStatus[order.status]


            return order
        })

        const orders = await Promise.all(getOrderPromise)

        console.log(orders)

        return res.render("orders/index", { orders })

    },
    async post(req, res) {

        try {
            // pegar todos os produtos do carrinho
            const cart = Cart.init(req.session.cart)
            const user_id = req.session.userId

            const filteredItems = cart.items.filter(item => item.product.user_id != req.session.userId)

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


                // pegar os dados do produto
                product = await LoadService.load('product', { where: { id: product_id } })

                // os dados do comprador
                const buyer = await User.findOne({ where: { id: user_id } })
                // enviar email com dados da compra para o vendedor 
                await mailer.sendMail({
                    to: seller.email,
                    from: 'no-replay@greeneggsandham.com.br',
                    subject: 'Order Receipt',
                    html: email(product, buyer, quantity, formattedPrice),

                })

                return order
            })

            // limpar o carrinho após a compra
            delete req.session.cart
            Cart.init()

            await Promise.all(createOrdersPromise)

            return res.render("orders/success")
            // notificar o usuário com alguma mensagem de sucesso

        } catch (error) {
            return res.render("orders/error")
        }

    },
    async show(req, res) {
        const { id } = req.params

        const order = await LoadOrder.load('order', { where: { id } })

        order.cardTitle = `Pedido nº ${order.id}`

        return res.render("orders/details", { order })
    },
    // async status(req, res) {

    //     try {
    //         const { id, action } = req.params

    //         const acceptedActions = ["cancel", "close"]

    //         if (!acceptedActions.includes(action)) return res.send("can't do this action")

    //         const order = await LoadOrder.load('order', { where: { id } })
    //         if (!order) return res.send("Can't find this order")

    //         if (order.status != "open") return res.send("Other actions are not possible")


    //         const allStatus = {
    //             "cancel": "canceled",
    //             "close": "sold"
    //         }

    //         order.status = allStatus[action]

    //         await Order.update(id, {
    //             status: order.status
    //         })

    //         return res.redirect('/orders/sales')

    //     } catch (error) {
    //         console.error(error)
    //     }

    // }

}