import 'dart:convert';

MarkedModel markedModelFromJson(String str) =>
    MarkedModel.fromJson(json.decode(str));

String markedModelToJson(MarkedModel data) => json.encode(data.toJson());

class MarkedModel {
  String id;
  String fecha;
  String hora;
  int tipo;

  MarkedModel({
    this.id,
    this.fecha,
    this.hora,
    this.tipo,
  });

  factory MarkedModel.fromJson(Map<String, dynamic> json) => new MarkedModel(
        id: json["id"],
        fecha: json["fecha"],
        hora: json["hora"],
        tipo: json["tipo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fecha": fecha,
        "hora": hora,
        "tipo": tipo,
      };
}
