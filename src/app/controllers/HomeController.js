const LoadRecipeService = require('../services/LoadRecipeService');


module.exports = {

    async index(req, res) {

        try {

            const recipes = await LoadRecipeService.load('recipes')
            // let recipes = await Recipe.findAll()
            const lastAdded = recipes.filter((recipe, index) => index > 10 ? false : true)   // pegar apenas os primeiros produtos

            return res.render("index", { recipes: lastAdded })

        } catch (error) {
            console.error(error)
        }
    }
}