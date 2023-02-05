const credentials = require("../credentials");
const jwt = require('jsonwebtoken');
const User = require('../models/user');

const admin = async (req, res, next) => {
    try {
        const token = req.header('x-auth-token');
        if (!token)  {
            return res
                .status(401) // Unauthorized
                .json({
                    msg: "No auth token. Access denied",
                });
        }

        const verified = jwt.verify(token, credentials.hashKey);
        if (!verified) {
            return res
                .status(401) // Unauthorized
                .json({
                    msg: "Token verification failed. Authorization denied",
                });
        }

        const user = await User.findById(verified.id);
        if (user.type == 'user' || user.type == 'seller') {
            return res
                .status(401) // Unauthorized
                .json({
                    msg: "You are not an admin",
                }); 
        }

        req.user = verified.id;
        req.token = token;
        next();
    } catch (e) {
        return res
            .status(500) // Internal Server Error
            .json({
                error: e.message,
            });
    }
}

module.exports = admin;
