const LoadRecipeService = require('../services/LoadRecipeService');


module.exports = {

    async index(req, res) {

        try {

            let recipes = await LoadRecipeService.load('recipes')
            // let recipes = await Recipe.findAll()
            recipes = recipes.filter((recipe, index) => index > 8 ? false : true)   // pegar apenas os primeiros produtos

            return res.render("index", { recipes })

        } catch (error) {
            console.error(error)
        }
    },
    about(req, res) {
        return res.render("about")
    },
    about2(req, res) {
        return res.render("about\ copy")
    }
}