const express = require("express");
const router = express.Router();
const bookingController = require("../controllers/bookingController");
const { protect } = require("../middlewares/authMiddleware");

// Create a new booking
router.post("/bookings", protect, bookingController.createBooking);

// Get all bookings
router.get("/bookings", bookingController.getAllBookings);

router.get("/my/bookings", protect, bookingController.getBookingsByUserId);

router.delete(
  "/bookings/:bookingId",
  protect,
  bookingController.deleteBookingAndUpdateParking
);

router.patch(
  "/bookings/:bookingId/update-to-reserved",
  // protect,
  bookingController.updateBookingToReserved
);

router.patch(
  "/bookings/:bookingId/update-to-available",
  bookingController.updateBookingToAvailable
);

//routes for hardware to reserved and available
router.patch(
  "/:slotNumber/update-to-reserved",

  bookingController.updateSlotToReserved
);

router.patch(
  "/:slotNumber/update-to-available",
  bookingController.updateSlotToAvailable
);

module.exports = router;
