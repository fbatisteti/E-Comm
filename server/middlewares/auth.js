const credentials = require("../credentials");
const jwt = requite('jsonwebtoken');

const auth = async (req, res, next) => {
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

module.exports = auth;