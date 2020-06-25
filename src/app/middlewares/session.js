function onlyUsers(req, res, next) {

    // se nao tem user.id, redireciona para a página de login
    if (!req.session.userId) {
        return res.redirect("/users/login")
    }

    console.log(req.session.userId)

    next()
}

function isLogged(req, res, next) {

    if (req.session.userId) {
        return res.redirect('/users')
    }

    next()
}

module.exports = {
    onlyUsers,
    isLogged
}