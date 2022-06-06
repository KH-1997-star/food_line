// To parse this JSON data, do
//
//     final commandeDetails = commandeDetailsFromJson(jsonString);

import 'dart:convert';

CommandeDetails commandeDetailsFromJson(String str) =>
    CommandeDetails.fromJson(json.decode(str));

String commandeDetailsToJson(CommandeDetails data) =>
    json.encode(data.toJson());

class CommandeDetails {
  CommandeDetails({
    this.results,
    this.count,
  });

  List<Result>? results;
  int? count;

  factory CommandeDetails.fromJson(Map<String, dynamic> json) =>
      CommandeDetails(
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
    this.linkedPanier,
    this.linkedCompte,
    this.listeProduits,
    this.totalHt,
    this.totalTtc,
    this.numeroCommande,
    this.numeroFacture,
    this.linkedFacture,
    this.linkedAdresseLivraison,
    this.codePromo,
    this.modePayment,
    this.statut,
    this.isActive,
    this.listeMenusCommande,
    this.quantite,
    this.livreur,
    this.station,
    this.trajetCamion,
    this.idPaiement,
    this.modePaiement,
    this.statutPaiement,
    this.dateCreation,
    this.dateLastModif,
  });

  String? identifiant;
  String? linkedPanier;
  String? linkedCompte;
  String? listeProduits;
  int? totalHt;
  double? totalTtc;
  int? numeroCommande;
  String? numeroFacture;
  String? linkedFacture;
  String? linkedAdresseLivraison;
  String? codePromo;
  String? modePayment;
  String? statut;
  String? isActive;
  List<ListeMenusCommande>? listeMenusCommande;
  int? quantite;
  String? livreur;
  String? station;
  String? trajetCamion;
  String? idPaiement;
  String? modePaiement;
  String? statutPaiement;
  DateTime? dateCreation;
  DateTime? dateLastModif;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        identifiant: json["Identifiant"],
        linkedPanier: json["linkedPanier"],
        linkedCompte: json["linkedCompte"],
        listeProduits: json["listeProduits"],
        totalHt: json["totalHT"],
        totalTtc: json["totalTTC"].toDouble(),
        numeroCommande: json["numeroCommande"],
        numeroFacture: json["numeroFacture"],
        linkedFacture: json["linkedFacture"],
        linkedAdresseLivraison: json["linkedAdresseLivraison"],
        codePromo: json["codePromo"],
        modePayment: json["modePayment"],
        statut: json["statut"],
        isActive: json["isActive"],
        listeMenusCommande: List<ListeMenusCommande>.from(
            json["listeMenusCommande"]
                .map((x) => ListeMenusCommande.fromJson(x))),
        quantite: json["quantite"],
        livreur: json["livreur"],
        station: json["station"],
        trajetCamion: json["trajetCamion"],
        idPaiement: json["idPaiement"],
        modePaiement: json["modePaiement"],
        statutPaiement: json["statutPaiement"],
        dateCreation: DateTime.parse(json["dateCreation"]),
        dateLastModif: DateTime.parse(json["dateLastModif"]),
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "linkedPanier": linkedPanier,
        "linkedCompte": linkedCompte,
        "listeProduits": listeProduits,
        "totalHT": totalHt,
        "totalTTC": totalTtc,
        "numeroCommande": numeroCommande,
        "numeroFacture": numeroFacture,
        "linkedFacture": linkedFacture,
        "linkedAdresseLivraison": linkedAdresseLivraison,
        "codePromo": codePromo,
        "modePayment": modePayment,
        "statut": statut,
        "isActive": isActive,
        "listeMenusCommande":
            List<dynamic>.from(listeMenusCommande!.map((x) => x.toJson())),
        "quantite": quantite,
        "livreur": livreur,
        "station": station,
        "trajetCamion": trajetCamion,
        "idPaiement": idPaiement,
        "modePaiement": modePaiement,
        "statutPaiement": statutPaiement,
        "dateCreation": dateCreation!.toIso8601String(),
        "dateLastModif": dateLastModif!.toIso8601String(),
      };
}

class ListeMenusCommande {
  ListeMenusCommande({
    this.identifiant,
    this.linkedCommande,
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
    this.description,
    this.dateCreation,
    this.dateLastModif,
    this.linkedPanier,
  });

  String? identifiant;
  String? linkedCommande;
  List<LinkedMenu>? linkedMenu;
  List<Taille>? tailles;
  List<Sauce>? sauces;
  List<Sauce>? viandes;
  List<dynamic>? garnitures;
  List<dynamic>? boisons;
  List<dynamic>? autres;
  int? quantite;
  String? prixHt;
  double? prixTtc;
  String? remise;
  String? statut;
  String? description;
  DateTime? dateCreation;
  DateTime? dateLastModif;
  String? linkedPanier;

