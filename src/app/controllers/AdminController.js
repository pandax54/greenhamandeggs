const Product = require('../models/Product')
const ProductImage = require('../models/ProductImage')
const { unlinkSync } = require("fs")
const { formatPrice, date } = require('../../lib/utils');
const LoadProductService = require('../services/LoadProductService');
const DeleteServiceProduct = require('../services/DeleteServiceProduct')

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

            return res.redirect('/products');


        } catch (err) {
            console.error(err)
            return res.redirect('/')
        }
    },
    async edit(req, res) {

        let product = await LoadProductService.load('product', { where: { "products.id": req.params.id } })

        if (!product) return res.send("Product not found!")

        return res.render('admin/update-form', { product })
    },
    async put(req, res) {
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

            const productId = await Product.update(req.body.id, {
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
                ProductImage.create({ name: file.filename, path: file.path, product_id: req.body.id })
            );

            await Promise.all(filesPromise);

            if (req.body.removed_files) {
                DeleteServiceProduct.removedFiles(req.body);

            }



            return res.render('admin/update-form', {
                success: "Product has been updated"
            });
        } catch (err) {
            console.error(err)
            return res.redirect("admin/update-form",
                {
                    product: req.body,
                    error: "Something wrong happened"
                })
        }
    },
    async delete(req, res) {
        try {
            const files = await Product.files(req.body.id);

            await Product.delete(req.body.id);

            DeleteServiceProduct.deleteFiles(files);

            return res.redirect('/products');
        } catch (err) {
            console.error(err);
        }
    }
}