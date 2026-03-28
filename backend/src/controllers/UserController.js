const User = require('../models/User');
const bcrypt = require('bcrypt');

class UserController {

    async updatePassword(req, res) {
        try {
            const { email, newPassword } = req.body;

            if (!email || !newPassword) {
                return res.status(400).json({
                    error: "Email e nova senha são obrigatórios"
                });
            }

            const user = await User.findOne({ email });

            if (!user) {
                return res.status(404).json({
                    error: "Usuário não encontrado"
                });
            }

            const hash = await bcrypt.hash(newPassword, 10);

            user.password = hash;
            await user.save();

            return res.json({
                message: `Senha do usuário ${email} atualizada com sucesso`
            });

        } catch (err) {
            return res.status(500).json({ error: err.message });
        }
    }

    async listUsers(req, res) {
        try {
            const users = await User.find().select('-password');
        return res.json(users);
        } catch (err) {
            return res.status(500).json({ error: err.message });
        }
    }
}

module.exports = new UserController();