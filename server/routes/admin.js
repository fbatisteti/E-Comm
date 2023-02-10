const express = require('express');
const adminRouter = express.Router();
const admin = require('../middlewares/admin');
const {Product} = require("../models/product");
const Order = require("../models/order");
const credentials = require("../credentials");

// ADD PRODUCT
adminRouter.post('/admin/add-product', admin, async (req, res) => {
    try {
        const {name, description, images, quantity, price, category, origin} = req.body;
        let product = new Product({
            name,
            description,
            images,
            quantity,
            price,
            category,
            origin,
        });
        product = await product.save();
        res.json(product);
    } catch (e) {
        return res
            .status(500) // Internal Server Error
            .json({
                error: e.message,
            });
    }
});

// GET PRODUCT
adminRouter.get('/admin/get-products', admin, async (req, res) => {
    try {
        const products = await Product.find({});
        res.json(products);
    } catch (e) {
        return res
            .status(500) // Internal Server Error
            .json({
                error: e.message,
            });
    }
});

// ADD FROM API
function getCategoria(depto) {
    switch(depto) {
        case 'Tools':
            return 'Appliances';
        case 'Outdoors':
            return 'Appliances';
        case 'Games':
            return 'Books';
        case 'Books':
            return 'Books';
        case 'Computers':
            return 'Books';
        case 'Music':
            return 'Appliances';
        case 'Garden':
            return 'Appliances';
        case 'Health':
            return 'Essentials';
        case 'Clothing':
            return 'Fashion';
        case 'Shoes':
            return 'Fashion';
        case 'Grocery':
            return 'Essentials';
        case 'Jewelery':
            return 'Fashion';
        case 'Baby':
            return 'Essentials';
        case 'Kids':
            return 'Essentials';
        case 'Industrial':
            return 'Appliances';
        case 'Home':
            return 'Appliances';
        case 'Toys':
            return 'Mobile';
        case 'Movies':
            return 'Mobile';
        case 'Beauty':
            return 'Fashion';
        case 'Electronics':
            return 'Mobile';
        case 'Sports':
            return 'Essentials';
        case 'Vestuário':
            return 'Fashion';
        default:
            return 'Tools';
      }
}

function getRandomCategoria() {
    let i = Math.floor(Math.random() * 6);

    switch (i) {
        case 0:
            return 'Appliances';
        case 1:
            return 'Books';
        case 2:
            return 'Essentials';
        case 3:
            return 'Fashion';
        case 4:
            return 'Mobile';
        default:
            return 'Tools';
    }
}

