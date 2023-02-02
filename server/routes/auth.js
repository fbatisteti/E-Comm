const express = require('express');
const bcryptjs = require('bcryptjs');
const User = require("../models/user");
const credentials = require('../credentials');
const jwt = require('jsonwebtoken');
const auth = require('../middlewares/auth');

const authRouter = express.Router();

// SING UP
authRouter.post('/api/signup', async (req, res) => {
    try {
        const {name, email, password} = req.body;

        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res
                .status(400) // Bad Request
                .json({
                    msg: "User with this e-mail already exists",
                });
        };
    
        if(password.length < 6) {
            return res
                .status(400) // Bad Request
                .json({
                    msg: "Password must have 6 or more characters",
                });
        };

        const hashedPassword = await bcryptjs.hash(password, 8); // aqui NÃO é a chave da encriptação

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
            });
    };
});

// SIGN IN
authRouter.post('/api/signin', async (req, res) => {
    try {
        const { email, password } = req.body;

        const user = await User.findOne({ email });
        if (!user) {
            return res
                .status(400) // Bad Request
                .json({
                    msg: "User with this e-mail does not exist"
                });
        };

        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return res
                .status(400) // Bad Request
                .json({
                    msg: "Incorrect password"
                });
        };

        const token = jwt.sign({ id: user._id }, credentials.hashKey) // AQUI é a chave criptografada

        res.json({ token, ...user._doc }); // ... vai mandar os elementos separados, ao invés de mandar um objeto inteiro // _doc para pegar a informação específica
    } catch (e) {
        return res
            .status(500) // Internal Server Error
            .json({
                error: e.message,
            });
    }
});

// AUTH
authRouter.post('/tokenIsValid', async (req, res) => {
    try {
        const token = req.header('x-auth-token');
        if (!token) return res.json(false);

        const verified = jwt.verify(token, credentials.hashKey); // e aqui vê se a criptografia bate
        if (!verified) return res.json(false);

        const user = await User.findById(verified.id);
        if (!user) return res.json(false);

        res.json(true);
    } catch (e) {
        return res
            .status(500) // Internal Server Error
            .json({
                error: e.message,
            });
    }
});

// GET USER DATA
authRouter.get('/', auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({
        ...user._doc,
        token: req.token
    });
});

module.exports = authRouter;
