const Product = require('../models/Product');
const { formatPrice, date, formatUSD, formatBRL } = require('../../lib/utils');
const Category = require('../models/Category')


// agora pegar as imagens usando o product id
async function getImages(productId) {
    // get the images of the product
    let files = await Product.files(productId)
    // somente retornar o caminho pois precisamos da url na tag da imagem
    files = files.map(file => ({
        ...file,
        src: `${file.path.replace("public", "")}`
        // /images/...
        // `${req.protocol}://${req.headers.host}${file.path.replace("public", "")}`
    }))

    // console.log("files", files)

    return files
}



async function format(product) {

    const files = await getImages(product.id)
    if (files) {
        product.img = files[0].src
        product.files = files
    }

    const category = await Category.findOne({ where: { id: product.category_id } })

    product.category = category
    product.formattedPrice = formatUSD(product.price)
    // product.formattedPrice = formatBRL(product.price)


    // product.infos = product.information.join('').split('@')

    // testing new split - uppercase letter
    // product.infos = product.information.join('').split(/(?=[A-Z])/)
    product.infos = product.information.join('').split(';')

    product.sale_price = formatUSD(product.price * product.sale)
    product.discount = Math.ceil((1 - product.sale) * 100)
    // recipe.steps = recipe.preparation.join('').split('@')

    // product.user.profileImage = recipe.user.profile_image.replace(/(.*)(\/images.*)/, '$2')

    return product
}


const LoadProductService = {
    load(service, filter) {

        this.filter = filter
        return this[service]()
    },
    async product() {

        try {

            const product = await Product.findOneFormat(this.filter)
            return format(product)

        } catch (error) {
            console.error(error)
        }

    },
    async products() {
        try {

            const products = await Product.findAll(this.filter)
            // products.map(product => format(product)) == products.map(format)
            const productsPromise = products.map(format)
            return Promise.all(productsPromise)

        } catch (error) {
            console.error(error)
        }
    },
    async productWithDeleted() {
        try {
            let product = await Product.findOneWithDeleted(this.filter)
            return format(product)

        } catch (error) {
            console.error(error)
        }
    },
    format
}

module.exports = LoadProductService