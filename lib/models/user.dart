import 'dart:convert';


User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.name = "",
    this.firstName = "",
    this.email = "",
    this.phone = "",
    this.adress = "",
    this.poitrine = "",
    this.password = "",
    this.authProvider = "",
    this.provider,
    this.accessToken = '',
    this.userId = "",
    this.type = "",
    this.ville = "",
    this.pays = "",
    this.codePostal = "",
  });

  int? id;
  String? name;
  String? firstName;
  String? email;
  String? phone;
  String? adress;
  String? password;
  late String authProvider;
  AuthProvider? provider;
  String? ville;
  String? codePostal;
  String? poitrine;

  String? accessToken;
  String? type;
  String? userId;
  String? pays;
  String? sexe;
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        firstName: json["firstName"],
        email: json["email"],
        phone: json["phone"],
        ville: json["ville"],
        codePostal: json["codePostal"],
        pays: json["pays"],
        adress: json["addresse"],
        password: json["password"],
        poitrine: json["poitrine"],
        authProvider: json["authProvider"],
        accessToken: json["accessToken"],
        userId: json["idUser"],
        type: json["type"],
        provider: AuthProvider.fromJson(json["provider"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "firstName": firstName,
        "email": email,
        "phone": phone,
        "addresse": adress,
        "password": password,
        "poitrine": poitrine,
        "ville": ville,
        "codePostal": codePostal,
        "pays": pays,
        "authProvider": authProvider,
        "accessToken": accessToken,
        "idUser": userId,
        "type": type,
        "provider": provider != null ? provider?.toJson() : null,
      };
}

class AuthProvider {
  AuthProvider({
    this.accessToken = "",
    this.userId = "",
    this.type = "",
  });

  late String accessToken;
  late String type;
  late String userId;

  factory AuthProvider.fromJson(Map<String, dynamic> json) => AuthProvider(
        accessToken: json["accessToken"],
        userId: json["idUser"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() =>
      {"accessToken": accessToken, "idUser": userId, "type": type};
}
