const nodemailer = require("nodemailer")

// configuracao de email
// mailtrap: https://mailtrap.io/


module.exports = nodemailer.createTransport({
    host: "smtp.mailtrap.io",
    port: 2525,
    auth: {
        user: "208edfe1f17e9d",
        pass: "8a21ebdd61d38b"
    }
});