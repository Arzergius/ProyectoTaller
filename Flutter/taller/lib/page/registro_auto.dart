// //Este escribe en la DB

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(registro_auto());
// }

// class Auto {
//   final String owner;
//   final String placa;
//   final String marca;
//   final String modelo;
//   final String servicio;
//   final double precio;

//   Auto({
//     required this.owner,
//     required this.placa,
//     required this.marca,
//     required this.modelo,
//     required this.servicio,
//     required this.precio,
//   });
// }

// class registro_auto extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // title: 'Taller Mecánico',
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<Auto> autos = [];
//   String owner = '';
//   String placa = '';
//   String marca = '';
//   String modelo = '';
//   String servicio = '';
//   String precio = '';

//   @override
//   void initState() {
//     super.initState();
//     fetchAutos();
//   }

//   Future<void> fetchAutos() async {
//     final response =
//         await http.get(Uri.parse('http://169.254.171.68:3001/api/autos'));

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = json.decode(response.body);
//       final List<Auto> autoList = jsonData
//           .map((data) => Auto(
//                 owner: data['owner'],
//                 placa: data['placa'],
//                 marca: data['marca'],
//                 modelo: data['modelo'],
//                 servicio: data['servicio'],
//                 precio: double.parse(data['precio']),
//               ))
//           .toList();

//       setState(() {
//         autos = autoList;
//       });
//     } else {
//       throw Exception('Failed to load autos');
//     }
//   }

//   Future<void> addAuto() async {
//     final now = DateTime.now(); // Obtiene la fecha y hora actual
//     final newAuto = {
//       'owner': owner,
//       'placa': placa,
//       'marca': marca,
//       'modelo': modelo,
//       'servicio': servicio,
//       'precio': double.parse(precio),
//       'fecha':
//           '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}', // Formato yy-mm-dd
//       'hora':
//           '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}', // Formato hh:mm:ss
//     };

//     final response = await http.post(
//       Uri.parse('http://169.254.171.68:3001/api/autos'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(newAuto),
//     );

//     if (response.statusCode == 201) {
//       final addedAuto = Auto(
//         owner: owner,
//         placa: placa,
//         marca: marca,
//         modelo: modelo,
//         servicio: servicio,
//         precio: double.parse(precio),
//       );

//       setState(() {
//         autos.add(addedAuto);
//       });
//     } else {
//       throw Exception('Failed to add auto');
//     }
//   }

//   // Future<void> addAuto() async {
//   //   final newAuto = {
//   //     'owner': owner,
//   //     'placa': placa,
//   //     'marca': marca,
//   //     'modelo': modelo,
//   //     'servicio': servicio,
//   //     'precio': double.parse(precio),
//   //   };

//   //   final response = await http.post(
//   //     Uri.parse('http://169.254.139.141:3001/api/autos'),
//   //     headers: <String, String>{
//   //       'Content-Type': 'application/json; charset=UTF-8',
//   //     },
//   //     body: jsonEncode(newAuto),
//   //   );

//   //   if (response.statusCode == 201) {
//   //     final addedAuto = Auto(
//   //       owner: owner,
//   //       placa: placa,
//   //       marca: marca,
//   //       modelo: modelo,
//   //       servicio: servicio,
//   //       precio: double.parse(precio),
//   //     );

