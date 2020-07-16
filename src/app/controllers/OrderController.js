const Product = require('../models/Product');
const { formatPrice, date } = require('../../lib/utils');
const ProductImage = require('../models/ProductImage');
const LoadProductService = require('../services/LoadProductService');
const User = require('../models/User');
const mailer = require('../../lib/mailer');
const Order = require('../models/Order');
const LoadOrder = require('../services/LoadOrderService')

const Cart = require("../../lib/cart")

const email = (seller, product, buyer, quantity, total) => `
    <h2>${seller.name}</h2>
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
            where: { buyer_id: req.session.userId }
        })

        const getOrderPromise = allOrders.map(async order => {
            //console.log(order)
            // detalhes do produto
            order.product = await LoadProductService.load("productWithDeleted", {
                where: { id: order.product_id }
            })
            console.log(order.product)
            // detalhes do comprador
            order.buyer = await User.findOne({
                where: { id: order.buyer_id }
            })
            // detalhes do vendedor
            order.seller = await User.findOne({
                where: { id: order.seller_id }
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
            // formatação de atualização em...
            order.updatedAt = date(order.updated_at)

            order.formattedUpdated_at = `${order.formattedStatus} em ${order.updatedAt.day}/${order.updatedAt.month}/${order.updatedAt.year}`

            if (order.product.deleted_at) {
                order.deletedAt = date(order.product.deleted_at)
                order.formattedDeleted_at = `Produto deletado em ${order.deletedAt.day}/${order.deletedAt.month}/${order.deletedAt.year}`
            }

            return order
        })

        const orders = await Promise.all(getOrderPromise)

        return res.render("orders/index", { orders })

    },
    async sales(req, res) {

        const sales = await LoadOrder.load('orders', {
            where: { seller_id: req.session.userId }
        })

        return res.render("orders/sales", { sales })
    },
    async post(req, res) {

        try {
            // pegar todos os produtos do carrinho
            const cart = Cart.init(req.session.cart)
            const buyer_id = req.session.userId

            const filteredItems = cart.items.filter(item => item.product.user_id != req.session.userId)

            // criar o pedido
            const createOrdersPromise = filteredItems.map(async item => {
                let { product, price: total, quantity, formattedPrice } = item // o price é o total, o preço individual está no product
                const { price, id: product_id, user_id: seller_id } = product
                const status = "open"

                const order = await Order.create({
                    seller_id,
                    buyer_id,
                    product_id,
                    price,
                    total,
                    quantity,
                    status
                })


                // pegar os dados do produto
                product = await LoadProductService.load('product', { where: { id: product_id } })
                // os dados do vendedor
                const seller = await User.findOne({ where: { id: seller_id } })
                // os dados do comprador
                const buyer = await User.findOne({ where: { id: buyer_id } })
                // enviar email com dados da compra para o vendedor 
                await mailer.sendMail({
                    to: seller.email,
                    from: 'no-replay@launchstore.com.br',
                    subject: 'Novo pedido de compra',
                    html: email(seller, product, buyer, quantity, formattedPrice),

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
                "close": "sold"
            }

            order.status = allStatus[action]

            await Order.update(id, {
                status: order.status
            })

            return res.redirect('/orders/sales')

        } catch (error) {
            console.error(error)
        }

    }

}