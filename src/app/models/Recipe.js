const db = require('../../config/db')


const Base = require('./Base');

Base.init({ table: 'recipes' })


const Recipe = {
    ...Base,
    async files(id) {

        const results = await db.query(
            `SELECT * FROM files WHERE recipe_id = $1`, [id])

        return results.rows
    },
    async search(params) {

        const {
            filter,
            difficulties,
            diet_restriction,
            meal_type,
            world_cuisine
        } = params

        let query = `
            SELECT recipes.*,
            difficulties.name AS difficulties_name
            FROM recipes
            LEFT JOIN difficulties ON (difficulties.id = recipes.difficulty_id)
            WHERE 1 = 1
        `

        if (difficulties) {
            query += ` AND recipes.difficulty_id = ${difficulties}`
        }

        if (filter) {
            query += ` AND (recipes.title ilike '%${filter}%' 
            OR recipes.information ilike '%${filter}%')`
        }

        const results = await db.query(query)
        return results.rows
    }
}

module.exports = Recipe
