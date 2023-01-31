import 'dart:convert';

Appointment appointmentFromJson(String str) => Appointment.fromJson(json.decode(str));

String appointmentToJson(Appointment data) => json.encode(data.toJson());

class Appointment {
  String id;
  String idStore;
  String idUser;
  String date;
  String time;
  String description;
  Appointment({
     this.id,
     this.idStore,
     this.idUser,
     this.date,
     this.time,
     this.description,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    id: json["id"] is int ? json["id"].toString() : json['id'],
    idStore: json["id_store"],
    idUser: json["id_user"],
    date: json["date"],
    time: json["time"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_store": idStore,
    "id_user": idUser,
    "date": date,
    "time": time,
    "description": description,
  };
}
