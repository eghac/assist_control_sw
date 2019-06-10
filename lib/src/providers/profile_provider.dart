import 'dart:convert';
import 'package:assist_control_all_sw/src/utils/user_preferences.dart';
import 'package:assist_control_all_sw/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProfileProvider {
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> getProfileAndContract() async {
    final employeeId = _prefs.employeeId;
    if (employeeId != null) {
      final _url = '$globalUrl/contrato/$employeeId';
      final response = await http.get(_url);
      Map<String, dynamic> decodedRespose = json.decode(response.body);
      _prefs.fechaInicio = decodedRespose['fecha_ini'];
      _prefs.fechaFin = decodedRespose['fecha_fin'];
      _prefs.horarioInicio = decodedRespose['inicio'];
      _prefs.horarioFin = decodedRespose['fin'];
      return {'status_code': 200};
    }
  }
}
