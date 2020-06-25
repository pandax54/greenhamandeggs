const LoadService = require('../services/LoadProductService');

module.exports = {

    async index(req, res) {

        try {

            // const lastAdded = await Promise.all(productsPromise)

            const recipes = await LoadService.load('recipes')
            const lastAdded = products.filter((recipe, index) => index > 8 ? false : true)   // pegar apenas os primeiros produtos

            return res.render("home/index", { products: lastAdded })

        } catch (error) {
            console.error(error)
        }

    }

}