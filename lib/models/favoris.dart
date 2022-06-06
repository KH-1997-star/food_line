// To parse this JSON data, do
//
//     final favoris = favorisFromJson(jsonString);

import 'dart:convert';

Favoris favorisFromJson(String str) => Favoris.fromJson(json.decode(str));

String favorisToJson(Favoris data) => json.encode(data.toJson());

class Favoris {
  Favoris({
    this.count,
    this.results,
  });

  int? count;
  List<Result>? results;

  factory Favoris.fromJson(Map<String, dynamic> json) => Favoris(
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
    this.compte,
    this.restaurant,
  });

  String? identifiant;
  String? compte;
  List<Restaurant>? restaurant;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        identifiant: json["Identifiant"],
        compte: json["compte"],
        restaurant: List<Restaurant>.from(
            json["restaurant"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "compte": compte,
        "restaurant": List<dynamic>.from(restaurant!.map((x) => x.toJson())),
      };
}

class Restaurant {
  Restaurant({
    this.identifiant,
    this.titre,
    this.description,
    this.phone,
    this.email,
    this.statut,
    this.photoCouverture,
    this.adresse,
    this.ville,
    this.pays,
    this.codePostal,
    this.position,
    this.responsable,
    this.logo,
    this.specialiteRestos,
    this.horaireTravails,
    this.tags,
    this.nbreMaxCommande,
    this.nbreCurrentCommande,
  });

  String? identifiant;
  String? titre;
  String? description;
  String? phone;
  String? email;
  String? statut;
  String? photoCouverture;
  String? adresse;
  String? ville;
  String? pays;
  String? codePostal;
  List<String>? position;
  String? responsable;
  String? logo;
  List<String>? specialiteRestos;
  String? horaireTravails;
  List<String>? tags;
  NbreCommande? nbreMaxCommande;
  NbreCommande? nbreCurrentCommande;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        identifiant: json["Identifiant"],
        titre: json["titre"],
        description: json["description"],
        phone: json["phone"],
        email: json["email"],
        statut: json["statut"],
        photoCouverture: json["photoCouverture"],
        adresse: json["adresse"],
        ville: json["ville"],
        pays: json["pays"],
        codePostal: json["codePostal"],
        position: List<String>.from(json["position"].map((x) => x)),
        responsable: json["responsable"],
        logo: json["logo"],
        specialiteRestos:
            List<String>.from(json["specialiteRestos"].map((x) => x)),
        horaireTravails: json["horaireTravails"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        nbreMaxCommande: NbreCommande.fromJson(json["nbreMaxCommande"]),
        nbreCurrentCommande: NbreCommande.fromJson(json["nbreCurrentCommande"]),
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "titre": titre,
        "description": description,
        "phone": phone,
        "email": email,
        "statut": statut,
        "photoCouverture": photoCouverture,
        "adresse": adresse,
        "ville": ville,
        "pays": pays,
        "codePostal": codePostal,
        "position": List<dynamic>.from(position!.map((x) => x)),
        "responsable": responsable,
        "logo": logo,
        "specialiteRestos": List<dynamic>.from(specialiteRestos!.map((x) => x)),
        "horaireTravails": horaireTravails,
        "tags": List<dynamic>.from(tags!.map((x) => x)),
        "nbreMaxCommande": nbreMaxCommande!.toJson(),
        "nbreCurrentCommande": nbreCurrentCommande!.toJson(),
      };
}

class NbreCommande {
  NbreCommande({
    this.midiNow,
    this.midiTomorrow,
    this.soirNow,
    this.soirTomorrow,
    this.nuitNow,
    this.nuitTomorrow,
  });

  int? midiNow;
  int? midiTomorrow;
  int? soirNow;
  int? soirTomorrow;
  int? nuitNow;
  int? nuitTomorrow;

  factory NbreCommande.fromJson(Map<String, dynamic> json) => NbreCommande(
        midiNow: json["midiNow"],
        midiTomorrow: json["midiTomorrow"],
        soirNow: json["soirNow"],
        soirTomorrow: json["soirTomorrow"],
        nuitNow: json["nuitNow"],
        nuitTomorrow: json["nuitTomorrow"],
      );

  Map<String, dynamic> toJson() => {
        "midiNow": midiNow,
        "midiTomorrow": midiTomorrow,
        "soirNow": soirNow,
        "soirTomorrow": soirTomorrow,
        "nuitNow": nuitNow,
        "nuitTomorrow": nuitTomorrow,
      };
}
