const db = require('../../config/db')


const Base = require('./Base');

Base.init({ table: 'difficulties' })


const Difficulties = {
    ...Base,
}


module.exports = Difficulties