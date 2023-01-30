const express = require('express');
const bcryptjs = require('bcryptjs');
const User = require("../models/user");

const authRouter = express.Router();

authRouter.post('/api/signup', async (req, res) => {
    try {
        const {name, email, password} = req.body;

        const existingUser = await User.findOne({ email });
        if (existingUser) {
            res
                .status(400) // Bad Request
                .json({
                    msg: "User with this e-mail already exists",
                });
        };
    
        const hashedPassword = await bcryptjs.hash(password, 8); // aqui é a chave da encriptação

        let user = new User({
            email,
            password: hashedPassword,
            name
        });
    
        user = await user.save();
        res.json(user);
    } catch (e) {
        return res
            .status(500) // Internal Server Error
            .json({
                error: e.message,
            })
    };
});

module.exports = authRouter;
