const User = require("../models/userModel");
const asyncHandler = require("express-async-handler");
const crypto = require("crypto");
const bcrypt = require("bcryptjs");
const nodemailer = require("nodemailer");
const generateAccessToken = require("../utils/generateAccessToken");
const Otp = require("../models/otpModel");
const generateRefreshToken = require("../utils/generateRefreshToken");
const jwt = require("jsonwebtoken");

var transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "nabinstha246@gmail.com",
    pass: process.env.GOOGLE_APP_PASSWORD,
  },
  tls: {
    rejectUnauthorized: false,
  },
});

module.exports.refreshToken = (req, res) => {
  const refreshToken = req.body.token;
  console.log("refreshToken: ", refreshToken);

  if (!refreshToken) return res.status(401).json("You are not authenticated!");

  jwt.verify(
    refreshToken,
    process.env.REFRESH_TOKEN_SECRET_KEY,
    async (err, user) => {
      err && console.log(err);

      // console.log(user);
      const newAccessToken = generateAccessToken({ id: user.id });
      const newRefreshToken = generateRefreshToken({ id: user.id });

      // refreshTokens.push(newRefreshToken);

      const userExists = await User.findById({ _id: user.id });

      res.status(200).json({
        userProfile: {
          _id: userExists._id,
          name: userExists.name,
          email: userExists.email,
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
        },
      });
    }
  );
};

// User Login /user/login
module.exports.userLogin = asyncHandler(async (req, res) => {
  try {
    const { email, password, updatePW } = req.body;
    console.log(req.body);
    const userExists = await User.findOne({ email });
    // console.log(password);

    if (!userExists) {
      throw new Error("User not found with this email!");
    }

    if (updatePW) {
      console.log("before", userExists.password);
      const salt = await bcrypt.genSalt(10);
      const hashedPW = await bcrypt.hash(password, salt);
      const updatedUser = await User.findByIdAndUpdate(
        { _id: userExists._id },
        {
          name: userExists.name,
          email: userExists.email,
          password: hashedPW,
          emailToken: userExists.emailToken,
        },
        { new: true, timestamps: true }
      );
      // console.log("after", updatedUser.password);
      if (await bcrypt.compare(password, updatedUser.password)) {
        const accessToken = generateAccessToken({ id: updatedUser._id });
        const refreshToken = generateRefreshToken({ id: updatedUser._id });

        console.log(updatedUser);

        return res.status(200).json({
          userProfile: {
            _id: updatedUser._id,
            name: updatedUser.name,
            email: updatedUser.email,
            emailIsVerified: userExists.emailIsVerified,
            accessToken: accessToken,
            refreshToken: refreshToken,
            isLogin: true,
          },
        });
      } else {
        return res.status(401).json({ errMessage: "Password does not match." });
      }
    }

    // console.log(userExists);
    else if (await bcrypt.compare(password, userExists.password)) {
      const accessToken = generateAccessToken({ id: userExists._id });
      const refreshToken = generateRefreshToken({ id: userExists._id });
      console.log("accessToken: ", accessToken);
      // console.log(userExists);

      return res.status(200).json({
        userProfile: {
          _id: userExists._id,
          name: userExists.name,
          email: userExists.email,
          emailIsVerified: userExists.emailIsVerified,
          accessToken: accessToken,
          refreshToken: refreshToken,
          isLogin: true,
        },
      });
    } else {
      return res.status(500).json({ errMessage: "Password does not match." });
    }
  } catch (err) {
    console.log(`Error from userLogin : ${err.message}`);
    return res.status(500).json({ errMessage: err.message });
  }
});

