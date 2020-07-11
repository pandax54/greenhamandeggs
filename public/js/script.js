// ==== INGREDIENTS FIELDS =========

function addIngredient() {
    console.log('click')
    const ingredients = document.querySelector("#ingredients");
    const fieldContainer = document.querySelectorAll(".ingredients-container");

    // Realiza um clone do último ingrediente adicionado
    const newField = fieldContainer[fieldContainer.length - 1].cloneNode(true);

    console.log(newField.children[1].querySelector("button"))

    // Não adiciona um novo input se o último tem um valor vazio
    if (newField.children[0].value == "") return false;

    // Deixa o valor do input vazio
    newField.children[0].value = "";
    ingredients.appendChild(newField);
}


document
    .querySelector(".add-ingredient")
    .addEventListener("click", addIngredient);


function remove(event) {

    const field = event.target.parentNode.parentNode.parentNode

    const fieldContainer = document.querySelectorAll(".ingredients-container");

    if (fieldContainer.length < 2) {
        alert('you cant delete all fields')
        return
    } else {

        return field.remove()
    }

}


// ==== INSTRUCTION FIELDS =========

function addInstructions() {
    console.log('click')
    const ingredients = document.querySelector("#instructions");
    const fieldContainer = document.querySelectorAll(".instructions-container");

    // Realiza um clone do último ingrediente adicionado
    const newField = fieldContainer[fieldContainer.length - 1].cloneNode(true);

    console.log(newField.children[1].querySelector("button"))

    // Não adiciona um novo input se o último tem um valor vazio
    if (newField.children[0].value == "") return false;

    // Deixa o valor do input vazio
    newField.children[0].value = "";
    ingredients.appendChild(newField);
}


document
    .querySelector(".add-instructions")
    .addEventListener("click", addInstructions);


function remove(event) {

    const field = event.target.parentNode.parentNode.parentNode

    const fieldContainer = document.querySelectorAll(".instructions-container");

    if (fieldContainer.length < 2) {
        alert('you cant delete all fields')
        return
    } else {

        return field.remove()
    }

}


const Mask = {
    apply(input, func) {

        setTimeout(() => {

            input.value = Mask[func](input.value)

        }, 1)

    },
    formatPreparation(value) {

        value = value.replace(/(.*\.)[a-zA-Z0-9,.!? ]*$/, '$1@')
        return value
    }
}