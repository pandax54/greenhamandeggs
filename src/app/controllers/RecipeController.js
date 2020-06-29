const Recipe = require('../models/Recipe');
const User = require('../models/User')
const LoadRecipeService = require('../services/LoadRecipeService');
// const user = require('../validator/user');




module.exports = {
    async index(req, res) {

        let recipes = await LoadRecipeService.load('recipes')

        // let recipes = await Recipe.findAll()

        return res.json(recipes)
    },
    // async show(req, res) {

    //     try {

    //         //let product = await Product.find(id)
    //         let product = await LoadService.load('product', { where: { id: req.params.id } })

    //         if (!product) return res.send("Product not found!")


    //         return res.render('products/show', { product, files: product.files })

    //     } catch (error) {
    //         console.error(error)
    //     }

    // },

}