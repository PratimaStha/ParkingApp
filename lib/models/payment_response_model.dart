// To parse this JSON data, do
//
//     final paymentResponseModel = paymentResponseModelFromJson(jsonString);

import 'dart:convert';

PaymentResponseModel paymentResponseModelFromJson(String str) =>
    PaymentResponseModel.fromJson(json.decode(str));

String paymentResponseModelToJson(PaymentResponseModel data) =>
    json.encode(data.toJson());

class PaymentResponseModel {
  Success? success;

  PaymentResponseModel({
    this.success,
  });

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) =>
      PaymentResponseModel(
        success:
            json["success"] == null ? null : Success.fromJson(json["success"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success?.toJson(),
      };
}

class Success {
  String? idx;
  Type? type;
  PaymentState? state;
  int? amount;
  int? feeAmount;
  dynamic reference;
  bool? refunded;
  String? createdOn;
  Type? user;
  Merchant? merchant;
  dynamic remarks;
  String? token;
  int? cashback;
  String? productIdentity;

  Success({
    this.idx,
    this.type,
    this.state,
    this.amount,
    this.feeAmount,
    this.reference,
    this.refunded,
    this.createdOn,
    this.user,
    this.merchant,
    this.remarks,
    this.token,
    this.cashback,
    this.productIdentity,
  });

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        idx: json["idx"],
        type: json["type"] == null ? null : Type.fromJson(json["type"]),
        state:
            json["state"] == null ? null : PaymentState.fromJson(json["state"]),
        amount: json["amount"],
        feeAmount: json["fee_amount"],
        reference: json["reference"],
        refunded: json["refunded"],
        createdOn: json["created_on"],
        user: json["user"] == null ? null : Type.fromJson(json["user"]),
        merchant: json["merchant"] == null
            ? null
            : Merchant.fromJson(json["merchant"]),
        remarks: json["remarks"],
        token: json["token"],
        cashback: json["cashback"],
        productIdentity: json["product_identity"],
      );

  Map<String, dynamic> toJson() => {
        "idx": idx,
        "type": type?.toJson(),
        "state": state?.toJson(),
        "amount": amount,
        "fee_amount": feeAmount,
        "reference": reference,
        "refunded": refunded,
        "created_on": createdOn,
        "user": user?.toJson(),
        "merchant": merchant?.toJson(),
        "remarks": remarks,
        "token": token,
        "cashback": cashback,
        "product_identity": productIdentity,
      };
}

class Merchant {
  String? idx;
  String? name;
  String? mobile;
  String? email;

  Merchant({
    this.idx,
    this.name,
    this.mobile,
    this.email,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
        idx: json["idx"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "idx": idx,
        "name": name,
        "mobile": mobile,
        "email": email,
      };
}

class PaymentState {
  String? idx;
  String? name;
  String? template;

  PaymentState({
    this.idx,
    this.name,
    this.template,
  });

  factory PaymentState.fromJson(Map<String, dynamic> json) => PaymentState(
        idx: json["idx"],
        name: json["name"],
        template: json["template"],
      );

  Map<String, dynamic> toJson() => {
        "idx": idx,
        "name": name,
        "template": template,
      };
}

class Type {
  String? idx;
  String? name;

  Type({
    this.idx,
    this.name,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        idx: json["idx"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "idx": idx,
        "name": name,
      };
}
