import 'dart:convert';

Services servicesFromJson(String str) => Services.fromJson(json.decode(str));

String servicesToJson(Services data) => json.encode(data.toJson());

class Services {
  String id;
  String idStore;
  String services;
  List<Services> toList = [];
  Services({
     this.id,
     this.idStore,
     this.services,
  });

  factory Services.fromJson(Map<String, dynamic> json) => Services(
    id: json["id"],
    idStore: json["id_store"],
    services: json["services"],
  );

  Services.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Services services = Services.fromJson(item);
      toList.add(services);
    });
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_store": idStore,
    "services": services,
  };
}
