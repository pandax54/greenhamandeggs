// UPLOAD DE FOTOS

const photoUpload = {
    input: "",
    preview: document.querySelector("#photos-preview"),
    photoLimit: 6,
    files: [],
    handleUploadPhoto(event) {

        const { files: fileList } = event.target
        photoUpload.input = event.target

        if (photoUpload.hasLimit(event)) return


        // fileList é um tipo de list entao para user forEach precisamos transformar em array
        Array.from(fileList).forEach(file => {

            // colocando no array 
            photoUpload.files.push(file)

            // permite que o js leia arquivo
            const reader = new FileReader();

            reader.onload = () => {
                const img = new Image(); // == <img />

                img.src = String(reader.result)

                // const container = document.createElement('div')
                const div = photoUpload.getContainer(img)

                photoUpload.preview.appendChild(div)
            }

            // depois que isso estiver pronto ele irá carregar a func onload
            reader.readAsDataURL(file)

        })

        // now we can add new photos without lost the previous one
        photoUpload.input.files = photoUpload.getAllfiles();
    },
    getContainer(image) {

        const div = document.createElement('div')
        div.classList.add('photo')

        div.onclick = photoUpload.removePhoto

        div.appendChild(image)

        div.appendChild(photoUpload.getRemoveButton())

        return div
    },
    hasLimit(event) {
        const { photoLimit, input: fileList } = photoUpload

        console.log(fileList, fileList.files, fileList.files.length)
        if (fileList.files.length > photoLimit) {
            // console.log('porra')
            alert(`Você atingiu o limite de fotos: máximo de ${photoLimit}`)
            event.preventDefault()
            return true
        }

        return false;
    },
    getRemoveButton() {
        const button = document.createElement('i');
        button.classList.add('material-icons');
        button.innerHTML = "close"
        return button

    },
    getAllfiles() {
        // dataTransfer nao funciona no firefox --> new ClipboardEvent("").clipboardData || new DataTransfer();
        const dataTransfer = new ClipboardEvent("").clipboardData || new DataTransfer();

        photoUpload.files.forEach(file => dataTransfer.items.add(file))


        //console.log(dataTransfer.files)
        return dataTransfer.files
    },
    removePhoto(event) {
        // o "i" está por cima da div da foto ocupando todo o espaço, mas querendo deletar a div inteira com a foto, por isso iremos pegar o parentNode
        const photoDiv = event.target.parentNode // <div class="photo">

        const photosArray = Array.from(photoUpload.preview.children)

        const index = photosArray.indexOf(photoDiv)

        // array.splice(index, howmany, item1, ....., itemX)
        photoUpload.files.splice(index, 1)


        photoUpload.input.files = photoUpload.getAllfiles()

        // deleta a foto somente no frontend, mas elas permanecem no input
        // photosArray[index].remove()
        // removed.remove()
        photoDiv.remove()
    },
    removeOldPhoto(event) {
        const photoDiv = event.target.parentNode

        if (photoDiv.id) {
            const removedFiles = document.querySelector('input[name="removed_files"]') // get the hidden input in DOM
            if (removedFiles) {
                removedFiles.value += `${photoDiv.id}, ` // 1,2,3...
            }
        }
        photoDiv.remove() // tirando do frontend
    }
}