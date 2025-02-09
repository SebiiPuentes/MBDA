
-------CONDUCTORES--------------------------------

CREATE OR REPLACE PACKAGE BODY PA_CONDUCTORES IS

    PROCEDURE AD_UBICACION(
        xnombre IN VARCHAR
    ) IS
    BEGIN
        PK_VIAJES.AD_UBICACION(xnombre);
    END AD_UBICACION;

    PROCEDURE AD_VEHICULO(
        xplaca IN CHAR, 
        xmodelo IN DATE, 
        xmarca IN VARCHAR, 
        xcolor IN VARCHAR, 
        xsoat IN CHAR, 
        xfechaSoat IN DATE, 
        xtecnomecanica IN CHAR, 
        xfechaTecnomecanica IN DATE, 
        xestado IN VARCHAR, 
        xnumeroPuestos IN NUMBER, 
        xidConductor IN CHAR
    ) IS
    BEGIN
        PK_VEHICULOS.AD_VEHICULO(xplaca, xmodelo, xmarca, xcolor, xsoat, xfechaSoat, xtecnomecanica, xfechaTecnomecanica, xestado, xnumeroPuestos, xidConductor);
    END AD_VEHICULO;

    PROCEDURE MO_VEHICULO(
        xplaca IN CHAR, 
        xsoat IN CHAR, 
        xfechaSoat IN DATE, 
        xtecnomecanica IN CHAR, 
        xfechaTecnomecanica IN DATE, 
        xestado IN VARCHAR
    ) IS
    BEGIN
        PK_VEHICULOS.MO_VEHICULO(xplaca, xsoat, xfechaSoat, xtecnomecanica, xfechaTecnomecanica, xestado);
    END MO_VEHICULO;

    PROCEDURE DEL_VEHICULO(
        xplaca IN CHAR
    ) IS
    BEGIN
        PK_VEHICULOS.DEL_VEHICULO(xplaca);
    END DEL_VEHICULO;

    PROCEDURE AD_RECORRIDO(
        xpuntoInicio IN VARCHAR, 
        xpuntoFin IN VARCHAR, 
        xplacaVehiculo IN CHAR
    ) IS
    BEGIN
        PK_VEHICULOS.AD_RECORRIDO(xpuntoInicio, xpuntoFin, xplacaVehiculo);
    END AD_RECORRIDO;

    PROCEDURE DEL_RECORRIDO(
        xid IN NUMBER
    ) IS
    BEGIN
        PK_VEHICULOS.DEL_RECORRIDO(xid);
    END DEL_RECORRIDO;

    PROCEDURE AD_REPORTE(
        xnumeroReporte IN CHAR, 
        xdescripcion IN VARCHAR, 
        xestadoReporte IN VARCHAR, 
        xidViaje IN CHAR
    ) IS
    BEGIN
        PK_VIAJES.AD_REPORTE(xnumeroReporte, xdescripcion, xestadoReporte, xidViaje);
    END AD_REPORTE;

    PROCEDURE AD_PAGO(
        xidPago IN CHAR, 
        xmetodoPago IN VARCHAR, 
        xestadoPago IN VARCHAR, 
        xvalorPagar IN NUMBER, 
        xidViaje IN CHAR
    ) IS
    BEGIN
        PK_VIAJES.AD_PAGO(xidPago, xmetodoPago, xestadoPago, xvalorPagar, xidViaje);
    END AD_PAGO;

    PROCEDURE AD_HORARIOS(
        xhorarioLlegada IN VARCHAR, 
        xhorarioSalida IN VARCHAR, 
        xdia IN VARCHAR, 
        xidRecorrido IN NUMBER
    ) IS
    BEGIN
        PK_HORARIOS.AD_HORARIOS(xhorarioLlegada, xhorarioSalida, xdia, xidRecorrido);
    END AD_HORARIOS;

    PROCEDURE MO_HORARIOS(
        xidHorario IN NUMBER, 
        xhorarioSalida IN VARCHAR, 
        xhorarioLlegada IN VARCHAR
    ) IS
    BEGIN
        PK_HORARIOS.MO_HORARIOS(xidHorario, xhorarioSalida, xhorarioLlegada);
    END MO_HORARIOS;

    PROCEDURE DEL_HORARIO(
        xidHorario IN NUMBER
    ) IS
    BEGIN
        PK_HORARIOS.DEL_HORARIO(xidHorario);
    END DEL_HORARIO;

    PROCEDURE AD_CALIFICACION(
        xidCalificacion IN VARCHAR, 
        xnumeroCalificacion IN NUMBER, 
        xdescripcion IN VARCHAR, 
        xidUsuario IN CHAR, 
        xidViaje IN CHAR
    ) IS
    BEGIN
        PK_USUARIOS.AD_CALIFICACION(xidCalificacion, xnumeroCalificacion, xdescripcion, xidUsuario, xidViaje);
    END AD_CALIFICACION;

    FUNCTION CO_CALIFICACIONPASAJEROS RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        v_cursor := PK_USUARIOS.CO_CALIFICACIONPASAJEROS;
        RETURN v_cursor;
    END CO_CALIFICACIONPASAJEROS;

    PROCEDURE AD_VERIFICACION(
        xnumeroVerificacion IN VARCHAR, 
        xestado IN VARCHAR
    ) IS
    BEGIN
        PK_USUARIOS.AD_VERIFICACION(xnumeroVerificacion, xestado);
    END AD_VERIFICACION;

    PROCEDURE AD_USUARIO(
        xidUsuario IN CHAR, 
        xcedula IN CHAR, 
        xnombre IN VARCHAR, 
        xapellido IN VARCHAR, 
        xcorreoInstitucional IN VARCHAR, 
        xcalificacion IN NUMBER, 
        xestadoUsuario IN VARCHAR, 
        xnumeroVerificacion IN VARCHAR
    ) IS
    BEGIN
        PK_USUARIOS.AD_USUARIO(xidUsuario, xcedula, xnombre, xapellido, xcorreoInstitucional, xcalificacion, xestadoUsuario, xnumeroVerificacion);
    END AD_USUARIO;

    PROCEDURE MO_USUARIO(
        xidUsuario IN CHAR, 
        xcalificacion IN NUMBER, 
        xestadoUsuario IN VARCHAR
    ) IS
    BEGIN
        PK_USUARIOS.MO_USUARIO(xidUsuario, xcalificacion, xestadoUsuario);
    END MO_USUARIO;

    PROCEDURE DEL_USUARIO(
        xidUsuario IN CHAR
    ) IS
    BEGIN
        PK_USUARIOS.DEL_USUARIO(xidUsuario);
    END DEL_USUARIO;

    FUNCTION CO_USUARIOS RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        v_cursor := PK_USUARIOS.CO_USUARIOS;
        RETURN v_cursor;
    END CO_USUARIOS;

    PROCEDURE AD_VIAJE(
        xidViaje IN CHAR, 
        xciudad IN VARCHAR, 
        xparadaPasajero IN VARCHAR, 
        xestadoViaje IN VARCHAR, 
        xcapacidad IN NUMBER, 
        xidPasajero IN CHAR, 
        xidConductor IN CHAR
    ) IS
    BEGIN
        PK_VIAJES.AD_VIAJE(xidViaje, xciudad, xparadaPasajero, xestadoViaje, xcapacidad, xidPasajero, xidConductor);
    END AD_VIAJE;

    PROCEDURE MO_VIAJE(
        xidViaje IN CHAR, 
        xestadoViaje IN VARCHAR, 
        xcapacidad IN NUMBER
    ) IS
    BEGIN
        PK_VIAJES.MO_VIAJE(xidViaje, xestadoViaje, xcapacidad);
    END MO_VIAJE;

    PROCEDURE DEL_VIAJE(
        xidViaje IN CHAR
    ) IS
    BEGIN
        PK_VIAJES.DEL_VIAJE(xidViaje);
    END DEL_VIAJE;

    FUNCTION CO_NUMEROVIAJES RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        v_cursor := PK_VIAJES.CO_NUMEROVIAJES;
        RETURN v_cursor;
    END CO_NUMEROVIAJES;

    PROCEDURE AD_CONDUCTOR(
        xidUsuarioConductor IN CHAR, 
        xnumeroLicencia IN CHAR, 
        xcalificacionPromedio IN NUMBER, 
        xfechaRegistro IN DATE
    ) IS
    BEGIN
        PK_USUARIOS.AD_CONDUCTOR(xidUsuarioConductor, xnumeroLicencia, xcalificacionPromedio, xfechaRegistro);
    END AD_CONDUCTOR;

    PROCEDURE DEL_CONDUCTOR(
        xidUsuarioConductor IN CHAR
    ) IS
    BEGIN
        PK_USUARIOS.DEL_CONDUCTOR(xidUsuarioConductor);
    END DEL_CONDUCTOR;

    PROCEDURE AD_AUTO(
        xidVehiculo IN CHAR, 
        numeroPuertas IN NUMBER
    ) IS
    BEGIN
        PK_VEHICULOS.AD_AUTO(xidVehiculo, numeroPuertas);
    END AD_AUTO;

    PROCEDURE DEL_AUTO(
        xidVehiculo IN CHAR
    ) IS
    BEGIN
        PK_VEHICULOS.DEL_AUTO(xidVehiculo);
    END DEL_AUTO;

    PROCEDURE AD_MOTO(
        xidVehiculo IN CHAR, 
        xtipoCilindraje IN VARCHAR
    ) IS
    BEGIN
        PK_VEHICULOS.AD_MOTO(xidVehiculo, xtipoCilindraje);
    END AD_MOTO;

    PROCEDURE DEL_MOTO(
        xidVehiculo IN CHAR
    ) IS
    BEGIN
        PK_VEHICULOS.DEL_MOTO(xidVehiculo);
    END DEL_MOTO;

