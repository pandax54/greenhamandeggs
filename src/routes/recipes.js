const express = require('express');
const routes = express.Router();
const { isLogged, onlyUsers } = require("../app/middlewares/session");

const RecipeController = require("../app/controllers/RecipeController")

routes.get("/", RecipeController.index)

routes.get("/recipe-form", RecipeController.create)

routes.get("/recipe-edit/:id", RecipeController.edit)

routes.get("/recipe/:id", RecipeController.show)


module.exports = routes  