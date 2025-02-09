
------REPORTES------

--Si se elimina un reporte se elimina su notificacion generada.

ALTER TABLE Notificaciones DROP CONSTRAINT  FK_Notificaciones_Reportes;

ALTER TABLE Notificaciones ADD CONSTRAINT FK_reporte_notificacion
FOREIGN KEY (idReporte)REFERENCES Reportes (numeroReporte) ON DELETE CASCADE;

------VEHICULOS------

--Si se elimina el vehiculo se elimina el auto o moto segun corresponda.

ALTER TABLE Recorridos
DROP CONSTRAINT FK_RECORRIDOS_VEHICULOS;

ALTER TABLE Recorridos
ADD CONSTRAINT FK_RECORRIDOS_VEHICULOS
FOREIGN KEY (placaVehiculo)
REFERENCES Vehiculos(placa)
ON DELETE SET NULL;

-- Para Autos
ALTER TABLE Autos
DROP CONSTRAINT FK_Autos_Vehiculos;

ALTER TABLE Autos ADD CONSTRAINT fk_vehiculo_auto FOREIGN KEY (idVehiculo) REFERENCES Vehiculos (placa)
ON DELETE CASCADE;

-- Para Motos
ALTER TABLE Motos
DROP CONSTRAINT FK_Motos_Vehiculos;

ALTER TABLE Motos ADD CONSTRAINT fk_vehiculo_moto FOREIGN KEY (idVehiculo)REFERENCES Vehiculos (placa)
ON DELETE CASCADE;


