// To parse this JSON data, do
//
//     final detailMenuSelected = detailMenuSelectedFromJson(jsonString);

import 'dart:convert';

List<DetailMenuSelected> detailMenuSelectedFromJson(String str) =>
    List<DetailMenuSelected>.from(
        json.decode(str).map((x) => DetailMenuSelected.fromJson(x)));

String detailMenuSelectedToJson(List<DetailMenuSelected> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DetailMenuSelected {
  DetailMenuSelected({
    this.identifiant,
    this.linkedPanier,
    this.linkedMenu,
    this.tailles,
    this.sauces,
    this.viandes,
    this.garnitures,
    this.boisons,
    this.autres,
    this.quantite,
    this.prixHt,
    this.prixTtc,
    this.remise,
    this.statut,
    this.dateCreation,
    this.dateLastModif,
    this.categorie,
  });

  dynamic identifiant;
  dynamic linkedPanier;
  dynamic linkedMenu;
  List<Taille>? tailles;
  List<Boison>? sauces;
  List<Boison>? viandes;
  List<Boison>? garnitures;
  List<Boison>? boisons;
  List<dynamic>? autres;
  dynamic quantite;
  dynamic prixHt;
  dynamic prixTtc;
  dynamic remise;
  dynamic statut;
  DateTime? dateCreation;
  DateTime? dateLastModif;
  List<String>? categorie;

  factory DetailMenuSelected.fromJson(Map<String, dynamic> json) =>
      DetailMenuSelected(
        identifiant: json["Identifiant"],
        linkedPanier: json["linkedPanier"],
        linkedMenu: json["linkedMenu"],
        tailles:
            List<Taille>.from(json["tailles"].map((x) => Taille.fromJson(x))),
        sauces:
            List<Boison>.from(json["sauces"].map((x) => Boison.fromJson(x))),
        viandes:
            List<Boison>.from(json["viandes"].map((x) => Boison.fromJson(x))),
        garnitures: List<Boison>.from(
            json["garnitures"].map((x) => Boison.fromJson(x))),
        boisons:
            List<Boison>.from(json["boisons"].map((x) => Boison.fromJson(x))),
        autres: List<dynamic>.from(json["autres"].map((x) => x)),
        quantite: json["quantite"] == null ? null : json["quantite"],
        prixHt: json["prixHT"] == null ? null : json["prixHT"],
        prixTtc: json["prixTTC"] == null ? null : json["prixTTC"],
        remise: json["remise"] == null ? null : json["remise"],
        statut: json["statut"] == null ? null : json["statut"],
        dateCreation: json["dateCreation"] == null
            ? null
            : DateTime.parse(json["dateCreation"]),
        dateLastModif: json["dateLastModif"] == null
            ? null
            : DateTime.parse(json["dateLastModif"]),
        categorie: json["categorie"] == null
            ? null
            : List<String>.from(json["categorie"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "linkedPanier": linkedPanier,
        "linkedMenu": linkedMenu,
        "tailles": List<dynamic>.from(tailles!.map((x) => x.toJson())),
        "sauces": List<dynamic>.from(sauces!.map((x) => x.toJson())),
        "viandes": List<dynamic>.from(viandes!.map((x) => x.toJson())),
        "garnitures": List<dynamic>.from(garnitures!.map((x) => x.toJson())),
        "boisons": List<dynamic>.from(boisons!.map((x) => x.toJson())),
        "autres": List<dynamic>.from(autres!.map((x) => x)),
        "quantite": quantite == null ? null : quantite,
        "prixHT": prixHt == null ? null : prixHt,
        "prixTTC": prixTtc == null ? null : prixTtc,
        "remise": remise == null ? null : remise,
        "statut": statut == null ? null : statut,
        "dateCreation":
            dateCreation == null ? null : dateCreation!.toIso8601String(),
        "dateLastModif":
            dateLastModif == null ? null : dateLastModif!.toIso8601String(),
        "categorie": categorie == null
            ? null
            : List<dynamic>.from(categorie!.map((x) => x)),
      };
}

class Boison {
  Boison({
    this.qte,
    this.prixFacculatitf,
    this.id,
  });

  dynamic qte;
  dynamic prixFacculatitf;
  dynamic? id;

  factory Boison.fromJson(Map<String, dynamic> json) => Boison(
        qte: json["qte"],
        prixFacculatitf: json["prixFacculatitf"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "qte": qte,
        "prixFacculatitf": prixFacculatitf,
        "id": id,
      };
}

class Taille {
  Taille({
    this.id,
    this.prix,
    this.name,
  });

  dynamic id;
  dynamic prix;
  dynamic name;

  factory Taille.fromJson(Map<String, dynamic> json) => Taille(
        id: json["id"],
        prix: json["prix"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prix": prix,
        "name": name,
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
