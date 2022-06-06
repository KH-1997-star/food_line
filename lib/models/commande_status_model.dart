// To parse this JSON data, do
//
//     final commandeStatus = commandeStatusFromJson(jsonString);

import 'dart:convert';

CommandeStatus commandeStatusFromJson(String str) =>
    CommandeStatus.fromJson(json.decode(str));

String commandeStatusToJson(CommandeStatus data) => json.encode(data.toJson());

class CommandeStatus {
  CommandeStatus({
    this.results,
    this.count,
  });

  List<Result>? results;
  int? count;

  factory CommandeStatus.fromJson(Map<String, dynamic> json) => CommandeStatus(
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
    this.commande,
    this.name,
    this.statut,
    this.dateCreation,
    this.dateLastModif,
  });

  String? identifiant;
  String? commande;
  String? name;
  String? statut;
  DateTime? dateCreation;
  DateTime? dateLastModif;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        identifiant: json["Identifiant"],
        commande: json["commande"],
        name: json["name"],
        statut: json["statut"],
        dateCreation: DateTime.parse(json["dateCreation"]),
        dateLastModif: DateTime.parse(json["dateLastModif"]),
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "commande": commande,
        "name": name,
        "statut": statut,
        "dateCreation": dateCreation!.toIso8601String(),
        "dateLastModif": dateLastModif!.toIso8601String(),
      };
}
