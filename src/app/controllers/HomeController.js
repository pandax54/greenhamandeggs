const LoadRecipeService = require('../services/LoadRecipeService');
const Difficulties = require('../models/Difficulty')
const dietRestriction = require('../models/dietRestriction')
const mealType = require('../models/mealType')
const worldCuisine = require('../models/worldCuisine')
const Category = require('../models/Category')

module.exports = {

    async index(req, res) {

        try {
            const difficulties = await Difficulties.findAll()
            const diet_restriction = await dietRestriction.findAll()
            const meal_type = await mealType.findAll()
            const world_cuisine = await worldCuisine.findAll()

            const categories = await Category.findAll()

            req.session.difficulties = difficulties
            req.session.diet_restriction = diet_restriction
            req.session.meal_type = meal_type
            req.session.world_cuisine = world_cuisine
            req.session.categories = categories
            if (req.session.user) {
                req.session.admin = req.session.user.is_admin ? true : false
                console.log(req.session.admin)
            }

            let recipes = await LoadRecipeService.load('recipes')

            recipes = recipes.map(recipe => ({
                ...recipe,
                img: recipe.files[0].path.replace(/(.*)(\/images.*)/, '$2')
            }))

            recipes = recipes.filter((recipe, index) => index > 8 ? false : true)   // pegar apenas os primeiros produtos



            return res.render("index", { recipes })

        } catch (error) {
            console.error(error)
        }
    },
    about(req, res) {
        return res.render("about")
    }
}