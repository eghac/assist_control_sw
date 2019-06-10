import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:
  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();

    Recuerden que el main() debe de ser async {...
*/

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  resetInstance() {
    this._prefs = null;
  }

  get fullName {
    return _prefs.getString('full_name') ?? '';
  }

  set fullName(String value) {
    _prefs.setString('full_name', value);
  }

  get employeeId {
    return _prefs.getString('employee_id') ?? '';
  }

  set employeeId(String value) {
    _prefs.setString('employee_id', value);
  }

  get email {
    return _prefs.getString('email') ?? '';
  }

  set email(String value) {
    _prefs.setString('email', value);
  }

  get ci {
    return _prefs.getString('ci') ?? '';
  }

  set ci(String value) {
    _prefs.setString('ci', value);
  }

  get fingerPrint {
    return _prefs.getString('finger_print') ?? '';
  }

  set fingerPrint(String value) {
    _prefs.setString('finger_print', value);
  }

  // GET y SET del nombre
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }

  // Contrato
  get fechaInicio {
    return _prefs.getString('fecha_inicio') ?? '';
  }

  set fechaInicio(String value) {
    _prefs.setString('fecha_inicio', value);
  }

  get fechaFin {
    return _prefs.getString('fecha_fin') ?? '';
  }

  set fechaFin(String value) {
    _prefs.setString('fecha_fin', value);
  }

  // Horario del contrato
  get horarioInicio {
    return _prefs.getString('horario_inicio') ?? '';
  }

  set horarioInicio(String value) {
    _prefs.setString('horario_inicio', value);
  }

  get horarioFin {
    return _prefs.getString('horario_fin') ?? '';
  }

  set horarioFin(String value) {
    _prefs.setString('horario_fin', value);
  }
}
