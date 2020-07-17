const { formatUSD } = require('./utils');
// o carrinho fica guardado na sessão (req.session) assim ele ficará acessível por toda a aplicacao
const Cart = {
    init(oldCart) {
        if (oldCart) {
            this.items = oldCart.items // [{ product: {}, price, quantity, for}, {}]
            this.total = oldCart.total
        } else {
            // primeira vez que a pessoa entrar, carrinho vazio
            this.items = []
            this.total = {
                quantity: 0,
                price: 0,
                formattedPrice: formatUSD(0)
            }
        }
        return this
    },
    // adicionar um item do carrinho + 1
    addOne(product) {
        // ver se o produto já existe no carrinho
        let inCart = this.items.find(item => item.product.id == product.id)

        // se nao existe, adicionar o produto
        // primeiramente a quantidade será zero porque iremos adicionar em uma lógica posterior
        if (!inCart) {
            inCart = {
                product: {
                    ...product,
                    formattedPrice: formatUSD(product.price)
                },
                quantity: 0,
                price: 0,
                formattedPrice: formatUSD(0)
            }

            this.items.push(inCart)
        }

        if (inCart.quantity >= product.quantity) return this

        // update item
        inCart.quantity++
        inCart.price = inCart.product.price * inCart.quantity
        inCart.formattedPrice = formatUSD(inCart.price)

        // update cart
        this.total.quantity++
        this.total.price += inCart.product.price
        this.total.formattedPrice = formatUSD(this.total.price)

        return this

    },
    // remover um item do carrinho - 1
    removeOne(productId) {
        // Verificar se o item existe no carrinho, e pegá-lo
        const inCart = this.items.find(item => item.product.id == productId)
        // alternative to use DRY
        // const inCart =  this.getCartItem(productId)

        // caso ele nao existe, nao fazer nada
        if (!inCart) return this

        // atualizar o item
        // inCart.quantity = inCart.quantity - 1
        inCart.quantity--
        inCart.price = inCart.product.price * inCart.quantity
        inCart.formattedPrice = formatUSD(inCart.price)

        // atualizar o carrinho
        this.total.quantity--
        this.total.price -= inCart.product.price
        this.total.formattedPrice = formatUSD(this.total.price)

        // se a quantidade do produto no carrinho for 0 entao removê-lo
        if (inCart.quantity < 1) {
            const itemIndex = this.items.indexOf(inCart)


            // ALTERNATIVE FORM
            // const filteredItems = this.items.filter(item => item.product.id != inCart.product.id)
            // this.items = filteredItems
            // podemos fazer direto também
            // this.items = this.items.filter(item => item.product.id != inCart.product.id)

            // pegar todos os items que nao sao o produto em questao
            this.items.splice(itemIndex, 1)
            return this
        }
        return this
    },
    // deletar o item do carrinho (delete)
    delete(productId) {
        const inCart = this.getCartItem(productId)
        if (!inCart) return this

        if (this.items.length > 0) {

            this.total.quantity -= inCart.quantity
            this.total.price -= inCart.price
            this.total.formattedPrice = formatUSD(this.total.price)

        }
        this.items = this.items.filter(item => item.product.id != inCart.product.id)

        return this

    },
    getCartItem(productId) {
        return this.items.find(item => item.product.id == productId)
    }
}


// TESTE
// const product = {
//     id: 1,
//     price: 199,
//     quantity: 4
// }

// const product2 = {
//     id: 2,
//     price: 299,
//     quantity: 3
// }

// const product3 = {
//     id: 3,
//     price: 599,
//     quantity: 3
// }

// console.log('add first cart item')
// let oldCart = Cart.init().addOne(product)
// // console.log(oldCart)

// console.log('add second cart item')
// oldCart = Cart.init(oldCart).addOne(product)
// // console.log(oldCart)

// console.log('add last cart item')
// oldCart = Cart.init(oldCart).addOne(product)
// // console.log(oldCart)

// console.log('add third cart item')
// oldCart = Cart.init(oldCart).addOne(product2)
// // console.log(oldCart)

// console.log('add third cart item')
// oldCart = Cart.init(oldCart).addOne(product2)
// // console.log(oldCart)

// console.log('add third cart item')
// oldCart = Cart.init(oldCart).addOne(product3)

// console.log('removing one item')
// oldCart = Cart.init(oldCart).removeOne(product.id)
// console.log(oldCart)

// console.log('removing one more item')
// oldCart = Cart.init(oldCart).removeOne(product.id)
// console.log(oldCart)

// oldCart = Cart.init(oldCart).delete(product2.id)
// console.log(oldCart)

module.exports = Cart 