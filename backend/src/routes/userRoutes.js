
/**
 * @swagger
 * /users/password:
 *   put:
 *     summary: Admin altera senha de um usuário pelo email
 *     tags: [Users]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - email
 *               - newPassword
 *             properties:
 *               email:
 *                 type: string
 *                 example: usuario@email.com
 *               newPassword:
 *                 type: string
 *                 example: novaSenha123
 *     responses:
 *       200:
 *         description: Senha atualizada com sucesso
 *       400:
 *         description: Dados inválidos
 *       403:
 *         description: Acesso negado
 *       404:
 *         description: Usuário não encontrado
*/
/**
 * @swagger
 * /users:
 *   get:
 *     summary: Lista todos os usuários (admin)
 *     tags: [Users]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Lista de usuários
 *       403:
 *         description: Acesso negado
 */

const express = require('express');
const router = express.Router();

const UserController = require('../controllers/UserController');
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/roleMiddleware');

router.put(
    '/password',
    authMiddleware,
    roleMiddleware('admin'),
    UserController.updatePassword
);

router.get(
    '/',
    authMiddleware,
    roleMiddleware('admin'),
    UserController.listUsers
);

module.exports = router;