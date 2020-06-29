// pg_ctl -D /usr/local/var/postgres start

const { Pool } = require("pg");

module.exports = new Pool({
    user: "fernandapenna",
    password: "",
    host: "localhost",
    port: 5432,
    database: "hamandeggs"
});