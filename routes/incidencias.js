const express = require('express');
const app = express();

const dotenv = require("dotenv");
dotenv.config();

const bcrypt = require("bcrypt");
app.use(express.json());

const {connection} = require("../config.db");

const countIncidenciasPorTipo = (req, res) => {
    const tipo = req.params.tipo;
    connection.query("CALL countIncidenciasPorTipo(?)", [tipo],
    (error, results) => {
        if (error) throw error;
        res.status(200).json(results[0][0]);
    });
};
app.route("/incidencias/count/:tipo").get(countIncidenciasPorTipo);

const cambiarEstadoIncidencia = async (req, res) => {
    try {
        const id = req.params.id;
        const { Estado } = req.body;
        await connection.query("SET @resultado = 0;");
        connection.query("CALL cambiarEstadoIncidencia(?, ?, @resultado)", [id, Estado],
        async (error, results) => {
            if (error) throw error;
            if (results.affectedRows === 0) {
                return res.status(404).json({ mensaje: "Incidencia no encontrada" });
            }
            const resultado = await connection.query("SELECT @resultado AS resultado;");
            if (resultado.resultado === 0) {
                return res.status(400).json({ mensaje: "Estado inválido" });
            }
            res.status(200).json({ mensaje: "Estado de la incidencia actualizado"});
        });
    } catch (error) {
        console.error("Error al actualizar estado de la incidencia: ", error);
        return res.status(400).json({ mensaje: "Error al actualizar estado de la incidencia" });
    }
};
app.route("/incidencias/estado/:id").put(cambiarEstadoIncidencia);

const obtenerIncidenciasRecientes = (req, res) => {
    const fecha = req.params.fecha;
    connection.query("CALL obtenerIncidenciasRecientes(?)", [fecha],
    (error, results) => {
        if (error) throw error;
        res.status(200).json(results[0]);
    });
};
app.route("/incidencias/recientes/:fecha").get(obtenerIncidenciasRecientes);

const actualizarDescripcionIncidencia = (req, res) => {
    const id = req.params.id;
    const { Contenido } = req.body;
    connection.query("CALL actualizarContenidoIncidencia(?, ?)", [id, Contenido],
    (error, results) => {
        if (error) throw error;
        if (results.affectedRows === 0) {
            return res.status(404).json({ mensaje: "Incidencia no encontrada" });
        }
        res.status(200).json({ mensaje: "Descripción de la incidencia actualizada exitosamente" });
    });
};
app.route("/incidencias/descripcion/:id").put(actualizarDescripcionIncidencia);

const contarIncidenciasSinContenido = (req, res) => {
    connection.query("CALL contarIncidenciasSinContenido()",
    (error, results) => {
        if (error) throw error;
        res.status(200).json(results[0][0]);
    });
};
app.route("/incidencias/sin-contenido").get(contarIncidenciasSinContenido);

const incidenciaContenidoMasLargo = (req, res) => {
    connection.query("CALL incidenciaContenidoMasLargo()",
    (error, results) => {
        if (error) throw error;
        res.status(200).json(results[0][0]);
    });
};
app.route("/incidencias/contenido-mas-largo").get(incidenciaContenidoMasLargo);

const eliminarIncidenciasInactivas = (req, res) => {
    connection.query("CALL eliminarIncidenciasInactivas()",
    (error, results) => {
        if (error) throw error;
        res.status(200).json({ mensaje: "Incidencias inactivas eliminadas exitosamente", eliminadas: results.affectedRows });
    });
};
app.route("/incidencias/eliminar-inactivas").delete(eliminarIncidenciasInactivas);

const marcarIncidenciasAntiguas = (req, res) => {
    const fecha = req.body.fecha;
    connection.query("CALL marcarIncidenciasAntiguas(?)", [fecha],
    (error, results) => {
        if (error) throw error;
        res.status(200).json({ mensaje: "Incidencias antiguas marcadas exitosamente", actualizadas: results.affectedRows });
    });
};
app.route("/incidencias/marcar-antiguas").post(marcarIncidenciasAntiguas);

const getIncidencias = (req, res) => {
    connection.query("CALL getIncidencias()",
    (error, results) => {
        if (error) throw error;
        res.status(200).json(results[0]);
    });
}
app.route("/incidencias").get(getIncidencias);

const buscarIncidenciasPorTexto = (req, res) => {
    const texto = req.params.texto;
    connection.query("CALL buscarIncidenciasPorTexto(?)", [texto],
    (error, results) => {
        if (error) throw error;
        res.status(200).json(results[0]);
    });
};
app.route("/incidencias/buscar/:texto").get(buscarIncidenciasPorTexto);

module.exports = app;