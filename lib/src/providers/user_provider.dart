import 'dart:convert';
import 'package:assist_control_all_sw/src/utils/constants.dart';
import 'package:assist_control_all_sw/src/utils/user_preferences.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final String _firebaseToken = 'AIzaSyAHRXcIAHTccz6pDG6C_FdpH6WRM1axEA0';

  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> signUp(String email, String password,
      String nombre, String cedula, String huella) async {
    Map<String, String> dataMap = new Map();
    dataMap['nombre'] = nombre;
    dataMap['email'] = email;
    dataMap['password'] = password;
    dataMap['cedula'] = cedula;
    dataMap['huella'] = huella;

    final _url = '$globalUrl/empleado';
    final response = await http.post(_url, body: dataMap);
    Map<String, dynamic> decodedRespose = json.decode(response.body);

    if (decodedRespose['status_code'] == 200) {
      _prefs.employeeId = decodedRespose['id'].toString();
      _prefs.fullName = decodedRespose['nombre'];
      _prefs.email = decodedRespose['email'];
      _prefs.ci = decodedRespose['cedula'];
      _prefs.fingerPrint = decodedRespose['huella'];
      return {'status_code': 200, 'message': decodedRespose['message']};
    } else
      return {'error': decodedRespose['message']};
  }

  logout() {
    // _prefs.resetInstance();
    _prefs.employeeId = '';
    _prefs.email = '';
    _prefs.fingerPrint = '';
    _prefs.fullName = '';
    _prefs.ci = '';
    _prefs.fechaInicio = '';
    _prefs.fechaFin = '';
    _prefs.horarioInicio = '';
    _prefs.horarioFin = '';
  }

  Future<Map<String, dynamic>> signupUser(String email, String password) async {
    final data = {
      'email': email,
      'password': password,
      'returnSecuryToken': true
    };

    final response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=$_firebaseToken',
        body: json.encode(data));
    Map<String, dynamic> decodedRespose = json.decode(response.body);

//    print(decodedRespose);

    if (decodedRespose.containsKey('idToken')) {
      // TODO guardar el token en el storage
      _prefs.token = decodedRespose['idToken'];
      return {'ok': true, 'token': decodedRespose['idToken']};
    } else {
      return {'ok': false, 'message': decodedRespose['error']['message']};
    }
  }

  Future<Map<String, dynamic>> signin(String email, String password) async {
    Map<String, String> dataMap = new Map();
    dataMap['email'] = email;
    dataMap['password'] = password;

    // final _url = '$globalUrl/empleado';
    final _url = '$globalUrl/login/$email/$password';

    final response = await http.get(_url);
    Map<String, dynamic> decodedRespose = json.decode(response.body);

    if (decodedRespose['status_code'] == 200) {
      _prefs.employeeId = decodedRespose['id'].toString();
      _prefs.fullName = decodedRespose['nombre'];
      _prefs.email = decodedRespose['email'];
      _prefs.ci = decodedRespose['cedula'].toString();
      _prefs.fingerPrint = decodedRespose['huella'];
      return {'status_code': 200, 'message': decodedRespose['message']};
    } else
      return {'error': decodedRespose['message']};
  }

  Future<Map<String, dynamic>> signinUser(String email, String password) async {
    final data = {
      'email': email,
      'password': password,
      'returnSecuryToken': true
    };

    final response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=$_firebaseToken',
        body: json.encode(data));
    Map<String, dynamic> decodedRespose = json.decode(response.body);

    print(decodedRespose);

    if (decodedRespose.containsKey('idToken')) {
      // TODO guardar el token en el storage
      _prefs.token = decodedRespose['idToken'];
      return {'ok': true, 'token': decodedRespose['idToken']};
    } else {
      return {'ok': false, 'message': decodedRespose['error']['message']};
    }
  }

//  {error: {code: 400, message: EMAIL_EXISTS, errors: [{message: EMAIL_EXISTS, domain: global, reason: invalid}]}}
}
