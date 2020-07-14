const db = require("../../config/db");



// criar um find genérico
// agora podemos alterar o findOne dentro do objeto
function find(filters, table) {

    let query = `SELECT * FROM ${table}`

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
    }

    return db.query(query)

}

const Base = {
    init({ table }) {
        if (!table) throw new Error('Invalid Params')

        this.table = table

        return this
        // this = Base
    },
    async find(id) {

        const results = await find({ where: { id } }, this.table)

        return results.rows[0]

    },
    async findOne(filters) {

        const results = await find(filters, this.table)

        return results.rows[0]

    },
    async findAll(filters) {

        const results = await find(filters, this.table)

        // usaremos o mesmo para o all com a diferença que agora usaremos todas as rows
        return results.rows

    },
    async findOneWithDeleted(filters) {
        const results = await find(filters, `${this.table}_with_deleted`)
        return results.rows[0]
    },
    async create(fields) {
        // fields = object(chaves e valores) == User.create({name: 'Mayk})
        try {

            // montar a query sql
            let keys = [],
                values = []

            Object.keys(fields).map(key => {
                // keys
                // name, age, address
                keys.push(key)

                // values 
                // fernanda, 33, ...
                values.push(`'${fields[key]}'`)
            })



            const query = `INSERT INTO ${this.table} (${keys.join(',')}) VALUES (${values.join(',')}) RETURNING id`
            // RETURNING id
            const results = await db.query(query)
            console.log("insert into the database", results)
            return results.rows[0].id

        } catch (error) {
            console.error(error)
        }
    },
    update(id, fields) {

        try {
            const update = []

            Object.keys(fields).map(key => {

                // category_id=($1)
                const line = `${key} = '${fields[key]}'`
                update.push(line)
            })

            let query = `
            UPDATE ${this.table} SET
            ${update.join(',')} WHERE id = ${id}
                `

            return db.query(query)


        } catch (err) {
            console.error(err)
        }
    },
    delete(id) {

        return db.query(`DELETE FROM ${this.table}
        WHERE id = $1
        `, [id])
    },

}

module.exports = Base

// Base.init({table: "users"})
// Base.init({table: "users"}).table
// 'users'