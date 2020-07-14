

module.exports = {

    async index(req, res) {

        return res.render("products/index")

    },
    async show(req, res) {
        return res.render("products/show")
    }
}