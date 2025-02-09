---No se puede modificar la fecha de registro de los pasajeros.
CREATE OR REPLACE TRIGGER trg_restringir_fecha_registro_pasajeros
BEFORE UPDATE OF fechaRegistro ON Pasajeros
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(
        -20004,
        'No está permitido modificar la fecha de registro de los pasajeros.'
    );
END;
/


---No se puede modificar la fecha de registro de los conductores
CREATE OR REPLACE TRIGGER trg_restringir_fecha_registro
BEFORE UPDATE OF fechaRegistro ON Conductores
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(
        -20003,
        'No está permitido modificar la fecha de registro de los conductores.'
    );
END;
/


---No se pueden modificar las calificaciones.
CREATE OR REPLACE TRIGGER trg_restringir_modificacion_calificaciones
BEFORE UPDATE ON Calificaciones
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(
        -20002, 
        'No está permitido modificar las calificaciones.'
    );
END;
/

--Solo se puede modificar el soat,fechaSoat,tecnomecanica,fechaTecnomecanica
CREATE OR REPLACE TRIGGER trg_restriccion_actualizacion_vehiculos
BEFORE UPDATE ON Vehiculos
FOR EACH ROW
BEGIN
    IF :NEW.modelo != :OLD.modelo OR
       :NEW.marca != :OLD.marca OR
       :NEW.color != :OLD.color OR
       :NEW.estado != :OLD.estado OR
       :NEW.numeroPuestos != :OLD.numeroPuestos OR
       :NEW.idConductor != :OLD.idConductor THEN
        RAISE_APPLICATION_ERROR(
            -20011, 
            'Solo se permite modificar las columnas soat, fechaSoat, tecnomecanica y fechaTecnomecanica.'
        );
    END IF;
END;
/



---Si el metodo de pago no se especifica entonces se asume que es efectivo.
CREATE OR REPLACE TRIGGER set_metodo_pago_efectivo
BEFORE INSERT ON Pagos
FOR EACH ROW
BEGIN
    IF :NEW.metodoPago IS NULL OR :NEW.metodoPago = '' THEN
        :NEW.metodoPago := 'Efectivo';
    END IF;
END;
/

---Si el metodo de notificacion no se especifica se asume que es email.
CREATE OR REPLACE TRIGGER set_medio_notificacion_email
BEFORE INSERT ON Notificaciones
FOR EACH ROW
BEGIN
    IF :NEW.medioNotificacion IS NULL OR :NEW.medioNotificacion = '' THEN
        :NEW.medioNotificacion := 'Email';
    END IF;
END;
/

---Si se elimina un conductor se elimina sus vehiculos asociados.
CREATE OR REPLACE TRIGGER eliminar_vehiculos_asociados
AFTER DELETE ON Conductores
FOR EACH ROW
BEGIN
    DELETE FROM Vehiculos
    WHERE idConductor = :OLD.idUsuarioConductor;
END;
/

---Si la fecha de la tecnomecanica o el soat es menor a la fecha actual entonces el estado del vehiculo es Inactivo.
CREATE OR REPLACE TRIGGER verificar_estado_vehiculo
BEFORE INSERT ON Vehiculos
FOR EACH ROW
BEGIN
    IF (:NEW.fechaSoat < SYSDATE OR :NEW.fechaTecnomecanica < SYSDATE) THEN
        :NEW.estado := 'Inactivo';
    END IF;
END;
/

---Al insertar un horario, la hora de inicio debe ser menor a la hora fin.
CREATE OR REPLACE TRIGGER verificar_hora_inicio_fin
BEFORE INSERT ON Horarios
FOR EACH ROW
BEGIN
    IF TO_TIMESTAMP(:NEW.horarioSalida, 'HH24:MI') >= TO_TIMESTAMP(:NEW.horarioLlegada, 'HH24:MI') THEN
        RAISE_APPLICATION_ERROR(-20001, 'La hora de inicio debe ser menor que la hora de fin.');
    END IF;
END;
/

---Se inserta una nueva calificación para un conductor, podemos actualizar automáticamente la calificación promedio del conductor.
CREATE OR REPLACE TRIGGER actualizar_calificacion_promedio
AFTER INSERT OR UPDATE OR DELETE ON Calificaciones
FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    v_calificacion_promedio NUMBER;
BEGIN
    SELECT AVG(numerocalificacion)
    INTO v_calificacion_promedio
    FROM Calificaciones
    WHERE idUsuario = :NEW.idUsuario;
    
    UPDATE Conductores
    SET calificacionPromedio = v_calificacion_promedio
    WHERE idUsuarioConductor = :NEW.idUsuario;


    COMMIT;
