class ApiConfig {
  static const String localhost = "http://192.168.1.74:5000";
  // static const String devServerUrl =
  //     'https://octopus-app-2f4az.ondigitalocean.app';
  static const String apiUrl = "/api";
  static const String baseUrl = localhost + apiUrl;

  static const String userUrl = "/user";
  static const registerUrl = "/register";
  static const verifyOtpUrl = "/verify-OTP";
  static const loginUrl = "/login";
  static const sendOtpUrl = "/sendOtp";

  static const String talentUrl = "/talent";
  static const String employerUrl = "/employer";
  static const String editTalentUrl = "/editTalent";
  static const String userTalentId = "/usertalentId";
}
