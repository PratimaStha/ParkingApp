const mongoose = require("mongoose");

const bookingSchema = new mongoose.Schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
  parkingSpot: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "ParkingSpot",
    required: true,
  },
  startTime: { type: Date, required: true },
  endTime: { type: Date, required: true },
  isConfirmed: { type: Boolean, default: false },
  price: {
    type: Number,
    default: 0,
  },
  numberPlate: {
    type: String,
  },
});

const Booking = mongoose.model("Booking", bookingSchema);

module.exports = Booking;
