import 'package:assist_control_all_sw/src/models/service_model.dart';
import 'package:flutter/material.dart';

class ServiceDetailPage extends StatelessWidget {
  static final String routeName = 'service_detail';

  @override
  Widget build(BuildContext context) {
    final Service service = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de la asignación'),
      ),
      body: Container(
        child: Center(
          child: Text(service.customerName),
        ),
      ),
    );
  }
}
