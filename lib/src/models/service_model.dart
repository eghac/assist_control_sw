// import 'dart:convert';

// Service serviceFromJson(String str) => Service.fromJson(json.decode(str));

// String serviceToJson(Service data) => json.encode(data.toJson());

// List<Service> serviceFromJson(String str) =>
//     new List<Service>.from(json.decode(str).map((x) => Service.fromJson(x)))
//         .toList();

// String serviceToJson(List<Service> data) =>
//     json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

// class Service {
//   String id;
//   String description;
//   String customerName;
//   int state;
//   double lat;
//   double lng;
//   int telefono;

//   Service({
//     this.id,
//     this.description,
//     this.customerName,
//     this.state,
//     this.lat,
//     this.lng,
//     this.telefono,
//   });

//   factory Service.fromJson(Map<String, dynamic> json) => new Service(
//         id: json["id"],
//         description: json["description"],
//         customerName: json["customer_name"],
//         state: json["state"],
//         lat: json["lat"].toDouble(),
//         lng: json["lng"].toDouble(),
//         telefono: json["telefono"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "description": description,
//         "customer_name": customerName,
//         "state": state,
//         "lat": lat,
//         "lng": lng,
//         "telefono": telefono,
//       };
// }

import 'dart:convert';

List<Service> serviceFromJson(String str) =>
    new List<Service>.from(json.decode(str).map((x) => Service.fromJson(x)));

String serviceToJson(List<Service> data) =>
    json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Service {
  int id;
  String description;
  String customerName;
  int state;
  double lat;
  double lng;

  Service({
    this.id,
    this.description,
    this.customerName,
    this.state,
    this.lat,
    this.lng,
  });

  factory Service.fromJson(Map<String, dynamic> json) => new Service(
        id: json["id"],
        description: json["description"],
        customerName: json["customer_name"],
        state: json["state"],
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "customer_name": customerName,
        "state": state,
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
      };
}

// ******************************************************************************** //

// import 'dart:convert';

// ServiceModel serviceModelFromJson(String str) => ServiceModel.fromJson(json.decode(str));

// String serviceModelToJson(ServiceModel data) => json.encode(data.toJson());

// class ServiceModel {
//   List<Service> services;

//   ServiceModel({
//     this.services,
//   });

//   factory ServiceModel.fromJson(Map<String, dynamic> json) => new ServiceModel(
//     services: new List<Service>.from(json["services"].map((x) => Service.fromJson(x))).toList(),
//   );

//   Map<String, dynamic> toJson() => {
//     "services": new List<dynamic>.from(services.map((x) => x.toJson())),
//   };
// }

// class Service {
//   String id;
//   String description;
//   String customerName;
//   int state;

//   Service({
//     this.id,
//     this.description,
//     this.customerName,
//     this.state,
//   });

//   factory Service.fromJson(Map<String, dynamic> json) => new Service(
//     id: json["id"],
//     description: json["description"],
//     customerName: json["customer_name"],
//     state: json["state"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "description": description,
//     "customer_name": customerName,
//     "state": state,
//   };
// }
