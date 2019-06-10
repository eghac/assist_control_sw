import 'dart:convert';

import 'package:assist_control_all_sw/src/models/marked_model.dart';
import 'package:assist_control_all_sw/src/utils/constants.dart';
import 'package:assist_control_all_sw/src/utils/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class MarkedProvider {
  final _url = '$globalUrl';
  // final _url = '';

  final _prefs = new PreferenciasUsuario();

  Future<bool> createMarked(
      MarkedModel newMarked, double lat, double lng) async {
    // final url = '$_url/api/marcado';
    final url = '$_url/marcado';
    // final response = await http.post(url, body: markedModelToJson(newMarked));
    Map<String, String> data = new Map();
    data['id_personal'] = _prefs.employeeId;
    data['fecha'] = newMarked.fecha;
    data['hora'] = newMarked.hora;
    data['tipo'] = newMarked.tipo.toString();
    data['x'] = '$lng';
    data['y'] = '$lat';
    final response = await http.post(url, body: data);
    final decodeData = json.decode(response.body);
    print('MarkedProvider: $decodeData');
    // return (response.statusCode == 200) ? true : false;
    return true;
  }
}
