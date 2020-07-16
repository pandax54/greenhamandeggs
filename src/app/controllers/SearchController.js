const Recipe = require('../models/Recipe');
const { formatBRL, date, forat } = require('../../lib/utils');
const File = require('../models/File');
const LoadRecipeService = require('../services/LoadRecipeService');

module.exports = {

    async index(req, res) {

        try {
            let results,
                params = {}

            const {
                filter,
                difficulties,
                diet_restriction,
                meal_type,
                world_cuisine
            } = req.query

            if (!filter) return res.redirect('/')

            // se tiver filtro adicionar no objeto params
            params.filter = filter

            // manter o ?filter= e adicionar ?category=
            if (difficulties) {
                // se tiver difficulties adicionar no objeto params
                params.difficulties = difficulties
            }
            if (diet_restriction) {
                // se tiver  diet_restriction adicionar no objeto params
                params.diet_restriction = diet_restriction
            }
            if (meal_type) {
                // se tiver meal_type adicionar no objeto params
                params.meal_type = meal_type
            }
            if (world_cuisine) {
                // se tiver world_cuisine adicionar no objeto params
                params.world_cuisine = world_cuisine
            }


            let recipes = await Recipe.search(params)

            // array de promises
            const recipesPromise = recipes.map(LoadRecipeService.format)
            recipes = await Promise.all(recipesPromise)

            // se houver mais de um produto com o mesmo nome ou cagoria, ele irá se repetir entao teremos que filtrar repetições
            const difficultiesSearch = recipes.map(recipe => ({
                id: recipe.difficulties.id,
                name: recipe.difficulties.name
            })).reduce((difficultiesFiltered, difficulties) => {
                // https://skylab.rocketseat.com.br/node/listando-produtos-da-launchstore/group/pagina-de-busca/lesson/organizando-categorias-e-filtros-1
                // se tiver repetido, nao colocar mais uma vez 
                const found = difficultiesFiltered.some(item => item.id == difficulties.id)

                // se ele nao achar
                if (!found) {
                    difficultiesFiltered.push(difficulties)
                }

                return difficultiesFiltered
            }, [])

            const dietRestrictionSearch = recipes.map(recipe => ({
                id: recipe.diet_restriction.id,
                name: recipe.diet_restriction.name
            })).reduce((dietRestrictionFiltered, diet_restriction) => {
                // https://skylab.rocketseat.com.br/node/listando-produtos-da-launchstore/group/pagina-de-busca/lesson/organizando-categorias-e-filtros-1
                // se tiver repetido, nao colocar mais uma vez 
                const found = dietRestrictionFiltered.some(item => item.id == diet_restriction.id)

                // se ele nao achar
                if (!found) {
                    dietRestrictionFiltered.push(diet_restriction)
                }

                return dietRestrictionFiltered
            }, [])

            const mealTypeSearch = recipes.map(recipe => ({
                id: recipe.meal_type.id,
                name: recipe.meal_type.name
            })).reduce((mealTypeFiltered, meal_type) => {
                // https://skylab.rocketseat.com.br/node/listando-produtos-da-launchstore/group/pagina-de-busca/lesson/organizando-categorias-e-filtros-1
                // se tiver repetido, nao colocar mais uma vez 
                const found = mealTypeFiltered.some(item => item.id == meal_type.id)

                // se ele nao achar
                if (!found) {
                    mealTypeFiltered.push(meal_type)
                }

                return mealTypeFiltered
            }, [])

            const worldCuisineSearch = recipes.map(recipe => ({
                id: recipe.world_cuisine.id,
                name: recipe.world_cuisine.name
            })).reduce((worldCuisineFiltered, world_cuisine) => {
                // https://skylab.rocketseat.com.br/node/listando-produtos-da-launchstore/group/pagina-de-busca/lesson/organizando-categorias-e-filtros-1
                // se tiver repetido, nao colocar mais uma vez 
                const found = worldCuisineFiltered.some(item => item.id == world_cuisine.id)

                // se ele nao achar
                if (!found) {
                    worldCuisineFiltered.push(world_cuisine)
                }

                return worldCuisineFiltered
            }, [])

            let labels = {
                difficulties: difficultiesSearch,
                diet_restriction: dietRestrictionSearch,
                meal_type: mealTypeSearch,
                world_cuisine: worldCuisineSearch,
                // filter
            }

            // LABELS FILTERS
            const labelsKeys = Object.keys(labels)

            // console.log("the recipes are", recipes)
            // difficulty = { id: 3, name: "hard"}
            // diet_restriction
            // meal_type
            // world_cuisine


            const search = {
                term: req.query.filter,
                total: recipes.length
            }


            // const search = {
            //     term: { filters: req.query },
            //     total: recipes.length
            // }


            return res.render("search/index", { recipes, search, params, labels, labelsKeys })


        } catch (error) {
            console.error(error)
        }

    }

}