const express = require('express');
const routes = express.Router();
const AdminController = require('../app/controllers/AdminController');
const { isLogged, onlyUsers, onlyAdmin } = require("../app/middlewares/session");
const multer = require('../app/middlewares/multer')
const fieldsValidator = require('../app/validators/product');

routes.get("/", AdminController.index)

routes.get("/form", onlyAdmin, AdminController.create)
routes.post("/form", onlyAdmin, multer.array("photos", 6), fieldsValidator.post, AdminController.post)


routes.get("/form-edit/:id", onlyAdmin, AdminController.edit)
routes.put("/form-edit", onlyAdmin, multer.array("photos", 6), fieldsValidator.put, AdminController.put)

routes.delete("/form", onlyAdmin, AdminController.delete);

module.exports = routes  