// To parse this JSON data, do
//
//     final bookSlotResponseModel = bookSlotResponseModelFromJson(jsonString);

import 'dart:convert';

BookSlotResponseModel bookSlotResponseModelFromJson(String str) =>
    BookSlotResponseModel.fromJson(json.decode(str));

String bookSlotResponseModelToJson(BookSlotResponseModel data) =>
    json.encode(data.toJson());

class BookSlotResponseModel {
  List<Booking>? bookings;

  BookSlotResponseModel({
    this.bookings,
  });

  factory BookSlotResponseModel.fromJson(Map<String, dynamic> json) =>
      BookSlotResponseModel(
        bookings: json["bookings"] == null
            ? []
            : List<Booking>.from(
                json["bookings"]!.map((x) => Booking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bookings": bookings == null
            ? []
            : List<dynamic>.from(bookings!.map((x) => x.toJson())),
      };
}

class Booking {
  String? id;
  User? user;
  ParkingSpot? parkingSpot;
  String? startTime;
  String? endTime;
  bool? isConfirmed;
  int? price;
  String? numberPlate;
  int? v;

  Booking({
    this.id,
    this.user,
    this.parkingSpot,
    this.startTime,
    this.endTime,
    this.isConfirmed,
    this.price,
    this.numberPlate,
    this.v,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        parkingSpot: json["parkingSpot"] == null
            ? null
            : ParkingSpot.fromJson(json["parkingSpot"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
        isConfirmed: json["isConfirmed"],
        price: json["price"],
        numberPlate: json["numberPlate"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user?.toJson(),
        "parkingSpot": parkingSpot?.toJson(),
        "startTime": startTime,
        "endTime": endTime,
        "isConfirmed": isConfirmed,
        "price": price,
        "numberPlate": numberPlate,
        "__v": v,
      };
}

class ParkingSpot {
  String? id;
  int? spotNumber;
  String? status;
  int? v;

  ParkingSpot({
    this.id,
    this.spotNumber,
    this.status,
    this.v,
  });

  factory ParkingSpot.fromJson(Map<String, dynamic> json) => ParkingSpot(
        id: json["_id"],
        spotNumber: json["spotNumber"],
        status: json["status"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "spotNumber": spotNumber,
        "status": status,
        "__v": v,
      };
}

class User {
  String? id;
  String? name;
  String? email;
  String? password;
  dynamic emailToken;
  bool? emailIsVerified;
  String? createdAt;
  String? updatedAt;
  int? v;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.emailToken,
    this.emailIsVerified,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        emailToken: json["emailToken"],
        emailIsVerified: json["emailIsVerified"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "emailToken": emailToken,
        "emailIsVerified": emailIsVerified,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}
