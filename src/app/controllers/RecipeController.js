const Recipe = require('../models/Recipe');
const User = require('../models/User')
const File = require('../models/File')
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

        req.session.userId = userId

        return res.render('recipes/index', { recipes })
    },
    async create(req, res) {

        const diet_restriction = await dietRestriction.findAll()
        const meal_type = await mealType.findAll()
        const world_cuisine = await worldCuisine.findAll()
        const difficulties = await Difficulties.findAll()

        // console.log(diet_restriction, meal_type, world_cuisine)

        return res.render('recipes/form', { diet_restriction, meal_type, world_cuisine })
    },
    async edit(req, res) {

        const diet_restriction = await dietRestriction.findAll()
        const meal_type = await mealType.findAll()
        const world_cuisine = await worldCuisine.findAll()

        return res.render('recipes/update-form', { diet_restriction, meal_type, world_cuisine })
    },
    async show(req, res) {

        try {

            //let product = await Product.find(id)
            let recipe = await LoadRecipeService.load('recipe', { where: { id: req.params.id } })

            if (!recipe) return res.send("Product not found!")

            console.log(recipe.preparation.join(',').split('@'))
            recipe.steps = recipe.preparation.join('').split('@')

            recipe.user.profileImage = recipe.user.profile_image.replace(/(.*)(\/images.*)/, '$2')


            return res.render('recipes/show', { recipe })
            // return res.json(recipe)

        } catch (error) {
            console.error(error)
        }

    },
    async post(req, res) {
        try {


            // console.log(diet_restriction, meal_type, world_cuisine)

            let {
                title,
                serving_size,
                cooking_time,
                difficulty_id,
                ingredients,
                preparation,
                information,
                diet_restriction_id,
                meal_type_id,
                world_cuisine_id
            } = req.body;

            const recipeId = await Recipe.create({
                title: title.replace("'", "''"),
                user_id: req.session.userId,
                serving_size,
                cooking_time,
                difficulty_id,
                ingredients: `{${ingredients.join(',').replace(/['"]/g, "''")}}`,
                preparation: `{${preparation.join(',').replace(/['"]/g, "''")}}`,
                information: information.replace("'", "''").replace("\"", ""),
                diet_restriction_id,
                meal_type_id,
                world_cuisine_id
            });

            // const recipeId = {
            //     title: title.replace("'", "''"),
            //     user_id: req.session.userId,
            //     serving_size,
            //     cooking_time,
            //     difficulty_id,
            //     ingredients: `{${ingredients.join(',').replace(/['"]/g, "''")}}`,
            //     preparation: `{${preparation.join(',').replace(/['"]/g, "''")}}`,
            //     information: information.replace("'", "''").replace("\"", ""),
            //     diet_restriction_id,
            //     meal_type_id,
            //     world_cuisine_id
            // };

            // str.replace(/[.#]/g, 'replacechar');
            // this will replace., - and # with your replacechar!

            console.log('recipe id', recipeId)

            const filesPromise = req.files.map((file) =>
                File.create({ name: file.filename, path: file.path, recipe_id: recipeId })
            );

            await Promise.all(filesPromise);

            return res.render('recipes/form', {
                success: "receita criada"
            });
            // return res.json(recipeId)


        } catch (err) {
            console.error(err)
            return res.redirect("recipes/form",
                {
                    recipe: req.body,
                    error: "Algum erro aconteceu"
                })
        }
    }
}