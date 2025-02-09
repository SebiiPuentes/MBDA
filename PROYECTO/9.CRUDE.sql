-----------
CREATE OR REPLACE PACKAGE PK_USUARIOS IS

    PROCEDURE AD_USUARIO(xidUsuario IN CHAR, xcedula IN CHAR, xnombre IN VARCHAR, xapellido IN VARCHAR, xcorreoInstitucional IN VARCHAR, xcalificacion IN NUMBER, xestadoUsuario IN VARCHAR, xnumeroVerificacion IN VARCHAR);
    PROCEDURE MO_USUARIO(xidUsuario IN CHAR,xcalificacion IN NUMBER,xestadoUsuario IN VARCHAR);
    PROCEDURE DEL_USUARIO(xidUsuario IN CHAR);
    FUNCTION CO_USUARIOS RETURN SYS_REFCURSOR;
    PROCEDURE AD_CALIFICACION(xidCalificacion IN VARCHAR, xnumeroCalificacion IN NUMBER, xdescripcion IN VARCHAR,xidUsuario IN CHAR, xidViaje IN CHAR);
    FUNCTION CO_CALIFICACIONCONDUCTOR RETURN SYS_REFCURSOR;
    FUNCTION CO_CALIFICACIONPASAJEROS RETURN SYS_REFCURSOR;
    PROCEDURE AD_VERIFICACION(xnumeroVerificacion IN VARCHAR, xestado IN VARCHAR);
    PROCEDURE MO_VERIFICACION(xnumeroVerificacion IN VARCHAR,xestado IN VARCHAR);
    PROCEDURE DEL_VERIFICACION(xnumeroVerificacion IN VARCHAR);
    PROCEDURE AD_PASAJERO (xidUsuarioPasajero IN CHAR, numeroViajes IN NUMBER, fechaRegistro IN DATE);
    PROCEDURE MO_PASAJERO(xidUsuarioPasajero IN CHAR, numeroViajes IN NUMBER);
    PROCEDURE DEL_PASAJERO(xidUsuarioPasajero IN CHAR);
    PROCEDURE AD_CONDUCTOR(xidUsuarioConductor IN CHAR, xnumeroLicencia IN CHAR, xcalificacionPromedio IN NUMBER, xfechaRegistro IN DATE);
    PROCEDURE MO_CONDUCTOR(xidUsuarioConductor IN CHAR, xcalificacionPromedio IN NUMBER);
    PROCEDURE DEL_CONDUCTOR(xidUsuarioConductor IN CHAR);
    
END PK_USUARIOS;
/

-----------
CREATE OR REPLACE PACKAGE PK_VEHICULOS IS

    PROCEDURE AD_VEHICULO(xplaca IN CHAR, xmodelo IN DATE, xmarca IN VARCHAR, xcolor IN VARCHAR, xsoat IN CHAR, xfechaSoat IN DATE, xtecnomecanica IN CHAR, xfechaTecnomecanica IN DATE, 
                          xestado IN VARCHAR, xnumeroPuestos IN NUMBER, xidConductor IN CHAR);
    PROCEDURE MO_VEHICULO(xplaca IN CHAR,xsoat IN CHAR, xfechaSoat IN DATE, xtecnomecanica IN CHAR, xfechaTecnomecanica IN DATE, xestado IN VARCHAR);
    PROCEDURE DEL_VEHICULO(xplaca IN CHAR);
    PROCEDURE AD_RECORRIDO(xpuntoInicio IN VARCHAR, xpuntoFin IN VARCHAR, xplacaVehiculo IN CHAR);
    PROCEDURE DEL_RECORRIDO(xid IN NUMBER);
    FUNCTION CO_RECORRIDOS(idConductor IN CHAR) RETURN SYS_REFCURSOR;
    PROCEDURE AD_AUTO(xidVehiculo IN CHAR, numeroPuertas IN NUMBER);
    PROCEDURE DEL_AUTO(xidVehiculo IN CHAR);
    PROCEDURE AD_MOTO(xidVehiculo IN CHAR, xtipoCilindraje IN VARCHAR);
    PROCEDURE DEL_MOTO(xidVehiculo IN CHAR);

END PK_VEHICULOS;
/
-----------
CREATE OR REPLACE PACKAGE PK_HORARIOS IS 

    PROCEDURE AD_HORARIOS(xhorarioLlegada IN VARCHAR, xhorarioSalida IN VARCHAR, xdia IN VARCHAR, xidRecorrido IN NUMBER);
    PROCEDURE MO_HORARIOS(xidHorario IN NUMBER,xhorarioSalida IN VARCHAR, xhorarioLlegada IN VARCHAR);
    PROCEDURE DEL_HORARIO(xidHorario IN NUMBER);
    
END PK_HORARIOS;
/
-----------
CREATE OR REPLACE PACKAGE PK_VIAJES IS

    PROCEDURE AD_VIAJE(xidViaje IN CHAR, xciudad IN VARCHAR, xparadaPasajero IN VARCHAR, xestadoViaje IN VARCHAR, xcapacidad IN NUMBER, xidPasajero IN CHAR, xidConductor IN CHAR);
    PROCEDURE MO_VIAJE(xidViaje IN CHAR,xestadoViaje IN VARCHAR,xcapacidad IN NUMBER);
    PROCEDURE MO_VIAJE2(xidViaje IN CHAR,  xparadaPasajero IN VARCHAR, xidPasajero IN CHAR);
    PROCEDURE DEL_VIAJE(xidViaje IN CHAR);
    FUNCTION CO_VIAJES RETURN SYS_REFCURSOR;
    FUNCTION CO_NUMEROVIAJES RETURN SYS_REFCURSOR;
    PROCEDURE AD_PAGO(xidPago IN CHAR, xmetodoPago IN VARCHAR, xestadoPago IN VARCHAR, xvalorPagar IN NUMBER, xidViaje IN CHAR);
    PROCEDURE MO_PAGO(xidPago IN CHAR,xestadoPago IN VARCHAR);
    PROCEDURE DEL_PAGO(xidPago IN CHAR);
    FUNCTION CO_PAGOS RETURN SYS_REFCURSOR;
    PROCEDURE AD_REPORTE (xnumeroReporte IN CHAR, xdescripcion IN VARCHAR, xestadoReporte IN VARCHAR, xidViaje IN CHAR);
    PROCEDURE MO_REPORTE (xnumeroReporte IN CHAR, xestadoReporte IN VARCHAR);
    PROCEDURE DEL_REPORTE (xnumeroReporte IN CHAR);
    FUNCTION CO_REPORTES RETURN SYS_REFCURSOR;
    PROCEDURE AD_PUNTODERECOGIDA (xfechaHora IN DATE,xidViaje IN CHAR, xidRecorrido IN NUMBER, xidUbicacion IN NUMBER);
    PROCEDURE DEL_PUNTODERECOGIDA (xidPunto IN NUMBER);
    PROCEDURE AD_MULTA(xidMulta IN CHAR, xdescripcion IN VARCHAR, xfecha IN DATE, xestado IN VARCHAR, xidViaje IN CHAR);
    PROCEDURE MO_MULTA(xidMulta IN CHAR, xestado IN VARCHAR);
    PROCEDURE DEL_MULTA(xidMulta IN CHAR);
    PROCEDURE AD_UBICACION (xnombre IN VARCHAR);
    PROCEDURE AD_NOTIFICACION (xidReporte IN CHAR, XfechaNotificacion IN DATE, XmedioNotificacion IN VARCHAR);

END PK_VIAJES;
/
----------------


    

    