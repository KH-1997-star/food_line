// To parse this JSON data, do
//
//     final defaultAddress = defaultAddressFromJson(jsonString);

import 'dart:convert';

List<DefaultAddress> defaultAddressFromJson(String str) =>
    List<DefaultAddress>.from(
        json.decode(str).map((x) => DefaultAddress.fromJson(x)));

String defaultAddressToJson(List<DefaultAddress> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DefaultAddress {
  DefaultAddress({
    this.identifiant,
    this.linkedCompte,
    this.addresse,
    this.ville,
    this.pays,
    this.codePostal,
    this.position,
    this.isActive,
    this.dateCreation,
    this.dateLastModif,
  });

  String? identifiant;
  String? linkedCompte;
  String? addresse;
  String? ville;
  String? pays;
  String? codePostal;
  List<double>? position;
  String? isActive;
  DateTime? dateCreation;
  DateTime? dateLastModif;

  factory DefaultAddress.fromJson(Map<String, dynamic> json) => DefaultAddress(
        identifiant: json["Identifiant"],
        linkedCompte: json["linkedCompte"],
        addresse: json["addresse"],
        ville: json["ville"],
        pays: json["pays"],
        codePostal: json["codePostal"],
        position: List<double>.from(json["position"].map((x) => x.toDouble())),
        isActive: json["isActive"],
        dateCreation: DateTime.parse(json["dateCreation"]),
        dateLastModif: DateTime.parse(json["dateLastModif"]),
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "linkedCompte": linkedCompte,
        "addresse": addresse,
        "ville": ville,
        "pays": pays,
        "codePostal": codePostal,
        "position": List<dynamic>.from(position!.map((x) => x)),
        "isActive": isActive,
        "dateCreation": dateCreation!.toIso8601String(),
        "dateLastModif": dateLastModif!.toIso8601String(),
      };
}
