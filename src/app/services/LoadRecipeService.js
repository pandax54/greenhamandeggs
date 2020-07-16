const Recipe = require('../models/Recipe');
const { formatPrice, date } = require('../../lib/utils');
const User = require('../models/User')
const Difficulties = require('../models/Difficulty')
const dietRestriction = require('../models/dietRestriction')
const mealType = require('../models/mealType')
const worldCuisine = require('../models/worldCuisine')
const LoadUserService = require('./LoadUserService')

// agora pegar as imagens usando o product id
async function getImages(recipeId) {
    // get the images of the product
    let files = await Recipe.files(recipeId)

    // somente retornar o caminho pois precisamos da url na tag da imagem
    files = files.map(file => ({
        ...file,
        // src: `${file.path.replace("public", "")}`
        src: file.name.includes('http') ? file.name : file.path.replace(/(.*)(\/images.*)/, '$2')

    }))

    return files
}



async function format(recipe) {

    const files = await getImages(recipe.id)
    if (files) {
        recipe.img = files[0].src
        recipe.files = files
    }

    // const user = await User.findOne({ where: { id: recipe.user_id } })
    const user = await LoadUserService.load('user', { where: { id: recipe.user_id } })

    recipe.user = user

    const { hour, minutes, day, month, year } = date(recipe.updated_at)

    recipe.published = {
        date: `${day}/${month}/${year}`,
        time: `${hour}h:${minutes}`
    }

    recipe.formattedCreatedAt = `${recipe.published.date} às ${recipe.published.time}`

    const difficulty = await Difficulties.findOne({ where: { id: recipe.difficulty_id } })

    recipe.difficulties = difficulty

    const diet_restriction = await dietRestriction.findOne({ where: { id: recipe.diet_restriction_id } })
    const meal_type = await mealType.findOne({ where: { id: recipe.meal_type_id } })
    const world_cuisine = await worldCuisine.findOne({ where: { id: recipe.world_cuisine_id } })

    recipe.diet_restriction = diet_restriction
    recipe.meal_type = meal_type
    recipe.world_cuisine = world_cuisine

    recipe.steps = recipe.preparation.join('').split('@')

    // recipe.user.profileImage = recipe.user.profile_image.replace(/(.*)(\/images.*)/, '$2')

    return recipe
}


const LoadRecipeService = {
    load(service, filter) {

        this.filter = filter
        return this[service]()
    },
    async recipe() {

        try {

            const recipe = await Recipe.findOne(this.filter)
            return format(recipe)

        } catch (error) {
            console.error(error)
        }

    },
    async recipes() {
        try {

            const recipes = await Recipe.findAll(this.filter)
            // recipes.map(recipe => format(recipe)) == recipes.map(format)
            const recipesPromise = recipes.map(format)
            return Promise.all(recipesPromise)

        } catch (error) {
            console.error(error)
        }
    }
}

module.exports = LoadRecipeService 