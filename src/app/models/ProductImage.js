const db = require('../../config/db')


const Base = require('./Base');

Base.init({ table: 'product_image' })


const ProductImage = {
    ...Base,
}


module.exports = ProductImage