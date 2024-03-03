const { default: mongoose } = require("mongoose");
const Booking = require("../models/bookingModel");
const ParkingSpot = require("../models/parkingSpotModel");
const User = require("../models/userModel");

// Controller to handle booking creation
const createBooking = async (req, res) => {
  try {
    console.log(req.user.id);
    const { spotId, startTime, endTime, price, numberPlate } = req.body;
    console.log(req.body);

    // Check if the parking spot is available for the given time range
    const isSpotAvailable = await ParkingSpot.findOne({
      spotNumber: spotId,
    });

    console.log("isSpotAvailable :: " + isSpotAvailable);

    if (isSpotAvailable == null) {
      await ParkingSpot.create({
        spotNumber: spotId,
        status: "available",
      });
    }

    if (isSpotAvailable.status != "available") {
      return res
        .status(400)
        .json({ errMessage: "Parking spot not available for booking." });
    }

    // // Update the status of the parking spot to booked
    await ParkingSpot.findByIdAndUpdate(isSpotAvailable.id, {
      status: "booked",
    });

    // // Create the booking
    const booking = await Booking.create({
      user: req.user,
      parkingSpot: isSpotAvailable,
      startTime,
      endTime,
      price,
      numberPlate,
    });

    res.status(201).json({ bookings: booking });
  } catch (error) {
    console.error(error);
    res.status(500).json({ errMessage: "Internal server error" });
  }
};

// Controller to get all bookings
const getAllBookings = async (req, res) => {
  try {
    const bookings = await Booking.find().populate("user parkingSpot");
    res.status(200).json({ bookings: bookings });
  } catch (error) {
    console.error(error);
    res.status(500).json({ errMessage: error });
  }
};

const getBookingsByUserId = async (req, res) => {
  try {
    const userId = req.user; // Assuming you pass the user ID as a parameter in the route

    // Check if the user exists
    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ errMessage: "User not found" });
    }

    // Get bookings for the user
    const bookings = await Booking.find({ user: userId }).populate(
      "parkingSpot user"
    );
    res.status(200).json({ bookings });
  } catch (error) {
    console.error(error);
    res.status(500).json({ errMessage: "Internal server error" });
  }
};

const deleteBookingAndUpdateParking = async (req, res) => {
  try {
    const bookingId = req.params.bookingId; // Assuming you pass the booking ID as a parameter in the route

    // Check if the booking exists
    const booking = await Booking.findById(bookingId);
    if (!booking) {
      return res.status(404).json({ errMessage: "Booking not found" });
    }

    // Update the status of the associated parking spot (assuming you have a reference to it)
    const parkingSpotId = booking.parkingSpot;
    await ParkingSpot.findByIdAndUpdate(parkingSpotId, { status: "available" });

    // Delete the booking
    await Booking.findByIdAndDelete(bookingId);

    res.status(200).json({ message: "Booking deleted successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ errMessage: "Internal server error" });
  }
};

const updateBookingToReserved = async (req, res) => {
  try {
    const bookingId = req.params.bookingId; // Assuming you pass the booking ID as a parameter in the route

    // Check if the booking exists
    const booking = await Booking.findById(bookingId).populate(
      "parkingSpot user"
    );
    if (!booking) {
      return res.status(404).json({ errMessage: "Booking not found" });
    }

    // Check if the booking is currently in the "booked" state
    if (booking.parkingSpot?.status !== "booked") {
      return res
        .status(400)
        .json({ errMessage: "Booking cannot be updated to reserved." });
    }

    // Update the booking status to "reserved"
    await Booking.findByIdAndUpdate(bookingId, { isConfirmed: true });

    // Update the status of the associated parking spot to "reserved"
    await ParkingSpot.findByIdAndUpdate(booking.parkingSpot?.id, {
      status: "reserved",
    });

    res
      .status(200)
      .json({ message: "Booking updated to reserved successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ errMessage: "Internal server error" });
  }
};

const updateBookingToAvailable = async (req, res) => {
  try {
    const bookingId = req.params.bookingId; // Assuming you pass the booking ID as a parameter in the route

    // Check if the booking exists
    const booking = await Booking.findById(bookingId).populate(
      "parkingSpot user"
    );
    if (!booking) {
      return res.status(404).json({ errMessage: "Booking not found" });
    }

    // Check if the booking is currently in the "reserved" state
    if (booking.parkingSpot?.status !== "reserved") {
      return res
        .status(400)
        .json({ message: "Booking cannot be updated to available." });
    }

    // Update the status of the associated parking spot to "available"
    await ParkingSpot.findByIdAndUpdate(booking.parkingSpot?.id, {
      status: "available",
    });

    await Booking.findByIdAndDelete(bookingId);

    res
      .status(200)
      .json({ message: "Booking updated to available successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ errMessage: "Internal server error" });
  }
};

const updateSlotToReserved = async (req, res) => {
  try {
    const slotNumber = req.params.slotNumber; // Assuming you pass the booking ID as a parameter in the route

    // Check if the slot exists
    const parkingSpot = await ParkingSpot.findOne({
      spotNumber: slotNumber,
    });

    console.log(parkingSpot);

    if (!parkingSpot) {
      return res.status(404).json({ errMessage: "Parking Spot not found" });
    }

    // Check if the slot is currently in the "available" state
    if (parkingSpot?.status !== "booked") {
      return res
        .status(400)
        .json({ errMessage: "Parking Spot cannot be updated to reserved." });
    }

    // Update the booking status to "reserved"
    const updatedBooking = await Booking.findOneAndUpdate(
      { parkingSpot: parkingSpot?.id },
      { isConfirmed: true }
    );

    // Update the status of the associated parking spot to "reserved"
    const updatedParkingSpot = await ParkingSpot.findByIdAndUpdate(
      parkingSpot?.id,
      {
        status: "reserved",
      }
    );

    console.log("updated booking" + updatedBooking);
    console.log("updated parkingSpot" + updatedParkingSpot);

    res
      .status(200)
      .json({ message: "Parking Spot updated to reserved successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ errMessage: "Internal server error" });
  }
};

const updateSlotToAvailable = async (req, res) => {
  try {
    const slotNumber = req.params.slotNumber; // Assuming you pass the booking ID as a parameter in the route

    // Check if the slot exists
    const parkingSpot = await ParkingSpot.findOne({
      spotNumber: slotNumber,
    });

    console.log(parkingSpot);

    if (!parkingSpot) {
      return res
        .status(404)
        .json({ errMessage: "Slot with given number not found" });
    }

    // Check if the booking is currently in the "reserved" state
    if (parkingSpot?.status !== "reserved") {
      return res
        .status(400)
        .json({ message: "Slot cannot be updated to available." });
    }

    // Update the status of the associated parking spot to "available"
    const updatedParkingSpot = await ParkingSpot.findByIdAndUpdate(
      parkingSpot?.id,
      {
        status: "available",
      }
    );

    console.log("updated parking spot " + updatedParkingSpot);

    await Booking.findOneAndRemove({ parkingSpot: parkingSpot.id });

    res.status(200).json({ message: "Slot updated to available successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ errMessage: "Internal server error" });
  }
};

module.exports = {
  createBooking,
  getAllBookings,
  getBookingsByUserId,
  deleteBookingAndUpdateParking,
  updateBookingToReserved,
  updateBookingToAvailable,
  updateSlotToReserved,
  updateSlotToAvailable,
};
