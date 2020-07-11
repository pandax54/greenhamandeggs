const LoadRecipeService = require('../services/LoadRecipeService');
const Difficulties = require('../models/Difficulty')
const dietRestriction = require('../models/dietRestriction')
const mealType = require('../models/mealType')
const worldCuisine = require('../models/worldCuisine')

module.exports = {

    async index(req, res) {

        try {
            const difficulties = await Difficulties.findAll()
            const diet_restriction = await dietRestriction.findAll()
            const meal_type = await mealType.findAll()
            const world_cuisine = await worldCuisine.findAll()

            req.session.difficulties = difficulties
            req.session.diet_restriction = diet_restriction
            req.session.meal_type = meal_type
            req.session.world_cuisine = world_cuisine

            let recipes = await LoadRecipeService.load('recipes')
            // let recipes = await Recipe.findAll()
            recipes = recipes.map(recipe => ({
                ...recipe,
                img: recipe.files[0].path.replace(/(.*)(\/images.*)/, '$2')
            }))

            recipes = recipes.filter((recipe, index) => index > 8 ? false : true)   // pegar apenas os primeiros produtos

            console.log(req.session.userId)

            return res.render("index", { recipes })

        } catch (error) {
            console.error(error)
        }
    },
    about(req, res) {
        return res.render("about")
    }
}