//   //     setState(() {
//   //       autos.add(addedAuto);
//   //     });
//   //   } else {
//   //     throw Exception('Failed to add auto');
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(title: Text('Taller Mecánico'),),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: autos.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return ListTile(
//                     title: Text('Dueño: ${autos[index].owner}'),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Placa: ${autos[index].placa}'),
//                         Text('Marca: ${autos[index].marca}'),
//                         Text('Modelo: ${autos[index].modelo}'),
//                         Text('Servicio: ${autos[index].servicio}'),
//                         Text('Precio: ${autos[index].precio}'),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 16.0),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Dueño'),
//               onChanged: (value) {
//                 setState(() {
//                   owner = value;
//                 });
//               },
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Placa'),
//               onChanged: (value) {
//                 setState(() {
//                   placa = value;
//                 });
//               },
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Marca'),
//               onChanged: (value) {
//                 setState(() {
//                   marca = value;
//                 });
//               },
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Modelo'),
//               onChanged: (value) {
//                 setState(() {
//                   modelo = value;
//                 });
//               },
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Servicio'),
//               onChanged: (value) {
//                 setState(() {
//                   servicio = value;
//                 });
//               },
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Precio'),
//               onChanged: (value) {
//                 setState(() {
//                   precio = value;
//                 });
//               },
//               keyboardType: TextInputType.number,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 addAuto();
//               },
//               child: Text('Guardar'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//2DA VERSION

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(registro_auto());
// }

// class Auto {
//   final String owner;
//   final String placa;
//   final String marca;
//   final String modelo;
//   final String servicio;
//   final double precio;

//   Auto({
//     required this.owner,
//     required this.placa,
//     required this.marca,
//     required this.modelo,
//     required this.servicio,
//     required this.precio,
//   });
// }

// class registro_auto extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<Auto> autos = [];
//   String owner = '';
//   String placa = '';
//   String marca = '';
//   String modelo = '';
//   String servicio = '';
//   String precio = '';

//   @override
//   void initState() {
//     super.initState();
//     fetchAutos();
//   }

//   Future<void> fetchAutos() async {
//     final response =
//         await http.get(Uri.parse('http://192.168.100.75:3000/api/autos'));

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = json.decode(response.body);
//       final List<Auto> autoList = jsonData
//           .map((data) => Auto(
//                 owner: data['owner'],
//                 placa: data['placa'],
//                 marca: data['marca'],
//                 modelo: data['modelo'],
//                 servicio: data['servicio'],
//                 precio: double.parse(data['precio']),
//               ))
//           .toList();

//       setState(() {
//         autos = autoList;
//       });
//     } else {
//       throw Exception('Failed to load autos');
//     }
//   }

//   Future<void> addAuto() async {
//     final now = DateTime.now(); // Obtiene la fecha y hora actual
//     final newAuto = {
//       'owner': owner,
//       'placa': placa,
//       'marca': marca,
//       'modelo': modelo,
//       'servicio': servicio,
//       'precio': double.parse(precio),
//       'fecha':
//           '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}', // Formato yy-mm-dd
//       'hora':
//           '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}', // Formato hh:mm:ss
//     };

//     final response = await http.post(
//       Uri.parse('http://192.168.100.75:3000/api/autos'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(newAuto),
//     );

//     if (response.statusCode == 201) {
//       final addedAuto = Auto(
//         owner: owner,
//         placa: placa,
//         marca: marca,
//         modelo: modelo,
//         servicio: servicio,
//         precio: double.parse(precio),
//       );

//       setState(() {
//         autos.add(addedAuto);
//       });
//     } else {
//       throw Exception('Failed to add auto');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () {
//           // Cierra el teclado cuando se toca cualquier parte de la pantalla
//           FocusScope.of(context).unfocus();
//         },
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: ListView.builder(
//             itemCount: autos.length + 1, // +1 para agregar el formulario
//             itemBuilder: (BuildContext context, int index) {
//               if (index == autos.length) {
//                 // Último elemento: formulario para agregar auto
//                 return Column(
//                   children: [
//                     TextFormField(
//                       decoration: InputDecoration(labelText: 'Dueño'),
//                       onChanged: (value) {
//                         setState(() {
//                           owner = value;
//                         });
//                       },
//                     ),
//                     TextFormField(
//                       decoration: InputDecoration(labelText: 'Placa'),
//                       onChanged: (value) {
//                         setState(() {
//                           placa = value;
//                         });
//                       },
//                     ),
//                     TextFormField(
//                       decoration: InputDecoration(labelText: 'Marca'),
//                       onChanged: (value) {
//                         setState(() {
//                           marca = value;
//                         });
//                       },
//                     ),
//                     TextFormField(
//                       decoration: InputDecoration(labelText: 'Modelo'),
//                       onChanged: (value) {
//                         setState(() {
//                           modelo = value;
//                         });
//                       },
//                     ),
//                     TextFormField(
//                       decoration: InputDecoration(labelText: 'Servicio'),
//                       onChanged: (value) {
//                         setState(() {
//                           servicio = value;
//                         });
//                       },
//                     ),
//                     TextFormField(
//                       decoration: InputDecoration(labelText: 'Precio'),
//                       onChanged: (value) {
//                         setState(() {
//                           precio = value;
//                         });
//                       },
//                       keyboardType: TextInputType.number,
//                     ),
//                     Card(
//                       color: Colors.white,
//                       child: Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: TextField(
//                           maxLines: 8,
//                           decoration:
//                               InputDecoration(labelText: 'Repuestos usados'),
//                           // ... otras propiedades del TextField ...
//                         ),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         addAuto();
//                       },
//                       child: Text('Guardar'),
//                     ),
//                   ],
//                 );
//               } else {
//                 // Elemento existente en la lista de autos
//                 return ListTile(
//                   title: Text('Dueño: ${autos[index].owner}'),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // ... otros Text widgets ...
//                     ],
//                   ),
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

//osdkmclsdkm
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(registro_auto());
}

class Auto {
  final String owner;
  final String placa;
  final String marca;
  final String modelo;
  final String servicio;
  final double precio;
  final String repuestos;

  Auto({
    required this.owner,
    required this.placa,
    required this.marca,
    required this.modelo,
    required this.servicio,
    required this.precio,
    required this.repuestos,
  });
}

class registro_auto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Auto> autos = [];
  String owner = '';
  String placa = '';
  String marca = '';
  String modelo = '';
  String servicio = '';
  String precio = '';
  String repuestos = '';

  @override
  void initState() {
    super.initState();
    fetchAutos();
  }

  Future<void> fetchAutos() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.43:3000/api/autos'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<Auto> autoList = jsonData
          .map((data) => Auto(
                owner: data['owner'],
                placa: data['placa'],
                marca: data['marca'],
                modelo: data['modelo'],
                servicio: data['servicio'],
                precio: double.parse(data['precio']),
                repuestos: data['repuestos'], // Agregar el campo de repuestos
              ))
          .toList();

      setState(() {
        autos = autoList;
      });
    } else {
      throw Exception('Failed to load autos');
    }
  }

  Future<void> addAuto() async {
    final now = DateTime.now();
    final newAuto = {
      'owner': owner,
      'placa': placa,
      'marca': marca,
      'modelo': modelo,
      'servicio': servicio,
      'precio': double.parse(precio),
      'repuestos': repuestos,
      'fecha':
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}',
      'hora':
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}',
    };

    final response = await http.post(
      Uri.parse('http://192.168.1.43:3000/api/autos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(newAuto),
    );

    if (response.statusCode == 201) {
      final addedAuto = Auto(
        owner: owner,
        placa: placa,
        marca: marca,
        modelo: modelo,
        servicio: servicio,
        precio: double.parse(precio),
        repuestos: repuestos,
      );

      setState(() {
        autos.add(addedAuto);
      });
    } else {
      throw Exception('Failed to add auto');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: autos.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == autos.length) {
                return Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Dueño'),
                      onChanged: (value) {
                        setState(() {
                          owner = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Placa'),
                      onChanged: (value) {
                        setState(() {
                          placa = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Marca'),
                      onChanged: (value) {
                        setState(() {
                          marca = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Modelo'),
                      onChanged: (value) {
                        setState(() {
                          modelo = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Servicio'),
                      onChanged: (value) {
                        setState(() {
                          servicio = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Precio'),
                      onChanged: (value) {
                        setState(() {
                          precio = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                    Card(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          maxLines: 8,
                          onChanged: (value) {
                            setState(() {
                              repuestos = value;
                            });
                          },
                          decoration:
                              InputDecoration(labelText: 'Repuestos usados'),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addAuto();
                      },
                      child: Text('Guardar'),
                    ),
                  ],
                );
              } else {
                return ListTile(
                  title: Text('Dueño: ${autos[index].owner}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Placa: ${autos[index].placa}'),
                      Text('Marca: ${autos[index].marca}'),
                      Text('Modelo: ${autos[index].modelo}'),
                      Text('Servicio: ${autos[index].servicio}'),
                      Text('Precio: ${autos[index].precio}'),
                      Text(
                          'Repuestos usados: ${autos[index].repuestos}'), // Agregar repuestos
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