// User Register /user/register
module.exports.userRegister = asyncHandler(async (req, res) => {
  try {
    // console.log(req.body);
    const { name, email, password, jobType } = req.body;

    const userExists = await User.findOne({ email: email });

    if (userExists && userExists.emailIsVerified == true) {
      return res.status(400).json({ errMessage: "User already exists." });
    }
    console.log(`userExists :: ${userExists}`);
    if (userExists != null) {
      await User.findByIdAndRemove({ _id: userExists._id });
    }

    const newUser = await User.create({
      name,
      email,
      password,
      emailToken: crypto.randomBytes(64).toString("hex"),
    });

    if (newUser) {
      var otpCode = `${Math.floor(1000 + Math.random() * 9000)}`;
      var mailOptions = {
        from: ' "Verify your email" <rojgar@gmail.com> ',
        to: newUser.email,
        subject: "ROJGAR -verify your email",
        html: ` <h2> ${newUser.name}! Thanks for registering on our <strong>ROJGAR</strong> site. </h2>
              <h4> Please verify your mail to continue... </h4>
              <p>${otpCode}</p>`,
      };

      const hashedOTP = await bcrypt.hash(otpCode, 10);

      console.log(otpCode);

      await Otp.deleteMany({ email: newUser.email });

      const newOTP = await Otp({
        userId: newUser._id,
        email: newUser.email,
        otp: hashedOTP,
        createdAt: Date.now(),
        expiresIn: Date.now() + 3600 * 1000,
      });

      transporter.sendMail(mailOptions, async function (error, info) {
        if (error) {
          console.log(error);
        } else {
          console.log(info);
          await newOTP.save();
          console.log("Verification email is sent to your gmail account");
        }
      });
      return res.status(200).json({
        message: "Otp Verification email is sent to your gmail account",
        otpCode: otpCode,
      });
    }
  } catch (err) {
    console.log(`Error from userRegister : ${err}`);
    return res.status(400).json({ errMessage: err.message });
  }
});

module.exports.sendOtp = async (req, res) => {
  try {
    // console.log(req.body);
    const userExist = await User.findOne({ email: req.body.email });
    if (!userExist) {
      throw new Error("User not found");
    }
    var otpCode = `${Math.floor(1000 + Math.random() * 9000)}`;

    var mailOptions = {
      from: ' "RESET your email" <rojgar@gmail.com> ',
      to: userExist.email,
      subject: "ROJGAR -reset your password",
      html: ` <p>Enter <strong>${otpCode}</strong> in the app to reset your email address password and Complete the reset process.</p>
              <p> This code <b>expires in 1 hour</b>.</p> `,
    };

    const hashedOTP = await bcrypt.hash(otpCode, 10);
    // console.log(otpCode);

    await Otp.deleteMany({ userId: userExist._id });

    const newOTP = await Otp({
      userId: userExist._id,
      email: userExist.email,
      otp: hashedOTP,
      createdAt: Date.now(),
      expiresIn: Date.now() + 3600 * 1000,
    });

    await newOTP.save();

    transporter.sendMail(mailOptions, function (error, info) {
      if (error) {
        console.log(error);
      } else {
        console.log(info);
        console.log(
          "Password Resetting for email is sent to your gmail account"
        );
      }
    });
    // console.log(userExist._id);

    return res.status(200).json({
      OTPMessage: "Password Resetting otp has been sent to your gmail account",
    });
  } catch (err) {
    console.log(`Error from sendOtp : ${err}`);
    return res.status(500).json({
      errMessage: err.message,
      OTPMessage: "Something went wrong.",
    });
  }
};

module.exports.verifyOTP = async (req, res) => {
  try {
    let { email, otp } = req.body;

    console.log(email, otp);

    if (!email || !otp) {
      throw new Error("Empty otp details are not allowed");
    } else {
      const OTPVerificationRecords = await Otp.findOne({ email });
      if (OTPVerificationRecords.length <= 0) {
        throw new Error("No otp verification records found.");
      } else {
        console.log(OTPVerificationRecords);
        const { expiresIn } = OTPVerificationRecords;
        const hashedOTP = OTPVerificationRecords.otp;
        if (expiresIn < Date.now()) {
          await Otp.deleteMany({ email });
          throw new Error("Code has been expired. Please request again.");
        } else {
          const validOTP = await bcrypt.compare(otp, hashedOTP);
          if (!validOTP) {
            throw new Error("Invalid otp code passed. Check your inbox.");
          } else {
            // await User.updateOne({ _id: email }, { pwResetOtpVerified: true });
            await Otp.deleteMany({ email });
            const user = await User.findOne({ email });
            if (user) {
              user.emailToken = null;
              user.emailIsVerified = true;
              await user.save();
            }
            return res.status(200).json({
              message: "Otp has been Verified Successfully.",
            });
          }
        }
      }
    }
  } catch (err) {
    return res.status(400).json({
      errMessage: err.message ?? "Something went wrong",
    });
  }
};

module.exports.getMyUser = async (req, res) => {
  try {
    console.log(req.user);

    var user = await User.findById(req.user).select("-password");

    if (!user) {
      throw new Error("User not found");
    }

    return res.status(200).json(user);
  } catch (err) {
    return res.status(400).json({
      errMessage: err.message ?? "Something went wrong",
    });
  }
};
