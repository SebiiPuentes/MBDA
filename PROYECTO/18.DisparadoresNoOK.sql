---Solo se puede modificar el soat,fechaSoat,tecnomecanica,fechaTecnomecanica
UPDATE VEHICULOS SET color = 'Rojo' WHERE placa = 'ABD123';

------No se puede eliminar a un conductor si tiene viajes asignados.
DELETE FROM CONDUCTORES WHERE idUsuarioConductor = '10000000001';

---No se pueden modificar las calificaciones.

UPDATE CALIFICACIONES SET numeroCalificacion = 1 WHERE idCalificacion ='0429829304';

---No se puede modificar la fecha de registro de los conductores

UPDATE CONDUCTORES SET fechaRegistro = to_date('2026-08-19', 'RRRR-MM-DD') WHERE idUsuarioConductor = '10000000001';

--No se puede modificar la fecha de registro de los Pasajeros.
UPDATE PASAJEROS SET fechaRegistro = to_date('2026-08-19', 'RRRR-MM-DD') WHERE idUsuarioPasajero = '10000003996';
