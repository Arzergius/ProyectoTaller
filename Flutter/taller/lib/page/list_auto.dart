// //Este lista de la BD
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(list_auto());
// }

// class list_auto extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<list_auto> {
//   List<dynamic> autos = [];

//   Future<void> getAutos() async {
//     final response =
//         await http.get(Uri.parse('http://192.168.100.75:3000/api/autos'));

//     if (response.statusCode == 200) {
//       setState(() {
//         autos = json.decode(response.body);
//       });
//     } else {
//       print('Error al obtener los autos: ${response.statusCode}');
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
//         //appBar: AppBar(title: Text('Lista de Autos')),
//         body: ListView.builder(
//           itemCount: autos.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(autos[index]['marca']),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Modelo: ${autos[index]['modelo']}'),
//                   Text('Dueño: ${autos[index]['owner']}'), // Agregar esta línea
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

//192.168.100.75:3000

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(list_auto());
}

class list_auto extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<list_auto> {
  List<dynamic> autos = [];

  Future<void> getAutos() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.43:3000/api/autos'));

    if (response.statusCode == 200) {
      setState(() {
        autos = json.decode(response.body);
      });
    } else {
      print('Error al obtener los autos: ${response.statusCode}');
    }
  }

  Future<void> deleteAuto(int index) async {
    final autoId = autos[index]['id'];

    // Mostrar cuadro de diálogo de confirmación
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar eliminación'),
          content: Text('¿Estás seguro de que quieres eliminar este auto?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      final response = await http.delete(
        Uri.parse('http://192.168.1.43:3000/api/autos/$autoId'),
      );

      if (response.statusCode == 200) {
        setState(() {
          autos.removeAt(index);
        });
      } else {
        print('Error al borrar el auto: ${response.statusCode}');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getAutos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //appBar: AppBar(title: Text('Lista de Autos')),
        body: ListView.builder(
          itemCount: autos.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                deleteAuto(index);
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              child: ListTile(
                title: Text(autos[index]['marca']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Modelo: ${autos[index]['modelo']}'),
                    Text('Dueño: ${autos[index]['owner']}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
