// ignore_for_file: public_member_api_docs, sort_constructors_first

class RegisterRequestModel {
  String? name;
  String? email;
  String? password;
  String? jobType;
  String? otp;
  RegisterRequestModel({
    this.name,
    this.email,
    this.password,
    this.jobType,
    this.otp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'jobType': jobType,
      'otp': otp,
    };
  }
}
