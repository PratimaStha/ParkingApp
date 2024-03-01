const mongoose = require("mongoose");

const connectDB = async (app) => {
  try {
    const conn = await mongoose.connect(process.env.MONGO_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    const PORT = process.env.PORT || 5000;

    app.listen(PORT, () => {
      console.log(
        `Server running in ${process.env.NODE_ENV} mode on port ${PORT}!!!`
          .yellow.bold
      );
    });
    console.log(`MongoDB connected: ${conn.connection.name}`.cyan.underline);
  } catch (err) {
    console.log(`Error: ${err.message}`.red.underline.bold);
    process.exit(1);
  }
};

module.exports = connectDB;
