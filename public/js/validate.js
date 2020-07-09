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
