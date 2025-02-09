INSERT INTO Verificaciones VALUES ('1010','Aprobado');

INSERT INTO Verificaciones VALUES ('1111','Aprobado');

INSERT INTO Usuarios VALUES ('101010', '1011084071', 'Mi', 'Moss', 'mi.moss@mail.escuelaing.edu.co',3, 'Activo','1010');
INSERT INTO Usuarios VALUES ('111111', '1011084072', 'Tu', 'Golf', 'tu.golf@mail.escuelaing.edu.co',3, 'Activo','1111');

--El id del pasajero no es nulo por lo tanto el numero de Viajes es mayor o igual a 0.
INSERT INTO Pasajeros VALUES ('101010',-1,to_date('2024-07-03', 'RRRR-MM-DD'));


----Si el dia no es nulo  entonces la hora de llegada y salida no lo son tampoco..
INSERT INTO Horarios (HORARIOSALIDA, HORARIOLLEGADA, DIA, IDRECORRIDO) VALUES ('07:22', '15:26', NULL, 4002);