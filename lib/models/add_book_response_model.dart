// To parse this JSON data, do
//
//     final addBookSlotResponseModel = addBookSlotResponseModelFromJson(jsonString);

import 'dart:convert';

import 'book_slot_response_model.dart';

AddBookSlotResponseModel addBookSlotResponseModelFromJson(String str) =>
    AddBookSlotResponseModel.fromJson(json.decode(str));

String addBookSlotResponseModelToJson(AddBookSlotResponseModel data) =>
    json.encode(data.toJson());

class AddBookSlotResponseModel {
  Bookings? bookings;

  AddBookSlotResponseModel({
    this.bookings,
  });

  factory AddBookSlotResponseModel.fromJson(Map<String, dynamic> json) =>
      AddBookSlotResponseModel(
        bookings: json["bookings"] == null
            ? null
            : Bookings.fromJson(json["bookings"]),
      );

  Map<String, dynamic> toJson() => {
        "bookings": bookings?.toJson(),
      };
}

class Bookings {
  User? user;
  ParkingSpot? parkingSpot;
  String? startTime;
  String? endTime;
  bool? isConfirmed;
  int? price;
  String? numberPlate;
  String? id;
  int? v;

  Bookings({
    this.user,
    this.parkingSpot,
    this.startTime,
    this.endTime,
    this.isConfirmed,
    this.price,
    this.numberPlate,
    this.id,
    this.v,
  });

  factory Bookings.fromJson(Map<String, dynamic> json) => Bookings(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        parkingSpot: json["parkingSpot"] == null
            ? null
            : ParkingSpot.fromJson(json["parkingSpot"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
        isConfirmed: json["isConfirmed"],
        price: json["price"],
        numberPlate: json["numberPlate"],
        id: json["_id"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "parkingSpot": parkingSpot?.toJson(),
        "startTime": startTime,
        "endTime": endTime,
        "isConfirmed": isConfirmed,
        "price": price,
        "numberPlate": numberPlate,
        "_id": id,
        "__v": v,
      };
}
