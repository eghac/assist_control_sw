import 'package:assist_control_all_sw/src/blocs/login_bloc.dart';
import 'package:assist_control_all_sw/src/blocs/provider.dart';
import 'package:assist_control_all_sw/src/models/marked_model.dart';
import 'package:assist_control_all_sw/src/pages/signin_page.dart';
import 'package:assist_control_all_sw/src/providers/marked_provider.dart';
import 'package:assist_control_all_sw/src/providers/user_provider.dart';
import 'package:assist_control_all_sw/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class SignupPage extends StatelessWidget {
  static final routeName = 'signup_page';

  final userProvider = new UserProvider();

  final LocalAuthentication _localAuthentication = LocalAuthentication();

  bool _canCheckBiometric = false;

  final markedProvider = new MarkedProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[_buildBackgroud(context), _loginForm(context)],
    ));
  }

  Widget _buildBackgroud(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final backgroud = Container(
        height: size.height * 0.4,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
          Color.fromRGBO(63, 63, 156, 1.0),
          Color.fromRGBO(90, 70, 178, 1.0)
        ]))
//      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0 ))),
        );

    final circle = Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05),
        ));

    final circle2 = Container(
        height: size.height * 0.6,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.elliptical(200.0, 160.0)),
            gradient: LinearGradient(colors: <Color>[
              Color.fromRGBO(63, 63, 156, 1.0),
              Color.fromRGBO(90, 70, 178, 1.0)
            ])));

    return Stack(
      children: <Widget>[
        backgroud,
//        circle2,
        Positioned(top: 90.0, left: 30.0, child: circle),
        Positioned(top: -40.0, right: -30.0, child: circle),
        Positioned(bottom: -50.0, right: -10.0, child: circle),
        Positioned(bottom: 120.0, right: 20.0, child: circle),
        Positioned(bottom: -50.0, left: -20.0, child: circle),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
              SizedBox(width: double.infinity, height: 10.0),
              Text('Assist Control',
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.logicBloc(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(child: Container(height: 180.0)),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30.0),
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      // offset para que recorra la sombra en uno de sus ejes (x, y)
                      offset: Offset(0.0, 5.0),
                      //
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text('Registro de personal', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                _buildNameInputBox(context, bloc),
                SizedBox(height: 30.0),
                _buildCiInputBox(context, bloc),
                SizedBox(height: 30.0),
                _buildEmailInputBox(context, bloc),
                SizedBox(height: 30.0),
                _buildPasswordInputBox(context, bloc),
                SizedBox(height: 30.0),
                _buildButton(bloc)
              ],
            ),
          ),
          FlatButton(
              onPressed: () => Navigator.pushReplacementNamed(context, LoginPage.routeName),
              child: Text('¿Ya tienes una cuenta?')),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _buildNameInputBox(BuildContext context, LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.nameStream,
        builder: (BuildContext context, AsyncSnapshot<String> snapShot) =>
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    icon: Icon(Icons.perm_identity,
                        color: Theme.of(context).primaryColor),
                    labelText: "Nombre completo",
                    hintText: "",
                    counterText: snapShot.data,
                    errorText: snapShot.error),
                onChanged: bloc.changeName,
              ),
            ));
  }

  Widget _buildCiInputBox(BuildContext context, LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.ciStream,
        builder: (BuildContext context, AsyncSnapshot<String> snapShot) =>
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    icon: Icon(Icons.payment,
                        color: Theme.of(context).primaryColor),
                    labelText: "Cédula de identidad",
                    hintText: "",
                    counterText: '${snapShot.data}',
                    errorText: snapShot.error),
//                onChanged: (value) => bloc.changeEmail(value),
                onChanged: bloc.changeCi,
              ),
            ));
  }

  Widget _buildEmailInputBox(BuildContext context, LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot<String> snapShot) =>
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    icon: Icon(Icons.alternate_email,
                        color: Theme.of(context).primaryColor),
                    labelText: "Correo electrónico",
                    hintText: "ejemplo@correo.com",
                    counterText: snapShot.data,
                    errorText: snapShot.error),
//                onChanged: (value) => bloc.changeEmail(value),
                onChanged: bloc.changeEmail,
              ),
            ));
  }

  Widget _buildPasswordInputBox(BuildContext context, LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (context, snapshot) => Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                // obscureText para ocultar el texto (TextField password)
                obscureText: true,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock_outline,
                        color: Theme.of(context).primaryColor),
                    labelText: "Contraseña",
                    hintText: "Contraseña",
                    counterText: snapshot.data,
                    errorText: snapshot.error),
                onChanged: bloc.changePassword,
              ),
            ));
  }

  Widget _buildButton(LoginBloc bloc) {
    return StreamBuilder<bool>(
        stream: bloc.formValidateStream,
        builder: (context, snapshot) {
          return RaisedButton(
              // Container para estilizar este botón
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 15.0),
                child: Text('Registrar huella'),
              ),
              elevation: 0.0,
              color: Colors.deepPurple,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              onPressed:
                  // snapshot.hasData ? () => _sign_in(context, bloc) : null);
                  snapshot.hasData ? () => _fingerPrint(context, bloc) : null);
        });
  }

  _sign_in(BuildContext context, LoginBloc bloc, fingerprint) async {

    // encriptar password aquí
    final fingerprintEncryp = await encryptFingerprint(bloc);

    final res = await userProvider.signUp(
        bloc.email, bloc.password, bloc.name, bloc.ci, fingerprintEncryp);

    if (res['status_code'] == 200) {
      print('SINGUP: ${res['message']}');
      Navigator.pushReplacementNamed(context, 'home');
    } else
      showAlert(context, res['error']);
  }

  Future<void> _fingerPrint(BuildContext context, LoginBloc bloc) async {
    bool canCheckBiometric = false;

    bool isAuthorized = false;
    bool fingerprint = false;
    try {
      canCheckBiometric = await _localAuthentication.canCheckBiometrics;

      if (canCheckBiometric) {
        fingerprint = await _localAuthentication.authenticateWithBiometrics(
            localizedReason:
                "Por favor autentica para completar el proceso de registro.",
            useErrorDialogs: true,
            stickyAuth: true);
            isAuthorized = fingerprint;
      } else
        print('No hay autenticación: $canCheckBiometric');

    } on PlatformException catch (e) {
      print(e.code);
    }

    if (isAuthorized) {
      print('Autorizado');
      _sign_in(context, bloc, fingerprint);
      print('Autorizado y petición enviada');
    } else
      print('No autorizado');
  }
}
