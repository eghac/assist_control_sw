import 'package:assist_control_all_sw/src/blocs/login_bloc.dart';
import 'package:assist_control_all_sw/src/blocs/services_bloc.dart';
import 'package:assist_control_all_sw/src/models/marked_model.dart';
export 'package:assist_control_all_sw/src/blocs/services_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Provider extends InheritedWidget {
  final _servicesBloc = new ServicesBloc();
  final loginBloc = LoginBloc();
  final bool markedGlobal;
  // final double _latUser;
  // final double _lngUser;

  static Provider _instance;

  factory Provider({Key key, Widget child, bool marked}) {
    if (_instance == null) {
      _instance = new Provider._internal(marked, key: key, child: child);
    }
    return _instance;
  }

  Provider._internal(this.markedGlobal, {Key key, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static Provider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(Provider);

  static ServicesBloc servicesBloc(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)
        ._servicesBloc;
  }

  static LoginBloc logicBloc(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)
        .loginBloc;
  }

  // static MarkedBloc markedBloc(BuildContext context) {
  //   return (context.inheritFromWidgetOfExactType(Provider) as Provider)
  //       ._latUser;
  // }
}