END PA_CONDUCTORES;
/

-------------------PASAJEROS--------------------------------------

CREATE OR REPLACE PACKAGE BODY PA_PASAJEROS IS

    PROCEDURE AD_PUNTODERECOGIDA(
        xfechaHora IN DATE, 
        xidViaje IN CHAR, 
        xidRecorrido IN NUMBER, 
        xidUbicacion IN NUMBER
    ) IS
    BEGIN
        PK_VIAJES.AD_PUNTODERECOGIDA(xfechaHora, xidViaje, xidRecorrido, xidUbicacion);
    END AD_PUNTODERECOGIDA;

    PROCEDURE DEL_PUNTODERECOGIDA(
        xidPunto IN NUMBER
    ) IS
    BEGIN
        PK_VIAJES.DEL_PUNTODERECOGIDA(xidPunto);
    END DEL_PUNTODERECOGIDA;

    PROCEDURE AD_UBICACION(
        xnombre IN VARCHAR
    ) IS
    BEGIN
        PK_VIAJES.AD_UBICACION(xnombre);
    END AD_UBICACION;

    PROCEDURE AD_REPORTE(
        xnumeroReporte IN CHAR, 
        xdescripcion IN VARCHAR, 
        xestadoReporte IN VARCHAR, 
        xidViaje IN CHAR
    ) IS
    BEGIN
        PK_VIAJES.AD_REPORTE(xnumeroReporte, xdescripcion, xestadoReporte, xidViaje);
    END AD_REPORTE;

 
    PROCEDURE AD_VIAJE(
        xidViaje IN CHAR, 
        xciudad IN VARCHAR, 
        xparadaPasajero IN VARCHAR, 
        xestadoViaje IN VARCHAR, 
        xcapacidad IN NUMBER, 
        xidPasajero IN CHAR, 
        xidConductor IN CHAR
    ) IS
    BEGIN
        PK_VIAJES.AD_VIAJE(xidViaje, xciudad, xparadaPasajero, xestadoViaje, xcapacidad, xidPasajero, xidConductor);
    END AD_VIAJE;
    
    
    -------MO_VIAJE2-----------
    PROCEDURE MO_VIAJE2(
        xidViaje IN CHAR,
        xparadaPasajero IN VARCHAR,
        xidPasajero IN CHAR
    ) IS
    BEGIN
        PK_VIAJES.MO_VIAJE2(xidViaje,  xparadaPasajero, xidPasajero);
    END MO_VIAJE2;
    ----------------

 
    PROCEDURE DEL_VIAJE(
        xidViaje IN CHAR
    ) IS
    BEGIN
        PK_VIAJES.DEL_VIAJE(xidViaje);
    END DEL_VIAJE;

    FUNCTION CO_VIAJES RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        v_cursor := PK_VIAJES.CO_VIAJES;
        RETURN v_cursor;
    END CO_VIAJES;

    PROCEDURE AD_VERIFICACION(
        xnumeroVerificacion IN VARCHAR, 
        xestado IN VARCHAR
    ) IS
    BEGIN
        PK_USUARIOS.AD_VERIFICACION(xnumeroVerificacion, xestado);
    END AD_VERIFICACION;

    PROCEDURE AD_USUARIO(
        xidUsuario IN CHAR, 
        xcedula IN CHAR, 
        xnombre IN VARCHAR, 
        xapellido IN VARCHAR, 
        xcorreoInstitucional IN VARCHAR, 
        xcalificacion IN NUMBER, 
        xestadoUsuario IN VARCHAR, 
        xnumeroVerificacion IN VARCHAR
    ) IS
    BEGIN
        PK_USUARIOS.AD_USUARIO(xidUsuario, xcedula, xnombre, xapellido, xcorreoInstitucional, xcalificacion, xestadoUsuario, xnumeroVerificacion);
    END AD_USUARIO;

    PROCEDURE MO_USUARIO(
        xidUsuario IN CHAR, 
        xcalificacion IN NUMBER, 
        xestadoUsuario IN VARCHAR
    ) IS
    BEGIN
        PK_USUARIOS.MO_USUARIO(xidUsuario, xcalificacion, xestadoUsuario);
    END MO_USUARIO;

    PROCEDURE DEL_USUARIO(
        xidUsuario IN CHAR
    ) IS
    BEGIN
        PK_USUARIOS.DEL_USUARIO(xidUsuario);
    END DEL_USUARIO;

    FUNCTION CO_CALIFICACIONCONDUCTOR RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        v_cursor := PK_USUARIOS.CO_CALIFICACIONCONDUCTOR;
        RETURN v_cursor;
    END CO_CALIFICACIONCONDUCTOR;

    PROCEDURE AD_CALIFICACION(
        xidCalificacion IN VARCHAR, 
        xnumeroCalificacion IN NUMBER, 
        xdescripcion IN VARCHAR, 
        xidUsuario IN CHAR, 
        xidViaje IN CHAR
    ) IS
    BEGIN
        PK_USUARIOS.AD_CALIFICACION(xidCalificacion, xnumeroCalificacion, xdescripcion, xidUsuario, xidViaje);
    END AD_CALIFICACION;

    PROCEDURE AD_PASAJERO(
        xidUsuarioPasajero IN CHAR, 
        numeroViajes IN NUMBER, 
        fechaRegistro IN DATE
    ) IS
    BEGIN
        PK_USUARIOS.AD_PASAJERO(xidUsuarioPasajero, numeroViajes, fechaRegistro);
    END AD_PASAJERO;

    PROCEDURE DEL_PASAJERO(
        xidUsuarioPasajero IN CHAR
    ) IS
    BEGIN
        PK_USUARIOS.DEL_PASAJERO(xidUsuarioPasajero);
    END DEL_PASAJERO;

