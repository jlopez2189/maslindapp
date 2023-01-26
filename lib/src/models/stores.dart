import 'dart:convert';

Stores storesFromJson(String str) => Stores.fromJson(json.decode(str));

String storesToJson(Stores data) => json.encode(data.toJson());

class Stores {
  String id;
  String shop;
  String description;
  String image1;
  String image2;
  String image3;
  List<Stores> toList = [];
  Stores({
     this.id,
     this.shop,
     this.description,
     this.image1,
     this.image2,
     this.image3,
  });

  factory Stores.fromJson(Map<String, dynamic> json) => Stores(
    id: json["id"] is int ? json["id"].toString() : json['id'],
    shop: json["shop"],
    description: json["description"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
  );

  Stores.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Stores stores = Stores.fromJson(item);
      toList.add(stores);
    });
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "shop": shop,
    "description": description,
    "image1": image1,
    "image2": image2,
    "image3": image3,
  };

  static bool isInteger(num value) => value is int || value == value.roundToDouble();

}