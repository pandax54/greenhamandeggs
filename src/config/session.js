const session = require('express-session')
// https://www.npmjs.com/package/express-session

const pgSession = require('connect-pg-simple')(session)

const db = require('./db')


module.exports = session({
    store: new pgSession({
        pool: db
    }),
    secret: 'ham',
    resave: false,
    saveUninitialized: false,
    cookie: {
        // miliseconds -> 30 days
        maxAge: 30 * 24 * 60 * 60 * 1000
    }
})