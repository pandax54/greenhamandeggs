const formDelete = document.querySelector('#form-delete')
formDelete.addEventListener("submit", function () {
    const confirmation = confirm("Tem certeza que deseja excluir sua conta? Essa operação não poderá ser desfeita")
    if (!confirmation) {
        e.preventDefault()
    }
})