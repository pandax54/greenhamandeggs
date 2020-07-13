
const recipeDelete = document.querySelector('#form-delete')
recipeDelete.addEventListener("submit", function () {
    const confirmation = confirm("Please, confirm the recipe deletion")
    if (!confirmation) {
        e.preventDefault()
    }
})
