const swaggerJsDoc = require('swagger-jsdoc');

const options = {
    definition: {
        openapi: "3.2.0",
        info: {
            title: "Password Vault API",
            version: "1.0.0",
            description: "API para gerenciamento de cofre de senhas"
        },
        servers: [
            { url: "http://localhost:3000" }
        ],
        components: {
            securitySchemes: {
                bearerAuth: {
                    type: "http",
                    scheme: "bearer",
                    bearerFormat: "JWT"
                }
            }
        }
    },
    apis: ["./src/routes/*.js"]
};

const swaggerSpec = swaggerJsDoc(options);

module.exports = swaggerSpec;