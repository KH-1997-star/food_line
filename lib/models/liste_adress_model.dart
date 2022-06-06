// To parse this JSON data, do
//
//     final listeAdress = listeAdressFromJson(jsonString);

import 'dart:convert';

ListeAdress listeAdressFromJson(String str) =>
    ListeAdress.fromJson(json.decode(str));

String listeAdressToJson(ListeAdress data) => json.encode(data.toJson());

class ListeAdress {
  ListeAdress({
    this.results,
    this.count,
  });

  List<Result>? results;
  int? count;

  factory ListeAdress.fromJson(Map<String, dynamic> json) => ListeAdress(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
        "count": count,
      };
}

class Result {
  Result({
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
    this.statut,
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
  String? statut;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
        statut: json["statut"],
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
        "statut": statut,
      };
}
