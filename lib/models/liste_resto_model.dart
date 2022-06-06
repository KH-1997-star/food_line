// To parse this JSON data, do
//
//     final listeResto = listeRestoFromJson(jsonString);

import 'dart:convert';

List<ListeResto> listeRestoFromJson(String str) =>
    List<ListeResto>.from(json.decode(str).map((x) => ListeResto.fromJson(x)));

String listeRestoToJson(List<ListeResto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListeResto {
  ListeResto({
    this.id,
    this.name,
    this.listeRestaurant,
  });

  String? id;
  String? name;
  List<ListeRestaurant>? listeRestaurant;

  factory ListeResto.fromJson(Map<String, dynamic> json) => ListeResto(
        id: json["id"],
        name: json["name"],
        listeRestaurant: List<ListeRestaurant>.from(
            json["listeRestaurant"].map((x) => ListeRestaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "listeRestaurant":
            List<dynamic>.from(listeRestaurant!.map((x) => x.toJson())),
      };
}

class ListeRestaurant {
  ListeRestaurant(
      {this.identifiant,
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
      this.tags,
      this.disponible,
      this.qteMax,
      this.qteRestant,
      this.like});

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
  List<String>? tags;
  bool? disponible;
  dynamic? qteRestant;
  dynamic? qteMax;
  dynamic? like;

  factory ListeRestaurant.fromJson(Map<String, dynamic> json) =>
      ListeRestaurant(
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
        tags: List<String>.from(json["tags"].map((x) => x)),
        disponible: json["disponible"],
        qteMax: json["qteMax"],
        qteRestant: json["qteRestant"],
        like: json["like"],
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
        "tags": List<dynamic>.from(tags!.map((x) => x)),
        "disponible": disponible,
        "qteMax": qteMax,
        "qteRestant": qteRestant,
        "like": like
      };
}
