const express = require('express');
const routes = express.Router();
const ProductController = require('../app/controllers/ProductController');


routes.get("/", ProductController.index)

routes.get("/:id", ProductController.show)

routes.get("/test/:id", ProductController.teste)

module.exports = routes