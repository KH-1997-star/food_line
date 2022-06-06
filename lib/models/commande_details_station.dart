// To parse this JSON data, do
//
//     final commandeDetailsLivreur = commandeDetailsLivreurFromJson(jsonString);

import 'dart:convert';

CommandeDetailsStation commandeDetailsStationFromJson(String str) =>
    CommandeDetailsStation.fromJson(json.decode(str));

String commandeDetailsStationToJson(CommandeDetailsStation data) =>
    json.encode(data.toJson());

class CommandeDetailsStation {
  CommandeDetailsStation({
    this.results,
    this.count,
  });

  List<Result>? results;
  int? count;

  factory CommandeDetailsStation.fromJson(Map<String, dynamic> json) =>
      CommandeDetailsStation(
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
  List<String>? listeMenusCommande;
  int? quantite;
  String? livreur;
  List<Station>? station;
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
        listeMenusCommande:
            List<String>.from(json["listeMenusCommande"].map((x) => x)),
        quantite: json["quantite"],
        livreur: json["livreur"],
        station:
            List<Station>.from(json["station"].map((x) => Station.fromJson(x))),
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
            List<dynamic>.from(listeMenusCommande!.map((x) => x)),
        "quantite": quantite,
        "livreur": livreur,
        "station": List<dynamic>.from(station!.map((x) => x.toJson())),
        "trajetCamion": trajetCamion,
        "idPaiement": idPaiement,
        "modePaiement": modePaiement,
        "statutPaiement": statutPaiement,
        "dateCreation": dateCreation!.toIso8601String(),
        "dateLastModif": dateLastModif!.toIso8601String(),
      };
}

class Station {
  Station({
    this.identifiant,
    this.name,
    this.position,
    this.isActive,
    this.statut,
    this.dateCreation,
    this.dateLastModif,
  });

  String? identifiant;
  String? name;
  List<double>? position;
  String? isActive;
  String? statut;
  DateTime? dateCreation;
  DateTime? dateLastModif;

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        identifiant: json["Identifiant"],
        name: json["name"],
        position: List<double>.from(json["position"].map((x) => x.toDouble())),
        isActive: json["isActive"],
        statut: json["statut"],
        dateCreation: DateTime.parse(json["dateCreation"]),
        dateLastModif: DateTime.parse(json["dateLastModif"]),
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "name": name,
        "position": List<dynamic>.from(position!.map((x) => x)),
        "isActive": isActive,
        "statut": statut,
        "dateCreation": dateCreation!.toIso8601String(),
        "dateLastModif": dateLastModif!.toIso8601String(),
      };
}
