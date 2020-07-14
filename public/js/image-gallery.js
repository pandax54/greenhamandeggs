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