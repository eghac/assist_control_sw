import 'package:assist_control_all_sw/src/blocs/provider.dart';
import 'package:assist_control_all_sw/src/models/marked_model.dart';
import 'package:assist_control_all_sw/src/pages/maps_page.dart';
import 'package:assist_control_all_sw/src/pages/profile_page.dart';
import 'package:assist_control_all_sw/src/pages/service_page.dart';
import 'package:assist_control_all_sw/src/pages/signin_page.dart';
import 'package:assist_control_all_sw/src/pages/signup_page.dart';
import 'package:assist_control_all_sw/src/providers/marked_provider.dart';
import 'package:assist_control_all_sw/src/providers/profile_provider.dart';
import 'package:assist_control_all_sw/src/providers/user_provider.dart';
import 'package:assist_control_all_sw/src/utils/constants.dart';
import 'package:assist_control_all_sw/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gm;
import 'package:geolocator/geolocator.dart' as geo;

class HomePage extends StatefulWidget {
  static final String routeName = 'home';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentPage = 0;

  final LocalAuthentication _localAuthentication = LocalAuthentication();

  bool _canCheckBiometric = false;

  GlobalKey<HomePageState> _keyParent = GlobalKey();

  final markedProvider = new MarkedProvider();

  final userProvider = new UserProvider();

  final profileProvider = new ProfileProvider();

  @override
  Widget build(BuildContext context) {
    final markedGlobal = Provider.of(context).markedGlobal;

    return Scaffold(
      key: _keyParent,
      appBar: AppBar(
        title: Text('Assist Control App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => _handleProfile(context),
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: _buildPage(_currentPage),
      bottomNavigationBar: _bottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _floatingActionButton(),
    );
  }

  void _handleProfile(BuildContext context) async {
    final res = await profileProvider.getProfileAndContract();
    if (res['status_code'] == 200) {
      Navigator.pushNamed(context, ProfilePage.routeName);
      // showControlDialog333(context, 'HOla');
    } else {
      print('_handleProfile Error');
    }
  }

  void _choiceAction(String choice) {
    if (choice == menu[0]) {
      print('0');
    } else if (choice == menu[1]) {
      // _logout(context);
      print('1');
    }
  }

  _logout(BuildContext context) async {
    await userProvider.logout();
    print('logout');
    Navigator.pushReplacementNamed(context, LoginPage.routeName);
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
        backgroundColor: Colors.black,
        // onPressed: _fingerPrint,
        onPressed: () => showControlDialog333(context, 'HOla'),
        child: Icon(
          Icons.fingerprint,
          size: 40.0,
          color: Colors.white,
        ));
  }

  Future<void> fingerPrint(int markedType) async {
    bool canCheckBiometric = false;

    bool isAuthorized = false;
    try {
      canCheckBiometric = await _localAuthentication.canCheckBiometrics;

      if (canCheckBiometric) {
        isAuthorized = await _localAuthentication.authenticateWithBiometrics(
            localizedReason:
                "Por favor autentica para completar el proceso de marcado",
            useErrorDialogs: true,
            stickyAuth: true);
      } else
        print('No hay autenticación: $canCheckBiometric');
    } on PlatformException catch (e) {
      print(e.code);
    }

    if (!mounted) return;

    // setState(() {
    if (isAuthorized) {
      // _authorizedOrNot = "Autorized";
      print('Autorizado');
      final datetime = DateTime.now();
      final d = datetime.toString().split(' ');
      final time = d[1];
      final date = d[0];

      await markedProvider
          .createMarked(MarkedModel(fecha: date, hora: time, tipo: markedType),
              _position?.latitude, _position?.longitude)
          .then((b) {
        if (b) {
          _showDialog(context);
        }
      });
      print('Autorizado y petición enviada');
    } else {
      // _authorizedOrNot = "Not Autorized";
      print('No autorizado');
    }
    // });
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Mapa')),
          BottomNavigationBarItem(
              icon: Icon(Icons.brightness_5), title: Text('Direcciones')),
        ],
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        currentIndex: _currentPage);
  }

  geo.Position _position;

  Widget _buildPage(int currentPage) {
    switch (currentPage) {
      case 0:
        return MapsPage(markedCallback2: (geo.Position position) {
          setState(() {
            _position = position;
          });
        });
      case 1:
        return ServicePage();
      default:
        return MapsPage();
    }
  }

  bool value;
  void updateText(bool text) {
    setState(() {
      value = text;
      print('HOME PAGE: $value');
    });
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('TITLE'),
            content: Text('CONTENT'),
            actions: <Widget>[
              new FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void showControlDialog333(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Marcar asistencia'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        textColor: Colors.white,
                        color: Colors.deepPurple,
                        child: Text('Marcar entrada'),
                        onPressed: () => fingerPrint(0),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        textColor: Colors.white,
                        color: Colors.deepPurple,
                        child: Text('Marcar salida'),
                        onPressed: () => fingerPrint(1),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // actions: <Widget>[
            //   FlatButton(
            //       onPressed: () => Navigator.of(context).pop(), child: Text('ok'))
            // ],
          );
        });
  }
}
