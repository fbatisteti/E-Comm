const express = require('express');
const mongoose = require('mongoose');
const credentials = require('./credentials');
const adminRouter = require('./routes/admin');

const PORT = 3000;

const app = express();

const authRouter = require('./routes/auth');
app.use(express.json()); // as requests que chegam viram JSON antes de serem utilizadas
app.use(authRouter);
app.use(adminRouter);

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
