const Recipe = require('../models/Recipe');
const User = require('../models/User')
const File = require('../models/File')
const LoadRecipeService = require('../services/LoadRecipeService');
// const user = require('../validator/user');
const Difficulties = require('../models/Difficulty')
const dietRestriction = require('../models/dietRestriction')
const mealType = require('../models/mealType')
const worldCuisine = require('../models/worldCuisine')
const DeleteService = require('../services/DeleteService')
const { format } = require('../services/format')




module.exports = {
    async index(req, res) {

        let { page, limit } = req.query;
        page = page || 1;
        limit = limit || 10;
        let offset = limit * (page - 1);

        const params = {
            page,
            limit,
            offset,
        };

        let totalRecipes = await LoadRecipeService.load('recipes')

        let total = totalRecipes.length

        let recipes = await Recipe.paginate(params)

        recipesPromises = await recipes.map(format)

        recipes = await Promise.all(recipesPromises)

        const pagination = {
            total: Math.ceil(total / limit),
            page
        };

        // because of the seed there are http images that may broken the layout
        // recipes = recipes.map(recipe => ({
        //     ...recipe,
        //     img: (recipe.img.includes('http') ? recipe.img : `/images/${recipe.img}`)
        // }))

        return res.render('recipes/index', { recipes, pagination })
    },
    async create(req, res) {

        return res.render('recipes/form')
    },
    async edit(req, res) {

        const { id } = req.params

        let recipe = await LoadRecipeService.load('recipe', { where: { id } })

        return res.render('recipes/update-form', { recipe })
    },
    async show(req, res) {

        try {

            //let product = await Product.find(id)
            let recipe = await LoadRecipeService.load('recipe', { where: { id: req.params.id } })

            console.log(recipe)

            if (!recipe) return res.send("Product not found!")


            return res.render('recipes/show', { recipe })
            // return res.json(recipe)

        } catch (error) {
            console.error(error)
        }

    },
    async post(req, res) {
        try {

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


            const filesPromise = req.files.map((file) =>
                File.create({ name: file.filename, path: file.path, recipe_id: recipeId })
            );

            await Promise.all(filesPromise);

            return res.render('recipes/form', {
                success: "receita criada"
            });


        } catch (err) {
            console.error(err)
            return res.redirect('/')
            // return res.redirect("recipes/form",
            //     {
            //         recipe: req.body,
            //         error: "Algum erro aconteceu"
            //     })
        }
    },
    async put(req, res) {
        try {

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

            if (req.files.length != 0) {
                const newFilesPromise = req.files.map((file) =>
                    File.create({ name: file.filename, path: file.path })
                );
                await Promise.all(newFilesPromise)
            }

            if (req.body.removed_files) {
                DeleteService.removedFiles(req.body);
            }

            await Recipe.update(req.body.id, {
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


            return res.render('recipes/update-form', {
                success: "receita atualizada"
            });
        } catch (err) {
            console.error(err)
            return res.redirect("recipes/update-form",
                {
                    recipe: req.body,
                    error: "Algum erro aconteceu"
                })
        }
    },
    async delete(req, res) {
        try {
            const files = await Recipe.files(req.body.id);

            await Recipe.delete(req.body.id);

            DeleteService.deleteFiles(files);

            return res.render("index", {
                success: "deletada",
            });
        } catch (err) {
            console.error(err);
        }
    }
}