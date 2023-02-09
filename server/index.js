const express = require('express');
const mongoose = require('mongoose');
const credentials = require('./credentials');
const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');

const PORT = 3000;

const app = express();

app.use(express.json()); // as requests que chegam viram JSON antes de serem utilizadas
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

mongoose
    .connect(credentials.db)
    .then(() => {
        console.log('connected to DB');
    })
    .catch((e) => {
        console.log(e);
    });

app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected at port ${PORT}`);
}); // 0.0.0.0 para funcionar em dispositivos Androids, para debug
