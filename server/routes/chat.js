const express = require('express');
const User = require('../models/user');
const auth = require('../middlewares/auth');
const chatRouter = express.Router();

chatRouter.get('/api/chat/users',auth, async(req, res) => {
    try {
        const chat = await User.find({});
        res.json(chat);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = chatRouter;