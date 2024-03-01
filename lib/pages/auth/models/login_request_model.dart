class LoginRequestModel {
  String? email;
  String? password;
  String? updatedPassword;
  LoginRequestModel({
    this.email,
    this.password,
    this.updatedPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'updatePW': updatedPassword,
    };
  }
}
