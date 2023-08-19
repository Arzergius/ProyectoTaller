// // Con este borras y miras

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   List<dynamic> autos = [];

//   Future<void> getAutos() async {
//     final response =
//         await http.get(Uri.parse('http://192.168.100.4:3001/api/autos'));

//     if (response.statusCode == 200) {
//       setState(() {
//         autos = json.decode(response.body);
//       });
//     } else {
//       print('Error al obtener los autos: ${response.statusCode}');
//     }
//   }

//   Future<void> deleteAuto(int index) async {
//     final autoId = autos[index]['id'];
//     final response = await http.delete(
//       Uri.parse('http://192.168.100.4:3001/api/autos/$autoId'),
//     );

//     if (response.statusCode == 200) {
//       setState(() {
//         autos.removeAt(index);
//       });
//     } else {
//       print('Error al borrar el auto: ${response.statusCode}');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getAutos();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Lista de Autos')),
//         body: ListView.builder(
//           itemCount: autos.length,
//           itemBuilder: (context, index) {
//             return Dismissible(
//               key: UniqueKey(),
//               onDismissed: (direction) {
//                 deleteAuto(index);
//               },
//               background: Container(
//                 color: Colors.red,
//                 alignment: Alignment.centerRight,
//                 padding: EdgeInsets.only(right: 16.0),
//                 child: Icon(Icons.delete, color: Colors.white),
//               ),
//               child: ListTile(
//                 title: Text(autos[index]['marca']),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Modelo: ${autos[index]['modelo']}'),
//                     Text('Dueño: ${autos[index]['owner']}'),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:taller/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
