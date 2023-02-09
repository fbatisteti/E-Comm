const express = require('express');
const User = require("../models/user");
const auth = require('../middlewares/auth');
const {Product} = require("../models/product");
const userRouter = express.Router();

userRouter.post('/api/add-to-cart', auth, async (req, res) => {
    try {
        const {id} = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        if (user.cart.length == 0) { // iniciando o carrinho
            user.cart.push({product, quantity: 1});
        } else {
            let productFound = false;
            for (let i = 0; i < user.cart.length; i++) {
              //if (user.cart[i].product._id.toString().equals(id)) {
                if (user.cart[i].product._id.equals(product._id)) { // já existe o produto
                    productFound = true;
                }
            }

            if (productFound) {
                let targetProduct = user.cart.find((target) => target.product._id.equals(product._id));
                targetProduct.quantity += 1;
            } else {
                user.cart.push({product, quantity: 1});
            }
        }
        user = await user.save();
        res.json(user);
    } catch (e) {
        return res
            .status(500) // Internal Server Error
            .json({
                error: e.message,
            });
    }
});

userRouter.delete('/api/remove-from-cart/:id', auth, async (req, res) => {
    try {
        const {id} = req.params;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        for (let i = 0; i < user.cart.length; i++) {
            if (user.cart[i].product._id.equals(product._id)) {
                (user.cart[i].quantity == 1)
                ? user.cart.splice(i, 1)
                : user.cart[i].quantity -= 1;
            }
        }

        user = await user.save();
        res.json(user);
    } catch (e) {
        return res
            .status(500) // Internal Server Error
            .json({
                error: e.message,
            });
    }
});

module.exports = userRouter;
