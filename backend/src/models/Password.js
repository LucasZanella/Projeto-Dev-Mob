const mongoose = require('mongoose');

const PasswordSchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    },
    service: String,
    login: String,
    password: String
}, { timestamps: true });

module.exports = mongoose.model('Password', PasswordSchema);