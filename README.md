
<h1 align="center">
    <img style="display: block; margin: 60px auto" src="https://i.imgur.com/R0gjOhT.png">
</h1>

<!-- <p align="center">
![stacks](https://img.shields.io/static/v1?label=Nodejs&message=v12.17.0&color=7EC83E)  ![stacks](https://img.shields.io/static/v1?label=Nunjucks&message=v16.13.1&color=7EC83E)  ![stacks](https://img.shields.io/static/v1?label=CSS&message=v16.13.1&color=FF876C)  ![stacks](https://img.shields.io/static/v1?label=stack&message=VanillaJS&color=FF876C)  ![stacks](https://img.shields.io/static/v1?label=stack&message=Express&color=01B8FE)
<p align="center"> -->

<p align="center">
 
 <img alt="Node" src="https://img.shields.io/static/v1?label=Nodejs&message=v12.17.0&color=7EC83E">
  
 <img alt="Nunjucks" src="https://img.shields.io/static/v1?label=Nunjucks&message=v16.13.1&color=7EC83E">

<img alt="CSS" src="https://img.shields.io/static/v1?label=CSS&message=v16.13.1&color=FF876C">

<img alt="JS" src="https://img.shields.io/static/v1?label=stack&message=VanillaJS&color=FF876C">

<img alt="Express" src="https://img.shields.io/static/v1?label=stack&message=Express&color=01B8FE">
</p>


## Project
:us: __GREEN HAM AND EGGS COOKBOOK__ is a project developed in nodeJS, express, Vanilla js and CSS. It's a recipe website with a store to sells Dr Seuss kitchen related products. The goal is to show the knowledge and skills learned in the Launchbase bootcamp from Rocketseat.


<div align="center">
  <img src="https://i.imgur.com/frR7Zmh.jpg"/>
  <img src="https://i.imgur.com/RajXUfB.jpg"/>
  <img src="https://i.imgur.com/DfeRlDm.jpg"/>
</div>

</br>

## Technologies

#### :us: This project was developed with the following technologies:
<span style="margin-right: 5px">

- [Express](https://github.com/expressjs/express)
- [Multer](https://www.npmjs.com/package/multer)
- [Node.js](https://nodejs.org/en/) 
- [PostgreSQL](https://www.postgresql.org/)
- [Nunjucks](https://mozilla.github.io/nunjucks/)
- [Faker.js](https://github.com/marak/Faker.js/)
- [Lottie](https://github.com/airbnb/lottie-web)

## Tools
- [Visual Studio Code](https://code.visualstudio.com)
- [Insomnia](https://insomnia.rest)
- Postbird
</br>

## Features

- [x] Dynamic pages and content powered by Nunjucks.
- [x] Database powered by Postgresql.
- [x] Being able to add new recipes, update and delete them.
- [x] Search recipes.
- [x] Pagination.
- [x] Upload images to database using Multer.
- [x] Image Gallery with Lightbox feature.
- [x] Complete login system, with administrators and regular users.
- [x] Routes with Validators.
- [x] Nodemailer to reset and recover passwords.
- [x] Users, Recipes and Images seeds available thanks to Faker.js. 
<!-- - [x] Feedback animations powered by Lottie. -->
- [x] Store and cart functionalities.
- [x] Invoice and orders details pages for users.


## How to use


### Start the Application
You need the following tools installed in order to run this project:
  [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git), [Node.js + NPM](https://nodejs.org/en/), [PostgreSQL](https://www.postgresql.org/download/), and [Postbird](https://www.electronjs.org/apps/postbird).
Clone the project in your computer and execute these commands:

<div align="center">
  <img src="https://i.imgur.com/4barDSZ.png"/>
</div>

### Set up the database

   ```bash
   psql -U <username> -c "CREATE DATABASE hamandeggs"
   psql -U <username> -d hamandeggs -f hamandeggs.sql
   ```

   You can manually import the hamandeggs.sql to Postbird or use the code in database.sql, remember to create a new database with the name hamandeggs.

   ```bash
   Important!
   You have to alter the db.js, located in src/config to match your PostgreSQL settings.    
   You also have to alter the mailer.js, located in src/lib to match your Mailtrap settings.  
   ```

### Populate it with Faker.js

<div align="center">
  <img src="https://i.imgur.com/Bwj9l9x.png"/>
</div>


## Some examples of the layout

You can find more images examples of the layout inside the "UI design" folder.

![](./Screen_1.gif)
![](./Screen_2.gif)
![](./Screen_3.gif)

<div align="center">
  <img src="https://i.imgur.com/hiB5Hcc.gif"/>
  <img src="https://i.imgur.com/OHo6jQT.gif"/>
  <img src="https://i.imgur.com/P0Wkmoo.gif"/>
  <img src="https://i.imgur.com/GkTpDxf.gif"/>
</div>


---
###### Developed on Launchbase from [RocketSeat](https://rocketseat.com.br) :rocket:. 

