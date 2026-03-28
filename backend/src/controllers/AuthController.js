const User = require('../models/User');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

class AuthController {
    async register(req, res) {
        try {
            const { name, email, password } = req.body;
            if (await User.findOne({ email })) {
                return res.status(400).json({ error: "Email já cadastrado" });
            }
            const hash = await bcrypt.hash(password, 10);
            const user = await User.create({ name, email, password: hash , role});
            res.status(201).json(user);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    }

    async login(req, res) {
        try {
            const { email, password } = req.body;
            const user = await User.findOne({ email });
            if (!user) return res.status(404).json({ error: "Usuário não encontrado" });
            if (!await bcrypt.compare(password, user.password)) {
                return res.status(401).json({ error: "Senha inválida" });
            }
            const token = jwt.sign({ id: user._id, role: user.role }, process.env.JWT_SECRET, { expiresIn: "1d" });
            res.json({ token });
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    }
}

module.exports = new AuthController();