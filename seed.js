const faker = require('faker')
const { hash } = require('bcryptjs')

const User = require('./src/app/models/User')

let usersIds = []
let totalUsers = 10
let totalChefs = 8

async function createUsers() {
    const users = []
    const password = await hash('1111', 8)

    while (users.length < totalUsers) {
        users.push({
            name: faker.name.firstName(),
            email: faker.internet.email(),
            password,
            is_admin: false
        })
    }

    const usersPromise = users.map(user => User.create(user))

    usersIds = await Promise.all(usersPromise)
}


async function init() {
    await createUsers()
}

init()