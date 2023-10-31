const mongoose = require('mongoose');

const messSchema = mongoose.Schema({
    toId: {
        type: String,
        required: true,
        trim: true,
        default: '',
    },
    msg: {
        type: String,
        required: true,
        trim: true,
        default: ''
    },
    sent: {
        type: String,
        default: '',
    },
    fromId: {
        type: String,
        required: true,
        trim: true,
        default: '',
    },
    read: {
        type: String,
        default: '',
    },

});

module.exports = messSchema;