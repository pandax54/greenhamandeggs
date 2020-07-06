const Recipe = require('../models/Recipe');
const User = require('../models/User')
const LoadRecipeService = require('../services/LoadRecipeService');
// const user = require('../validator/user');
const Difficulties = require('../models/Difficulty')
const dietRestriction = require('../models/dietRestriction')
const mealType = require('../models/mealType')
const worldCuisine = require('../models/worldCuisine')



module.exports = {
    async index(req, res) {

        let recipes = await LoadRecipeService.load('recipes')

        // let recipes = await Recipe.findAll()

        return res.json(recipes)
    },
    async create(req, res) {

        const diet_restriction = await dietRestriction.findAll()
        const meal_type = await mealType.findAll()
        const world_cuisine = await worldCuisine.findAll()

        // console.log(diet_restriction, meal_type, world_cuisine)

        return res.render('recipes/form', { diet_restriction, meal_type, world_cuisine })
    },
    async show(req, res) {

        try {

            //let product = await Product.find(id)
            let recipe = await LoadRecipeService.load('recipe', { where: { id: req.params.id } })

            console.log(recipe)
            console.log(recipe.files[0].path)

            if (!recipe) return res.send("Product not found!")


            return res.render('recipes/show', { recipe })
            // return res.json(recipe)

        } catch (error) {
            console.error(error)
        }

    }

}