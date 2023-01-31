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
  int idCategory;
  int idService;
  int condition;
  List<Stores> toList = [];
  Stores({
     this.id,
     this.shop,
     this.description,
     this.image1,
     this.image2,
     this.image3,
     this.idCategory,
     this.idService,
     this.condition,
  });

  factory Stores.fromJson(Map<String, dynamic> json) => Stores(
    id: json["id"] is int ? json["id"].toString() : json['id'],
    shop: json["shop"],
    description: json["description"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    idCategory: json["id_category"] is String ? int.parse(json["id_category"]) : json["id_category"],
    idService: json["id_service"] is String ? int.parse(json["id_service"]) : json["id_service"],
    condition: json["condition"],
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
    "id_category": idCategory,
    "id_service": idService,
    "condition": condition,
  };

  static bool isInteger(num value) => value is int || value == value.roundToDouble();

}