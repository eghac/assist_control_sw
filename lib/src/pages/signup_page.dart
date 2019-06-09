import 'package:flutter/material.dart';

// class SignupPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(
//       children: <Widget>[_buildBackgroud(context), _loginForm(context)],
//     ));
//   }

//   Widget _buildBackgroud(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     final backgroud = Container(
//         height: size.height * 0.4,
//         width: double.infinity,
//         decoration: BoxDecoration(
//             gradient: LinearGradient(colors: <Color>[
//           Color.fromRGBO(63, 63, 156, 1.0),
//           Color.fromRGBO(90, 70, 178, 1.0)
//         ]))
// //      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0 ))),
//         );

//     final circle = Container(
//         width: 100.0,
//         height: 100.0,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(100.0),
//           color: Color.fromRGBO(255, 255, 255, 0.05),
//         ));

//     final circle2 = Container(
//         height: size.height * 0.6,
//         width: double.infinity,
//         decoration: BoxDecoration(
//             borderRadius:
//                 BorderRadius.vertical(bottom: Radius.elliptical(200.0, 160.0)),
//             gradient: LinearGradient(colors: <Color>[
//               Color.fromRGBO(63, 63, 156, 1.0),
//               Color.fromRGBO(90, 70, 178, 1.0)
//             ])));

//     return Stack(
//       children: <Widget>[
//         backgroud,
// //        circle2,
//         Positioned(top: 90.0, left: 30.0, child: circle),
//         Positioned(top: -40.0, right: -30.0, child: circle),
//         Positioned(bottom: -50.0, right: -10.0, child: circle),
//         Positioned(bottom: 120.0, right: 20.0, child: circle),
//         Positioned(bottom: -50.0, left: -20.0, child: circle),
//         Container(
//           padding: EdgeInsets.only(top: 80.0),
//           child: Column(
//             children: <Widget>[
//               Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
//               SizedBox(width: double.infinity, height: 10.0),
//               Text('Assist Control',
//                   style: TextStyle(color: Colors.white, fontSize: 25.0))
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   Widget _loginForm(BuildContext context) {
//     final bloc = Provider.of(context);
//     final size = MediaQuery.of(context).size;

//     return SingleChildScrollView(
//       child: Column(
//         children: <Widget>[
//           SafeArea(child: Container(height: 180.0)),
//           Container(
//             margin: EdgeInsets.symmetric(vertical: 30.0),
//             width: size.width * 0.85,
//             padding: EdgeInsets.symmetric(vertical: 50.0),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5.0),
//                 color: Colors.white,
//                 boxShadow: <BoxShadow>[
//                   BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 3.0,
//                       // offset para que recorra la sombra en uno de sus ejes (x, y)
//                       offset: Offset(0.0, 5.0),
//                       //
//                       spreadRadius: 3.0)
//                 ]),
//             child: Column(
//               children: <Widget>[
//                 Text('Crear cuenta', style: TextStyle(fontSize: 20.0)),
//                 SizedBox(height: 60.0),
//                 _buildEmailInputBox(context, bloc),
//                 SizedBox(height: 30.0),
//                 _buildPasswordInputBox(context, bloc),
//                 SizedBox(height: 30.0),
//                 _buildButton(bloc)
//               ],
//             ),
//           ),
//           FlatButton(
//               onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
//               child: Text('¿Ya tienes una cuenta?')),
//           SizedBox(height: 100.0)
//         ],
//       ),
//     );
//   }

//   Widget _buildEmailInputBox(BuildContext context, LoginBloc bloc) {
//     return StreamBuilder(
//         stream: bloc.emailStream,
//         builder: (BuildContext context, AsyncSnapshot<String> snapShot) =>
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               child: TextField(
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                     icon: Icon(Icons.alternate_email,
//                         color: Theme.of(context).primaryColor),
//                     labelText: "Correo electrónico",
//                     hintText: "ejemplo@correo.com",
//                     counterText: snapShot.data,
//                     errorText: snapShot.error),
// //                onChanged: (value) => bloc.changeEmail(value),
//                 onChanged: bloc.changeEmail,
//               ),
//             ));
  // }
// }
