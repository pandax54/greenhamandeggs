const express = require('express');
const routes = express.Router();
const ProductController = require('../app/controllers/ProductController');


routes.get("/", ProductController.index)

routes.get("/:id", ProductController.show)

module.exports = routes

//
// now we're gonna create a file just with the route (paths)
// const multer = require('../app/middlewares/multer')
// const HomeController = require('../app/controllers/HomeController');
// const SearchController = require('../app/controllers/SearchController');
// const ProductController = require('../app/controllers/ProductController');
// const express = require('express')
// const routes = express.Router();

// const { onlyUsers } = require('../app/middlewares/session')

// const fieldsValidator = require('../app/validator/product');

// // SEARCH
// routes.get('/search', SearchController.index)


// // PRODUCTS
// routes.get('/create', onlyUsers, ProductController.create)

// // colocaremos agora o multer como filtro, recebendo arquivos do campo photos e limitando a 6 
// routes.post('/', onlyUsers, multer.array("photos", 6), fieldsValidator.post, ProductController.post)
// routes.put('/', onlyUsers, multer.array("photos", 6), fieldsValidator.put, ProductController.put)

// routes.get('/:id/edit', onlyUsers, ProductController.update)
// routes.delete('/', onlyUsers, ProductController.delete)
// // show
// routes.get('/:id', ProductController.show)


// module.exports = routes