const db = require('../../config/db')

// const { hash } = require("bcryptjs");
// const fs = require("fs")

const Base = require('./Base');

Base.init({ table: 'chefs' })


const Chef = {
    ...Base
}

module.exports = Chef