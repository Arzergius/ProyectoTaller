const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const mysql = require('mysql');

const app = express();
const port = 3000;

// Configuración de la conexión a la base de datos
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '12345678',
  database: 'taller_mecanico'
});

// Conexión a la base de datos
connection.connect((err) => {
  if (err) {
    console.error('Error al conectar a la base de datos: ', err);
  } else {
    console.log('Conexión exitosa a la base de datos');
  }
});

// Middleware para parsear el cuerpo de las solicitudes
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());


//FLUTTER

// Ruta para obtener todos los autos
app.get('/api/autos', (req, res) => {
  const query = 'SELECT * FROM autos';
  connection.query(query, (err, results) => {
    if (err) {
      console.error('Error al obtener autos de la base de datos: ', err);
      res.status(500).json({ error: 'Error al obtener autos' });
    } else {
      res.json(results);
    }
  });
});

// Ruta para eliminar un auto por su ID
app.delete('/api/autos/:id', (req, res) => {
  const autoId = req.params.id;
  const query = 'DELETE FROM autos WHERE id = ?';
  connection.query(query, [autoId], (err, result) => {
    if (err) {
      console.error('Error al eliminar el auto de la base de datos: ', err);
      res.status(500).json({ error: 'Error al eliminar el auto' });
    } else {
      res.json({ message: 'Auto eliminado exitosamente' });
    }
  });
});

// Ruta para agregar un nuevo auto
app.post('/api/autos', (req, res) => {
  const { owner, placa, marca, modelo, servicio, precio, fecha, hora, repuestos } = req.body;
  const query = 'INSERT INTO autos (owner, placa, marca, modelo, servicio, precio, fecha, hora, repuestos) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)';
  connection.query(query, [owner, placa, marca, modelo, servicio, precio, fecha, hora, repuestos], (err, result) => {
    if (err) {
      console.error('Error al agregar el auto en la base de datos: ', err);
      res.status(500).json({ error: 'Error al agregar el auto' });
    } else {
      res.json({ message: 'Auto agregado exitosamente' });
    }
  });
});

// Ruta para agregar un nuevo producto al inventario
app.post('/api/inventarios', (req, res) => {
  const { barcode, nombre, tipo, marca, precio, stock, fecha_ingreso, fecha_movimiento } = req.body;
  const query = 'INSERT INTO Inventarios (barcode, nombre, tipo, marca, precio, stock, fecha_ingreso, fecha_movimiento) VALUES (?, ?, ?, ?, ?, ?, ?, ?)';
  connection.query(query, [barcode, nombre, tipo, marca, precio, stock, fecha_ingreso, fecha_movimiento], (err, result) => {
    if (err) {
      console.error('Error al agregar el producto al inventario en la base de datos: ', err);
      res.status(500).json({ error: 'Error al agregar el producto al inventario' });
    } else {
      res.json({ message: 'Producto agregado al inventario exitosamente' });
    }
  });
});

// Ruta para obtener todos los productos del inventario
app.get('/api/inventarios', (req, res) => {
    const query = 'SELECT * FROM Inventarios';
    connection.query(query, (err, results) => {
      if (err) {
        console.error('Error al obtener inventarios de la base de datos: ', err);
        res.status(500).json({ error: 'Error al obtener inventarios' });
      } else {
        res.json(results);
      }
    });
});

  // Ruta para actualizar la cantidad de stock de un producto en el inventario
app.put('/api/inventarios/:id', (req, res) => {
    const productoId = req.params.id;
    const { cantidad } = req.body;
  
    // Aquí deberías implementar la lógica para aumentar o disminuir la cantidad de stock
    // Actualiza la cantidad en la base de datos según tu lógica
  
    const query = 'UPDATE Inventarios SET stock = ? WHERE id = ?';
    connection.query(query, [cantidad, productoId], (err, result) => {
      if (err) {
        console.error('Error al actualizar la cantidad de stock en la base de datos: ', err);
        res.status(500).json({ error: 'Error al actualizar la cantidad de stock' });
      } else {
        res.json({ message: 'Cantidad de stock actualizada exitosamente' });
      }
    });
  });
  






//HTML
// Ruta para servir el formulario HTML

app.use(express.static(path.join(__dirname, '../Frontend')));


app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, '../Frontend', 'index.html'));
});

app.get('/pruebita', (req, res) => {
  res.sendFile(path.join(__dirname, '../Frontend/pruebita', 'tables.html'));
});

app.get('/detalles_auto', (req, res) => {
  res.sendFile(path.join(__dirname, '../Frontend/pruebita', 'detalles_auto.html'));
});

app.get('/lista_inventarios', (req, res) => {
  res.sendFile(path.join(__dirname, '../Frontend/pruebita', 'lista_inventarios.html'));
});

app.get('/registro_auto', (req, res) => {
  res.sendFile(path.join(__dirname, '../Frontend/pruebita', 'registro_auto.html'));
});

app.get('/registro_inventario', (req, res) => {
  res.sendFile(path.join(__dirname, '../Frontend/pruebita', 'registro_inventario.html'));
});

// Ruta para guardar un auto en la base de datos desde el formulario
app.post('/guardar_auto', (req, res) => {
  const { owner, placa, marca, modelo, servicio, precio } = req.body;

  const query = `INSERT INTO autos (owner, placa, marca, modelo, servicio, precio) 
                 VALUES (?, ?, ?, ?, ?, ?)`;

  connection.query(query, [owner, placa, marca, modelo, servicio, precio], (err, result) => {
    if (err) {
      console.error('Error al guardar el auto en la base de datos: ', err);
      res.status(500).send('Error al guardar el auto en la base de datos');
    } else {
      console.log('Auto guardado en la base de datos');
      res.status(201).send('Auto guardado exitosamente');
    }
  });
});

// Iniciar el servidor en el puerto especificado
app.listen(port, () => {
  console.log(`Servidor en ejecución en http://localhost:${port}`);
});
