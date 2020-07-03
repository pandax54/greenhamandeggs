const express = require('express');
const routes = express.Router();

const RecipeController = require("../app/controllers/RecipeController")

routes.get("/", RecipeController.index)

routes.get("/recipe-form", RecipeController.create)


module.exports = routes  