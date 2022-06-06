// To parse this JSON data, do
//
//     final listeMenu = listeMenuFromJson(jsonString);

import 'dart:convert';

List<ListeMenu> listeMenuFromJson(String str) =>
    List<ListeMenu>.from(json.decode(str).map((x) => ListeMenu.fromJson(x)));

String listeMenuToJson(List<ListeMenu> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListeMenu {
  ListeMenu({
    this.id,
    this.name,
    this.listeMenus,
  });

  String? id;
  String? name;
  List<ListeMenuElement>? listeMenus;

  factory ListeMenu.fromJson(Map<String, dynamic> json) => ListeMenu(
        id: json["id"],
        name: json["name"],
        listeMenus: List<ListeMenuElement>.from(
            json["listeMenus"].map((x) => ListeMenuElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "listeMenus": List<dynamic>.from(listeMenus!.map((x) => x.toJson())),
      };
}

class ListeMenuElement {
  ListeMenuElement({
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
  double? prix;
  String? image;
  List<String>? categorie;

  factory ListeMenuElement.fromJson(Map<String, dynamic> json) =>
      ListeMenuElement(
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
