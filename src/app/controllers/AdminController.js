const Product = require('../models/Product')
const ProductImage = require('../models/ProductImage')

module.exports = {

    async index(req, res) {



        return res.render("products/index")

    },
    create(req, res) {
        return res.render("admin/form")
    },
    async post(req, res) {
        try {

            let {
                title,
                category_id,
                description,
                information,
                price,
                quantity,
                available,
                sale
            } = req.body;

            price = price.replace(/\D/g, "")

            const productId = await Product.create({
                title: title.replace("'", "''"),
                category_id,
                description,
                information: `{${information.join(',').replace(/['"]/g, "''")}}`,
                price,
                quantity,
                available,
                sale
            });


            const filesPromise = req.files.map((file) =>
                ProductImage.create({ name: file.filename, path: file.path, product_id: productId })
            );

            await Promise.all(filesPromise);

            return res.render('admin/form', {
                success: "produto criado"
            });


        } catch (err) {
            console.error(err)
            return res.redirect('/')
        }
    }
}