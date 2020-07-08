// const e = require("express");


const Mask = {
    apply(input, func) {

        setTimeout(() => {

            input.value = Mask[func](input.value)

        }, 1)

    },
    formatBRL(value) {

        value = value.replace(/\D/g, "");

        return Intl.NumberFormat('pt-BR', {
            style: 'currency',
            currency: 'BRL'
        }).format(value / 100)
    },
    formatCPF(value) {

        // 000.000.000-00
        return value
            .replace(/\D/g, "")
            .replace(/(\d{3})(\d)/, '$1.$2')
            .replace(/(\d{3})(\d)/, '$1.$2')
            .replace(/(\d{3})(\d{2})/, '$1-$2')
            .replace(/(-\d{2})\d+?$/, '$1')

    },
    formatCEP(value) {

        // 00000-00
        return value
            .replace(/\D/g, "")
            .replace(/(\d{5})(\d{3})/, '$1-$2')
            .replace(/(-\d{3})\d+?$/, '$1')
    },
    cpfCnpj(value) {

        value = value.replace(/\D/g, "")

        // if (value.length > 14) {
        // value = value.slice(0, -1)
        // }

        // check if cpnj
        if (value.length > 11) {
            // 11.222.333/4444-55 -> exemplo de cnpj

            // 11.222333444455
            value = value.replace(/(\d{2})(\d)/, "$1.$2")
            // 11.222.333444455
            value = value.replace(/(\d{3})(\d)/, "$1.$2")
            // 11.222.333/444455
            value = value.replace(/(\d{3})(\d)/, "$1/$2")
            // 11.222.333/4444-55
            value = value.replace(/(\d{4})(\d)/, "$1-$2")
            // nao permitir mais entradas
            value = value.replace(/(-\d{2})\d+?$/, '$1')

        } else if (value.length == 11) {
            // cpf
            value = value.replace(/(\d{3})(\d)/, '$1.$2')
            value = value.replace(/(\d{3})(\d)/, '$1.$2')
            value = value.replace(/(\d{3})(\d)/, '$1-$2')

            //value = value.replace(/(\d{3})(\d{2})/, '$1-$2')
            //value = value.replace(/(-\d{2})\d+?$/, '$1')



        }

        return value
    }
}

const Validate = {
    apply(input, func) {
        // para evitar que se acumulem muitas mensagens de invalidação, toda vez que entrar no campo as mensagens sao limpas

        //Validate.clearErrors(input)  ---> !!!


        // nao precisa do setTimeout porque estaremos acionando esse com onblur
        // input.value = Mask[func](input.value)
        // let results = Validate[func](input.value)
        let results = Validate[func](input)

        input.value = results.value

        if (results.error) {
            //Validate.displayError(input, results.error)
            Validate.displayErrorInInput(input, results.error)
            //alert(results.error)
            // chamando novamente para o input- o cursor continua dentro do campo
            //Validate.display(input, results.error)
        } else {
            Validate.clearInput(input)
        }

    },
    displayError(input, error) {

        const div = document.createElement('div')
        div.classList.add('error')
        div.innerHTML = error
        input.parentNode.appendChild(div)
        input.focus()
    },
    displayErrorInInput(input, error) {

        //const div = document.createElement('div')
        //div.classList.add('error')
        input.classList.add('error')
        input.placeholder = error
        //input.parentNode.appendChild(div)
        input.focus()
    },
    clearErrors(input) {
        // identificar o errorDiv, se tiver, retirá-lo 
        const errorDiv = input.parentNode.querySelector(".error")
        if (errorDiv)
            errorDiv.remove()
    },
    clearInput(input) {
        console.log(input)
        input.classList.remove('error')

    },
    isEmail(input) {
        //const regex = /^\D+@\w+\.(com|com\.br)$/gm;
        // /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
        //const str = `fernanda.panda@gmail.com
        let error = null
        const mailFormat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/

        let value = input.value

        // match(regexp)
        if (!input.value.match(mailFormat)) {
            error = "Email inválido"
        } else {
            Validate.clearInput(input)
        }

        return {
            error,
            value
        }

    },
    isCpfCnpj(input) {
        let error = null

        let value = input.value

        const cleanValues = input.value.replace(/\D/, "")

        if (cleanValues > 11 && cleanValues.length !== 14) {
            error = "CNPJ incorreto"
        } else if (cleanValues.length < 12 && cleanValues.length !== 11) {
            error = "CPF incorreto"
        } else {
            Validate.clearInput(input)
        }

        return {
            error,
            value
        }

    },
    isCep(input) {
        let error = null

        let value = input.value

        const cleanValues = input.value.replace(/\D/g, "")

        if (cleanValues.length !== 8) {
            error = "CEP inválido"
        } else {
            Validate.clearInput(input)
        }

        return {
            error,
            value
        }
    },
    allFields(e) {
        const items = document.querySelectorAll('.item input, .item select, .item textarea')

        for (item of items) {
            if (item.value == "") {
                // recriar o elemento message.njk por meio do js
                const message = document.createElement('div')
                message.classList.add('messages')
                message.classList.add('error')
                message.style.position = 'fixed'
                message.innerHTML = "Preencha todos os campos"
                document.querySelector('body').append(message)

                // alert("please fill all fields") 
                e.preventDefault()
            }
        }
    }
}


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

