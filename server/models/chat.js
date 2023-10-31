const mongoose = require('mongoose');
const messSchema = require('./message');

const chatSchema = mongoose.Schema({
    chat : [messSchema],
});

const Chat = mongoose.model('Chat',chatSchema);
module.exports = Chat;