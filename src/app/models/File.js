const db = require('../../config/db')


const Base = require('./Base');

Base.init({ table: 'files' })


const Files = {
    ...Base,
}


module.exports = Files