import 'package:assist_control_all_sw/src/blocs/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';

void showAlert(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('¡Alerta!'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('ok'))
          ],
        );
      });
}

void showErrorAlert(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('¡Alerta!'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('ok'))
          ],
        );
      });
}

Future<String> encryptFingerprint(LoginBloc bloc) async {
  final cryptor = new PlatformStringCryptor();
  print(
      '***************************** Utils - encryptFingerprint ***************************');
  final String salt = await cryptor.generateSalt();
  print('salta: $salt');
  final String key = await cryptor.generateKeyFromPassword(bloc.password, salt);
  final String encrypted =
      await cryptor.encrypt('${bloc.email}-${bloc.password}', key);
  print('encrypted: $encrypted');
  return encrypted;
}

// void showControlDialog333(BuildContext context, String message) {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
          
//           title: Text('Marcar asistencia'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     FlatButton(
//                       textColor: Colors.white,
//                       color: Colors.deepPurple,
//                       child: Text('Marcar entrada'),
//                       onPressed: () {_markedEntry},
//                     ),
//                   ],
//                 ),
//                 Row(                
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     FlatButton(                    
//                       padding: EdgeInsets.symmetric(horizontal: 16.0),
//                       textColor: Colors.white,
//                       color: Colors.deepPurple,
//                       child: Text('Marcar salida'),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           // actions: <Widget>[
//           //   FlatButton(
//           //       onPressed: () => Navigator.of(context).pop(), child: Text('ok'))
//           // ],
//         );
//       });
// }
