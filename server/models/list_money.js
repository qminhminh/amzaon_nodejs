const mongoose = require('mongoose');

const listmoneySchema = new mongoose.Schema({
   money:{
    type: Number,
    default: 0,
   },
});

const ListMoney = mongoose.model('ListMoney', listmoneySchema);
module.exports = {ListMoney,listmoneySchema};