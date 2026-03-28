const express = require('express');
const app = express();

const swaggerUi = require('swagger-ui-express');
const swaggerSpec = require('./docs/swagger');

const authRoutes = require('./routes/authRoutes');
const passwordRoutes = require('./routes/passwordRoutes');


app.use(express.json());

app.use('/auth', authRoutes);
app.use('/passwords', passwordRoutes);

app.use('/docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

module.exports = app;