import 'package:assist_control_all_sw/src/blocs/provider.dart';
import 'package:assist_control_all_sw/src/models/service_model.dart';
import 'package:assist_control_all_sw/src/pages/home_page.dart';
import 'package:assist_control_all_sw/src/pages/service_detail_page.dart';
import 'package:flutter/material.dart';

import 'package:location/location.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'dart:async';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart' as gm;

typedef void MarkedCallback(geo.Position position);

class MapsPage extends StatefulWidget {
  final MarkedCallback markedCallback2;

  MapsPage({this.markedCallback2});

  @override
  _MapsPageState createState() =>
      _MapsPageState(markedCallback: markedCallback2);
}

class _MapsPageState extends State<MapsPage> {
  final MarkedCallback markedCallback;

  _MapsPageState({this.markedCallback});

  Completer<gm.GoogleMapController> _controller = Completer();

  final mapController = new MapController();

  String typeMap = 'satellite';

  var _currentLocation = LocationData.fromMap(Map());

  bool _loading = true;

  geo.Position userLocation;

  final _keyParent = GlobalKey<HomePageState>().currentState;

  @override
  void initState() {
    super.initState();

    _getLocation().then((position) {
      userLocation = position;
      print(
          'Current location: ${userLocation.latitude} - ${userLocation.longitude}');

      // if (userLocation != null) {
      //   _distanceBetween(
      //           LatLng(userLocation.latitude, userLocation.longitude),
      //           // LatLng(-17.802445, -63.159036))
      //           // LatLng(-17.803444, -63.157518))
      //           LatLng(-17.739491, -63.174085))
      //       .then((distanceBetween) {
      //     print('Distance between: $distanceBetween');
      //     if (distanceBetween <= _radius) {
      //       print('HAbilitar huella');
      //     } else {
      //       print('Deshabilitar huella');
      //       _keyParent.currentState.updateText(true);
      //     }
      //   });
      // } else {
      //   print('User location is null');
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    final servicesBloc = Provider.servicesBloc(context);
    if (_loading) {
      servicesBloc.getServices();
      _loading = false;
    }

    final markedGlobal = Provider.of(context).markedGlobal;
    print('$markedGlobal');
    // _method();
    _tracking(markedGlobal);
    return _buildMapWidget(servicesBloc);
  }

  List<Service> services = new List();

  Widget _buildMapWidget(ServicesBloc servicesBloc) {
    return StreamBuilder(
      stream: servicesBloc.servicesStream,
      builder: (BuildContext context, AsyncSnapshot<List<Service>> snapshot) {
        if (snapshot.hasData) {
          services = snapshot.data;
          final List<gm.LatLng> markersList = new List();
          services.forEach((service) {
            print(service.customerName);
            markersList.add(gm.LatLng(service.lat, service.lng));
          });
          return _createGoogleMap(context, markersList);
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _createGoogleMap(BuildContext context, List<gm.LatLng> markersList) {
    return new Scaffold(
      body: gm.GoogleMap(
        markers: _getMarkers(context, markersList),
        mapType: gm.MapType.hybrid,
        initialCameraPosition: _initialCamera(),
        onMapCreated: (gm.GoogleMapController controller) {
          if (!mounted) return;
          setState(() {
            _controller.complete(controller);
          });
        },
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
      ),
    );
  }

  List<Marker> allMarkers = [];

  geo.Geolocator geolocator = geo.Geolocator();

  Marker marker;

  final _radius = 100.0;

  geo.Position _positionUser;

  Future<geo.Position> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: geo.LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  _tracking(bool markedGlobal) {
    var locationOptions = geo.LocationOptions(
        accuracy: geo.LocationAccuracy.high, distanceFilter: 50);

    StreamSubscription<geo.Position> positionStream = geolocator
        .getPositionStream(locationOptions)
        .listen((geo.Position position) async {
      print(position == null
          ? 'Unknown tracking: '
          : 'tracking: ' +
              position.latitude.toString() +
              ', ' +
              position.longitude.toString());

      _positionUser = position;

      print('User location: $_positionUser');

      if (_positionUser != null) {
        markedCallback(_positionUser);

        _distanceBetween(
                LatLng(_positionUser.latitude, _positionUser.longitude),
                LatLng(-17.802367, -63.159041))
            .then((distanceBetween) {
          print('Distance between: $distanceBetween');
          if (distanceBetween <= _radius) {
            print('HAbilitar huella');
          } else {
            print('DESHABILITAR huella');
            if(!mounted) return;
            setState(() {
              markedGlobal ?? true;
            });
            // _keyParent.currentState.updateText(true);
          }
        });
      } else {
        print('User location is null');
      }
    });
  }

  Future<double> _distanceBetween(LatLng start, LatLng end) async {
    double distanceInMeters = await geo.Geolocator().distanceBetween(
        start.latitude, start.longitude, end.latitude, end.longitude);
    return distanceInMeters;
  }

  Set<gm.Marker> _getMarkers(
      BuildContext context, List<gm.LatLng> markersLatLng) {
    Set<gm.Marker> markers = Set();

    for (int i = 0; i < markersLatLng.length; i++) {
      gm.Marker marker = gm.Marker(
          icon: gm.BitmapDescriptor.defaultMarker,
          position: markersLatLng[i],
          markerId: gm.MarkerId(markersLatLng[i].toString()),
          draggable: false,
          infoWindow: gm.InfoWindow(
              title: 'Cliente: ${services[i].customerName}',
              snippet: 'Servicio: ${services[i].description}',
              onTap: () {
                Navigator.pushNamed(context, ServiceDetailPage.routeName,
                    arguments: services[i]);
                print('Tap marker: ${services[i].customerName}');
              }));
      print(marker.markerId);
      markers.add(marker);
    }
    return markers;
  }

  gm.CameraPosition _initialCamera() {
    // Future.delayed(Duration(milliseconds: 2000));
    return gm.CameraPosition(
        target: _positionUser != null
            ? gm.LatLng(_positionUser.latitude, _positionUser.longitude)
            : gm.LatLng(-17.783043, -63.182100),
        zoom: 14.4746,
        bearing: 192.8334901395799,
        tilt: 59.440717697143555);
  }
}
