const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const mysql = require('mysql');
const app = express();

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

// Ruta para servir el formulario HTML
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '../Frontend', 'index.html'));
});

// Ruta para guardar un auto en la base de datos
app.post('/guardar_auto', (req, res) => {
  const { owner, placa, marca, modelo, servicio, precio } = req.body;

  // Query para insertar el auto en la base de datos
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

// Iniciar el servidor en el puerto 3000
app.listen(3000, () => {
  console.log('Servidor en ejecución en http://localhost:3000');
});
