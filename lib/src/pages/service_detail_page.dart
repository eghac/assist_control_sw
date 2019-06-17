import 'dart:async';

import 'package:assist_control_all_sw/src/models/marked_model.dart';
import 'package:assist_control_all_sw/src/models/service_model.dart';
import 'package:assist_control_all_sw/src/providers/marked_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class ServiceDetailPage extends StatefulWidget {
  static final String routeName = 'service_detail';

  @override
  _ServiceDetailPageState createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  final markedProvider = new MarkedProvider();

  Position userLocation;

  Position _position;

  final LocalAuthentication _localAuthentication = LocalAuthentication();

  final _radius = 100.0;

  bool _inicioServicio = false;
  bool _finalServicio = false;
  bool _servicioTerminado = false;

  @override
  void initState() {
    super.initState();

    _getLocation().then((position) {
      userLocation = position;
      print(
          'Current location: DETALLE SER ${userLocation.latitude} - ${userLocation.longitude}');
    });
  }

  Future<Position> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  @override
  Widget build(BuildContext context) {
    final Service service = ModalRoute.of(context).settings.arguments;

    _tracking(true, service);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del servicio'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            _showMap(service),
            Divider(),
            _showDetail(context, service)
          ],
        ),
      ),
    );
  }

  _showMap(Service service) {
    return _createGoogleMap(context, service);
  }

  Completer<GoogleMapController> _controller = Completer();

  Widget _createGoogleMap(BuildContext context, Service service) {
    return new Container(
      height: MediaQuery.of(context).size.height / 1.5,
      width: double.infinity,
      child: GoogleMap(
        markers: _getMarkers(context, service),
        mapType: MapType.hybrid,
        initialCameraPosition: _initialCamera(service),
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            _controller.complete(controller);
          });
        },
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
      ),
    );
  }

  Set<Marker> _getMarkers(BuildContext context, Service service) {
    Set<Marker> markers = Set();
    Marker marker = Marker(
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(service.lat, service.lng),
        markerId: MarkerId(service.toString()),
        draggable: false,
        infoWindow: InfoWindow(
            title: 'Cliente: ${service.customerName}',
            snippet: 'Servicio: ${service.description}',
            onTap: () {}));
    markers.add(marker);
    return markers;
  }

  _showDetail(BuildContext context, Service service) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Detalle',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Text(
                'Cliente: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${service.customerName}')
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Text(
                'Descripción: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${service.description}')
            ],
          ),
          SizedBox(height: 16.0),
          Center(
            child: Row(
              children: <Widget>[
                RaisedButton(
                    textColor: Colors.white,
                    color: !_inicioServicio && !_servicioTerminado
                        ? Theme.of(context).primaryColor
                        : (_servicioTerminado) ? Colors.transparent : null,
                    child: Text('Iniciar servicio'),
                    onPressed: () {
                      if (!_inicioServicio && !_servicioTerminado) {
                        return fingerPrint(context, 2, service);
                      } else if (_servicioTerminado) return null;
                    }),
                SizedBox(
                  width: 16.0,
                ),
                RaisedButton(
                  textColor: Colors.white,
                  color: _inicioServicio
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  child: Text('Terminar servicio'),
                  onPressed: () =>
                      _inicioServicio ? fingerPrint(context, 3, service) : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fingerPrint(
      BuildContext context, markedType, Service service) async {
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

    if (isAuthorized) {
      print('Autorizado');
      final datetime = DateTime.now();
      final d = datetime.toString().split(' ');
      final time = d[1];
      final date = d[0];

      print(userLocation);

      await markedProvider
          .createMarked(MarkedModel(fecha: date, hora: time, tipo: markedType),
              userLocation.latitude, userLocation?.longitude, service.id)
          .then((b) {
        if (b) {
          setState(() {
            if (markedType == 3) {
              _finalServicio = true;
              _inicioServicio = false;
              _servicioTerminado = true;
            } else if (markedType == 2) {
              _inicioServicio = true;
            }
          });

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

  Position _positionUser;

  Geolocator geolocator = Geolocator();

  _tracking(bool markedGlobal, Service service) {
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 50);

    StreamSubscription<Position> positionStream = geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) async {
      print(position == null
          ? 'Unknown tracking: '
          : 'tracking:DETALLE SER  ' +
              position.latitude.toString() +
              ', ' +
              position.longitude.toString());

      _positionUser = position;

      print('User location:DETALLE SER $_positionUser');

      if (_positionUser != null) {
        _position = _positionUser;
        print('Distancia********************');
        print('$_position');

        _distanceBetween(
                LatLng(_positionUser.latitude, _positionUser.longitude),
                LatLng(service.lat, service.lng))
            .then((distanceBetween) {
          print('Distance between: DETALLE SER $distanceBetween');
          if (distanceBetween <= _radius) {
            print('HAbilitar huella DETALLE SER');
          } else {
            print('DESHABILITAR huella DETALLE SER');
            // setState(() {
            //   markedGlobal ?? true;
            // });
            // _keyParent.currentState.updateText(true);
          }
        });
      } else {
        print('User location is null DETALLE SER');
      }
    });
  }

  Future<double> _distanceBetween(LatLng start, LatLng end) async {
    double distanceInMeters = await Geolocator().distanceBetween(
        start.latitude, start.longitude, end.latitude, end.longitude);
    return distanceInMeters;
  }

  CameraPosition _initialCamera(Service service) {
    // Future.delayed(Duration(milliseconds: 2000));
    return CameraPosition(
        target: LatLng(service.lat, service.lng),
        // target: _positionUser != null
        //     ? LatLng(_positionUser.latitude, _positionUser.longitude)
        //     : LatLng(-17.783043, -63.182100),
        zoom: 14.4746,
        bearing: 192.8334901395799,
        tilt: 59.440717697143555);
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registro de marcado'),
            content: Text('Marcado registrado exitosamente.'),
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
