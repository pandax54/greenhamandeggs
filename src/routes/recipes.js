const express = require('express');
const routes = express.Router();

const RecipeController = require("../app/controllers/RecipeController")

routes.get("/", RecipeController.index)


module.exports = routes  