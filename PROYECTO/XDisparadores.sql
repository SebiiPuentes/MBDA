
--XDisparadores

---Si el metodo de pago no se especifica entonces se asume que es efectivo.
DROP TRIGGER set_metodo_pago_efectivo;

---Si el metodo de notificacion no se especifica se asume que es email.
DROP TRIGGER set_medio_notificacion_email;

---Si se elimina un conductor se elimina sus vehiculos asociados.
DROP TRIGGER eliminar_vehiculos_asociados;

---Si la fecha de la tecnomecanica o el soat es menor a la fecha actual entonces el estado del vehiculo es Inactivo.
DROP TRIGGER verificar_estado_vehiculo;

---Al insertar un horario, la hora de inicio debe ser menor a la hora fin.
DROP TRIGGER verificar_hora_inicio_fin;

---Se inserta una nueva calificación para un conductor, podemos actualizar automáticamente la calificación promedio del conductor.
DROP TRIGGER actualizar_calificacion_promedio;

---Si el estado de un usuario es Inactivo entonces no puede solicitar un viaje.
DROP TRIGGER verificar_estado_usuario;
DROP TRIGGER verificar_estado_usuario2;

---El id del Recorrido es autogenerado.
DROP TRIGGER trg_recorridos_id;

DROP SEQUENCE seq_recorridos_id;

--El id del Punto de Recogida es autogenerado.
DROP TRIGGER trg_puntos_de_recogida_id;

DROP SEQUENCE seq_puntos_de_recogida_id;

--EL id de la ubicacion es autogenerado.
DROP TRIGGER trg_ubicaciones_id;

DROP SEQUENCE seq_ubicaciones_id;

--No se puede eliminar a un conductor si tiene viajes asignados.
DROP TRIGGER trg_no_eliminar_conductor_con_viajes;

----Un pasajero puede solicitar un viaje siempre y cuando la capacidad sea menor al numero de puestos en el vehiculo.
DROP TRIGGER  trg_incrementar_capacidad_viaje;


--El id de horarios es autogenerado
DROP SEQUENCE seq_id_horarios;

DROP TRIGGER trg_auto_id_horarios;

---No se puede modificar la fecha de registro de los pasajeros.
DROP TRIGGER trg_restringir_fecha_registro_pasajeros;

---No se puede modificar la fecha de registro de los conductores
DROP TRIGGER trg_restringir_fecha_registro;

-----No se pueden modificar las calificaciones.
DROP TRIGGER trg_restringir_modificacion_calificaciones;

-----Solo se puede modificar el soat,fechaSoat,tecnomecanica,fechaTecnomecanica
DROP TRIGGER trg_restriccion_actualizacion_vehiculos;
