
--No se puede modificar los atributos si no es el soat, fechaSoat,tecnomecanica, fechaTecnomecanica.
EXECUTE PK_VEHICULOS.mo_vehiculo('Negro');

--Se eliminan vehiculos que no existen
EXECUTE PK_VEHICULOS.del_vehiculo('123ABZ');

SELECT * 
FROM VEHICULOS
WHERE placa = '123ABZ' ;

--No se puede eliminar porque tiene un viaje asociado.
EXECUTE pk_usuarios.del_conductor('10000001923');

--No se puede modificar el horario y que la hora de salida de mayor a la hora de llegada.
SELECT * 
FROM HORARIOS 
WHERE idHorario = 3;

EXECUTE pk_horarios.mo_horarios(3,'13:32','7:00');

--Si en la actualizacion la calicacion del usuario no esta entre 1 y 5, lanza error.
SELECT * 
FROM USUARIOS;

EXECUTE pk_usuarios.mo_usuario('10000003950',6,'Activo');

--Si se actualiza la fecha del soat y fecha de la tecnomecanica y estas son menores a la fecha actual,error.
SELECT * 
FROM VEHICULOS;

EXECUTE pk_vehiculos.mo_vehiculo('OZJ12Y','227482769629102',to_date('2020-01-01', 'RRRR-MM-DD'),'227482769629102',to_date('2026-01-01', 'RRRR-MM-DD'),'Activo');

--Se eliminan pagos que no existen
SELECT * 
FROM PAGOS
WHERE idPago = '123456789';

EXECUTE PK_VIAJES.del_pago('123456789');

--
