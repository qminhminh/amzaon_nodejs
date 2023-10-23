const express = require('express');
const mongoose= require('mongoose');
const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');
const DB = "mongodb+srv://hqminh050503:minh0505@cluster0.us3cipj.mongodb.net/?retryWrites=true&w=majority";
const PORT = process.env.PORT || 3000;
// app
const app = express();
// other files


// middleware client->middleware->server->client
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);
app.use(productRouter);

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
