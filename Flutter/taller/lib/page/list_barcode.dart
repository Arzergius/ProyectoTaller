import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(list_barcode());
}

class Inventario {
  final String barcode;
  final String nombre;
  final String tipo;
  final String marca;
  final double precio;
  final int stock;

  Inventario({
    required this.barcode,
    required this.nombre,
    required this.tipo,
    required this.marca,
    required this.precio,
    required this.stock,
  });
}

class list_barcode extends StatelessWidget {
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
  List<Inventario> inventarios = [];
  String barcode = '';
  String nombre = '';
  String tipo = '';
  String marca = '';
  String precio = '';
  String stock = '';

  @override
  void initState() {
    super.initState();
    fetchInventarios();
  }

  Future<void> fetchInventarios() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.43:3000/api/inventarios'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<Inventario> inventarioList = jsonData
          .map((data) => Inventario(
                barcode: data['barcode'],
                nombre: data['nombre'],
                tipo: data['tipo'],
                marca: data['marca'],
                precio: double.parse(data['precio']),
                stock: int.parse(data['stock']),
              ))
          .toList();

      setState(() {
        inventarios = inventarioList;
      });
    } else {
      throw Exception('Failed to load inventarios');
    }
  }

  Future<void> addInventario() async {
    final now = DateTime.now();
    final newInventario = {
      'barcode': barcode,
      'nombre': nombre,
      'tipo': tipo,
      'marca': marca,
      'precio': double.parse(precio),
      'stock': int.parse(stock),
      'fecha_ingreso':
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}',
      'fecha_movimiento':
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}',
    };

    final response = await http.post(
      Uri.parse('http://192.168.1.43:3000/api/inventarios'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(newInventario),
    );

    if (response.statusCode == 201) {
      final addedInventario = Inventario(
        barcode: barcode,
        nombre: nombre,
        tipo: tipo,
        marca: marca,
        precio: double.parse(precio),
        stock: int.parse(stock),
      );

      setState(() {
        inventarios.add(addedInventario);
      });
    } else {
      throw Exception('Failed to add inventario');
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
            itemCount: inventarios.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == inventarios.length) {
                return Column(
                  children: [
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Código de Barras'),
                      onChanged: (value) {
                        setState(() {
                          barcode = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Nombre'),
                      onChanged: (value) {
                        setState(() {
                          nombre = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Tipo'),
                      onChanged: (value) {
                        setState(() {
                          tipo = value;
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
                      decoration: InputDecoration(labelText: 'Precio'),
                      onChanged: (value) {
                        setState(() {
                          precio = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Stock'),
                      onChanged: (value) {
                        setState(() {
                          stock = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addInventario();
                      },
                      child: Text('Guardar'),
                    ),
                  ],
                );
              } else {
                return ListTile(
                  title:
                      Text('Código de Barras: ${inventarios[index].barcode}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nombre: ${inventarios[index].nombre}'),
                      Text('Tipo: ${inventarios[index].tipo}'),
                      Text('Marca: ${inventarios[index].marca}'),
                      Text('Precio: ${inventarios[index].precio}'),
                      Text('Stock: ${inventarios[index].stock}'),
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
