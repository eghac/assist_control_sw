import 'package:assist_control_all_sw/src/blocs/provider.dart';
import 'package:assist_control_all_sw/src/models/service_model.dart';
import 'package:assist_control_all_sw/src/pages/service_detail_page.dart';
import 'package:flutter/material.dart';

import 'package:location/location.dart';
import 'package:flutter/services.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final mapController = new MapController();

  String typeMap = 'satellite';

  var _currentLocation = LocationData.fromMap(Map());

  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    final servicesBloc = Provider.servicesBloc(context);
    if (_loading) {
      servicesBloc.getServices();
      _loading = false;
    }
    _method();
    return _buildMapWidget(servicesBloc);
  }

  List<Service> services = new List();

  Widget _buildMapWidget(ServicesBloc servicesBloc) {
    return StreamBuilder(
      stream: servicesBloc.servicesStream,
      builder: (BuildContext context, AsyncSnapshot<List<Service>> snapshot) {
        if (snapshot.hasData) {
          // final services = snapshot.data;
          services = snapshot.data;
          final List<LatLng> markersList = new List();
          services.forEach((service) {
            markersList.add(LatLng(service.lat, service.lng));
          });
          return _createFlutterMap(markersList);
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _createFlutterMap(List<LatLng> markersList) {
    return FlutterMap(
      // mapController: mapController,
      // options: MapOptions(center: LatLng(-17.780349, -63.181690), zoom: 15),
      options: MapOptions(center: LatLng(_currentLocation.latitude, _currentLocation.longitude), zoom: 15),
      layers: [
        _buildMap(),
        _buildMarkers2(markersList),
        _buildMarkersUserLocation(),
      ],
      // mapController: mapController
    );
  }

//
  _buildMap() {
    return TileLayerOptions(
        urlTemplate: 'https://api.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1IjoiZWxpb3RkZXYiLCJhIjoiY2p3OXNqcnM1MDA1YjQ5cWt6Mmt0Nmx4ZyJ9.RWzSMHtxfdte7ELcgrOa2Q',
          'id': 'mapbox.satellite'
          // streets, dark, light, outdoors, satellite
        });
  }

  _buildMarkers() {
    return MarkerLayerOptions(markers: [
      Marker(
          width: 100.0,
          height: 100.0,
          // point: LatLng(-17.780349, -63.181690),
          point: LatLng(-17.780349, -63.181690),
          builder: (BuildContext context) => Container(
                child: Icon(Icons.location_on,
                    size: 70.0, color: Theme.of(context).primaryColor),
              )),
    ]);
  }

  _buildMarkersUserLocation() {
    return MarkerLayerOptions(markers: [
      Marker(
          width: 100.0,
          height: 100.0,
          point: LatLng(_currentLocation.latitude, _currentLocation.longitude),
          builder: (BuildContext context) => Container(
                child: Icon(Icons.location_on, size: 70.0, color: Colors.red),
              )),
    ]);
  }

  _buildMarkers2(List<LatLng> markersList) {
    return MarkerLayerOptions(markers: _markers(markersList));
  }

  // final List<LatLng> markerssss = [
  //   LatLng(-17.780349, -63.181690),
  //   LatLng(-17.764968, -63.184164),
  //   LatLng(-17.776285, -63.195081),
  //   LatLng(-17.777279, -63.164685),
  //   LatLng(-17.735185, -63.181023)
  // ];

  List<Marker> _markers(List<LatLng> markerList) {
    final List<Marker> markers = new List();

    for (int i = 0; i < markerList.length; i++) {
      Marker marker = new Marker(
          width: 100.0,
          height: 100.0,
          point: markerList[i],
          builder: (BuildContext context) => Container(
                child: IconButton(
                    icon: Icon(Icons.location_on),
                    iconSize: 70.0,
                    color: Theme.of(context).primaryColor,
                    onPressed: () => Navigator.pushNamed(
                        context, ServiceDetailPage.routeName,
                        arguments: services[i])),
              ));
      markers.add(marker);
    }
    return markers;
  }

  Future<LocationData> _method() async {
    // LocationData currentLocation = LocationData as LocationData;
    var location = new Location();

    String error = '';

    var currentLocation = LocationData.fromMap(Map());

    try {
      currentLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      }
      currentLocation = null;
    }

    if(!mounted) return null;

    setState(() {
      _currentLocation = currentLocation;
    });

    location.onLocationChanged().listen((LocationData currentLocation2) {
      // mapController.move(
      //     LatLng(currentLocation2.latitude, currentLocation2.longitude), 15);
      setState(() {
        _currentLocation = currentLocation2;
      });
      print('latitude maps: ${currentLocation.latitude}');
      print('Longitude maps: ${currentLocation.longitude}');
    });
  }

//
//  _floatingActionButton(BuildContext context) {
//    return FloatingActionButton(
//        child: Icon(Icons.repeat),
//        backgroundColor: Theme.of(context).primaryColor,
//        onPressed: () {
//          if (typeMap == 'streets')
//            typeMap = 'dark';
//          else if (typeMap == 'dark')
//            typeMap = 'light';
//          else if (typeMap == 'light')
//            typeMap = 'outdoors';
//          else if (typeMap == 'outdoors')
//            typeMap = 'satellite';
//          else if (typeMap == 'satellite')
//            typeMap = 'streets';
//          else
//            typeMap = 'streets';
//          setState(() {});
//        });
//  }
}

// class MapSample extends StatefulWidget {
//   @override
//   State<MapSample> createState() => MapSampleState();
// }

// class MapSampleState extends State<MapSample> {
//   Completer<GoogleMapController> _controller = Completer();

//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   static final CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: GoogleMap(
//         mapType: MapType.hybrid,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: Text('To the lake!'),
//         icon: Icon(Icons.directions_boat),
//       ),
//     );
//   }

//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }
