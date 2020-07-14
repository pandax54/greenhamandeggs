const express = require('express');
const routes = express.Router();
const { isLogged, onlyUsers } = require("../app/middlewares/session");
const multer = require('../app/middlewares/multer')

const RecipeController = require("../app/controllers/RecipeController")

const SearchController = require('../app/controllers/SearchController')

const fieldsValidator = require('../app/validators/recipe');

routes.get("/", RecipeController.index)

routes.get("/recipe-form", RecipeController.create)

routes.get("/recipe-edit/:id", RecipeController.edit)

routes.get("/recipe/:id", RecipeController.show)

// SEARCH
routes.get('/search', SearchController.index)

// colocaremos agora o multer como filtro, recebendo arquivos do campo photos e limitando a 6 
routes.post('/recipe-form', onlyUsers, multer.array("photos", 6), fieldsValidator.post, RecipeController.post)
routes.put('/recipe-form', onlyUsers, multer.array("photos", 6), fieldsValidator.put, RecipeController.put)
routes.delete("/recipe-form", onlyUsers, RecipeController.delete);


module.exports = routes  