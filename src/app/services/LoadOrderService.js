const Order = require("../models/Order")
const Product = require('../models/Product')
const User = require('../models/User')
const { formatPrice, date } = require('../../lib/utils');
const LoadProductService = require('./LoadProductService')



async function format(order) {

    // alterar a tabela de products para 'productWithDeleted', pois o histórico dos pedidos permanecem mesmo que posteriormente os produtos sejam deletados
    order.product = await LoadProductService.load("product", {
        where: { id: order.product_id }
    })

    // detalhes do comprador
    order.user = await User.findOne({
        where: { id: order.user_id }
    })

    // formatação de preços
    order.formattedPrice = formatPrice(order.price)
    order.formattedTotal = formatPrice(order.total)

    return order
}


const LoadOrder = {
    load(service, filter) {

        this.filter = filter
        return this[service]()
    },
    async order() {

        try {

            const order = await Order.findOne(this.filter)

            return format(order)

        } catch (error) {
            console.error(error)
        }

    },
    async orders() {
        try {

            const allOrders = await Order.findAll(this.filter)
            const getOrderPromise = allOrders.map(format)

            const orders = await Promise.all(getOrderPromise)

            return orders

        } catch (error) {
            console.error(error)
        }
    },
    format
}

// LoadProductService.load('product', { where: { id: 1}})

module.exports = LoadOrder