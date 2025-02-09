INSERT INTO Verificaciones VALUES ('00000000001','Aprobado');
INSERT INTO Verificaciones VALUES ('00000000002','Aprobado');

--El correo debe ser @mail.escuelaing.edu.co
INSERT INTO Usuarios (idUsuario, cedula, nombre, apellido, correoInstitucional, calificacion, estadoUsuario, numeroVerificacion) 
VALUES ('11230000001', '12345678901', 'Juan', 'Pérez', 'juan.perez@correo.com', 4.5, 'Activo', '00000000001');  

--El estado del Usuario es Activo o Inactivo
INSERT INTO Usuarios (idUsuario, cedula, nombre, apellido, correoInstitucional, calificacion, estadoUsuario, numeroVerificacion) 
VALUES ('11230000001', '98765432101', 'Ana', 'Gómez', 'ana.gomez@correo.com', 4.8, 'Ocupado', '00000000002'); 

--El Valor del pago debe ser mayor o igual a 0.
INSERT INTO PAGOS (IDPAGO, METODOPAGO, ESTADOPAGO, VALORPAGAR, IDVIAJE) 
VALUES ('123400000000009', 'Efectivo', 'Pago', -2, '120000000000009');

--El metodoPago debe ser Efectivo o Transferencia.
INSERT INTO PAGOS (IDPAGO, METODOPAGO, ESTADOPAGO, VALORPAGAR, IDVIAJE) 
VALUES ('123400000000009', 'Tarjeta', 'Pago', 2000, '120000000000009');

--El numero de calificacion es entre 1 y 5.
INSERT INTO CALIFICACIONES (IDCALIFICACION, NUMEROCALIFICACION, DESCRIPCION, IDUSUARIO, IDVIAJE) 
VALUES ('0420009304', 6, 'descripcion del viaje', '10000000001', '120000000000001');

--El metodo de Notificacion es 'Email' o SMS.
INSERT INTO NOTIFICACIONES
VALUES (to_date('2024-01-07', 'RRRR-MM-DD'),'Llamada','0232100002');

--El estado de la verificacion es Aprobado, Pendiente Y Denegado.
INSERT INTO VERIFICACIONES (NUMEROVERIFICACION, ESTADO) 
VALUES ('SH5PH2222', 'Expulsado');

--El estado de la multa es Pendiente o Pago
INSERT INTO MULTAS (IDMULTA, DESCRIPCION, FECHA, ESTADO, IDVIAJE) 
VALUES ('00000243176', 'multa por mal comportamiento', to_date('2024-02-18', 'RRRR-MM-DD'), 'Cheque', '120000000000571');
