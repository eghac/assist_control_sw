import 'dart:async';

import 'package:assist_control_all_sw/src/blocs/validators.dart';

import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
//  final _emailController = StreamController<String>.broadcast();
//  final _passwordController = StreamController<String>.broadcast();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();
  final _ciController = BehaviorSubject<String>();
  final _fingerPrintController = BehaviorSubject<String>();

  // Recuperar los datos de Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  Stream<String> get nameStream => _nameController.stream;

  Stream<String> get ciStream => _ciController.stream;

  Stream<String> get fingerPrintStream => _fingerPrintController.stream;

  Stream<bool> get formValidateStream =>
      Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeCi => _ciController.sink.add;
  Function(String) get changeFingerPrint => _fingerPrintController.sink.add;

  //
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get name => _nameController.value;
  String get ci => _ciController.value;
  String get fingerPrint => _fingerPrintController.value;

  disposed() {
    _emailController?.close();
    _passwordController?.close();
    _nameController?.close();
    _ciController?.close();
    _fingerPrintController?.close();
  }
}
