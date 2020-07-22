const Category = require('../models/Category');
const Product = require('../models/Product');
const ProductImage = require('../models/ProductImage');
const { unlinkSync } = require("fs")
const { formatPrice, date } = require('../../lib/utils');
const LoadProductService = require('../services/LoadProductService');


module.exports = {

    async index(req, res) {

        let products = await LoadProductService.load('products')

        if (!products) return res.send("Products not found!")

        return res.render("products/index", { products })

    },
    async show(req, res) {
        try {


            let product = await LoadProductService.load('product', { where: { "products.id": req.params.id } })

            if (!product) return res.send("Product not found!")

            // console.log(product)


            // return res.render('products/show', { product, files: product.files })
            return res.render("products/show", { product })

        } catch (error) {
            console.error(error)
        }

    },
    async teste(req, res) {
        try {


            let product = await LoadProductService.load('product', { where: { "products.id": req.params.id } })

            if (!product) return res.send("Product not found!")

            // console.log(product)


            // return res.render('products/show', { product, files: product.files })
            return res.render("products/show-test", { product })

        } catch (error) {
            console.error(error)
        }
    },

    // async create(req, res) {

    //     try {
    //         // já devolve as rows
    //         const categories = await Category.findAll()
    //         return res.render("products/create.njk", { categories })


    //     } catch (error) {
    //         console.error(error)
    //     }
    // },
    // async post(req, res) {

    //     try {
    //         // a validação de todos os campos agora está no validator -> product.js

    //         let { category_id, name, description, old_price, price, quantity, status } = req.body

    //         price = price.replace(/\D/g, "")


    //         // user_id 
    //         req.body.user_id = req.session.userId
    //         const { user_id } = req.body

    //         let productId = await Product.create({
    //             category_id,
    //             user_id,
    //             // user_id: req.session.userId,
    //             name,
    //             description,
    //             old_price: old_price || price,
    //             price,
    //             quantity,
    //             status: status || 1
    //         })

    //         //console.log('req.files', req.files.path)
    //         const filesPromise = req.files.map(file => {
    //             // console.log(file)  // para ver os campos 
    //             File.create({ name: file.filename, path: file.path, product_id: productId })
    //         })

    //         await Promise.all(filesPromise)

    //         categories = await Category.findAll()

    //         res.redirect(`/`)

    //     } catch (error) {
    //         console.error(error)
    //     }

    // },
    // async update(req, res) {

    //     try {

    //         let product = await LoadService.load('product', { where: { id: req.params.id } })

    //         if (!product) return res.send("Product not found")


    //         const categories = await Category.findAll()


    //         return res.render('products/edit', { product, categories, files: product.files })

    //     } catch (error) {
    //         console.error(error)
    //     }

    // },
    async put(req, res) {

        try {

            // verificar se imagens foram adicionadas, e se foram iremos criar um array de promesas
            if (req.files.length != 0) {
                const newFilesPromise = req.files.map(file => {
                    File.create({ name: file.filename, path: file.path, product_id: req.body.id })
                })
                await Promise.all(newFilesPromise)
            }

            if (req.body.removed_files) {
                const removedfiles = req.body.removed_files.split(',')  // [1,2,3,] --> porém ele virá com um item vazio no array
                // pare remover esse item vazio pegaremos o index do último elemento
                const lastIndex = removedfiles.length - 1
                removedfiles.splice(lastIndex, 1) // pegar o index do último elemento e remover apenas 1 ==> [1,2,3]

                // precisaremos fazer um array de promises
                const removedfilesPromise = removedfiles.map(id => File.delete(id))

                await Promise.all(removedfilesPromise)
            }

            req.body.price = req.body.price.replace(/\D/g, "")

            // get the old price and save it in the update
            if (req.body.old_price != req.body.price) {
                let oldProduct = await Product.find(req.body.id)
                req.body.old_price = oldProduct.price
            }

            const productId = req.body.id
            // aqui iremos fazer a lógica de salvar essa imagens - criação do Model - File.js
            // map -> retorna um array 
            // iremos criar um array de promises
            const filesPromise = req.files.map(file => {
                File.update({ name: file.filename, path: file.path, product_id: productId })
            })
            // depois de criarmos um array de promessas, passaremos elas para o Promise.all()
            await Promise.all(filesPromise)

            await Product.update(req.body.id, {
                category_id: req.body.category_id,
                name: req.body.name,
                description: req.body.description,
                price: req.body.price,
                old_price: req.body.old_price,
                quantity: req.body.quantity,
                status: req.body.status
            })

            return res.redirect(`/products/${productId}`)

        } catch (error) {
            console.error(error)
        }
    },
    // async delete(req, res) {

    //     let files = await Product.files(req.body.id)

    //     const { id } = req.body

    //     await Product.delete(id)

    //     files = files.map(file => {
    //         try {
    //             unlinkSync(file.path)
    //         } catch (error) {
    //             console.error(error)
    //         }
    //     })


    //     return res.redirect('/');

    // }

}