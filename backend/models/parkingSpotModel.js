const mongoose = require("mongoose");

const parkingSpotSchema = new mongoose.Schema({
  spotNumber: { type: Number, required: true },
  status: {
    type: String,
    enum: ["available", "booked", "reserved", "selected"],
    default: "available",
  },
});

const ParkingSpot = mongoose.model("ParkingSpot", parkingSpotSchema);

module.exports = ParkingSpot;
