// To parse this JSON data, do
//
//     final cmdAcheminement = cmdAcheminementFromJson(jsonString);

import 'dart:convert';

CmdAcheminement cmdAcheminementFromJson(String str) =>
    CmdAcheminement.fromJson(json.decode(str));

String cmdAcheminementToJson(CmdAcheminement data) =>
    json.encode(data.toJson());

class CmdAcheminement {
  CmdAcheminement({
    this.count,
    this.listeCommandes,
  });

  int? count;
  List<ListeCommande>? listeCommandes;

  factory CmdAcheminement.fromJson(Map<String, dynamic> json) =>
      CmdAcheminement(
        count: json["count"],
        listeCommandes: List<ListeCommande>.from(
            json["listeCommandes"].map((x) => ListeCommande.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "listeCommandes":
            List<dynamic>.from(listeCommandes!.map((x) => x.toJson())),
      };
}

class ListeCommande {
  ListeCommande({
    this.id,
    this.idLivreur,
    this.position,
  });

  String? id;
  String? idLivreur;
  List<double>? position;

  factory ListeCommande.fromJson(Map<String, dynamic> json) => ListeCommande(
        id: json["id"],
        idLivreur: json["idLivreur"],
        position: List<double>.from(json["position"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idLivreur": idLivreur,
        "position": List<dynamic>.from(position!.map((x) => x)),
      };
}
