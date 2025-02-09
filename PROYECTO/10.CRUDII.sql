CREATE OR REPLACE PACKAGE BODY PK_USUARIOS IS

    PROCEDURE AD_USUARIO( xidUsuario IN CHAR,  xcedula IN CHAR,  xnombre IN VARCHAR,  xapellido IN VARCHAR,  xcorreoInstitucional IN VARCHAR,  xcalificacion IN NUMBER,  xestadoUsuario IN VARCHAR, xnumeroVerificacion IN VARCHAR ) IS
    BEGIN
    
        INSERT INTO Usuarios (idUsuario, cedula, nombre, apellido, correoInstitucional, calificacion, estadoUsuario, numeroVerificacion) VALUES 
        (xidUsuario, xcedula, xnombre, xapellido, xcorreoInstitucional, xcalificacion, xestadoUsuario, xnumeroVerificacion);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20118, 'Error al ADICIONAR USUARIOS');
        
    END AD_USUARIO;

    PROCEDURE MO_USUARIO(xidUsuario IN CHAR,xcalificacion IN NUMBER,xestadoUsuario IN VARCHAR) IS
    
    BEGIN
    IF xcalificacion < 1 OR xcalificacion > 5 THEN
        RAISE_APPLICATION_ERROR(-20118, 'La calificación debe estar entre 1 y 5.');
    END IF;

    UPDATE Usuarios
    SET calificacion = xcalificacion,
        estadoUsuario = xestadoUsuario
    WHERE idUsuario = xidUsuario;
    COMMIT;

    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20117, 'Error al modificar usuarios');
    END MO_USUARIO;


    PROCEDURE DEL_USUARIO(xidUsuario IN CHAR) IS
    BEGIN
    
        DELETE FROM Usuarios
        WHERE idUsuario = xidUsuario;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20116, 'Error al Eliminar Usuarios');
        
    END DEL_USUARIO;

    FUNCTION CO_USUARIOS RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT idUsuario, cedula, nombre, apellido, correoInstitucional, calificacion, estadoUsuario
            FROM Usuarios;
        RETURN v_cursor;
    END CO_USUARIOS;
    
    ---CALIFICACIONES-----
    PROCEDURE AD_CALIFICACION(xidCalificacion IN VARCHAR, xnumeroCalificacion IN NUMBER, xdescripcion IN VARCHAR, xidUsuario IN CHAR, xidViaje IN CHAR) IS
    BEGIN
    
        INSERT INTO Calificaciones ( idCalificacion, numeroCalificacion, descripcion, idUsuario, idViaje) VALUES (xidCalificacion, xnumeroCalificacion, xdescripcion, xidUsuario, xidViaje);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20115, 'Error al Adicionar Calificacion');
    END AD_CALIFICACION;

    -- Función para obtener las calificaciones de los conductores
    FUNCTION CO_CALIFICACIONCONDUCTOR RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT c.idCalificacion, c.numerocalificacion, c.descripcion, 
                   u.nombre || ' ' || u.apellido AS conductor
            FROM Calificaciones c
            JOIN Conductores co ON c.idUsuario = co.idUsuarioConductor
            JOIN Usuarios u ON u.idUsuario = co.idUsuarioConductor;
        RETURN v_cursor;
    END CO_CALIFICACIONCONDUCTOR;

    -- Función para obtener el número de calificaciones hechas por los pasajeros
    FUNCTION CO_CALIFICACIONPASAJEROS RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT v.idPasajero, COUNT(c.idCalificacion) AS total_calificaciones
            FROM Calificaciones c
            JOIN Viajes v ON c.idViaje = v.idViaje
            GROUP BY v.idPasajero;
        RETURN v_cursor;
    END CO_CALIFICACIONPASAJEROS;
    
    ---------VERIFICACIONES--------------
    PROCEDURE AD_VERIFICACION(xnumeroVerificacion IN VARCHAR, xestado IN VARCHAR) IS
    BEGIN
    
        INSERT INTO Verificaciones (numeroVerificacion, estado) VALUES (xnumeroVerificacion, xestado );
        COMMIT;
        
    EXCEPTION 
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20112, 'Error al Insertar Verificaciones');
    END AD_VERIFICACION;

    PROCEDURE MO_VERIFICACION(xnumeroVerificacion IN VARCHAR, xestado IN VARCHAR) IS
    BEGIN
        UPDATE Verificaciones
        SET estado = xestado
        WHERE numeroVerificacion = xnumeroVerificacion;
        COMMIT;
        
    EXCEPTION 
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20113, 'Error al Modificar Verificacion');
        
    END MO_VERIFICACION;

    PROCEDURE DEL_VERIFICACION( xnumeroVerificacion IN VARCHAR) IS
    BEGIN
        DELETE FROM Verificaciones
        WHERE numeroVerificacion = xnumeroVerificacion;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20114, 'Error al Eliminar Verificacion');
    END DEL_VERIFICACION;
    
    ---------PASAJEROS---------------
    PROCEDURE AD_PASAJERO(
        xidUsuarioPasajero IN CHAR,
        numeroViajes IN NUMBER,
        fechaRegistro IN DATE
    ) IS
    BEGIN
        INSERT INTO Pasajeros (idUsuarioPasajero, numeroViajes, fechaRegistro)
        VALUES (xidUsuarioPasajero, numeroViajes, fechaRegistro);
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20143, 'Error al ADICIONAR PASAJEROS');
    END AD_PASAJERO;

   
    PROCEDURE MO_PASAJERO(
        xidUsuarioPasajero IN CHAR,
        numeroViajes IN NUMBER
    ) IS
    BEGIN
        UPDATE Pasajeros
        SET numeroViajes = numeroViajes
        WHERE idUsuarioPasajero = xidUsuarioPasajero;
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20144, 'Error al MODIFICAR PASAJEROS');
    END MO_PASAJERO;

   
    PROCEDURE DEL_PASAJERO(
        xidUsuarioPasajero IN CHAR
    ) IS
    BEGIN
        DELETE FROM Pasajeros
        WHERE idUsuarioPasajero = xidUsuarioPasajero;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20145, 'Error al ELIMINAR PASAJEROS');
    END DEL_PASAJERO;
    
    ---------CONDUCTOR----------
    PROCEDURE AD_CONDUCTOR(
        xidUsuarioConductor IN CHAR,
        xnumeroLicencia IN CHAR,
        xcalificacionPromedio IN NUMBER,
        xfechaRegistro IN DATE
    ) IS
    BEGIN
    
        INSERT INTO Conductores (idUsuarioConductor, numeroLicencia, calificacionPromedio, fechaRegistro)
        VALUES (xidUsuarioConductor, xnumeroLicencia, xcalificacionPromedio, xfechaRegistro);
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20146, 'Error al ADICIONAR CONDUCTORES');
    END AD_CONDUCTOR;

   
    PROCEDURE MO_CONDUCTOR(
        xidUsuarioConductor IN CHAR,
        xcalificacionPromedio IN NUMBER
    ) IS
    BEGIN
     
        UPDATE Conductores
        SET calificacionPromedio = xcalificacionPromedio
        WHERE idUsuarioConductor = xidUsuarioConductor;
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20147, 'Error al MODIFICAR CONDUCTORES');
    END MO_CONDUCTOR;

   
    PROCEDURE DEL_CONDUCTOR(
        xidUsuarioConductor IN CHAR
    ) IS
    BEGIN
        DELETE FROM Conductores
        WHERE idUsuarioConductor = xidUsuarioConductor;
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20148, 'Error al ELIMINAR CONDUCTORES');
    END DEL_CONDUCTOR;

