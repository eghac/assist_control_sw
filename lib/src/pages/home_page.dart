import 'package:assist_control_all_sw/src/pages/maps_page.dart';
import 'package:assist_control_all_sw/src/pages/service_page.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  static final String routeName = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;

  final LocalAuthentication _localAuthentication = LocalAuthentication();

  bool _canCheckBiometric = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assist Control App'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.more_vert),
//              onPressed: scansBloc.deleteAllScans)
              onPressed: () {
                print('HOla');
              }),
          PopupMenuButton<ChoiceChip>(
            onSelected: (ChoiceChip choiceChip) {},
            itemBuilder: (BuildContext context) {
              // return choices.skip(2).map((ChoiceChip choice) {
              //   return PopupMenuItem<Choice>(
              //     value: choice,
              //     child: Text(choice.title),
              //   );
              // }).toList();
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
            localizedReason: "Por favor autentica para completar el proceso",
            useErrorDialogs: true,
            stickyAuth: true);
      } else {
        print('No hay autenticación loca: $canCheckBiometric');
      }
    } on PlatformException catch (e) {
      print(e.code);
    }

    if (!mounted) return;

    // setState(() {
    if (isAuthorized) {
      // _authorizedOrNot = "Autorized";
      print('Autorizado');
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

  Widget _buildPage(int currentPage) {
    switch (currentPage) {
      case 0:
        return MapsPage();
      case 1:
        return ServicePage();
      default:
        return MapsPage();
    }
  }
}
