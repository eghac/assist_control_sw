import 'package:assist_control_all_sw/src/blocs/provider.dart';
import 'package:assist_control_all_sw/src/pages/service_detail_page.dart';
import 'package:assist_control_all_sw/src/providers/services_provider.dart';
import 'package:flutter/material.dart';

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  bool _loading = true;
  @override
  Widget build(BuildContext context) {
    final servicesBloc = Provider.servicesBloc(context);

    if (_loading) {
      servicesBloc.getServices();
      _loading = false;
    }
    // servicesBloc.getServices();

    // final servicesProvider = new ServicesProvider();

    return _buildList(servicesBloc);
    // return _buildList(servicesProvider);
  }

  Widget _buildList(ServicesBloc servicesBloc) {
    return StreamBuilder(
        // future: servicesProvider.getServices(),
        stream: servicesBloc.servicesStream,
        builder: (BuildContext context, AsyncSnapshot<List<Service>> snapshot) {
          if (snapshot.hasData) {
            final services = snapshot.data;
            if (services.length > 0) {
              return ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (context, i) =>
                      _buildItem(context, services[i]));
            } else {
              return Center(child: Text('No hay clientes asignados'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _buildItem(BuildContext context, Service service) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          leading:
              Icon(Icons.assignment_ind, color: Theme.of(context).primaryColor),
          trailing: Icon(Icons.keyboard_arrow_right,
              color: Theme.of(context).primaryColor),
          title: Text('${service.customerName}'),
          subtitle: Text('${service.description}'),
          onTap: () => (service.state == 0)
              ? Navigator.pushNamed(context, ServiceDetailPage.routeName,
                  arguments: service)
              : null,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Text(
                'Estado: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                  padding: EdgeInsets.all(4.0),
                  color: service.state == 0 ? Colors.deepPurple : Colors.green,
                  child: Text(
                    service.state == 0 ? 'Pendiente' : 'Completado',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