// https://stackoverflow.com/questions/5813344/how-to-customize-input-type-file
// https://tympanus.net/codrops/2015/09/15/styling-customizing-file-inputs-smart-way/
// https://css-tricks.com/snippets/css/custom-file-input-styling-webkitblink/
// https://www.youtube.com/watch?v=GNA4FldprF8
// https://www.youtube.com/watch?v=tUkQxzdSJ20
// https://www.youtube.com/watch?v=GBDMr24O_rs

// -========================= IMAGE GALLERY ============================================
const ImageGallery = {
    // para selecionar o hightligh e trocar a imagem em destaque para a imagem selecionada
    hightlight: document.querySelector('.highlight .gallery > img'),
    // selecionar todas as imagens 
    previews: document.querySelectorAll('.gallery-preview img'),
    setImage(e) {
        const { target } = e

        // retirar de todas para adicionar na foto clicada
        ImageGallery.previews.forEach(preview => preview.classList.remove('active'))

        // adicionar a classe de ativo quando a imagem for clicada
        target.classList.add('active')

        // substituir pela imagem clicada
        ImageGallery.hightlight.src = target.src
        // !! agora é a imagem que aparece no lightbox é a imagem com a classe active
        Lightbox.image.src = target.src
    }
}

const Lightbox = {
    target: document.querySelector('.lightbox-target'),
    image: document.querySelector('.lightbox-target img'),
    closeButton: document.querySelector('.lightbox-target a.lightbox-close'),
    open() {
        // mudando agora a opacity pelo js para que o lightbox fique visível
        Lightbox.target.style.opacity = 1
        Lightbox.target.style.top = 0
        Lightbox.target.style.bottom = 0

        Lightbox.closeButton.style.top = 0
        // mudar o target da imagem que expande acima !!


    },
    close() {
        Lightbox.target.style.opacity = 0
        Lightbox.target.style.top = "-100%"
        Lightbox.target.style.bottom = "initial"

        Lightbox.closeButton.style.top = "-80px"
    }
}


//=============================

// var tableElements = document.getElementsByClassName("element");
// console.log(tableElements);
// console.log(tableElements.length);

// for(var i=0;i<tableElements.length;i++){
//    tableElements[i].addEventListener("click", dispElementData(this));
// } //doesnt work

// var tableElements = document.querySelectorAll(".element");

// tableElements.forEach(function(element) {
//     element.addEventListener("click", function() {
//         dispElementData(this);
//     });
// });

// document.addEventListener("DOMContentLoaded", function(){
//     var tableElements = document.getElementsByClassName("element");  
// for(var i=0;i<tableElements.length;i++){ 
//   tableElements[i].addEventListener("click", dispElementData(this)); 
// }
// })




https://github.com/viniciusmoreeira/foodfy
https://github.com/Rocketseat/bootcamp-launchbase-desafios-04/blob/master/desafios/04-admin-foodfy.md