const express = require("express");
const router = express.Router();
const bookingController = require("../controllers/bookingController");
const { protect } = require("../middlewares/authMiddleware");

// Create a new booking
router.post("/bookings", protect, bookingController.createBooking);

// Get all bookings
router.get("/bookings", protect, bookingController.getAllBookings);

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
router.patch(
  "/:slotNumber/update-to-available",
  bookingController.updateSlotToAvailable
);

module.exports = router;
