const express = require('express');
const productRouter = express.Router();
const auth = require('../middlewares/auth');
const Product = require("../models/product");
const credentials = require("../credentials");

// api/endpoint?param=value -> req.query.param
// api/endpoit:param=value -> req.params.param

// GET PRODUCT FROM CATEGORY
productRouter.get('/api/products', auth, async (req, res) => {
    try {
        const products = await Product.find({category: req.query.category});
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
