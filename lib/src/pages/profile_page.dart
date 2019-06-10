import 'package:assist_control_all_sw/src/utils/user_preferences.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static final String routeName = 'profile';

  final _prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi perfil'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Text('Perfil', style: TextStyle(fontSize: 24.0)),
          Divider(),
          _buildFullName(),
          Divider(),
          _buildEmail(),
          Divider(),
          Text('Contrato', style: TextStyle(fontSize: 24.0)),
          Divider(),
          Row(
            children: <Widget>[
              Text('Fecha inicio: ',
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              Text('${_prefs.fechaInicio}', style: TextStyle(fontSize: 16.0)),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Text('Fecha final: ',
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              Text('${_prefs.fechaFin}', style: TextStyle(fontSize: 16.0)),
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Text('Hora de entrada: ',
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              Text('${_prefs.horarioInicio}', style: TextStyle(fontSize: 16.0)),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Text('Hora de salida: ',
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              Text('${_prefs.horarioFin}', style: TextStyle(fontSize: 16.0)),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildFullName() {
    return TextField(
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        // counter: Text('Letras '),
        hintText: '${_prefs.fullName}',
        // labelText: 'Nombre completo',
        // helperText: 'Sólo es nombre',
        suffixIcon: Icon(Icons.accessibility),
        prefixIcon: Icon(Icons.account_circle),
      ),
      onChanged: (textValue) {
        // setState(() {
        //   _name = textValue;
        // });
      },
    );
  }

  Widget _buildEmail() {
    return TextField(
      // Tipo de input email
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: '${_prefs.email}',
        // labelText: 'Email',
        suffixIcon: Icon(Icons.alternate_email),
        prefixIcon: Icon(Icons.email),
      ),
      onChanged: (textValue) {
        // setState(() {
        //   _email = textValue;
        // });
      },
    );
  }
}
