// To parse this JSON data, do
//
//     final livreur = livreurFromJson(jsonString);

import 'dart:convert';

Livreur livreurFromJson(String str) => Livreur.fromJson(json.decode(str));

String livreurToJson(Livreur data) => json.encode(data.toJson());

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
  dynamic codePostal;
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
        "dateCreation": dateCreation?.toIso8601String(),
        "dateLastModif": dateLastModif?.toIso8601String(),
      };
}
