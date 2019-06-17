import 'dart:convert';

import 'package:assist_control_all_sw/src/models/marked_model.dart';
import 'package:assist_control_all_sw/src/utils/constants.dart';
import 'package:assist_control_all_sw/src/utils/user_preferences.dart';
import 'package:http/http.dart' as http;

class MarkedProvider {
  final _url = '$globalUrl';

  final _prefs = new PreferenciasUsuario();

  Future<bool> createMarked(
      MarkedModel newMarked, double lat, double lng, int serviceId) async {
    final url = '$_url/marcado';
    Map<String, String> data = new Map();
    data['id_personal'] = _prefs.employeeId;
    data['fecha'] = newMarked.fecha;
    data['hora'] = newMarked.hora;
    data['tipo'] = newMarked.tipo.toString();
    data['x'] = '$lng';
    data['y'] = '$lat';
    data['id_nota'] = '$serviceId';
    final response = await http.post(url, body: data);
    final decodeData = json.decode(response.body);
    print('MarkedProvider: $decodeData');
    // return (response.statusCode == 200) ? true : false;
    return true;
  }
}
