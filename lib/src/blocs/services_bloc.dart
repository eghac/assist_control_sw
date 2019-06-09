import 'dart:convert';
import 'dart:io';

import 'package:assist_control_all_sw/src/providers/services_provider.dart';
import 'package:assist_control_all_sw/src/utils/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:assist_control_all_sw/src/models/service_model.dart';
import 'package:http_parser/http_parser.dart';
export 'package:assist_control_all_sw/src/models/service_model.dart';
import 'package:mime_type/mime_type.dart';
import 'package:rxdart/rxdart.dart';

class ServicesBloc {
  final _servicesController = new BehaviorSubject<List<Service>>();
  final _loadingController = new BehaviorSubject<bool>();

  final _servicesProvider = new ServicesProvider();

  Stream<List<Service>> get servicesStream => _servicesController.stream;
  Stream<bool> get loading => _loadingController.stream;

  dispose() {
    _servicesController?.close();
    _loadingController?.close();
  }

  void getServices() async {
    final services = await _servicesProvider.getServices();
    _servicesController.sink.add(services);
  }

//
//  final _scansController = StreamController<List<ScanModel>>.broadcast();
//
//  Stream<List<ScanModel>> get scansStream =>
//      _scansController.stream.transform(validateGeo);
//
//  Stream<List<ScanModel>> get scansStreamHttp =>
//      _scansController.stream.transform(validateHttp);
//
//  // Para cerrar el controller
//  dispose() {
//    _scansController?.close();
//  }
//
//  getScans() async => _scansController.sink.add(await DBProvider.db.getScans());
//
//  addScan(ScanModel newScan) async {
//    await DBProvider.db.createScan(newScan);
//    getScans();
//  }
//
//  deleteScans(int id) async {
//    await DBProvider.db.deleteScan(id);
//    getScans();
//  }
//
//  deleteAllScans() async {
//    await DBProvider.db.deleteScanAll();
////    _scansController.sink.add([]);
//    getScans();
//  }
}
