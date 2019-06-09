import 'dart:collection';

import 'package:assist_control_all_sw/src/models/service_model.dart';
import 'package:assist_control_all_sw/src/utils/constants.dart';

import 'dart:convert';
import 'dart:io';

import 'package:assist_control_all_sw/src/utils/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:assist_control_all_sw/src/models/service_model.dart';
import 'package:http_parser/http_parser.dart';
export 'package:assist_control_all_sw/src/models/service_model.dart';
import 'package:mime_type/mime_type.dart';

class ServicesProvider {
  // final _url = '$globalUrl/eliot';
  final _url = '$globalUrl';

  Future<List<Service>> getServices() async {
    // final url = '$_url/archivo.json';
    final url = '$_url/api/servicio/5';
    final response = await http.get(url);
//    print(response.statusCode);
//    if (response.statusCode == 200) {
    if (response.statusCode != 200) {
      return [];
    }
    // final Map<String, dynamic> decodeData = json.decode(response.body);
    final List decodeData = await json.decode(response.body);

    if (decodeData == null) return [];

    final List<Service> services = new List();

    // final d = decodeData.toList();

    decodeData.map((item) {
      print('Service provider: $item');
      services.add(Service.fromJson(item));
    }).toList();
    print('Length services: ${services.length}');
    return services;
    // return services;
  }
}
