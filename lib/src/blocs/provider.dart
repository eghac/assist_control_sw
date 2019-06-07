import 'package:assist_control_all_sw/src/blocs/services_bloc.dart';
export 'package:assist_control_all_sw/src/blocs/services_bloc.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final _servicesBloc = new ServicesBloc();

  static Provider _instance;

  factory Provider({Key key, Widget child}) {
    if (_instance == null) {
      _instance = new Provider._internal(key: key, child: child);
    }
    return _instance;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ServicesBloc servicesBloc(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)
        ._servicesBloc;
  }
}
