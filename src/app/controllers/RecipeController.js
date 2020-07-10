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


            return res.render('recipes/show', { recipe })
            // return res.json(recipe)

        } catch (error) {
            console.error(error)
        }

    },
    async post(req, res) {
        try {
            //   let { chef, title, ingredients, preparation, information } = req.body;

            //   const recipeId = await Recipe.create({
            //     chef_id: chef,
            //     user_id: req.session.userId,
            //     title,
            //     ingredients,
            //     preparation,
            //     information,
            //   });

            //   const filesPromise = req.files.map((file) =>
            //     File.create({ name: file.filename, path: file.path })
            //   );
            //   const filesId = await Promise.all(filesPromise);

            //   const relationPromise = filesId.map((fileId) =>
            //     RecipeFile.create({
            //       recipe_id: recipeId,
            //       file_id: fileId,
            //     })
            //   );

            //   await Promise.all(relationPromise);

            //   return res.render("admin/parts/success", {
            //     type: "Receita",
            //     action: "criada",
            //   });
            return res.json(req.body)
        } catch (err) {
            console.error(err);
        }
    },

}