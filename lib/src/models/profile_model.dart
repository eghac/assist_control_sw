import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

// {
//     "nombre":"Eliot",
//     "ci": 9000147,
//     "huella": "asdfasdf",
//     "cargo": "vendedor",
//     "estado": 1,
//     "email" : "test@test.com",
//     "foto" : "http://www.google.com/path.png"
// }

class ProfileModel {
    String nombre;
    int ci;
    String huella;
    String cargo;
    int estado;
    String email;
    String foto;

    ProfileModel({
        this.nombre,
        this.ci,
        this.huella,
        this.cargo,
        this.estado,
        this.email,
        this.foto,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => new ProfileModel(
        nombre: json["nombre"],
        ci: json["ci"],
        huella: json["huella"],
        cargo: json["cargo"],
        estado: json["estado"],
        email: json["email"],
        foto: json["foto"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "ci": ci,
        "huella": huella,
        "cargo": cargo,
        "estado": estado,
        "email": email,
        "foto": foto,
    };
}