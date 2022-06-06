// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ListePromo welcomeFromJson(String str) => ListePromo.fromJson(json.decode(str));

String welcomeToJson(ListePromo data) => json.encode(data.toJson());

class ListePromo {
  ListePromo({
    this.count,
    this.results,
  });

  int? count;
  List<Result>? results;

  factory ListePromo.fromJson(Map<String, dynamic> json) => ListePromo(
        count: json["count"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.identifiant,
    this.name,
    this.linkedRestaurant,
    this.type,
    this.dateDebut,
    this.dateFin,
    this.value,
    this.link,
    this.photoCouverture,
    this.isActive,
    this.statut,
  });

  String? identifiant;
  String? name;
  String? linkedRestaurant;
  String? type;
  String? dateDebut;
  String? dateFin;
  String? value;
  String? link;
  String? photoCouverture;
  String? isActive;
  String? statut;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        identifiant: json["Identifiant"],
        name: json["name"],
        linkedRestaurant: json["linkedRestaurant"],
        type: json["type"],
        dateDebut: json["dateDebut"],
        dateFin: json["dateFin"],
        value: json["value"],
        link: json["link"],
        photoCouverture: json["photoCouverture"],
        isActive: json["isActive"],
        statut: json["statut"],
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "name": name,
        "linkedRestaurant": linkedRestaurant,
        "type": type,
        "dateDebut": dateDebut,
        "dateFin": dateFin,
        "value": value,
        "link": link,
        "photoCouverture": photoCouverture,
        "isActive": isActive,
        "statut": statut,
      };
}
