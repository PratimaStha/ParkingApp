class QrModel {
  String? name;
  String? email;
  String? numberPlate;
  int? spotNumber;
  int? price;
  String? startTime;
  String? endTime;
  String? status;
  QrModel({
    this.name,
    this.email,
    this.numberPlate,
    this.spotNumber,
    this.price,
    this.startTime,
    this.endTime,
    this.status,
  });

  QrModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    numberPlate = json['numberPlate'];
    spotNumber = json['spotNumber'];
    price = json['price'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['numberPlate'] = numberPlate;
    data['spotNumber'] = spotNumber;
    data['price'] = price;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['status'] = status;
    return data;
  }
}
