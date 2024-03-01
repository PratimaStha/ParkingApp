class SaveCredentialsRequestModel {
  SaveCredentialsRequestModel({
    this.token,
    this.userId,
    this.isGoogleSignIn,
    this.email,
    this.isTalent,
    this.isComplete,
    this.name,
  });

  String? token;
  String? email;
  String? userId;
  String? name;
  bool? isGoogleSignIn;
  bool? isTalent;
  bool? isComplete;

  Map<String, dynamic> toMap() => {
        "token": token,
        "email": email,
        "userId": userId,
        "name": name,
        "isGoogleSignIn": isGoogleSignIn,
        "isTalent": isTalent,
        "isComplete": isComplete,
      };
}
