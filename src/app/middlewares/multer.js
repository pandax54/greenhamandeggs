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


// ABOUT MULTER AND UPLOAD 
// https://www.youtube.com/watch?v=MkkbUfcZUZM
// https://www.youtube.com/watch?v=FKnDvu_eODY
// https://www.youtube.com/watch?v=9Qzmri1WaaE

// https://code.tutsplus.com/tutorials/file-upload-with-multer-in-node--cms-32088
// https://github.com/expressjs/multer#:~:text=Multer%20is%20a%20node.,multipart%2Fform%2Ddata%20).