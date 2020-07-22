const LoadProductService = require('./LoadProductService')
const Invoice = require('../models/Invoice')
const Order = require('../models/Order')
const User = require('../models/User')
const { formatPrice, date, formatUSD } = require('../../lib/utils');
const { hash } = require("bcryptjs");


async function format(invoice) {

    let quantity = 0

    let totalAmount = 0

    const OrdersPromise = invoice.orders_id.map(async id => {

        const order = await Order.findOne({ Where: { id } })
        order.productInfo = await LoadProductService.load('product', { where: { "products.id": order.product_id } })

        quantity += order.quantity

        totalAmount += order.price

        order.formattedPrice = formatUSD(order.total)

        return order

    })

    const orders = await Promise.all(OrdersPromise)

    const totalAmountFormatted = formatUSD(totalAmount)

    invoice.createdAt = date(invoice.created_at)
    invoice.formattedcreatedAt = `Date ${invoice.createdAt.day}/${invoice.createdAt.month}/${invoice.createdAt.year}`

    return ({
        ...invoice,
        quantity,
        totalAmount,
        totalAmountFormatted,
        orders
    })


}



const LoadInvoiceService = {
    load(service, filter) {

        this.filter = filter
        return this[service]()
    },
    async invoice() {

        try {

            const invoice = await Invoice.findOne(this.filter)
            // orders_id => orders 

            console.log("the invoice is", invoice)

            return format(invoice)

        } catch (error) {
            console.error(error)
        }

    },
    async invoices() {
        try {

            const invoices = await Invoice.findAll(this.filter)

            // [ { id: 1, orders_id: [ 1, 2, 3 ], user_id: 16 } ]

            // orders_id => orders
            const invoicesPromise = invoices.map(async invoice => {
                const ordersId = invoice.orders_id // number array

                const { id } = invoice

                let quantity = 0

                let totalAmount = 0

                const promiseOrders = ordersId.map(async id => {
                    const order = await Order.findOne({ Where: { id } })
                    order.productInfo = await LoadProductService.load('product', { where: { "products.id": order.product_id } })

                    quantity += order.quantity

                    totalAmount += order.price

                    order.formattedPrice = formatUSD(order.total)

                    return order
                })

                const orders = await Promise.all(promiseOrders)

                const totalAmountFormatted = formatUSD(totalAmount)

                invoice.createdAt = date(invoice.created_at)
                invoice.formattedcreatedAt = `Date ${invoice.createdAt.day}/${invoice.createdAt.month}/${invoice.createdAt.year}`

                // const trackingNumber = await hash(id, 8)

                return ({
                    ...invoice,
                    quantity,
                    totalAmount,
                    totalAmountFormatted,
                    orders
                })
            })

            return Promise.all(invoicesPromise)

        } catch (error) {
            console.error(error)
        }
    }
}

module.exports = LoadInvoiceService