END PK_USUARIOS;
/

-----------------
CREATE OR REPLACE PACKAGE BODY PK_VEHICULOS IS

   
    PROCEDURE AD_VEHICULO(xplaca IN CHAR, xmodelo IN DATE, xmarca IN VARCHAR, xcolor IN VARCHAR, 
                          xsoat IN CHAR, xfechaSoat IN DATE, xtecnomecanica IN CHAR, xfechaTecnomecanica IN DATE, 
                          xestado IN VARCHAR, xnumeroPuestos IN NUMBER, xidConductor IN CHAR) IS
    BEGIN
    
        INSERT INTO Vehiculos (placa, modelo, marca, color, soat, fechaSoat, tecnomecanica, fechaTecnomecanica, estado, numeroPuestos, idConductor)
        VALUES (xplaca, xmodelo, xmarca, xcolor, xsoat, xfechaSoat, xtecnomecanica, xfechaTecnomecanica, xestado, xnumeroPuestos, xidConductor);
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20121, 'Error al ADICIONAR VEHICULOS');
        
    END AD_VEHICULO;

   
    PROCEDURE MO_VEHICULO(
    xplaca              IN CHAR,
    xsoat               IN CHAR,
    xfechaSoat          IN DATE,
    xtecnomecanica      IN CHAR,
    xfechaTecnomecanica IN DATE,
    xestado             IN VARCHAR
    ) IS
    v_estado VARCHAR2(10); 
    BEGIN
    IF xfechaSoat < SYSDATE OR xfechaTecnomecanica < SYSDATE THEN
        v_estado := 'Inactivo';
    ELSE
        v_estado := 'Activo';
    END IF;

    UPDATE Vehiculos
    SET soat = xsoat,
        fechaSoat = xfechaSoat,
        tecnomecanica = xtecnomecanica,
        fechaTecnomecanica = xfechaTecnomecanica,
        estado = v_estado 
    WHERE placa = xplaca;

    COMMIT;

    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20122, 'Error al modificar vehículos');
    END MO_VEHICULO;


    PROCEDURE DEL_VEHICULO(xplaca IN CHAR) IS
    BEGIN
    
        DELETE FROM Vehiculos WHERE placa = xplaca;
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20123, 'Error al ELIMINAR VEHICULOS');
        
    END DEL_VEHICULO;
    
    
    --------MOTOS------------
    PROCEDURE AD_MOTO(
        xidVehiculo IN CHAR,
        xtipoCilindraje IN VARCHAR
    ) IS
    BEGIN
        
        INSERT INTO Motos (idVehiculo, tipoCilindraje)
        VALUES (xidVehiculo, xtipoCilindraje);
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20151, 'Error al ADICIONAR MOTOS');
    END AD_MOTO;

   
    PROCEDURE DEL_MOTO(
        xidVehiculo IN CHAR
    ) IS
    BEGIN
        
        DELETE FROM Motos
        WHERE idVehiculo = xidVehiculo;
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20152, 'Error al ELIMINAR MOTOS');
    END DEL_MOTO;
    
    ------AUTOS---------
    PROCEDURE AD_AUTO(
        xidVehiculo IN CHAR,
        numeroPuertas IN NUMBER
    ) IS
    BEGIN
        
        INSERT INTO Autos (idVehiculo, numeroPuertas)
        VALUES (xidVehiculo, numeroPuertas);
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20149, 'Error al ADICIONAR AUTOS');
    END AD_AUTO;

  
    PROCEDURE DEL_AUTO(
        xidVehiculo IN CHAR
    ) IS
    BEGIN
       
        DELETE FROM Autos
        WHERE idVehiculo = xidVehiculo;
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20150, 'Error al ELIMINAR AUTOS');
    END DEL_AUTO;
    
    -------RECORRIDOS---------
    PROCEDURE AD_RECORRIDO(xpuntoInicio IN VARCHAR,  xpuntoFin IN VARCHAR, xplacaVehiculo IN CHAR ) IS
    BEGIN
    
        INSERT INTO Recorridos (puntoInicio, puntoFin, placaVehiculo) VALUES (xpuntoInicio, xpuntoFin, xplacaVehiculo);
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20119, 'Error al ADICIONAR REOCRRIDOS');
        
    END AD_RECORRIDO;

   
    PROCEDURE DEL_RECORRIDO( xid IN NUMBER) IS
    BEGIN

        DELETE FROM Recorridos
        WHERE id = xid;
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20120, 'Error al ELIMINAR REOCRRIDOS');
        
    END DEL_RECORRIDO;

    FUNCTION CO_RECORRIDOS(idConductor IN CHAR) RETURN SYS_REFCURSOR IS
        rec_cursor SYS_REFCURSOR;
    BEGIN
        OPEN rec_cursor FOR
            SELECT r.*
            FROM Recorridos r
            JOIN Vehiculos v ON r.placaVehiculo = v.placa
            WHERE v.idConductor = idConductor;
        
        RETURN rec_cursor;
    END CO_RECORRIDOS;

