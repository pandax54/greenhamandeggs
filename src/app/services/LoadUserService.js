
const Recipe = require('../models/Recipe');
const User = require('../models/User')
const LoadRecipeService = require('../services/LoadRecipeService')



async function format(user) {

    console.log(user.profile_image)

    let profileImage = user.profile_image.includes('http') ? user.profile_image : user.profile_image.replace(/(.*)(\/images.*)/, '$2')

    const recipes = await LoadRecipeService.load('recipes', { where: { user_id: user.id } })

    user = {
        ...user,
        profileImage,
        recipes
    }

    return user
}


const LoadUserService = {
    load(service, filter) {

        this.filter = filter
        return this[service]()
    },
    async user() {

        try {

            const user = await User.findOne(this.filter)
            return format(user)

        } catch (error) {
            console.error(error)
        }

    },
    async users() {
        try {

            const users = await User.findAll(this.filter)
            // recipes.map(recipe => format(recipe)) == recipes.map(format)
            const usersPromise = users.map(format)
            return Promise.all(usersPromise)

        } catch (error) {
            console.error(error)
        }
    },
    format
}

module.exports = LoadUserService