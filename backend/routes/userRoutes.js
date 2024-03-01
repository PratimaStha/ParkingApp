const express = require("express");
const router = express.Router();
const {
  userRegister,

  userLogin,
  sendOtp,
  verifyOTP,
  refreshToken,
  getMyUser,
} = require("../controllers/userController");
const verifyEmail = require("../middlewares/verifyEmail");
const { protect } = require("../middlewares/authMiddleware");

router.post("/refreshToken", refreshToken);

router.post("/login", verifyEmail, userLogin);

router.post("/register", userRegister);

router.post("/sendOtp", sendOtp);

router.post("/verify-OTP", verifyOTP);

router.get("/myProfile", protect, getMyUser);

module.exports = router;