END;
/


---Si el estado de un usuario es Inactivo entonces no puede solicitar un viaje.
CREATE OR REPLACE TRIGGER verificar_estado_usuario
BEFORE INSERT ON Viajes
FOR EACH ROW
BEGIN
    DECLARE
        v_estado_usuario VARCHAR(15);
    BEGIN
        SELECT estadoUsuario
        INTO v_estado_usuario
        FROM Usuarios
        WHERE idUsuario = :NEW.idConductor;
        
        IF v_estado_usuario != 'Activo' THEN
            RAISE_APPLICATION_ERROR(-20002, 'El Conductor no está activo y no puede crear un viaje.');
        END IF;
    END;
END;
/

CREATE OR REPLACE TRIGGER verificar_estado_usuario2
BEFORE INSERT ON Viajes
FOR EACH ROW
BEGIN
    DECLARE
        v_estado_usuario VARCHAR(15);
    BEGIN
        SELECT estadoUsuario
        INTO v_estado_usuario
        FROM Usuarios
        WHERE idUsuario = :NEW.idPasajero;
        
        IF v_estado_usuario != 'Activo' THEN
            RAISE_APPLICATION_ERROR(-20002, 'El pasajero no está activo y no puede crear un viaje.');
        END IF;
    END;
END;
/

---El id del Recorrido es autogenerado.
CREATE SEQUENCE seq_recorridos_id
START WITH 1 
INCREMENT BY 1 
NOCACHE 
NOCYCLE;

CREATE OR REPLACE TRIGGER trg_recorridos_id
BEFORE INSERT ON Recorridos
FOR EACH ROW
BEGIN
  :NEW.id := seq_recorridos_id.NEXTVAL;
END;
/

--El id del punto de recogida es autogenerado.
CREATE SEQUENCE seq_puntos_de_recogida_id
START WITH 1 
INCREMENT BY 1 
NOCACHE  
NOCYCLE;  

CREATE OR REPLACE TRIGGER trg_puntos_de_recogida_id
BEFORE INSERT ON PuntosDeRecogida
FOR EACH ROW
BEGIN
  :NEW.idPunto := seq_puntos_de_recogida_id.NEXTVAL;
END;
/

--EL id de la ubicacion es autogenerado.
CREATE SEQUENCE seq_ubicaciones_id
START WITH 1 
INCREMENT BY 1  
NOCACHE  
NOCYCLE;  

CREATE OR REPLACE TRIGGER trg_ubicaciones_id
BEFORE INSERT ON Ubicaciones
FOR EACH ROW
BEGIN
  :NEW.idUbicacion := seq_ubicaciones_id.NEXTVAL;
END;
/
-------------------
CREATE OR REPLACE TRIGGER trg_incrementar_capacidad_viaje
BEFORE INSERT ON Viajes
FOR EACH ROW
DECLARE
  v_numero_puestos NUMBER;
BEGIN
  -- Obtener el número de puestos del vehículo asociado al conductor
  SELECT MAX(numeroPuestos)
  INTO v_numero_puestos
  FROM Vehiculos
  WHERE idConductor = :NEW.idConductor;

  -- Verificar y ajustar la capacidad antes de insertar
  IF :NEW.capacidad < v_numero_puestos THEN
    :NEW.capacidad := :NEW.capacidad + 1;
  ELSE
    RAISE_APPLICATION_ERROR(-20006, 'Capacidad máxima del vehículo alcanzada para este viaje.');
  END IF;
END;
/



--No se puede eliminar a un conductor si tiene viajes asignados.
CREATE OR REPLACE TRIGGER trg_no_eliminar_conductor_con_viajes
BEFORE DELETE ON Conductores
FOR EACH ROW
DECLARE
  v_viajes_asignados NUMBER;
BEGIN
 
  SELECT COUNT(*)
  INTO v_viajes_asignados
  FROM Viajes
  WHERE idConductor = :OLD.idUsuarioConductor; 
  
  IF v_viajes_asignados > 0 THEN
    RAISE_APPLICATION_ERROR(-20004, 'No se puede eliminar el conductor porque tiene viajes asignados.');
  END IF;
END;
/

--El id de horarios es autogenerado
CREATE SEQUENCE seq_id_horarios
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE OR REPLACE TRIGGER trg_auto_id_horarios
BEFORE INSERT ON Horarios
FOR EACH ROW
BEGIN
  :NEW.idHorario := seq_id_horarios.NEXTVAL;
END;
/















