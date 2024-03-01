const jwt = require("jsonwebtoken");
const User = require("../models/userModel");
const asyncHandler = require("express-async-handler");

module.exports.protect = asyncHandler(async (req, res, next) => {
  let token;
  console.log("middleware: ", req.headers.authorization);
  if (
    req.headers.authorization &&
    req.headers.authorization.startsWith("Bearer")
  ) {
    try {
      token = req.headers.authorization.split(" ")[1];
      const decoded = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET_KEY);

      req.user = await User.findById(decoded.id).select("-password");
      // console.log("middleware: ", req.user);
      next();
    } catch (error) {
      return res
        .status(401)
        .json({ errMessage: "Not austhorized, token failed" });
      // throw new Error("Not authorized, token failed");
    }
  }

  if (!token) {
    return res.status(401).json({ errMessage: "Not authorized, no token" });
    // throw new Error("Not authorized, no token");
  }
});

module.exports.admin = (req, res, next) => {
  if (req.user && req.user.isAdmin) {
    next();
  } else {
    return res.status(401).json({ errMessage: "Not authorized as an admin" });
    // throw new Error("Not authorized as an admin");
  }
};
