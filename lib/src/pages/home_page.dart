import 'package:assist_control_all_sw/src/blocs/provider.dart';
import 'package:assist_control_all_sw/src/models/marked_model.dart';
import 'package:assist_control_all_sw/src/pages/maps_page.dart';
import 'package:assist_control_all_sw/src/pages/service_page.dart';
import 'package:assist_control_all_sw/src/providers/marked_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    final markedGlobal = Provider.of(context).markedGlobal;

    return Scaffold(
      key: _keyParent,
      appBar: AppBar(
        title: Text('Assist Control App'),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                    child: GestureDetector(
                  child: Text('Mi perfil'),
                  onTap: () {
                    print('Mostrar mi perfil');
                  },
                )),
              ];
            },
          ),
        ],
      ),
      body: _buildPage(_currentPage),
      bottomNavigationBar: _bottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: _fingerPrint,
        child: Icon(
          Icons.fingerprint,
          size: 40.0,
          color: Colors.white,
        ));
  }

  Future<void> _fingerPrint() async {
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
          .createMarked(MarkedModel(fecha: date, hora: time, tipo: 1),
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
          print('MapsPage');
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
}