END PK_VEHICULOS;
/


------------------------------
CREATE OR REPLACE PACKAGE BODY PK_HORARIOS IS

   
    PROCEDURE AD_HORARIOS(xhorarioLlegada IN VARCHAR, xhorarioSalida IN VARCHAR, xdia IN VARCHAR, xidRecorrido IN NUMBER ) IS
    BEGIN
        
        INSERT INTO Horarios (horarioLlegada, horarioSalida, dia, idRecorrido)
        VALUES (xhorarioLlegada, xhorarioSalida, xdia, xidRecorrido);
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20124, 'Error al ADICIONAR HORARIOS');
    END AD_HORARIOS;

    PROCEDURE MO_HORARIOS(
    xidHorario       IN NUMBER,
    xhorarioSalida   IN VARCHAR,
    xhorarioLlegada  IN VARCHAR
    ) IS
    BEGIN
    IF TO_DATE(xhorarioSalida, 'HH24:MI') > TO_DATE(xhorarioLlegada, 'HH24:MI') THEN
        RAISE_APPLICATION_ERROR(-20126, 'La hora de salida no puede ser mayor que la hora de llegada.');
    END IF;
    
    UPDATE Horarios
    SET horarioSalida = xhorarioSalida,
        horarioLlegada = xhorarioLlegada
    WHERE idHorario = xidHorario;

    COMMIT;

    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20125, 'Error al modificar horarios');
    END MO_HORARIOS;

    PROCEDURE DEL_HORARIO(xidHorario IN NUMBER) IS
    BEGIN

        DELETE FROM Horarios WHERE idHorario = xidHorario;
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20126, 'Error al ELIMINAR HORARIOS');
    END DEL_HORARIO;

