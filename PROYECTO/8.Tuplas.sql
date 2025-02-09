
--Si el dia no es nulo  entonces la hora de llegada y salida no lo son tampoco..

ALTER TABLE Horarios
ADD CONSTRAINT CK_DIA_HORA
CHECK (dia IS NOT NULL AND horarioSalida IS NOT NULL AND horarioLlegada IS NOT NULL);

--El id del pasajero no es nulo por lo tanto el numero de Viajes es mayor o igual a 0.
ALTER TABLE Pasajeros
ADD CONSTRAINT CK_VIAJESPASAJERO
CHECK (idUsuarioPasajero IS NOT NULL AND numeroViajes >= 0);



