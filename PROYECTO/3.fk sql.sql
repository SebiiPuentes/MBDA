

ALTER TABLE Usuarios
ADD CONSTRAINT FK_Usuarios_Verificacion FOREIGN KEY (numeroVerificacion) REFERENCES Verificaciones(numeroVerificacion);

ALTER TABLE Calificaciones
ADD CONSTRAINT FK_Usuarios_Calificacion FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario);

ALTER TABLE Calificaciones
ADD CONSTRAINT FK_Viajes_Calificacion FOREIGN KEY (idViaje) REFERENCES Viajes(idViaje);

ALTER TABLE Conductores
ADD CONSTRAINT FK_Conductores_Usuarios FOREIGN KEY (idUsuarioConductor) REFERENCES Usuarios(idUsuario);

ALTER TABLE Pasajeros
ADD CONSTRAINT FK_Pasajeros_Usuarios FOREIGN KEY (idUsuarioPasajero) REFERENCES Usuarios(idUsuario);

ALTER TABLE Vehiculos 
ADD CONSTRAINT FK_Vehiculos_Conductor FOREIGN KEY (idConductor) REFERENCES Conductores(idUsuarioConductor);

ALTER TABLE Autos
ADD CONSTRAINT FK_Autos_Vehiculos FOREIGN KEY (idVehiculo) REFERENCES Vehiculos(placa);

ALTER TABLE Motos
ADD CONSTRAINT FK_Motos_Vehiculos FOREIGN KEY (idVehiculo) REFERENCES Vehiculos(placa);

ALTER TABLE Recorridos
ADD CONSTRAINT FK_Recorridos_Vehiculos FOREIGN KEY (placaVehiculo) REFERENCES Vehiculos(placa);

ALTER TABLE Horarios
ADD CONSTRAINT FK_Horarios_Recorridos FOREIGN KEY (idRecorrido) REFERENCES Recorridos(id);

ALTER TABLE PuntosDeRecogida
ADD CONSTRAINT FK_PuntosDeRecogida_Recorridos FOREIGN KEY (idRecorrido) REFERENCES Recorridos(id);

ALTER TABLE PuntosDeRecogida
ADD CONSTRAINT FK_PuntosDeRecogida_Viajes FOREIGN KEY (idViaje) REFERENCES Viajes(idViaje);

ALTER TABLE PuntosDeRecogida
ADD CONSTRAINT FK_PuntosDeRecogida_Ubicaciones FOREIGN KEY (idUbicacion) REFERENCES Ubicaciones(idUbicacion);

ALTER TABLE Viajes 
ADD CONSTRAINT FK_Viajes_Pasajeros FOREIGN KEY (idPasajero) REFERENCES Pasajeros(idUsuarioPasajero);

ALTER TABLE Viajes 
ADD CONSTRAINT FK_Viajes_Conductores FOREIGN KEY (idConductor) REFERENCES Conductores(idUsuarioConductor);

ALTER TABLE Pagos
ADD CONSTRAINT FK_Pagos_Viajes FOREIGN KEY (idViaje) REFERENCES Viajes(idViaje);

ALTER TABLE Multas
ADD CONSTRAINT FK_Multas_Viajes FOREIGN KEY (idViaje) REFERENCES Viajes(idViaje);

ALTER TABLE Reportes
ADD CONSTRAINT FK_Reportes_Viajes FOREIGN KEY (idViaje) REFERENCES Viajes(idViaje);

ALTER TABLE Notificaciones 
ADD CONSTRAINT FK_Notificaciones_Reportes FOREIGN KEY (idReporte) REFERENCES Reportes(numeroReporte);