  factory ListeMenusCommande.fromJson(Map<String, dynamic> json) =>
      ListeMenusCommande(
        identifiant: json["Identifiant"],
        linkedCommande:
            json["linkedCommande"] == null ? null : json["linkedCommande"],
        linkedMenu: List<LinkedMenu>.from(
            json["linkedMenu"].map((x) => LinkedMenu.fromJson(x))),
        tailles:
            List<Taille>.from(json["tailles"].map((x) => Taille.fromJson(x))),
        sauces: List<Sauce>.from(json["sauces"].map((x) => Sauce.fromJson(x))),
        viandes:
            List<Sauce>.from(json["viandes"].map((x) => Sauce.fromJson(x))),
        garnitures: List<dynamic>.from(json["garnitures"].map((x) => x)),
        boisons: List<dynamic>.from(json["boisons"].map((x) => x)),
        autres: List<dynamic>.from(json["autres"].map((x) => x)),
        quantite: json["quantite"],
        prixHt: json["prixHT"],
        prixTtc: json["prixTTC"].toDouble(),
        remise: json["remise"],
        statut: json["statut"],
        description: json["description"] == null ? null : json["description"],
        dateCreation: DateTime.parse(json["dateCreation"]),
        dateLastModif: DateTime.parse(json["dateLastModif"]),
        linkedPanier:
            json["linkedPanier"] == null ? null : json["linkedPanier"],
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "linkedCommande": linkedCommande == null ? null : linkedCommande,
        "linkedMenu": List<dynamic>.from(linkedMenu!.map((x) => x.toJson())),
        "tailles": List<dynamic>.from(tailles!.map((x) => x.toJson())),
        "sauces": List<dynamic>.from(sauces!.map((x) => x.toJson())),
        "viandes": List<dynamic>.from(viandes!.map((x) => x.toJson())),
        "garnitures": List<dynamic>.from(garnitures!.map((x) => x)),
        "boisons": List<dynamic>.from(boisons!.map((x) => x)),
        "autres": List<dynamic>.from(autres!.map((x) => x)),
        "quantite": quantite,
        "prixHT": prixHt,
        "prixTTC": prixTtc,
        "remise": remise,
        "statut": statut,
        "description": description == null ? null : description,
        "dateCreation": dateCreation!.toIso8601String(),
        "dateLastModif": dateLastModif!.toIso8601String(),
        "linkedPanier": linkedPanier == null ? null : linkedPanier,
      };
}

class LinkedMenu {
  LinkedMenu({
    this.identifiant,
    this.titre,
    this.description,
    this.statut,
    this.linkedRestaurant,
    this.prix,
    this.image,
    this.tags,
    this.categorie,
    this.tailles,
    this.sauces,
    this.viandes,
    this.garnitures,
    this.boisons,
    this.autres,
    this.dateCreation,
    this.dateLastModif,
  });

  String? identifiant;
  String? titre;
  String? description;
  String? statut;
  String? linkedRestaurant;
  double? prix;
  String? image;
  List<dynamic>? tags;
  List<String>? categorie;
  List<dynamic>? tailles;
  List<dynamic>? sauces;
  List<dynamic>? viandes;
  List<dynamic>? garnitures;
  List<dynamic>? boisons;
  List<dynamic>? autres;
  DateTime? dateCreation;
  DateTime? dateLastModif;

  factory LinkedMenu.fromJson(Map<String, dynamic> json) => LinkedMenu(
        identifiant: json["Identifiant"],
        titre: json["titre"],
        description: json["description"],
        statut: json["statut"],
        linkedRestaurant:
            json["linkedRestaurant"] == null ? null : json["linkedRestaurant"],
        prix: json["prix"].toDouble(),
        image: json["image"],
        tags: json["tags"] == null
            ? null
            : List<dynamic>.from(json["tags"].map((x) => x)),
        categorie: List<String>.from(json["categorie"].map((x) => x)),
        tailles: json["tailles"] == null
            ? null
            : List<dynamic>.from(json["tailles"].map((x) => x)),
        sauces: json["sauces"] == null
            ? null
            : List<dynamic>.from(json["sauces"].map((x) => x)),
        viandes: json["viandes"] == null
            ? null
            : List<dynamic>.from(json["viandes"].map((x) => x)),
        garnitures: json["garnitures"] == null
            ? null
            : List<dynamic>.from(json["garnitures"].map((x) => x)),
        boisons: json["boisons"] == null
            ? null
            : List<dynamic>.from(json["boisons"].map((x) => x)),
        autres: json["autres"] == null
            ? null
            : List<dynamic>.from(json["autres"].map((x) => x)),
        dateCreation: json["dateCreation"] == null
            ? null
            : DateTime.parse(json["dateCreation"]),
        dateLastModif: json["dateLastModif"] == null
            ? null
            : DateTime.parse(json["dateLastModif"]),
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "titre": titre,
        "description": description,
        "statut": statut,
        "linkedRestaurant": linkedRestaurant == null ? null : linkedRestaurant,
        "prix": prix,
        "image": image,
        "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
        "categorie": List<dynamic>.from(categorie!.map((x) => x)),
        "tailles":
            tailles == null ? null : List<dynamic>.from(tailles!.map((x) => x)),
        "sauces":
            sauces == null ? null : List<dynamic>.from(sauces!.map((x) => x)),
        "viandes":
            viandes == null ? null : List<dynamic>.from(viandes!.map((x) => x)),
        "garnitures": garnitures == null
            ? null
            : List<dynamic>.from(garnitures!.map((x) => x)),
        "boisons":
            boisons == null ? null : List<dynamic>.from(boisons!.map((x) => x)),
        "autres":
            autres == null ? null : List<dynamic>.from(autres!.map((x) => x)),
        "dateCreation":
            dateCreation == null ? null : dateCreation!.toIso8601String(),
        "dateLastModif":
            dateLastModif == null ? null : dateLastModif!.toIso8601String(),
      };
}

class Sauce {
  Sauce({
    this.id,
    this.prixFacculatitf,
    this.qte,
  });

  String? id;
  int? prixFacculatitf;
  int? qte;

  factory Sauce.fromJson(Map<String, dynamic> json) => Sauce(
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

class Taille {
  Taille({
    this.id,
    this.prix,
  });

  String? id;
  int? prix;

  factory Taille.fromJson(Map<String, dynamic> json) => Taille(
        id: json["id"],
        prix: json["prix"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prix": prix,
      };
}
