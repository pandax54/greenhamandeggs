const { unlinkSync } = require("fs");

const ProductImage = require("../models/ProductImage");

const DeleteFiles = {
    deleteFiles(files) {
        files.map((file) => {
            try {
                ProductImage.delete(file.file_id);
                unlinkSync(file.path);
            } catch (err) {
                console.error(err);
            }
        });
    },
    async removedFiles(fields) {
        const removedFiles = fields.removed_files.split(",");
        const lastIndex = removedFiles.length - 1;
        removedFiles.splice(lastIndex, 1);

        const removedFilesPromise = removedFiles.map(async (id) => {
            try {
                const file = await ProductImage.findOne({ where: { id } });
                ProductImage.delete(id);
                unlinkSync(file.path);
            } catch (err) {
                console.error(err);
            }
        });

        await Promise.all(removedFilesPromise);
    },
};

module.exports = DeleteFiles;