// To parse this JSON data, do
//
//     final listeCmd = listeCmdFromJson(jsonString);

import 'dart:convert';

ListeCmd listeCmdFromJson(String str) => ListeCmd.fromJson(json.decode(str));

String listeCmdToJson(ListeCmd data) => json.encode(data.toJson());

class ListeCmd {
  ListeCmd({
    this.results,
    this.count,
  });

  List<Result>? results;
  int? count;

  factory ListeCmd.fromJson(Map<String, dynamic> json) => ListeCmd(
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
  List<Livreur>? livreur;
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
        listeMenusCommande:
            List<String>.from(json["listeMenusCommande"].map((x) => x)),
        quantite: json["quantite"],
        livreur:
            List<Livreur>.from(json["livreur"].map((x) => Livreur.fromJson(x))),
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
            List<dynamic>.from(listeMenusCommande!.map((x) => x)),
        "quantite": quantite,
        "livreur": List<dynamic>.from(livreur!.map((x) => x.toJson())),
        "station": station,
        "trajetCamion": trajetCamion,
        "idPaiement": idPaiement,
        "modePaiement": modePaiement,
        "statutPaiement": statutPaiement,
        "dateCreation": dateCreation!.toIso8601String(),
        "dateLastModif": dateLastModif!.toIso8601String(),
      };
}

class Livreur {
  Livreur({
    this.identifiant,
    this.nom,
    this.prenom,
    this.email,
    this.phone,
    this.aPropos,
    this.photoProfil,
    this.addresse,
    this.ville,
    this.pays,
    this.codePostal,
    this.position,
    this.tempsLivraison,
    this.isActive,
    this.role,
    this.disponible,
    this.idCompteBancaire,
    this.dateCreation,
    this.dateLastModif,
  });

  String? identifiant;
  String? nom;
  String? prenom;
  String? email;
  String? phone;
  String? aPropos;
  String? photoProfil;
  String? addresse;
  String? ville;
  String? pays;
  dynamic? codePostal;
  List<double>? position;
  String? tempsLivraison;
  String? isActive;
  String? role;
  String? disponible;
  String? idCompteBancaire;
  DateTime? dateCreation;
  DateTime? dateLastModif;

  factory Livreur.fromJson(Map<String, dynamic> json) => Livreur(
        identifiant: json["Identifiant"],
        nom: json["nom"],
        prenom: json["prenom"],
        email: json["email"],
        phone: json["phone"],
        aPropos: json["aPropos"],
        photoProfil: json["photoProfil"],
        addresse: json["addresse"],
        ville: json["ville"],
        pays: json["pays"],
        codePostal: json["codePostal"],
        position: List<double>.from(json["position"].map((x) => x.toDouble())),
        tempsLivraison: json["tempsLivraison"],
        isActive: json["isActive"],
        role: json["role"],
        disponible: json["disponible"],
        idCompteBancaire: json["idCompteBancaire"],
        dateCreation: DateTime.parse(json["dateCreation"]),
        dateLastModif: DateTime.parse(json["dateLastModif"]),
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "nom": nom,
        "prenom": prenom,
        "email": email,
        "phone": phone,
        "aPropos": aPropos,
        "photoProfil": photoProfil,
        "addresse": addresse,
        "ville": ville,
        "pays": pays,
        "codePostal": codePostal,
        "position": List<dynamic>.from(position!.map((x) => x)),
        "tempsLivraison": tempsLivraison,
        "isActive": isActive,
        "role": role,
        "disponible": disponible,
        "idCompteBancaire": idCompteBancaire,
        "dateCreation": dateCreation!.toIso8601String(),
        "dateLastModif": dateLastModif!.toIso8601String(),
      };
}
