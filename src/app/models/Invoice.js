const db = require('../../config/db')

// const { hash } = require("bcryptjs");
// const fs = require("fs")

const Base = require('./Base');

Base.init({ table: 'invoice' })


const Invoice = {
    ...Base
}

module.exports = Invoice