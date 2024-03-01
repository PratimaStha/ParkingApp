const express = require("express");
const cors = require("cors");
const connectDB = require("./config/db");
require("dotenv").config();
const colors = require("colors");
const app = express();
const axios = require("axios");
const morgan = require("morgan");
const userRoutes = require("./routes/userRoutes");
const bookingRoutes = require("./routes/bookingRoutes");
const path = require("path");
var cookieParser = require("cookie-parser");

var compression = require("compression");

if (process.env.NODE_ENV === "development") {
  app.use(morgan("dev"));
}

app.use(cors());
app.use(cookieParser());
app.use(express.json());
app.use(express.urlencoded({ extended: true, limit: 1000000 }));
app.use(
  compression({
    level: 1,
    threshold: 0,
  })
);

connectDB(app);

app.use("/api/user", userRoutes);
app.use("/api/slot", bookingRoutes);

// app.use(express.static("/uploads"));

app.get("/api/payment/:token/:amt/:key", async (req, res) => {
  console.log(`${req.params.token} ${req.params.amt} ${req.params.key}`);
  let data = {
    token: req.params.token,
    amount: req.params.amt,
  };

  let config = {
    headers: {
      Authorization: `Key ${req.params.key}`,
    },
  };

  await axios
    .post("https://khalti.com/api/v2/payment/verify/", data, config)
    .then(async (response) => {
      console.log(response.data);
      // await Post.findByIdAndUpdate(
      //   { _id: req.params.postId },
      //   { isPaid: true },
      //   { new: true }
      // );
      res.json({ success: response.data });
    })
    .catch((error) => {
      console.log(error);
    });
});
