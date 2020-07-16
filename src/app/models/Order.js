const Base = require('./Base');

Base.init({ table: 'orders' })

const Order = {
    ...Base,
}

module.exports = Order;