/**
 * @swagger
 * tags:
 *   name: Passwords
 *   description: Gerenciamento de senhas do usuário
 */

/**
 * @swagger
 * components:
 *   schemas:
 *     Password:
 *       type: object
 *       properties:
 *         _id:
 *           type: string
 *         service:
 *           type: string
 *         login:
 *           type: string
 *         password:
 *           type: string
 */

/**
 * @swagger
 * /passwords:
 *   post:
 *     summary: Cria uma nova senha
 *     tags: [Passwords]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               service:
 *                 type: string
 *               login:
 *                 type: string
 *               password:
 *                 type: string
 *     responses:
 *       201:
 *         description: Senha criada com sucesso
 *       401:
 *         description: Não autorizado
 */

/**
 * @swagger
 * /passwords:
 *   get:
 *     summary: Lista todas as senhas do usuário
 *     tags: [Passwords]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Lista de senhas
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Password'
 *       401:
 *         description: Não autorizado
 */

/**
 * @swagger
 * /passwords/{id}:
 *   get:
 *     summary: Busca uma senha pelo ID
 *     tags: [Passwords]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Senha encontrada
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Password'
 *       404:
 *         description: Não encontrado
 *       401:
 *         description: Não autorizado
 */

/**
 * @swagger
 * /passwords/{id}:
 *   put:
 *     summary: Atualiza uma senha
 *     tags: [Passwords]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               service:
 *                 type: string
 *               login:
 *                 type: string
 *               password:
 *                 type: string
 *               url:
 *                 type: string
 *               notes:
 *                 type: string
 *     responses:
 *       200:
 *         description: Atualizado com sucesso
 *       404:
 *         description: Não encontrado
 *       401:
 *         description: Não autorizado
 */

/**
 * @swagger
 * /passwords/{id}:
 *   delete:
 *     summary: Deleta uma senha
 *     tags: [Passwords]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Deletado com sucesso
 *       404:
 *         description: Não encontrado
 *       401:
 *         description: Não autorizado
 */

const express = require('express');
const router = express.Router();
const PasswordController = require('../controllers/PasswordController');
const authMiddleware = require('../middlewares/authMiddleware');

router.use(authMiddleware);

router.post('/', PasswordController.create);
router.get('/', PasswordController.list);
router.get('/:id', PasswordController.getById);
router.put('/:id', PasswordController.update);
router.delete('/:id', PasswordController.delete);

module.exports = router;