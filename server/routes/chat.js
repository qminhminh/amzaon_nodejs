const express = require('express');
const User = require('../models/user');
const auth = require('../middlewares/auth');
const Chat = require('../models/chat');
const { Message } = require('../models/message');
const chatRouter = express.Router();

chatRouter.get('/api/chat/users',auth, async(req, res) => {
    try {
        const chat = await User.find({});
        res.json(chat);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

chatRouter.get('/api/chat/messages/:id',auth, async(req, res) => {
    try {
        const {id} = req.params;
        const chat = await Chat.findOne({ id: id});
        res.json(chat);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

function getConversationID(id1, id2) {
    // Xác định chatId dựa trên hai ID người dùng
    const smallerID = id1 <= id2 ? id1 : id2;
    const largerID = id1 <= id2 ? id2 : id1;
    return `${smallerID}_${largerID}`;
}

chatRouter.put('/api/chat/messages/update',auth ,async(req,res)=>{
   try{
      const {toId,read,send} = req.body;
      //const conversationID = getConversationID(id1, id2);
      const chat = await Chat.findOne({ id: toId});
      let message = await Message.findById(send);
      chat.chats.message.read = read;
       message.read = read;
       console.log(read);
       console.log(toId);
       console.log(send);
       message = await message.save();
       console.log(message);
    res.json(message);
   }catch(e){
    res.status(500).json({ error: e.message });
   }
});
  
module.exports = chatRouter;