const db = require("../../config/db")

const Base = require('./Base');

Base.init({ table: 'products' })

function findFormat(filters, table) {

    let query = `SELECT (pr.price * pr.sale) AS discount,products.* 
    FROM products 
    LEFT JOIN products pr ON (products.id = pr.id) 
    `

    // WHERE p.id = $1

    if (filters) {
        Object.keys(filters).map(key => {
            // WHERE | OR | AND
            query += ` ${key}`
            // examplo da lógica aqui
            // key -> where
            // aqui o resultado será {email}
            Object.keys(filters[key]).map(field => {
                // // { email : email } colocar o valor do req.body que foi enviado do form
                query += ` ${field} = '${filters[key][field]}'`
            })


        })

        return db.query(query)

    }
}


const Product = {
    ...Base,
    async findOneFormat(filters) {

        const results = await findFormat(filters, this.table)

        return results.rows[0]

    },
    async findAllFormat(filters) {

        const results = await findFormat(filters, this.table)

        // usaremos o mesmo para o all com a diferença que agora usaremos todas as rows
        return results.rows

    },
    async files(id) {

        const results = await db.query(
            `SELECT * FROM product_image WHERE product_id = $1`, [id])

        return results.rows
    },
    async search(params) {

        const { filter, category } = params

        let query = `
            SELECT products.*,
                categories.name AS category_name
            FROM products
            LEFT JOIN categories ON (categories.id = products.category_id)
            WHERE 1 = 1
        `

        if (category) {
            query += ` AND products.category_id = ${category}`
        }

        if (filter) {
            query += ` AND (products.title ilike '%${filter}%' 
            OR products.information ilike '%${filter}%')`
        }

        query += ` AND available == true`

        const results = await db.query(query)
        return results.rows
    },
    quantity(id, quantity) {

        try {

            let query = `
            UPDATE ${this.table} SET
            quantity=${quantity} WHERE id = ${id}
                `

            return db.query(query)


        } catch (err) {
            console.error(err)
        }

    }
}


module.exports = Product