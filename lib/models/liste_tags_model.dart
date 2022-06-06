import 'dart:convert';

class ListeTags {
  ListeTags({
    this.results,
    this.count,
  });

  List<Result>? results;
  int? count;

  factory ListeTags.fromJson(Map<String, dynamic> json) => ListeTags(
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
    this.libelle,
    this.description,
    this.statut,
    this.isActive,
    this.image,
  });

  String? identifiant;
  String? libelle;
  String? description;
  String? statut;
  String? isActive;
  String? image;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        identifiant: json["Identifiant"],
        libelle: json["libelle"],
        description: json["description"],
        statut: json["statut"],
        isActive: json["isActive"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "libelle": libelle,
        "description": description,
        "statut": statut,
        "isActive": isActive,
        "image": image,
      };

  ListeTags listTagsFromJson(String str) =>
      ListeTags.fromJson(json.decode(str));

  String listTagsToJson(ListeTags data) => json.encode(data.toJson());
}
