
--El id de horarios se genera automaticamente y la Hora de llegada debe ser posterior a la de salida. (2)
INSERT INTO HORARIOS (HORARIOSALIDA, HORARIOLLEGADA, DIA, IDRECORRIDO) VALUES ('07:22', '15:26', 'lunes', 4000);

-- El id de recorridos se genera automaticamente
INSERT INTO VEHICULOS (IDCONDUCTOR, PLACA, MODELO, MARCA, COLOR, SOAT, FECHASOAT, TECNOMECANICA, FECHATECNOMECANICA, ESTADO, NUMEROPUESTOS) 
VALUES ('10000000001', 'ABC123', to_date('2009-01-01', 'RRRR-MM-DD'), 'Nissan', 'Negro', '386911085388470', to_date('2025-10-05', 'RRRR-MM-DD'), '386911085388470', to_date('2025-10-05', 'RRRR-MM-DD'), 'Activo', 4);

INSERT INTO RECORRIDOS (PUNTOINICIO, PUNTOFIN, PLACAVEHICULO) 
VALUES ('Zona Petrea', 'Escuela Colombiana de Ingenieria Julio Garavito', 'ABC123');

select * from vehiculos where placa = 'ABC123';
--El id de PuntosDeRecogida se genera automaticamente.

INSERT INTO PUNTOSDERECOGIDA (FECHAHORA, IDVIAJE, IDRECORRIDO, IDUBICACION) 
VALUES (to_date('2026-08-19', 'RRRR-MM-DD'), '120000000000001', 720, 16);

-- El id de ubicaciones se genera automaticamente.

INSERT INTO UBICACIONES (NOMBRE) 
VALUES ('Centro Comercial Ciudad Gotica');

---Si el metodo de pago no se especifica entonces se asume que es efectivo.

INSERT INTO PAGOS (IDPAGO, METODOPAGO, ESTADOPAGO, VALORPAGAR, IDVIAJE) 
VALUES ('123450000000007', NULL, 'Pago', 5000, '120000000000007');

---Si el metodo de notificacion no se especifica se asume que es email.
INSERT INTO REPORTES (NUMEROREPORTE, DESCRIPCION, ESTADOREPORTE, IDVIAJE) 
VALUES ('1234500001', 'Robo', 'Finalizado', '120000000001026');

INSERT INTO NOTIFICACIONES VALUES (SYSDATE,NULL,'1234500001');

-----Si la fecha de la tecnomecanica o el soat es menor a la fecha actual entonces el estado del vehiculo es Inactivo.
INSERT INTO VEHICULOS (IDCONDUCTOR, PLACA, MODELO, MARCA, COLOR, SOAT, FECHASOAT, TECNOMECANICA, FECHATECNOMECANICA, ESTADO, NUMEROPUESTOS) 
VALUES ('10000001925', 'ABD123', to_date('2002-01-01', 'RRRR-MM-DD'), 'Suzuki', 'Verde', '143465968462862', to_date('2023-04-20', 'RRRR-MM-DD'), '143465968462862', to_date('2023-04-20', 'RRRR-MM-DD'), 'Activo', 1);

SELECT *
FROM VEHICULOS
WHERE PLACA = 'ABD123';

---Si el estado de un usuario es Inactivo entonces no puede solicitar un viaje.
UPDATE USUARIOS SET estadoUsuario = 'Inactivo' WHERE idUsuario = '10000004000';

INSERT INTO VIAJES (IDVIAJE, CIUDAD, PARADAPASAJERO, ESTADOVIAJE, IDPASAJERO, IDCONDUCTOR, CAPACIDAD) 
VALUES ('124354000000001', 'Bogotá', 'Puente Boyacá con 80', 'Programado', '10000004000', '10000000001', 0);

---Solo se puede modificar el soat,fechaSoat,tecnomecanica,fechaTecnomecanica
UPDATE VEHICULOS SET soat = '143465968462111' WHERE placa = 'ABD123';
