

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
        // return res.redirect('/')
    }

    next()
}

function onlyAdmin(req, res, next) {
    if (!req.session.userId) return res.redirect("/admin/login");

    if (req.session.userId && req.session.admin == false) {
        return res.redirect("/admin/profile");
    }

    next();
}

async function posterAdmin(req, res, next) {
    if (!req.session.userId) return res.redirect("/admin/login");

    let id = req.params.id;
    if (!id) id = req.body.id;

    const recipe = await Recipe.find(id);
    user = recipe.user_id;

    if (
        req.session.userId &&
        user != req.session.userId &&
        req.session.admin == false
    )
        return res.redirect(`/admin/recipes/${id}`);

    next();
}

module.exports = {
    onlyUsers,
    isLogged
}