const express = require('express');
const mongoose= require('mongoose');
const http = require('http');
const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');
const chatRouter = require('./routes/chat');
const Chat = require('./models/chat');
const DB = "mongodb+srv://hqminh050503:minh0505@cluster0.us3cipj.mongodb.net/?retryWrites=true&w=majority";
const PORT = process.env.PORT || 3000;
const PORTSERVER = process.env.PORT || 4000;
// app
const app = express();
// other files
var server = http.createServer(app);
var io = require("socket.io")(server);


// middleware client->middleware->server->client
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);
app.use(productRouter);
app.use(chatRouter);

// socket io
io.on("connection", (socket) => {
  console.log("a user connected");
  socket.on("disconnect", () => {
    console.log("a user disconnected");
  });

  socket.on("createRoomChat", async ({ user, message, time, id }) => {
    const userData = JSON.parse(user);
    console.log(message);
    console.log(time);
    console.log("toID:" + userData.id);
    console.log("fromID:" + id);

    try {
      const chatId = getConversationID(id, userData.id);
      let chat = await Chat.findOne({ id: chatId });

      if (chat) {
        // Chat exists, add the message to the existing chat
        const mess = {
          toId: userData.id,
          msg: message,
          sent: time,
          fromId: id,
        };

        chat.chats.push(mess);
        await chat.save();
      } else {
        // Chat doesn't exist, create a new chat
        const chatMess = new Chat({
          id: chatId,
          chats: [
            {
              toId: userData.id,
              msg: message,
              sent: time,
              fromId: id,
            },
          ],
        });

        await chatMess.save();
      }

      socket.join(chatId);
      io.to(chatId).emit("createRoomChatSuccess", chat);
    } catch (error) {
      console.log(error);
    }
  });

});


// connnect MongGo DB
mongoose.connect(DB).then(() => {
 console.log('Connnect Mongo Success');
}).catch((e)=>{
  console.log(e);
});

// lisetren port
app.listen(PORT,"0.0.0.0",() =>{
   console.log(`connnect at port: ${PORT}`);
});


server.listen(PORTSERVER, "0.0.0.0", () => {
  console.log(`Server started and running on port ${PORTSERVER}`);
});