const multer = require('multer')


// onde será armazenada
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, './public/images')
    },
    filename: (req, file, cb) => {
        // qual nome o arquivo será armazenado
        cb(null, `${Date.now().toString()}-${file.originalname}`)
    }
})

// quais arquivos irei aceitar o arquivo - jpg, png etc
const fileFilter = (req, file, cb) => {
    // quais formatos serão aceitos serão colocados em um array
    const isAccepted = ['image/png', 'image/jpg', 'image/jpeg']
        // percorrendo no array para verificar se a file uloaded tem formato descrito em um dos elementos do array
        .find(acceptedFormat => acceptedFormat == file.mimetype)

    if (isAccepted) {
        return cb(null, true)
    }

    return cb(null, false)

}

module.exports = multer({
    storage,
    fileFilter
})