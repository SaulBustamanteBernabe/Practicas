const dotenv = require("dotenv");
dotenv.config();

const mysql = require("mysql");
let connection;

try {
  connection = mysql.createConnection({
    host: process.env.DBHOST,
    user: process.env.DBUSER,
    password: process.env.DBPASS,
    database: process.env.DBNAME,
  });
} catch (error) {
  console.error("Error al conectar a la base de datos: ", error);
}

module.exports = {connection};