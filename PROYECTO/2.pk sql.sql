           
/*PK*/

ALTER TABLE Usuarios ADD CONSTRAINT PK_Usuarios PRIMARY KEY (idUsuario);

ALTER TABLE Pasajeros ADD CONSTRAINT PK_Pasajeros PRIMARY KEY (idUsuarioPasajero);

ALTER TABLE Conductores ADD CONSTRAINT PK_Conductores PRIMARY KEY (idUsuarioConductor);

ALTER TABLE Verificaciones ADD CONSTRAINT PK_Verificaciones PRIMARY KEY (numeroVerificacion);

ALTER TABLE Calificaciones ADD CONSTRAINT PK_Calificaciones PRIMARY KEY (idCalificacion);

ALTER TABLE Vehiculos ADD CONSTRAINT PK_Vehiculos PRIMARY KEY (placa);

ALTER TABLE Autos ADD CONSTRAINT PK_Autos PRIMARY KEY (idVehiculo);

ALTER TABLE Motos ADD CONSTRAINT PK_Motos PRIMARY KEY (idVehiculo);

ALTER TABLE Recorridos ADD CONSTRAINT PK_Recorridos PRIMARY KEY (id);

ALTER TABLE Horarios ADD CONSTRAINT PK_Horarios PRIMARY KEY (idHorario);

ALTER TABLE PuntosDeRecogida ADD CONSTRAINT PK_PuntosDeRecogida PRIMARY KEY (idPunto);

ALTER TABLE Ubicaciones ADD CONSTRAINT PK_Ubicaciones PRIMARY KEY (idUbicacion);

ALTER TABLE Viajes ADD CONSTRAINT PK_Viajes PRIMARY KEY (idViaje);

ALTER TABLE Multas ADD CONSTRAINT PK_Multas PRIMARY KEY (idMulta);

ALTER TABLE Pagos ADD CONSTRAINT PK_Pagos PRIMARY KEY (idPago);

ALTER TABLE Reportes ADD CONSTRAINT PK_Reportes PRIMARY KEY (numeroReporte);

ALTER TABLE Notificaciones ADD CONSTRAINT PK_Notificaciones PRIMARY KEY (idReporte);


