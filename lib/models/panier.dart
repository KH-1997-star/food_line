// To parse this JSON data, do
//
//     final panier = panierFromJson(jsonString);

import 'dart:convert';

List<Panier> panierFromJson(String str) =>
    List<Panier>.from(json.decode(str).map((x) => Panier.fromJson(x)));

String panierToJson(List<Panier> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Panier {
  Panier({
    this.identifiant,
    this.linkedCompte,
    this.linkedCommande,
    this.listeMenus,
    this.quantite,
    this.prixHt,
    this.prixTtc,
    this.remise,
    this.statut,
    this.dateCreation,
    this.dateLastModif,
  });

  String? identifiant;
  String? linkedCompte;
  String? linkedCommande;
  List<ListeMenu>? listeMenus;
  int? quantite;
  dynamic? prixHt;
  dynamic? prixTtc;
  int? remise;
  String? statut;
  DateTime? dateCreation;
  DateTime? dateLastModif;

  factory Panier.fromJson(Map<String, dynamic> json) => Panier(
        identifiant: json["Identifiant"],
        linkedCompte: json["linkedCompte"],
        linkedCommande: json["linkedCommande"],
        listeMenus: List<ListeMenu>.from(
            json["listeMenus"].map((x) => ListeMenu.fromJson(x))),
        quantite: json["quantite"],
        prixHt: json["prixHT"],
        prixTtc: json["prixTTC"].toDouble(),
        remise: json["remise"],
        statut: json["statut"],
        dateCreation: DateTime.parse(json["dateCreation"]),
        dateLastModif: DateTime.parse(json["dateLastModif"]),
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "linkedCompte": linkedCompte,
        "linkedCommande": linkedCommande,
        "listeMenus": List<dynamic>.from(listeMenus!.map((x) => x.toJson())),
        "quantite": quantite,
        "prixHT": prixHt,
        "prixTTC": prixTtc,
        "remise": remise,
        "statut": statut,
        "dateCreation": dateCreation!.toIso8601String(),
        "dateLastModif": dateLastModif!.toIso8601String(),
      };
}

class ListeMenu {
  ListeMenu({
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
    this.description,
    this.logoResto,
  });

  String? identifiant;
  String? linkedPanier;
  List<LinkedMenu>? linkedMenu;
  List<Taille>? tailles;
  List<Autre>? sauces;
  List<Autre>? viandes;
  List<Autre>? garnitures;
  List<Autre>? boisons;
  List<Autre>? autres;
  int? quantite;
  dynamic? prixHt;
  dynamic? prixTtc;
  String? remise;
  String? statut;
  DateTime? dateCreation;
  DateTime? dateLastModif;
  dynamic? description;
  dynamic? logoResto;

  factory ListeMenu.fromJson(Map<String, dynamic> json) => ListeMenu(
        identifiant: json["Identifiant"],
        linkedPanier: json["linkedPanier"],
        linkedMenu: List<LinkedMenu>.from(
            json["linkedMenu"].map((x) => LinkedMenu.fromJson(x))),
        tailles:
            List<Taille>.from(json["tailles"].map((x) => Taille.fromJson(x))),
        sauces: List<Autre>.from(json["sauces"].map((x) => Autre.fromJson(x))),
        viandes:
            List<Autre>.from(json["viandes"].map((x) => Autre.fromJson(x))),
        garnitures:
            List<Autre>.from(json["garnitures"].map((x) => Autre.fromJson(x))),
        boisons:
            List<Autre>.from(json["boisons"].map((x) => Autre.fromJson(x))),
        autres: List<Autre>.from(json["autres"].map((x) => Autre.fromJson(x))),
        quantite: json["quantite"],
        prixHt: json["prixHT"],
        prixTtc: json["prixTTC"].toDouble(),
        remise: json["remise"],
        statut: json["statut"],
        description: json["description"],
        dateCreation: DateTime.parse(json["dateCreation"]),
        dateLastModif: DateTime.parse(json["dateLastModif"]),
        logoResto: json["logoResto"],
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "linkedPanier": linkedPanier,
        "linkedMenu": List<dynamic>.from(linkedMenu!.map((x) => x.toJson())),
        "tailles": List<dynamic>.from(tailles!.map((x) => x.toJson())),
        "sauces": List<dynamic>.from(sauces!.map((x) => x.toJson())),
        "viandes": List<dynamic>.from(viandes!.map((x) => x.toJson())),
        "garnitures": List<dynamic>.from(garnitures!.map((x) => x.toJson())),
        "boisons": List<dynamic>.from(boisons!.map((x) => x.toJson())),
        "autres": List<dynamic>.from(autres!.map((x) => x.toJson())),
        "quantite": quantite,
        "prixHT": prixHt,
        "prixTTC": prixTtc,
        "remise": remise,
        "statut": statut,
        "description": description,
        "dateCreation": dateCreation!.toIso8601String(),
        "dateLastModif": dateLastModif!.toIso8601String(),
        "logoResto": logoResto
      };
}

class Autre {
  Autre({
    this.id,
    this.prixFacculatitf,
    this.qte,
  });

  String? id;
  dynamic? prixFacculatitf;
  int? qte;

  factory Autre.fromJson(Map<String, dynamic> json) => Autre(
        id: json["id"],
        prixFacculatitf: json["prixFacculatitf"],
        qte: json["qte"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prixFacculatitf": prixFacculatitf,
        "qte": qte,
      };
}

class LinkedMenu {
  LinkedMenu({
    this.identifiant,
    this.titre,
    this.description,
    this.statut,
    this.prix,
    this.image,
    this.categorie,
  });

  String? identifiant;
  String? titre;
  String? description;
  String? statut;
  dynamic? prix;
  String? image;
  List<String>? categorie;

  factory LinkedMenu.fromJson(Map<String, dynamic> json) => LinkedMenu(
        identifiant: json["Identifiant"],
        titre: json["titre"],
        description: json["description"],
        statut: json["statut"],
        prix: json["prix"].toDouble(),
        image: json["image"],
        categorie: List<String>.from(json["categorie"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "titre": titre,
        "description": description,
        "statut": statut,
        "prix": prix,
        "image": image,
        "categorie": List<dynamic>.from(categorie!.map((x) => x)),
      };
}

class Taille {
  Taille({this.id, this.prix, this.name});

  String? id;
  dynamic? prix;
  dynamic? name;

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