adminRouter.get('/admin/external-api', admin, async (req, res) => {
    let allProducts = [];
    try {
        let apis = Object.keys(credentials.externalApi);
        var products;

        for (let i = 0; i < apis.length; i++) {
            products = await fetch(
                credentials.externalApi[apis[i]],
                {
                    method: 'GET',
                    headers: {'Accept': 'application/json',},
                })
                .then((response) => response.json());

            allProducts.push([
                apis[i], // chave
                products, // produtos
            ]);
        }
    } catch (e) {
        return res
            .status(500) // Internal Server Error
            .json({
                error: e.message,
            });
    }

    var convertedProducts = [];

    /***
     * Este mapeamento vai depender das suas APIs externas.
     * Como eu já sei como elas vêm, estou ajustando para o padrão delas.
     * 
     * Não vou arriscar mapear "na esperança", pois as chaves dos objetos podem vir
     * de maneiras diferentes dentro dos próprios objetos, o que deixaria qualquer
     * sequenciamneto numérico quase impossível de ser feito.
     */
    for (let i = 0; i < allProducts.length; i ++) {
        allProducts[i][1].forEach(product => {
            convertedProducts.push(new Product({
                name: // nome - name
                    (allProducts[i][0] == 'pt-br')
                    ? product['nome']
                    : product['name'],
                description: // descrição - description / material - details.material / status - details.adjective
                    (allProducts[i][0] == 'pt-br')
                    ? (product['descricao'] + ' / Material: ' + product['material'] + ' / Status: ' + product['categoria'])
                    : (product['description'] + ' / Material: ' + product['details']['material'] + ' / Status: ' + product['details']['adjective']),
                images: // imagem - gallery
                    (allProducts[i][0] == 'pt-br') 
                    ? product['imagem']  
                    : product['gallery'],
                quantity:
                    Math.floor(Math.random() * 101), // random de 0 a 100
                price: // preco - price / _ - if hasDiscount, price * (1 - discountValue)
                    (allProducts[i][0] == 'pt-br')
                    ? parseFloat(product['preco'])
                    : (product['hasDiscount'])
                        ? parseFloat(product['price'] * (1 - product['discountValue']))
                        : parseFloat(product['price']),
                category: // departamento - _ / _ - aleatório
                    (allProducts[i][0] == 'pt-br')
                    ? getCategoria(product['departamento'])
                    : getRandomCategoria(),
                ratings: [{ userId: 'x', rating: (Math.floor(Math.random() * 49) + 1)/10, }], // random de 1 a 5
                origin: allProducts[i][0],
            }));
        });
    }

    convertedProducts.forEach(async product => {
        product = await product.save();
    });

    res.json({msg: "Populated from API"});
})

// DELETE PRODUCT
adminRouter.post('/admin/delete-product', admin, async (req, res) => {
    try {
        const {id} = req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json(product);
    } catch (e) {
        return res
            .status(500) // Internal Server Error
            .json({
                error: e.message,
            });
    }
})

// GET ORDERS
adminRouter.get('/admin/get-orders', admin, async (req, res) => {
    try {
        const orders = await Order.find({});
        res.json(orders);
    } catch (e) {
        return res
            .status(500) // Internal Server Error
            .json({
                error: e.message,
            });
    }
});

// MOVE ORDER FORWARD
adminRouter.post('/admin/change-order-status', admin, async (req, res) => {
    try {
        const { id, status } = req.body;
        let order = await Order.findById(id);
        order.status = status;
        order = await order.save();
        res.json(order);
    } catch (e) {
        return res
            .status(500) // Internal Server Error
            .json({
                error: e.message,
            });
    }
});

// ANALYTICS
adminRouter.get('/admin/analytics', admin, async (req, res) => {
    try {
        const orders = await Order.find({});
        let totalEarnings = 0;

        for (let i = 0; i < orders.length; i++) {
            for (let j = 0; j < orders[i].products.length; j++) {
                totalEarnings += orders[i].products[j].product.price * orders[i].products[j].quantity;
            }
        }
        
        let mobileEarnings = await fetchCategoryWiseProducts('Mobiles');
        let essentialsEarnings = await fetchCategoryWiseProducts('Essentials');
        let appliancesEarnings = await fetchCategoryWiseProducts('Appliances');
        let booksEarnings = await fetchCategoryWiseProducts('Books');
        let fashionEarnings = await fetchCategoryWiseProducts('Fashion');
        
        let earnings = {
            totalEarnings,
            mobileEarnings,
            essentialsEarnings,
            appliancesEarnings,
            booksEarnings,
            fashionEarnings,
        };

        res.json(earnings);
    } catch (e) {
        return res
            .status(500) // Internal Server Error
            .json({
                error: e.message,
            });
    }
});

async function fetchCategoryWiseProducts(category) {
    let earnings = 0;

    let categoryOrders = await Order.find({
        'products.product.category': category,
    });

    for (let i = 0; i < categoryOrders.length; i++) {
        for (let j = 0; j < categoryOrders[i].products.length; j++) {
            earnings += categoryOrders[i].products[j].product.price * categoryOrders[i].products[j].quantity;
        }
    }

    return earnings;
}

module.exports = adminRouter;
