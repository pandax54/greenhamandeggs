const Recipe = require('../models/Recipe');
const { formatPrice, date } = require('../../lib/utils');


// agora pegar as imagens usando o product id
async function getImages(recipeId) {
    // get the images of the product
    let files = await Recipe.files(productId)
    // somente retornar o caminho pois precisamos da url na tag da imagem
    files = files.map(file => ({
        ...file,
        src: `${file.path.replace("public", "")}`
        // /images/...
        // `${req.protocol}://${req.headers.host}${file.path.replace("public", "")}`
    }))

    return files
}



async function format(recipe) {

    const files = await getImages(recipe.id)
    recipe.img = files[0].src
    recipe.files = files

    const { hour, minutes, day, month, year } = date(recipe.updated_at)

    recipe.published = {
        date: `${day}/${month}/${year}`,
        time: `${hour}h:${minutes}`
    }

    recipe.formattedCreatedAt = `${recipe.published.date} às ${recipe.published.time}`


    // devolve o product formatado
    return recipe
}


const LoadService = {
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

            const recipe = await Recipe.findAll(this.filter)
            // recipes.map(recipe => format(recipe)) == recipes.map(format)
            const recipesPromise = recipes.map(format)
            return Promise.all(recipesPromise)

        } catch (error) {
            console.error(error)
        }
    },
    // async recipeWithDeleted() {
    //     try {
    //         let recipe = await Recipe.findOneWithDeleted(this.filter)
    //         return format(recipe)

    //     } catch (error) {
    //         console.error(error)
    //     }
    // },
    format
}

// LoadService.load('recipe', { where: { id: 1}})

module.exports = LoadService