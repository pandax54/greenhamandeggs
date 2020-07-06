const db = require('../../config/db')

// const { hash } = require("bcryptjs");
// const fs = require("fs")

const Base = require('./Base');

Base.init({ table: 'diet_restriction' })


const dietRestriction = {
    ...Base
}

module.exports = dietRestriction