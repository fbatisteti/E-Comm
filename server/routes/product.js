const express = require('express');
const productRouter = express.Router();
const auth = require('../middlewares/auth');
const Product = require("../models/product");

// api/endpoint?param=value -> req.query.param
// api/endpoit:param=value -> req.params.param

// GET PRODUCT FROM CATEGORY
productRouter.get('/api/products', auth, async (req, res) => {
    let searchCategory = req.query.category;
    try {
        const products = (searchCategory == undefined) // ou seja, não enviou / não existe
        ? await Product.find({})
        : await Product.find({category: req.query.category});
        res.json(products);
    } catch (e) {
        return res
            .status(500) // Internal Server Error
            .json({
                error: e.message,
            });
    }
});

// GET PRODUCT FROM SEARCH
productRouter.get('/api/products/search/:query', auth, async (req, res) => {
    try {
        const products = await Product.find({
            name: {$regex: req.params.query, $options: "i"},
            description: {$regex: req.params.query, $options: "i"},
        });
        res.json(products);
    } catch (e) {
        return res
            .status(500) // Internal Server Error
            .json({
                error: e.message,
            });
    }
});

// RATE PRODUCT
productRouter.post('/api/rate-product', auth, async (req, res) => {
    try {
        const { id, rating } = req.body;
        let product = await Product.findById(id);

        for (let i = 0; i < product.ratings.length; i++) {
            if (product.ratings[i].userId == req.user) { // pegando USER do middleware
                product.ratings.splice(i, 1); // "pop" localizado
                break;
            }
        };

        const ratingSchema = {
            userId: req.user,
            rating,
        };
        
        product.ratings.push(ratingSchema);
        product = await product.save();

        res.json(product);
    } catch (e) {
        return res
            .status(500) // Internal Server Error
            .json({
                error: e.message,
            });
    }
})

// DEAL OF THE DAY
productRouter.get('/api/deal-of-day', auth, async (req, res) => {
    try {
        let products = await Product.find({});

        products = products.sort((a, b) => {
            let aSum = 0;
            let bSum = 0;

            for (let i = 0; i < a.ratings.length; i++) {
                aSum += a.ratings[i];
            };

            for (let i = 0; i < b.ratings.length; i++) {
                bSum += b.ratings[i];
            };

            return (aSum < bSum) ? 1 : -1; // aSum - bSum
        });

        res.json(products[0]); // o maior
    } catch (e) {
        return res
            .status(500) // Internal Server Error
            .json({
                error: e.message,
            });
    }
})

module.exports = productRouter;
