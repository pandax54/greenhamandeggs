const express = require('express');
const routes = express.Router();
const AdminController = require('../app/controllers/AdminController');
const { isLogged, onlyUsers, onlyAdmin } = require("../app/middlewares/session");
const multer = require('../app/middlewares/multer')
const fieldsValidator = require('../app/validators/product');

routes.get("/", AdminController.index)

routes.get("/form", AdminController.create)
routes.post("/form", onlyUsers, multer.array("photos", 6), fieldsValidator.post, AdminController.post)
///admin/add-product
///admin/list-product
///admin/form-product

module.exports = routes  