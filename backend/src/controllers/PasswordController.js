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
 */


const Password = require('../models/Password');

class PasswordController {
    async create(req, res) {
        try {
            const data = await Password.create({ ...req.body, userId: req.userId });
            res.status(201).json(data);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    }

    async list(req, res) {
        const passwords = await Password.find({ userId: req.userId });
        res.json(passwords);
    }

    async getById(req, res) {
        const password = await Password.findOne({ _id: req.params.id, userId: req.userId });
        if (!password) return res.status(404).json({ error: "Não encontrado" });
        res.json(password);
    }

    async update(req, res) {
        const password = await Password.findOneAndUpdate(
            { _id: req.params.id, userId: req.userId },
            req.body,
            { new: true }
        );
        if (!password) return res.status(404).json({ error: "Não encontrado" });
        res.json(password);
    }

    async delete(req, res) {
        const password = await Password.findOneAndDelete({ _id: req.params.id, userId: req.userId });
        if (!password) return res.status(404).json({ error: "Não encontrado" });
        res.json({ message: "Deletado com sucesso" });
    }
}

module.exports = new PasswordController();