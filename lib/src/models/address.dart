import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  String id;
  String idUser;
  String address;
  String neighbordhood;
  double lat;
  double lng;
  Address({
     this.id,
     this.idUser,
     this.address,
     this.neighbordhood,
     this.lat,
     this.lng,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"] is int ? json['id'].toString() : json['id'],
    idUser: json["id_user"],
    address: json["address"],
    neighbordhood: json["neighbordhood"],
    lat: json["lat"] is String ? double.parse(json["lat"]) : json["lat"],
    lng: json["lng"] is String ? double.parse(json["lng"]) : json["lng"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_user": idUser,
    "address": address,
    "neighbordhood": neighbordhood,
    "lat": lat,
    "lng": lng,
  };
}