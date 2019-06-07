import 'dart:collection';

import 'package:assist_control_all_sw/src/models/service_model.dart';

import 'dart:convert';
import 'dart:io';

import 'package:assist_control_all_sw/src/utils/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:assist_control_all_sw/src/models/service_model.dart';
import 'package:http_parser/http_parser.dart';
export 'package:assist_control_all_sw/src/models/service_model.dart';
import 'package:mime_type/mime_type.dart';

class ServicesProvider {
//  final _url = 'http://localhost/eliot';
  final _url = 'http://67b5c3a6.ngrok.io/eliot';
  // final _url = 'https://flutter-varios-67398.firebaseio.com';

  Future<List<Service>> getServices() async {
    final url = '$_url/archivo.json';
    // final url = '$_url/products.json';
    final response = await http.get(url);
//    print(response.statusCode);
//    if (response.statusCode == 200) {
    // final Map<String, dynamic> decodeData = json.decode(response.body);
    final List decodeData = json.decode(response.body);

    if (decodeData == null) return [];

    final List<Service> services = new List();

    decodeData.map((item) {
      print(item);
      services.add(Service.fromJson(item));
    }).toList();
    return services;
  }
}
