const faker = require('faker')
const { hash } = require('bcryptjs')

const Recipe = require('./src/app/models/Recipe')
const User = require('./src/app/models/User')
const File = require('./src/app/models/File')

let usersIds = []
let totalUsers = 15

let totalRecipes = 15

async function createUsers() {
    const users = []
    const password = await hash('1111', 8)



    while (users.length < totalUsers) {

        let acccount = faker.internet.userName()

        users.push({
            name: faker.name.findName(),
            email: faker.internet.email(),
            password,
            is_admin: false,
            about: faker.lorem.lines(5),
            instagram: acccount,
            twitter: acccount,
            profile_image: `https://source.unsplash.com/collection/2013520/${Math.round(
                Math.random() * 1000
            )}`,
            profile_image: faker.image.avatar()
        })
    }



    const usersPromise = users.map(user => User.create(user))

    usersIds = await Promise.all(usersPromise)
    console.log("Users", usersIds)

}

async function createRecipes() {
    const recipes = []

    while (recipes.length < totalRecipes) {
        recipes.push({
            user_id: usersIds[Math.floor(Math.random() * totalUsers)],
            title: faker.name.title(),
            serving_size: Math.ceil(Math.random() * 10),
            cooking_time: Math.ceil(Math.random() * 40),
            ingredients: '{ "3 kg de carne moída (escolha uma carne magra e macia)", "300 g de bacon moído", "1 ovo", "3 colheres (sopa) de farinha de trigo", "3 colheres (sopa) de tempero caseiro: feito com alho, sal, cebola, pimenta e cheiro verde processados no liquidificador", "30 ml de água gelada"}',
            preparation: '{ "Misture todos os ingredientes muito bem e amasse para que fique tudo muito bem misturado", "Faça porções de 90 g a 100 g", "Forre um plástico molhado em uma bancada e modele os hambúrgueres utilizando um aro como base", "Faça um de cada vez e retire o aro logo em seguida", "Forre uma assadeira de metal com plástico, coloque os hambúrgueres e intercale camadas de carne e plásticos (sem apertar)", "Faça no máximo 4 camadas por forma e leve para congelar", "Retire do congelador, frite ou asse e está pronto"}',
            // preparation:'{Combine milk with vinegar in a medium bowl and set aside for 5 minutes to "sour".@,Combine flour,sugar,baking powder,baking soda,and salt in a large mixing bowl. Whisk egg and butter into "soured" milk. Pour the flour mixture into the wet ingredients and whisk until lumps are gone.@,Heat a large skillet over medium heat,and coat with cooking spray. Pour 1/4 cupfuls of batter onto the skillet,and cook until bubbles appear on the surface. Flip with a spatula,and cook until browned on the other side.@}'
            // ingredients: '{ "meeting", "lunch" }',
            // preparation: '{ "meeting", "lunch" }',
            difficulty_id: Math.ceil(Math.random() * 7),
            diet_restriction_id: Math.ceil(Math.random() * 14),
            meal_type_id: Math.ceil(Math.random() * 5),
            world_cuisine_id: Math.ceil(Math.random() * 18),
            information: faker.lorem.paragraph(Math.ceil(Math.random() * 10)),

        })
    }


    const recipesPromise = recipes.map(recipe => Recipe.create(recipe))
    recipesIds = await Promise.all(recipesPromise)
    console.log("recipes", recipesIds)


    let files = []

    while (files.length < 50) {
        files.push({
            name: faker.image.food(),
            path: `public/images/placeholder.png`,
            recipe_id: recipesIds[Math.floor(Math.random() * totalRecipes)]
        })
    }
    const filesPromise = files.map(file => File.create(file))
    await Promise.all(filesPromise)
    console.log("files")


}


async function init() {
    await createUsers()
    await createRecipes()
}

init()