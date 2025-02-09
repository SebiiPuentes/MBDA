

INSERT INTO Verificaciones VALUES ('123','Aprobado');

INSERT INTO Verificaciones VALUES ('234','Aprobado');

INSERT INTO Usuarios VALUES ('1234', '1011084070', 'Michele', 'Moss', 'michele.moss@mail.escuelaing.edu.co',3, 'Activo','123');
INSERT INTO Usuarios VALUES ('4567', '1011084078', 'Tulio', 'Golf', 'tulio.golf@mail.escuelaing.edu.co',3, 'Activo','234');

--El id del pasajero no es nulo por lo tanto el numero de Viajes es mayor o igual a 0.
INSERT INTO Pasajeros VALUES ('1234',1,to_date('2024-07-03', 'RRRR-MM-DD'));

----Si el dia no es nulo  entonces la hora de llegada y salida no lo son tampoco..
INSERT INTO CONDUCTORES (IDUSUARIOCONDUCTOR, NUMEROLICENCIA, FECHAREGISTRO) 
VALUES ('4567', '719104224705532', to_date('2024-11-19', 'RRRR-MM-DD'));

INSERT INTO VEHICULOS VALUES ( 'ACB123', to_date('2002-01-01', 'RRRR-MM-DD'), 'Suzuki', 'Verde', '143465968462862', to_date('2025-04-20', 'RRRR-MM-DD'), '143465968462862', to_date('2025-04-20', 'RRRR-MM-DD'), 'Activo', 1,'4567');
INSERT INTO Recorridos VALUES (NULL,'Zona H', 'Escuela Colombiana de Ingenieria Julio Garavito', 'ABC123');

INSERT INTO Horarios (HORARIOSALIDA, HORARIOLLEGADA, DIA, IDRECORRIDO) VALUES ('07:22', '15:26', 'lunes', 4001);