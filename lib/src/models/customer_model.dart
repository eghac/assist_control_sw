import 'dart:convert';

CustomerModel customerModelFromJson(String str) =>
    CustomerModel.fromJson(json.decode(str));

String customerModelToJson(CustomerModel data) => json.encode(data.toJson());

class CustomerModel {
  String id;
  String name;
  String telephone;
  String address;
  String locationName;
  String lat;
  String lon;

  CustomerModel({
    this.id,
    this.name,
    this.telephone,
    this.address,
    this.locationName,
    this.lat,
    this.lon,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      new CustomerModel(
        id: json["id"],
        name: json["name"],
        telephone: json["telephone"],
        address: json["address"],
        locationName: json["location_name"],
        lat: json["lat"],
        lon: json["lon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "telephone": telephone,
        "address": address,
        "location_name": locationName,
        "lat": lat,
        "lon": lon,
      };
}
