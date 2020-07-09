
const formDelete = document.querySelector('#form-delete')
formDelete.addEventListener("submit", function () {
    const confirmation = confirm("Deseja deletar o produto")
    if (!confirmation) {
        e.preventDefault()
    }
})