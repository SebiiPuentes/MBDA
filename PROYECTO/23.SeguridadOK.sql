------------------PA_CONDUCTORES--------------------------
EXECUTE pa_conductores.ad_verificacion('V02','Aprobado');

EXECUTE pa_conductores.ad_usuario('USUARIO2','101109','Christian','Romero','christian.romero@mail.escuelaing.edu.co',3,'Inactivo','V02');

EXECUTE pa_conductores.mo_usuario('USUARIO2',3,'Activo');

EXECUTE pa_conductores.ad_conductor('USUARIO2','123456789104213',5,SYSDATE);

EXECUTE pa_conductores.ad_vehiculo('V4GG12',TO_DATE('2020-01-01', 'RRRR-MM-DD'),'Nissan','Negro','123456781054375',TO_DATE('2028-01-01', 'RRRR-MM-DD'),'675478653927462',TO_DATE('2027-01-01', 'RRRR-MM-DD'),'Activo',4,'USUARIO2');

SELECT  *
FROM CONDUCTORES
WHERE idUsuarioConductor = 'USUARIO2';

SELECT *
FROM VEHICULOS
WHERE placa = 'V4GG12';

------------------PA_PASAJERO-----------------------------
--AD VERIFICACION
EXECUTE pa_pasajeros.ad_verificacion('V01','Aprobado');

SELECT * 
FROM VERIFICACIONES 
WHERE numeroVerificacion = 'V01';

--AD_USUARIO
EXECUTE pa_pasajeros.ad_usuario('USUARIO1','101108','Juan','Puentes','juan.puentes@mail.escuelaing.edu.co',3,'Inactivo','V01');

SELECT * 
FROM USUARIOS 
WHERE idUsuario = 'USUARIO1';
--MO_USUARIO
EXECUTE pa_pasajeros.mo_usuario('USUARIO1',3,'Activo');

--AD_PASAJERO
EXECUTE pa_pasajeros.ad_pasajero('USUARIO1',0,SYSDATE);

SELECT * FROM PASAJEROS WHERE idUsuarioPasajero = 'USUARIO1';

--AD_VIAJE
EXECUTE PA_PASAJEROS.AD_VIAJE('VIAJE01','Bogota','Santa Fe', 'Programado', 1, 'USUARIO1','USUARIO2');

SELECT *
FROM VIAJES
WHERE idViaje = 'VIAJE01';

--AD_REPORTE

EXECUTE pa_pasajeros.ad_reporte('REPORTE01','MAL COMPORTAMIENTO DEL CONDUCTOR','En Revision','VIAJE01');

--AD_NOTIFICACION

EXECUTE pa_administradores.ad_notificacion('REPORTE01', SYSDATE,NULL);

---------ADMINISTRADOR-----------
--DEL_REPORTE
EXECUTE pa_administradores.del_reporte('REPORTE01');

-----CONDUCTOR-------------------
--AD_RECORRIDO
EXECUTE pa_conductores.ad_recorrido('GLADYS CLUB BAR','ECI','V4GG12');

SELECT *
FROM RECORRIDOS
WHERE placaVehiculo = 'V4GG12';
--AD_HORARIO
EXECUTE pa_conductores.ad_horarios('10:00','08:00', 'Lunes',4004);

-----------PASAJERO----------------
--AD_UBICACION
EXECUTE pa_pasajeros.ad_ubicacion('Gladys Club Bar');

SELECT *
FROM UBICACIONES
WHERE nombre = 'Gladys Club Bar';

EXECUTE pa_conductores.ad_ubicacion('Iglesia KRIS R');
--AD_PUNTODERECOGIDA
EXECUTE pa_pasajeros.ad_puntoderecogida(TO_DATE('2021-04-17 06:00', 'YYYY-MM-DD HH24:MI'),'123456789011232',4004,24);

--ADMINISTRADOR--

EXECUTE pa_administradores.ad_multa('MULTA01','Viaje Cancelado', SYSDATE, 'Pago','VIAJE01');

SELECT *
FROM MULTAS
WHERE idMulta = 'MULTA01';