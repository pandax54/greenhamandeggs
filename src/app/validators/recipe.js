const Category = require('../models/Category');


async function post(req, res, next) {
    // const categories = await Category.findAll()
    const keys = Object.keys(req.body)

    for (key of keys) {
        if (req.body[key] == "") {
            return res.send("Please fill all the fields")
        }
    }
    // exigir pelo menos uma imagem - como está sendo exigido os campos anteriores
    if (!req.files || req.files.length == 0)
        return res.send('Please, send at least one image')

    next()
}

async function put(req, res, next) {
    const keys = Object.keys(req.body)

    for (key of keys) {
        if (req.body[key] == "" && key !== 'removed_files') {
            console.log(keys)
            console.log(req.body)
            return res.send("Please fill all the fields")
        }
    }
    next()
}


module.exports = {
    post,
    put
}
