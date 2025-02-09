
/*Declarativas*/
ALTER TABLE Usuarios
ADD CONSTRAINT CK_Usuarios_Correo CHECK (correoInstitucional LIKE '%@mail.escuelaing.edu.co');

ALTER TABLE Pagos
ADD CONSTRAINT CK_Pagos_metodoPago CHECK (metodoPago IN ('Efectivo','Transferencia'));

ALTER TABLE Pagos
ADD CONSTRAINT CK_Pagos_mestadoPago CHECK (estadoPago IN ('Pendiente','Pago'));

ALTER TABLE Pagos
ADD CONSTRAINT CK_Pagos_valorPago CHECK (valorPagar >= 0);

ALTER TABLE Notificaciones
ADD CONSTRAINT CK_Notificaciones_medioNotificacion CHECK (medioNotificacion IN ('Email','SMS'));

ALTER TABLE Verificaciones
ADD CONSTRAINT CK_Verificaciones_estado CHECK (estado IN ('Aprobado','Denegado','Pendiente'));

ALTER TABLE Multas
ADD CONSTRAINT CK_Multas_estado CHECK (estado IN ('Pendiente','Pago'));

ALTER TABLE Reportes
ADD CONSTRAINT CK_Reportes_estado CHECK (estadoReporte IN ('En Revision','Finalizado'));

ALTER TABLE Vehiculos
ADD CONSTRAINT CK_Vehiculos_estado CHECK (estado IN ('Activo','Inactivo'));

ALTER TABLE Viajes
ADD CONSTRAINT CK_Viajes_estado CHECK (estadoViaje IN ('Programado','En Progreso', 'Finalizado'));

ALTER TABLE Usuarios ADD CONSTRAINT C_USUARIOS_CALIFICACION CHECK (calificacion BETWEEN 1 and 5);

ALTER TABLE Calificaciones ADD CONSTRAINT CK_CALIFICACION CHECK (numeroCalificacion BETWEEN 1 and 5);

ALTER TABLE Usuarios ADD CONSTRAINT CK_EstadoUsuario CHECK (estadoUsuario IN ('Activo','Inactivo'));