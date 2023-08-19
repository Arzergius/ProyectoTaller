// const express = require('express');
// const bodyParser = require('body-parser');
// const mysql = require('mysql');

// const app = express();
// const port = 3001;

// // Configuración de la conexión a la base de datos
// const connection = mysql.createConnection({
//   host: 'localhost',
//   user: 'root',
//   password: '12345678',
//   database: 'taller_mecanico'
// });

// // Conexión a la base de datos
// connection.connect((err) => {
//   if (err) {
//     console.error('Error al conectar a la base de datos: ', err);
//   } else {
//     console.log('Conexión exitosa a la base de datos');
//   }
// });

// // Middleware para parsear el cuerpo de las solicitudes
// app.use(bodyParser.urlencoded({ extended: true }));
// app.use(bodyParser.json());

// // Ruta para obtener todos los autos
// app.get('/api/autos', (req, res) => {
//   const query = 'SELECT * FROM autos';
//   connection.query(query, (err, results) => {
//     if (err) {
//       console.error('Error al obtener autos de la base de datos: ', err);
//       res.status(500).json({ error: 'Error al obtener autos' });
//     } else {
//       res.json(results);
//     }
//   });
// });
// // Ruta para eliminar un auto por su ID
// app.delete('/api/autos/:id', (req, res) => {
//   const autoId = req.params.id;
//   const query = 'DELETE FROM autos WHERE id = ?';
//   connection.query(query, [autoId], (err, result) => {
//     if (err) {
//       console.error('Error al eliminar el auto de la base de datos: ', err);
//       res.status(500).json({ error: 'Error al eliminar el auto' });
//     } else {
//       res.json({ message: 'Auto eliminado exitosamente' });
//     }
//   });
// });


// // Ruta para agregar un nuevo auto
// app.post('/api/autos', (req, res) => {
//   const { owner, placa, marca, modelo, servicio, precio } = req.body;
//   const query = 'INSERT INTO autos (owner, placa, marca, modelo, servicio, precio) VALUES (?, ?, ?, ?, ?, ?)';
//   connection.query(query, [owner, placa, marca, modelo, servicio, precio], (err, result) => {
//     if (err) {
//       console.error('Error al agregar el auto en la base de datos: ', err);
//       res.status(500).json({ error: 'Error al agregar el auto' });
//     } else {
//       res.json({ message: 'Auto agregado exitosamente' });
//     }
//   });
// });

// // Iniciar el servidor en el puerto especificado
// app.listen(port, () => {
//   console.log(`Servidor en ejecución en http://localhost:${port}`);
// });
const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');

const app = express();
const port = 3001;

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
  const { owner, placa, marca, modelo, servicio, precio, fecha, hora } = req.body; // Agregado fecha y hora
  const query = 'INSERT INTO autos (owner, placa, marca, modelo, servicio, precio, fecha, hora) VALUES (?, ?, ?, ?, ?, ?, ?, ?)'; // Modificado el query
  connection.query(query, [owner, placa, marca, modelo, servicio, precio, fecha, hora], (err, result) => { // Agregado fecha y hora
    if (err) {
      console.error('Error al agregar el auto en la base de datos: ', err);
      res.status(500).json({ error: 'Error al agregar el auto' });
    } else {
      res.json({ message: 'Auto agregado exitosamente' });
    }
  });
});

// Iniciar el servidor en el puerto especificado
app.listen(port, () => {
  console.log(`Servidor en ejecución en http://localhost:${port}`);
});
