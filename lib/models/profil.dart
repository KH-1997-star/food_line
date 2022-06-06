import 'dart:convert';

List<UserResponse> userResponseFromJson(String str) => List<UserResponse>.from(
    json.decode(str).map((x) => UserResponse.fromJson(x)));

String userResponseToJson(List<UserResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserResponse {
  UserResponse({
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
    this.joursLivraison,
    this.timeLivraison,
  });

  dynamic? identifiant;
  dynamic? nom;
  dynamic? prenom;
  dynamic? email;
  dynamic? phone;
  dynamic? aPropos;
  dynamic? photoProfil;
  dynamic? addresse;
  dynamic? ville;
  dynamic? pays;
  dynamic? codePostal;
  dynamic? position;
  dynamic? tempsLivraison;
  dynamic? isActive;
  dynamic? role;
  dynamic? joursLivraison;
  dynamic? timeLivraison;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
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
        position: json["position"],
        tempsLivraison: json["tempsLivraison"],
        isActive: json["isActive"],
        role: json["role"],
        joursLivraison: json["joursLivraison"],
        timeLivraison: json["timeLivraison"],
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
        "position": position,
        "tempsLivraison": tempsLivraison,
        "isActive": isActive,
        "role": role,
        "joursLivraison": joursLivraison,
        "timeLivraison": timeLivraison,
      };
}
