const formDelete = document.querySelector('#form-delete')
formDelete.addEventListener("submit", function () {
    const confirmation = confirm("Are you sure do you want to delete your account?")
    if (!confirmation) {
        e.preventDefault()
    }
})