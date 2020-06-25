const Recipe = require('../models/Recipe');

// const LoadService = require('../services/LoadProductService');
const user = require('../validator/user');




module.exports = {
    async index(req, res) {

        return res.send("hello")
        // return res.render("user/register")
    },

}