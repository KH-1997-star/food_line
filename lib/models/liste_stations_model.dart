// To parse this JSON data, do
//
//     final listeStation = listeStationFromJson(jsonString);

import 'dart:convert';

ListeStation listeStationFromJson(String str) =>
    ListeStation.fromJson(json.decode(str));

String listeStationToJson(ListeStation data) => json.encode(data.toJson());

class ListeStation {
  ListeStation({
    this.listeStations,
  });

  List<ListeStationElement>? listeStations;

  factory ListeStation.fromJson(Map<String, dynamic> json) => ListeStation(
        listeStations: List<ListeStationElement>.from(
            json["listeStations"].map((x) => ListeStationElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "listeStations":
            List<dynamic>.from(listeStations!.map((x) => x.toJson())),
      };
}

class ListeStationElement {
  ListeStationElement({
    this.idStation,
    this.heureArrive,
    this.heureDepart,
    this.livreur,
    this.nomStation,
    this.postion,
    this.trajetCamion,
    this.distance,
    this.temps,
  });

  String? idStation;
  String? heureArrive;
  String? heureDepart;
  Livreur? livreur;
  String? nomStation;
  List<double>? postion;
  String? trajetCamion;
  double? distance;
  double? temps;

  factory ListeStationElement.fromJson(Map<String, dynamic> json) =>
      ListeStationElement(
        idStation: json["idStation"],
        heureArrive: json["heureArrive"],
        heureDepart: json["heureDepart"],
        livreur: Livreur.fromJson(json["livreur"]),
        nomStation: json["nomStation"],
        postion: List<double>.from(json["postion"].map((x) => x.toDouble())),
        trajetCamion: json["trajetCamion"],
        distance: json["distance"].toDouble(),
        temps: json["temps"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "idStation": idStation,
        "heureArrive": heureArrive,
        "heureDepart": heureDepart,
        "livreur": livreur!.toJson(),
        "nomStation": nomStation,
        "postion": List<dynamic>.from(postion!.map((x) => x)),
        "trajetCamion": trajetCamion,
        "distance": distance,
        "temps": temps,
      };
}

class Livreur {
  Livreur({
    this.identifiant,
    this.image,
    this.name,
    this.prenom,
    this.phone,
    this.email,
  });

  String? identifiant;
  String? image;
  String? name;
  String? prenom;
  String? phone;
  String? email;

  factory Livreur.fromJson(Map<String, dynamic> json) => Livreur(
        identifiant: json["Identifiant"],
        image: json["image"],
        name: json["name"],
        prenom: json["prenom"],
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "image": image,
        "name": name,
        "prenom": prenom,
        "phone": phone,
        "email": email,
      };
}
