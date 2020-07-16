const Order = require("../models/Order")
const Product = require('../models/Product')
const User = require('../models/User')
const { formatPrice, date } = require('../../lib/utils');
const LoadProductService = require('./LoadProductService')



async function format(order) {

    // alterar a tabela de products para 'productWithDeleted', pois o histórico dos pedidos permanecem mesmo que posteriormente os produtos sejam deletados
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
    order.formattedUpdatedAt = `${order.formattedStatus} em ${order.updatedAt.day}/${order.updatedAt.month}/${order.updatedAt.year}`

    if (order.product.deleted_at) {
        order.deletedAt = date(order.product.deleted_at)
        order.formattedDeleted_at = `Produto deletado em ${order.deletedAt.day}/${order.deletedAt.month}/${order.deletedAt.year}`
    }

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