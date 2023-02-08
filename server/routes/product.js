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

module.exports = productRouter;
