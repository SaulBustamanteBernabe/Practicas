const express = require('express');
const app = express();

const dotenv = require("dotenv");
dotenv.config();

const bcrypt = require("bcrypt");
app.use(express.json());

const {connection} = require("../config.db");

const getUsers = (req, res) => {
    connection.query("SELECT eCodUser, tFullNameUser, eMatricula, tGenero, tCorreoInstitucional, tTelefono, tDireccion, bStateUser FROM Users",
    (error, results) => {
        if (error) throw error;
        if (results.length === 0) {
            return res.status(404).json({ mensaje: "No hay información registrada" });
        }
        res.status(200).json(results);
    });
};

app.route("/users").get(getUsers);

const getUserById = (req, res) => {
    const id = req.params.id;
    connection.query("SELECT eCodUser, tFullNameUser, eMatricula, tGenero, tCorreoInstitucional, tTelefono, tDireccion, bStateUser FROM Users WHERE eCodUser = ?", [id],
    (error, results) => {
        if (error) throw error;
        if (results.length === 0) {
            return res.status(404).json({ mensaje: "Usuario no encontrado" });
        }
        res.status(200).json(results[0]);
    });
}

app.route("/users/:id").get(getUserById);

const postUser = async (req, res) => {
    try {
        const { tFullNameUser, eMatricula, tPassword, tGenero, tCorreoInstitucional, tTelefono, tDireccion } = req.body;
        const saltRounds = 10;
        const hashedPassword = await bcrypt.hash(tPassword, saltRounds);
        
        connection.query("INSERT INTO Users (tFullNameUser, eMatricula, tPassword, tGenero, tCorreoInstitucional, tTelefono, tDireccion) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [tFullNameUser, eMatricula, hashedPassword, tGenero, tCorreoInstitucional, tTelefono, tDireccion],
        (error, results) => {
            if (error) throw error;
            res.status(201).json({ mensaje: "Usuario añadido exitosamente", results: results.affectedRows });
        });
    } catch (error) {
        console.error("Error al insertar usuario: ", error);
        return res.status(400).json({ mensaje: "Error al insertar usuario" });
    }
};

app.route("/users").post(postUser);

const putUser = async (req, res) => {
    try {
        const id = req.params.id;
        const { tFullNameUser, eMatricula, tPassword, tGenero, tCorreoInstitucional, tTelefono, tDireccion } = req.body;
        const saltRounds = 10;
        const hashedPassword = await bcrypt.hash(tPassword, saltRounds);
        
        connection.query("UPDATE Users SET tFullNameUser = ?, eMatricula = ?, tPassword = ?, tGenero = ?, tCorreoInstitucional = ?, tTelefono = ?, tDireccion = ? WHERE eCodUser = ?",
        [tFullNameUser, eMatricula, hashedPassword, tGenero, tCorreoInstitucional, tTelefono, tDireccion, id],
        (error, results) => {
            if (error) throw error;
            if (results.affectedRows === 0) {
                return res.status(404).json({ mensaje: "Usuario no encontrado" });
            }
            res.status(200).json({ mensaje: "Usuario actualizado exitosamente", results: results.affectedRows });
        });
    } catch (error) {
        console.error("Error al actualizar usuario: ", error);
        return res.status(400).json({ mensaje: "Error al actualizar usuario" });
    }
};

app.route("/users/:id").put(putUser);

const deleteUser = (req, res) => {
    const id = req.params.id;
    connection.query("UPDATE Users SET bStateUser = 0 WHERE eCodUser = ?", [id],
    (error, results) => {
        if (error) throw error;
        if (results.affectedRows === 0) {
            return res.status(404).json({ mensaje: "Usuario no encontrado" });
        }
        res.status(200).json({ mensaje: "Usuario eliminado exitosamente", results: results.affectedRows });
    });
};

app.route("/users/:id").delete(deleteUser);

const getAllUsers = (req, res) => {
    connection.query("CALL getAllUsers()",
    (error, results) => {
        if (error) throw error;
        res.status(200).json(results);
    });
}

app.route("/userssp").get(getAllUsers);

const getUserByIdSP = (req, res) => {
    const id = req.params.id;
    connection.query("CALL getUserById(?)", [id],
    (error, results) => {
        if (error) throw error;
        if (results.length === 0) {
            return res.status(404).json({ mensaje: "Usuario no encontrado" });
        }
        res.status(200).json(results[0]);
    });
}

app.route("/userssp/:id").get(getUserByIdSP);

const createUser = async (req, res) => {
    try {
        const { tFullNameUser, eMatricula, tPassword, tGenero, tCorreoInstitucional, tTelefono, tDireccion } = req.body;
        const saltRounds = 10;
        const hashedPassword = await bcrypt.hash(tPassword, saltRounds);
        
        connection.query("CALL createUser(?, ?, ?, ?, ?, ?, ?)",
        [tFullNameUser, eMatricula, hashedPassword, tGenero, tCorreoInstitucional, tTelefono, tDireccion],
        (error, results) => {
            if (error) throw error;
            res.status(201).json({ mensaje: "Usuario añadido exitosamente", results: results.affectedRows });
        });
    } catch (error) {
        console.error("Error al insertar usuario: ", error);
        return res.status(400).json({ mensaje: "Error al insertar usuario" });
    }
};

app.route("/userssp").post(createUser);

module.exports = app;