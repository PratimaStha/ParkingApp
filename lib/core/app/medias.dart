//svg data here...
const baseSVGPath = 'assets/svg/';

//image data here...
const baseImagePath = 'assets/images/';
//json data here...
const baseJsonPath = 'assets/json/';

final kRojgarLogo = _getImageBasePath("rojgarlogo.png");
final kGoogleImage = _getImageBasePath("googleIcon.png");

final kCountriesJson = _getJsonBasePath("country.json");

final kResetPasswordGif = _getImageBasePath("resetPassword.gif");

final kForgotPasswordSvg = _getSvgBasePath("forgotPassword.svg");

final kHomeSvg = _getSvgBasePath("home.svg");
final kProfileSvg = _getSvgBasePath("profile.svg");
final kJobSvg = _getSvgBasePath("job.svg");
final kChatSvg = _getSvgBasePath("chat.svg");

//svg function here...
String _getSvgBasePath(String name) {
  return baseSVGPath + name;
}

//json function here...
String _getJsonBasePath(String name) {
  return baseJsonPath + name;
}

//image function here...
String _getImageBasePath(String name) {
  return baseImagePath + name;
}