END PK_HORARIOS;
/


-----------------
CREATE OR REPLACE PACKAGE BODY PK_VIAJES IS

    PROCEDURE AD_VIAJE(xidViaje IN CHAR, xciudad IN VARCHAR, xparadaPasajero IN VARCHAR, xestadoViaje IN VARCHAR, xcapacidad IN NUMBER, xidPasajero IN CHAR, xidConductor IN CHAR) IS
    BEGIN
        
        INSERT INTO Viajes (idViaje, ciudad, paradaPasajero, estadoViaje, capacidad, idPasajero, idConductor)
        VALUES (xidViaje, xciudad, xparadaPasajero, xestadoViaje, xcapacidad, xidPasajero, xidConductor);
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20127, 'Error al ADICIONAR VIAJES');
        
    END AD_VIAJE;
    
    PROCEDURE MO_VIAJE2(xidViaje IN CHAR,  xparadaPasajero IN VARCHAR, xidPasajero IN CHAR) IS
    BEGIN
        UPDATE viajes
        SET paradaPasajero = xparadaPasajero,
            idPasajero = xidPasajero
        WHERE idViaje = xidViaje;
        COMMIT;
     EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20228, 'Error al MODIFICAR VIAJES');
    END;

   
    PROCEDURE MO_VIAJE(xidViaje IN CHAR, xestadoViaje IN VARCHAR, xcapacidad IN NUMBER) IS
    BEGIN
    
        UPDATE Viajes
        SET estadoViaje = xestadoViaje,
            capacidad = xcapacidad
        WHERE idViaje = xidViaje;
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20128, 'Error al MODIFICAR VIAJES');
        
    END MO_VIAJE;

    PROCEDURE DEL_VIAJE(xidViaje IN CHAR) IS
    BEGIN
        
        DELETE FROM Viajes WHERE idViaje = xidViaje;
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20129, 'Error al ELIMINAR VIAJES');
        
    END DEL_VIAJE;

    FUNCTION CO_VIAJES RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
     
        OPEN v_cursor FOR
            SELECT idViaje, ciudad, paradaPasajero, estadoViaje, capacidad
            FROM Viajes;
        RETURN v_cursor;
        
    END CO_VIAJES;

    FUNCTION CO_NUMEROVIAJES RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN

        OPEN v_cursor FOR
            SELECT idPasajero, COUNT(idViaje) AS num_viajes
            FROM Viajes
            GROUP BY idPasajero;
        RETURN v_cursor;
        
    END CO_NUMEROVIAJES;
    
    ----PAGOS----
    PROCEDURE AD_PAGO(xidPago IN CHAR, xmetodoPago IN VARCHAR, xestadoPago IN VARCHAR, xvalorPagar IN NUMBER, xidViaje IN CHAR) IS
    BEGIN

        INSERT INTO Pagos (idPago, metodoPago, estadoPago, valorPagar, idViaje)
        VALUES (xidPago, xmetodoPago, xestadoPago, xvalorPagar, xidViaje);
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20130, 'Error al ADICIONAR PAGOS');
    END AD_PAGO;

    PROCEDURE MO_PAGO(xidPago IN CHAR, xestadoPago IN VARCHAR) IS
    BEGIN
       
        UPDATE Pagos
        SET estadoPago = xestadoPago
        WHERE idPago = xidPago;
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20131, 'Error al MODIFICAR PAGOS');
    END MO_PAGO;

 
    PROCEDURE DEL_PAGO(xidPago IN CHAR) IS
    BEGIN
        
        DELETE FROM Pagos WHERE idPago = xidPago;
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20132, 'Error al ELIMINAR PAGOS');
        
    END DEL_PAGO;

  
    FUNCTION CO_PAGOS RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT idPago, metodoPago, estadoPago, valorPagar
            FROM Pagos;
        RETURN v_cursor;
    END CO_PAGOS;
    
    -----REPORTE-------------------
    PROCEDURE AD_REPORTE (
        xnumeroReporte IN CHAR,
        xdescripcion IN VARCHAR,
        xestadoReporte IN VARCHAR,
        xidViaje IN CHAR
    ) IS 
    BEGIN
        INSERT INTO Reportes (numeroReporte, descripcion, estadoReporte, idViaje)
        VALUES (xnumeroReporte, xdescripcion, xestadoReporte, xidViaje);
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20133, 'Error al ADICIONAR REPORTE');
    END AD_REPORTE;

    PROCEDURE MO_REPORTE (xnumeroReporte IN CHAR,
        xestadoReporte IN VARCHAR
    ) IS 
    BEGIN
        UPDATE Reportes
        SET estadoReporte = xestadoReporte;
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20134, 'Error al MODIFICAR REPORTE');
    END MO_REPORTE;

    PROCEDURE DEL_REPORTE (
        xnumeroReporte IN CHAR
    ) IS 
    BEGIN
        DELETE FROM Reportes
        WHERE numeroReporte = xnumeroReporte;
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20135, 'Error al ELIMINAR REPORTES');
    END DEL_REPORTE;

    -- Función para consultar todos los reportes enviados por los usuarios
    FUNCTION CO_REPORTES RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
        SELECT numeroReporte, descripcion, estadoReporte, idViaje
        FROM Reportes;
        RETURN cur;
    END CO_REPORTES;
    
    
    -----------PUNTODERECOGIDA-------------
    PROCEDURE AD_PUNTODERECOGIDA (xfechaHora IN DATE,xidViaje IN CHAR, xidRecorrido IN NUMBER, xidUbicacion IN NUMBER) IS
    BEGIN
        INSERT INTO PuntosDeRecogida (fechaHora, idViaje, idRecorrido, idUbicacion)
        VALUES (xfechaHora, xidViaje, xidRecorrido, xidUbicacion);
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20136, 'Error al ADICIONAR PUNTOS DE RECOGIDA');
    END AD_PUNTODERECOGIDA;


    PROCEDURE DEL_PUNTODERECOGIDA (xidPunto IN NUMBER) IS
    BEGIN
        DELETE FROM PuntosDeRecogida
        WHERE idPunto = xidPunto;
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20137, 'Error al ELIMINAR PUNTOS DE RECOGIDA');
    END DEL_PUNTODERECOGIDA;
    
    
    -------MULTAS--------
    PROCEDURE AD_MULTA(
        xidMulta IN CHAR, 
        xdescripcion IN VARCHAR, 
        xfecha IN DATE, 
        xestado IN VARCHAR,
        xidViaje IN CHAR
    ) IS
    BEGIN
        INSERT INTO Multas (idMulta, descripcion, fecha, estado, idViaje)
        VALUES (xidMulta, xdescripcion, xfecha, xestado, xidViaje);
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20138, 'Error al ADICIONAR MLTAS');
    END AD_MULTA;


    PROCEDURE MO_MULTA(
        xidMulta IN CHAR,  
        xestado IN VARCHAR
    ) IS
    BEGIN
        UPDATE Multas
        SET estado = xestado
        WHERE idMulta = xidMulta; 
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20139, 'Error al MODIFICAR MULTAS');
    END MO_MULTA;


    PROCEDURE DEL_MULTA(
        xidMulta IN CHAR
    ) IS
    BEGIN
        DELETE FROM Multas
        WHERE idMulta = xidMulta; 
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20140, 'Error al ELIMINAR MLTAS');
    END DEL_MULTA;
    
    -----UBICACIONES----------
    PROCEDURE AD_UBICACION(
        xnombre IN VARCHAR
    ) IS
    BEGIN
        INSERT INTO Ubicaciones (nombre)
        VALUES (xnombre);
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20141, 'Error al ADICIONAR UBICACION');
    END AD_UBICACION;
    
    
    ---------NOTIFICACIONES-----------
    PROCEDURE AD_NOTIFICACION(
        xidReporte IN CHAR, 
        XfechaNotificacion IN DATE, 
        XmedioNotificacion IN VARCHAR
    ) IS
    BEGIN
        INSERT INTO Notificaciones (idReporte, fechaNotificacion, medioNotificacion)
        VALUES (xidReporte, XfechaNotificacion, XmedioNotificacion);
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20142, 'Error al ADICIONAR NOTIFICACION');
    END AD_NOTIFICACION;

END PK_VIAJES;
/

----------




