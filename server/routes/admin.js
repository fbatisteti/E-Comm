const express = require('express');
const adminRouter = express.Router();
const admin = require('../middlewares/admin');
const {Product} = require("../models/product");
const Order = require("../models/order");
const credentials = require("../credentials");

// ADD PRODUCT
adminRouter.post('/admin/add-product', admin, async (req, res) => {
    try {
        const {name, description, images, quantity, price, category} = req.body;
        let product = new Product({
            name,
            description,
            images,
            quantity,
            price,
            category,
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

adminRouter.get('/admin/external-api', admin, async (req, res) => {
    var products;
    try {
        products = await fetch(
            credentials.externalApi.br,
            {
                method: 'GET',
                headers: {'Accept': 'application/json',},
            })
            .then((response) => response.json());
    } catch (e) {
        return res
            .status(500) // Internal Server Error
            .json({
                error: e.message,
            });
    }

    var convertedProducts = [];

    products.forEach(product => {
        convertedProducts.push(new Product({
            name: product['nome'],
            description: (product['descricao'] + ' / Material: ' + product['material'] + ' / Status: ' + product['categoria']),
            images: product['imagem'],
            quantity: Math.floor(Math.random() * 101), // random de 0 a 100
            price: parseFloat(product['preco']),
            category: getCategoria(product['departamento']), // conversões devidas
            ratings: [{
                userId: 'x',
                rating: (Math.floor(Math.random() * 49) + 1)/10,
            }], // random de 1 a 5
        }));
    });

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

module.exports = adminRouter;
