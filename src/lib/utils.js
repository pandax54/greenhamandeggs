module.exports = {
    age(timestamp) {
        const today = new Date();
        const birthDate = new Date(timestamp);

        let age = today.getFullYear() - birthDate.getFullYear();
        const month = today.getMonth() - birthDate.getMonth();

        if (month < 0 || (month == 0 && today.getDate() <= birthDate.getDate())) {
            age = age - 1;
        }
        return age;
    },
    date(timestamp) {
        const date = new Date(timestamp)

        // yyyy
        // const year = date.getUTCFullYear()
        const year = date.getFullYear()

        //mm
        //const month = `0${date.getUTCMonth() + 1}`.slice(-2) 

        // const month = (date.getUTCMonth() + 1 < 10) ? `0${date.getUTCMonth() + 1}` : date.getUTCMonth() + 1
        const month = (date.getMonth() + 1 < 10) ? `0${date.getMonth() + 1}` : date.getMonth() + 1

        // dd
        // const day = `0${date.getUTCDate()}`.slice(-2);
        const day = `0${date.getDate()}`.slice(-2);

        const hour = date.getHours();

        const minutes = date.getMinutes();

        // yyyy-mm-dd
        // console.log(`${year}-${month}-${day}`)

        // return `${year}-${month}-${day}`
        // I want options to show the data, so I am gonna create an object
        return {
            day,
            month,
            year,
            hour,
            minutes,
            "iso": `${year}-${month}-${day}`,
            "birthDay": `${day}/${month}`,
            format: `${day}/${month}/${year}`
            // you now must called it inside the functions 

        }
    },
    formatPrice(price) {
        return Intl.NumberFormat('pt-BR', {
            style: 'currency',
            currency: 'BRL'
        }).format(price / 100)
    },
};