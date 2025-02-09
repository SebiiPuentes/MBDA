------REPORTES------
--Si se elimina el reporte se elimina su notificacion asociada.
DELETE FROM REPORTES WHERE numeroReporte = '0000000943';

SELECT *
FROM NOTIFICACIONES
WHERE idReporte = '0000000943';

------VEHICULOS-----
--Si se elimina un vehiculo se en moto o auto segun corresponda.
DELETE FROM VEHICULOS WHERE placa ='DWG71K';

SELECT *
FROM MOTOS
WHERE idVehiculo = 'DWG71K';