END PA_PASAJEROS;
/


-----------ADMINISTRADORES------------------------------

CREATE OR REPLACE PACKAGE BODY PA_ADMINISTRADORES IS

    PROCEDURE AD_NOTIFICACION(
        xidReporte IN CHAR, 
        XfechaNotificacion IN DATE, 
        XmedioNotificacion IN VARCHAR
    ) IS
    BEGIN
        PK_VIAJES.AD_NOTIFICACION(xidReporte, XfechaNotificacion, XmedioNotificacion);
    END AD_NOTIFICACION;

    PROCEDURE AD_MULTA(
        xidMulta IN CHAR, 
        xdescripcion IN VARCHAR, 
        xfecha IN DATE, 
        xestado IN VARCHAR, 
        xidViaje IN CHAR
    ) IS
    BEGIN
        PK_VIAJES.AD_MULTA(xidMulta, xdescripcion, xfecha, xestado, xidViaje);
    END AD_MULTA;

   
    PROCEDURE MO_MULTA(
        xidMulta IN CHAR, 
        xestado IN VARCHAR
    ) IS
    BEGIN
        PK_VIAJES.MO_MULTA(xidMulta, xestado);
    END MO_MULTA;

    PROCEDURE DEL_MULTA(
        xidMulta IN CHAR
    ) IS
    BEGIN
        PK_VIAJES.DEL_MULTA(xidMulta);
    END DEL_MULTA;


    PROCEDURE MO_VERIFICACION(
        xnumeroVerificacion IN VARCHAR, 
        xestado IN VARCHAR
    ) IS
    BEGIN
        PK_USUARIOS.MO_VERIFICACION(xnumeroVerificacion, xestado);
    END MO_VERIFICACION;

    PROCEDURE DEL_VERIFICACION(
        xnumeroVerificacion IN VARCHAR
    ) IS
    BEGIN
        PK_USUARIOS.DEL_VERIFICACION(xnumeroVerificacion);
    END DEL_VERIFICACION;


    PROCEDURE AD_REPORTE(
        xnumeroReporte IN CHAR, 
        xdescripcion IN VARCHAR, 
        xestadoReporte IN VARCHAR, 
        xidViaje IN CHAR
    ) IS
    BEGIN
        PK_VIAJES.AD_REPORTE(xnumeroReporte, xdescripcion, xestadoReporte, xidViaje);
    END AD_REPORTE;

 
    PROCEDURE MO_REPORTE(
        xnumeroReporte IN CHAR, 
        xestadoReporte IN VARCHAR
    ) IS
    BEGIN
        PK_VIAJES.MO_REPORTE(xnumeroReporte, xestadoReporte);
    END MO_REPORTE;

    PROCEDURE DEL_REPORTE(
        xnumeroReporte IN CHAR
    ) IS
    BEGIN
        PK_VIAJES.DEL_REPORTE(xnumeroReporte);
    END DEL_REPORTE;

    FUNCTION CO_REPORTES RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        v_cursor := PK_VIAJES.CO_REPORTES;
        RETURN v_cursor;
    END CO_REPORTES;

    PROCEDURE AD_PAGO(
        xidPago IN CHAR, 
        xmetodoPago IN VARCHAR, 
        xestadoPago IN VARCHAR, 
        xvalorPagar IN NUMBER, 
        xidViaje IN CHAR
    ) IS
    BEGIN
        PK_VIAJES.AD_PAGO(xidPago, xmetodoPago, xestadoPago, xvalorPagar, xidViaje);
    END AD_PAGO;

    PROCEDURE MO_PAGO(
        xidPago IN CHAR, 
        xestadoPago IN VARCHAR
    ) IS
    BEGIN
        PK_VIAJES.MO_PAGO(xidPago, xestadoPago);
    END MO_PAGO;

    PROCEDURE DEL_PAGO(
        xidPago IN CHAR
    ) IS
    BEGIN
        PK_VIAJES.DEL_PAGO(xidPago);
    END DEL_PAGO;

    FUNCTION CO_PAGOS RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        v_cursor := PK_VIAJES.CO_PAGOS;
        RETURN v_cursor;
    END CO_PAGOS;

    PROCEDURE MO_VIAJE(
        xidViaje IN CHAR, 
        xestadoViaje IN VARCHAR, 
        xcapacidad IN NUMBER
    ) IS
    BEGIN
        PK_VIAJES.MO_VIAJE(xidViaje, xestadoViaje, xcapacidad);
    END MO_VIAJE;

    FUNCTION CO_VIAJES RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        v_cursor := PK_VIAJES.CO_VIAJES;
        RETURN v_cursor;
    END CO_VIAJES;

    PROCEDURE MO_CONDUCTOR(
        xidUsuarioConductor IN CHAR, 
        xcalificacionPromedio IN NUMBER
    ) IS
    BEGIN
        PK_USUARIOS.MO_CONDUCTOR(xidUsuarioConductor, xcalificacionPromedio);
    END MO_CONDUCTOR;

    PROCEDURE MO_PASAJERO(
        xidUsuarioPasajero IN CHAR, 
        numeroViajes IN NUMBER
    ) IS
    BEGIN
        PK_USUARIOS.MO_PASAJERO(xidUsuarioPasajero, numeroViajes);
    END MO_PASAJERO;

END PA_ADMINISTRADORES;
/


