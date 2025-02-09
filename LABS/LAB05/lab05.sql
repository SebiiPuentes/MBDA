
CREATE TABLE Demandas(
             idusuario CHAR(5)NOT NULL, 
             numero NUMBER NOT NULL, 
             fecha DATE NOT NULL, 
             tipoVivienda VARCHAR(25) NOT NULL, 
             maxCompra NUMBER NOT NULL);
             
CREATE TABLE Avisos(
             numeroDemanda NUMBER NOT NULL, 
             idAviso CHAR(5) NOT NULL, 
             fechaCreacion DATE NOT NULL, 
             mensaje VARCHAR(50) NOT NULL, 
             destinatario VARCHAR(25) NOT NULL);
             
CREATE TABLE OrigenFondos(
             numeroDemanda NUMBER NOT NULL, 
             valor NUMBER NOT NULL, 
             credito VARCHAR(15) NOT NULL, 
             estaAprobado VARCHAR(25));
             
CREATE TABLE InteresEn(
             codigoUbicacion CHAR(11) NOT NULL, 
             numeroDemanda NUMBER NOT NULL ,
             nivel VARCHAR(25) NOT NULL );

/*oferta*/
CREATE TABLE Ofertas(
            codigoUbicacion CHAR(11) NOT NULL, 
            numero NUMBER NOT NULL,
            fecha DATE NOT NULL,
            direccion VARCHAR(50) NOT NULL,
            tipoVivienda VARCHAR(25) NOT NULL,
            costo NUMBER NOT NULL,
            anexos VARCHAR(25) NULL,
            estado VARCHAR(25) NOT NULL,
            idusuario CHAR(5)NOT NULL);
            
CREATE TABLE Fotografias(
             nombre VARCHAR(15) NOT NULL, 
             ruta VARCHAR(100) NOT NULL, 
             descripcion VARCHAR(100) NOT NULL);
             
CREATE TABLE PermiteFotografias(
             numeroOferta NUMBER NOT NULL,
             nombreFotografia VARCHAR(15) NOT NULL);
             
CREATE TABLE OpcionesCreditos(
             plazo NUMBER NOT NULL,
             valorMensual NUMBER NOT NULL,
             numeroOferta NUMBER NOT NULL);

CREATE TABLE Ubicaciones(
             codigo CHAR(11) NOT NULL,
             latitud NUMBER NOT NULL ,
             longitud NUMBER NOT NULL,
             ciudad VARCHAR(10) NOT NULL,
             zona VARCHAR(25) NOT NULL ,
             barrio VARCHAR(10) NOT NULL);
CREATE TABLE Notificaciones(
             idNotificaciones CHAR(5) NOT NULL,
             estadoNotificacion VARCHAR(25) NOT NULL);
             
CREATE TABLE Alertas(
             idAlertas CHAR(5) NOT NULL,
             estadoAlertas VARCHAR(25) NOT NULL,
             datosImportantes VARCHAR(45) NOT NULL,
             hora VARCHAR(7) NOT NULL);

/*LAB05*/
CREATE TABLE Usuarios(
             id CHAR(5) PRIMARY KEY, 
             fechaRegistro DATE NOT NULL, 
             correoElectronico VARCHAR(50) NOT NULL);
             
CREATE TABLE numerosContactos(
             numeroContacto CHAR(12) PRIMARY KEY,
             idusuario CHAR(5) NOT NULL);
             
CREATE TABLE PersonaNaturales(
             tipoDocumento VARCHAR(25) NOT NULL, 
             numeroDocumento VARCHAR(25) NOT NULL, 
             nombres VARCHAR(50) NOT NULL, 
             nacionalidad VARCHAR(10) NOT NULL, 
             idusuario CHAR(5) PRIMARY KEY );
             
CREATE TABLE Empresas(
             nit CHAR(10), 
             razonSocial VARCHAR(100) NOT NULL, 
             idusuario CHAR(5)NOT NULL PRIMARY KEY);

/*PK*/

ALTER TABLE Demandas
ADD CONSTRAINT PK_Demandas PRIMARY KEY (numero);

ALTER TABLE Avisos
ADD CONSTRAINT PK_Avisos PRIMARY KEY (idAviso);

ALTER TABLE OrigenFondos
ADD CONSTRAINT PK_OrigenFondos PRIMARY KEY (numeroDemanda);

ALTER TABLE Ofertas
ADD CONSTRAINT PK_Ofertas PRIMARY KEY (numero);

ALTER TABLE Fotografias
ADD CONSTRAINT PK_Fotografias PRIMARY KEY (nombre);

ALTER TABLE Alertas 
ADD CONSTRAINT PF_Alertas PRIMARY KEY (idAlertas);

ALTER TABLE Notificaciones
ADD CONSTRAINT PK_Notificacion PRIMARY KEY (idNotificaciones);

ALTER TABLE PermiteFotografias
ADD CONSTRAINT PK_PermiteFotografias PRIMARY KEY (numeroOferta, nombreFotografia);

ALTER TABLE OpcionesCreditos
ADD CONSTRAINT PK_OpcionesCreditos PRIMARY KEY (numeroOferta);

ALTER TABLE Ubicaciones
ADD CONSTRAINT PK_Ubicaciones PRIMARY KEY (codigo);

ALTER TABLE InteresEn ADD CONSTRAINT PK_InteresEn PRIMARY KEY (codigoUbicacion, numeroDemanda);
             
/*FK*/           
ALTER TABLE numerosContactos
ADD CONSTRAINT FK_numerosContacto_Usuarios FOREIGN KEY (idusuario) REFERENCES Usuarios(id);

ALTER TABLE PersonaNaturales
ADD CONSTRAINT FK_PersonaNaturales_Usuarios FOREIGN KEY (idusuario)
REFERENCES Usuarios(id);

ALTER TABLE Empresas
ADD CONSTRAINT FK_Empresas_Usuarios FOREIGN KEY (idusuario)
REFERENCES Usuarios(id);

-----

ALTER TABLE Demandas
ADD CONSTRAINT FK_Demandas_Usuarios FOREIGN KEY (idusuario)
REFERENCES Usuarios(id);

ALTER TABLE Avisos
ADD CONSTRAINT FK_Avisos_Demandas FOREIGN KEY (numeroDemanda)
REFERENCES Demandas(numero);

ALTER TABLE OrigenFondos
ADD CONSTRAINT FK_OrigenFondos_Demandas FOREIGN KEY (numeroDemanda)
REFERENCES Demandas(numero);

ALTER TABLE InteresEn
ADD CONSTRAINT FK_InteresEn_Ubicaciones FOREIGN KEY (codigoUbicacion)
REFERENCES Ubicaciones(codigo);

ALTER TABLE InteresEn
ADD CONSTRAINT FK_InteresEn_Demandas FOREIGN KEY (numeroDemanda)
REFERENCES Demandas(numero);

ALTER TABLE Ofertas
ADD CONSTRAINT FK_Ofertas_Ubicaciones FOREIGN KEY (codigoUbicacion)
REFERENCES Ubicaciones(codigo);

ALTER TABLE Ofertas
ADD CONSTRAINT FK_Ofertas_Usuarios FOREIGN KEY (idusuario)
REFERENCES Usuarios(id);

ALTER TABLE PermiteFotografias
ADD CONSTRAINT FK_PermiteFotografias_Ofertas FOREIGN KEY (numeroOferta)
REFERENCES Ofertas(numero);

ALTER TABLE PermiteFotografias
ADD CONSTRAINT FK_PermiteFotografias_Fotografias FOREIGN KEY (nombreFotografia)
REFERENCES Fotografias(nombre);

ALTER TABLE OpcionesCreditos
ADD CONSTRAINT FK_OpcionesCreditos_Ofertas FOREIGN KEY (numeroOferta)
REFERENCES Ofertas(numero);

ALTER TABLE Alertas
ADD CONSTRAINT FK_Alertas_Avisos FOREIGN KEY (idAlertas)
REFERENCES Avisos(idAviso);

ALTER TABLE Notificaciones
ADD CONSTRAINT FK_Notificaciones_Avisos FOREIGN KEY (idNotificaciones)
REFERENCES Avisos(idAviso);

/*UK*/
ALTER TABLE PersonaNaturales
ADD CONSTRAINT Uk_PersonaNaturales UNIQUE (tipoDocumento, numeroDocumento);

ALTER TABLE Empresas
ADD CONSTRAINT Uk_Empresas_Nit UNIQUE (nit);

/*Atributos*/

ALTER TABLE Usuarios
ADD CONSTRAINT CK_Usuarios_Correo CHECK (correoElectronico LIKE '%@%');

ALTER TABLE Demandas
ADD CONSTRAINT CK_Demandas_MaxCompra CHECK (maxCompra > 0);

/*ACCIONES*/

ALTER TABLE PermiteFotografias
ADD CONSTRAINT fk_ofertas_PermiteFotografias
FOREIGN KEY (numeroOferta) REFERENCES Ofertas (numero)
ON DELETE CASCADE;

ALTER TABLE OpcionesCreditos
ADD CONSTRAINT fk_ofertas_OpcionesCredito
FOREIGN KEY (numeroOferta) REFERENCES Ofertas (numero)
ON DELETE CASCADE;


/*PoblarOK*/
INSERT INTO Usuarios VALUES ('10001',TO_DATE('28-SEP-2024 20:55:00', 'DD-MON-YYYY HH24:MI:SS'),'usuario01@gmail.com');
INSERT INTO Usuarios VALUES ('10002',TO_DATE('04-FEB-2024 18:05:00', 'DD-MON-YYYY HH24:MI:SS'),'usuario02@gmail.com');
INSERT INTO Usuarios VALUES ('10003',TO_DATE('13-OCT-2024 10:13:00', 'DD-MON-YYYY HH24:MI:SS'),'usuario03@gmail.com');

INSERT INTO PersonaNaturales VALUES ('Cedula', '1234567', 'Juan', 'Colombiana','10001');
INSERT INTO PersonaNaturales VALUES ('Cedula', '7654321', 'Maria', 'Mexicana','10002');
INSERT INTO PersonaNaturales VALUES ('Cedula', '9876543', 'Pedro', 'Argentino','10003');

INSERT INTO Empresas VALUES ('95687568-3','Empresa Publica de Telecomunicaciones de Colombia S.A.','10001');
INSERT INTO Empresas VALUES ('12374471-2','Comercial Mexicana de Pinturas S.A. de C.V.','10002');
INSERT INTO Empresas VALUES ('28145672-5','Aerolineas Argentinas S.A.','10003');

INSERT INTO Demandas VALUES ('10001',11,TO_DATE('2024/09/22','yyyy/mm/dd'),'Bodega',400000000);
INSERT INTO Demandas VALUES ('10001',12,TO_DATE('2024/04/12','yyyy/mm/dd'),'Apartamento',1005690);
INSERT INTO Demandas VALUES ('10003',13,TO_DATE('2024/06/04','yyyy/mm/dd'),'Casa',20000000);

INSERT INTO Avisos VALUES (80,'14785',TO_DATE('2024/08/11','yyyy/mm/dd'),'Recibi una notificacion...','Administradordelnegocio');
INSERT INTO Avisos VALUES (81,'96325',TO_DATE('2024/07/14','yyyy/mm/dd'),'Estoy buscando asesoria legal ...','Dueñodelainformacion');
INSERT INTO Avisos VALUES (82,'25897',TO_DATE('2024/12/02','yyyy/mm/dd'),'Le escribo para informarle...','Dueñodelainformacion');

INSERT INTO OrigenFondos VALUES (11, 300000000, 'CreditoH', 'Aprobado');
INSERT INTO OrigenFondos VALUES (12, 800000, 'CreditoP',null);
INSERT INTO OrigenFondos VALUES (13, 15000000, 'Ahorro', 'Pendiente');

INSERT INTO InteresEn VALUES ('98765432100', 67, 'Alto');
INSERT INTO InteresEn VALUES ('12345678900', 68, 'Medio');
INSERT INTO InteresEn VALUES ('09876543211', 69, 'Bajo');

INSERT INTO Ofertas VALUES ('98765432100', 1, TO_DATE('2024/09/25', 'yyyy/mm/dd'), 'Calle 123 #45-67', 'Bodega', 450000000, NULL, 'Pendiente', '10001');
INSERT INTO Ofertas VALUES ('12345678900', 2, TO_DATE('2024/03/15', 'yyyy/mm/dd'), 'Avenida 789 #12-34', 'Apartamento', 1200000, 'Contrato.pdf', 'Aceptada', '10001');
INSERT INTO Ofertas VALUES ('09876543211', 3, TO_DATE('2024/07/30', 'yyyy/mm/dd'), 'Calle 567 #89-90', 'Casa', 25000000, 'Fotos.zip', 'Rechazada', '10003');

INSERT INTO Fotografias VALUES ('Foto1', '/imagenes/foto1.jpg', 'Vista frontal de la propiedad');
INSERT INTO Fotografias VALUES ('Foto2', '/imagenes/foto2.jpg', 'Vista interior del apartamento');
INSERT INTO Fotografias VALUES ('Foto3', '/imagenes/foto3.jpg', 'Vista panorï¿½mica del barrio');

INSERT INTO PermiteFotografias VALUES (110, 'Foto1');
INSERT INTO PermiteFotografias VALUES (111, 'Foto2');
INSERT INTO PermiteFotografias VALUES (112, 'Foto3');

INSERT INTO OpcionesCreditos VALUES (20, 15000000, 110);
INSERT INTO OpcionesCreditos VALUES (15, 1000000, 111);
INSERT INTO OpcionesCreditos VALUES (30, 500000, 1112);

INSERT INTO Ubicaciones VALUES ('98765432100', -74, 485, 'Bogota', 'Norte', 'Chapinero');
INSERT INTO Ubicaciones VALUES ('12345678900', -98, 197, 'Mexico', 'Centro', 'Lomas');
INSERT INTO Ubicaciones VALUES ('09876543211', -545, -387, 'BuenoAire', 'Sur', 'Palermo');

/*PoblarNoOK*/
INSERT INTO Demandas VALUES ('99999', '12345', TO_DATE('2024/09/01', 'yyyy/mm/dd'), 'Casa', 500000000); /*El id del usuario no existe en usuarios*/
INSERT INTO OrigenFondos VALUES ('12345', 'cien mil', 'CreditoH', 'Aprobado');/*Para la segunda casilla corresponde aun valor tipo entero, no de cadena*/
INSERT INTO Usuarios VALUES ('10004', TO_DATE('2024/10/01', 'yyyy/mm/dd'), NULL, '3125555555');/*Coloca un Null en columna definifa como no null*/


INSERT INTO Usuarios VALUES ('10005', TO_DATE('2024/09/30', 'yyyy/mm/dd'), 'usuario05gmail.com', '3125555555');/*Recibe correos sin @*/
INSERT INTO Demandas VALUES ('10001', '98766', TO_DATE('2024/09/29', 'yyyy/mm/dd'), 'Casa', -50000000);/*el valos maximo de la compra es negativo*/
INSERT INTO PersonaNaturales VALUES ('Cedula', '1234567', 'Carlos', 'Colombiana', '10004'); /*Ingrsan 2 personas distintas con el mismo numero de cedula*/
INSERT INTO PersonaNaturales VALUES ('Cedula', '1234567', 'Luis', 'Colombiana', '10005');

/*nuevas inserciones punto F*/

INSERT INTO Usuarios VALUES ('U0001', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'usuario1@mail.com');
INSERT INTO Usuarios VALUES ('U0002', TO_DATE('2023-02-01', 'YYYY-MM-DD'), 'usuario2@mail.com');
INSERT INTO Usuarios VALUES ('U0003', TO_DATE('2023-03-01', 'YYYY-MM-DD'), 'usuario3@mail.com');
INSERT INTO Usuarios VALUES ('U0004', TO_DATE('2023-04-01', 'YYYY-MM-DD'), 'usuario4@mail.com');
INSERT INTO Usuarios VALUES ('U0005', TO_DATE('2023-05-01', 'YYYY-MM-DD'), 'usuario5@mail.com');
INSERT INTO Usuarios VALUES ('U0006', TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'usuario6@mail.com');
INSERT INTO Usuarios VALUES ('U0007', TO_DATE('2023-07-01', 'YYYY-MM-DD'), 'usuario7@mail.com');
INSERT INTO Usuarios VALUES ('U0008', TO_DATE('2023-08-01', 'YYYY-MM-DD'), 'usuario8@mail.com');
INSERT INTO Usuarios VALUES ('U0009', TO_DATE('2023-09-01', 'YYYY-MM-DD'), 'usuario9@mail.com');
INSERT INTO Usuarios VALUES ('U0010', TO_DATE('2023-10-01', 'YYYY-MM-DD'), 'usuario10@mail.com');

INSERT INTO PersonaNaturales VALUES ('Cedula', '123456789', 'Juan', 'Colombia', 'U0001');
INSERT INTO PersonaNaturales VALUES ('Cedula', '987654321', 'Carlos', 'Colombia', 'U0002');
INSERT INTO PersonaNaturales VALUES ('Cedula', '456789123', 'Luis', 'Colombia', 'U0003');
INSERT INTO PersonaNaturales VALUES ('Cedula', '321654987', 'Ana', 'Colombia', 'U0004');
INSERT INTO PersonaNaturales VALUES ('Cedula', '159753486', 'Marta', 'Colombia', 'U0005');
INSERT INTO PersonaNaturales VALUES ('Cedula', '753951852', 'Jose', 'Colombia', 'U0006');
INSERT INTO PersonaNaturales VALUES ('Cedula', '852963741', 'Maria', 'Colombia', 'U0007');
INSERT INTO PersonaNaturales VALUES ('Cedula', '951753258', 'Pedro', 'Colombia', 'U0008');
INSERT INTO PersonaNaturales VALUES ('Cedula', '654789321', 'Laura', 'Colombia', 'U0009');
INSERT INTO PersonaNaturales VALUES ('Cedula', '987321654', 'Sofia', 'Colombia', 'U0010');

INSERT INTO Empresas VALUES ('9001234567', 'Empresa1 S.A.S.', 'U0001');
INSERT INTO Empresas VALUES ('9002234567', 'Empresa2 S.A.S.', 'U0002');
INSERT INTO Empresas VALUES ('9003234567', 'Empresa3 S.A.S.', 'U0003');
INSERT INTO Empresas VALUES ('9004234567', 'Empresa4 S.A.S.', 'U0004');
INSERT INTO Empresas VALUES ('9005234567', 'Empresa5 S.A.S.', 'U0005');
INSERT INTO Empresas VALUES ('9006234567', 'Empresa6 S.A.S.', 'U0006');
INSERT INTO Empresas VALUES ('9007234567', 'Empresa7 S.A.S.', 'U0007');
INSERT INTO Empresas VALUES ('9008234567', 'Empresa8 S.A.S.', 'U0008');
INSERT INTO Empresas VALUES ('9009234567', 'Empresa9 S.A.S.', 'U0009');
INSERT INTO Empresas VALUES ('9000234567', 'Empresa10 S.A.S.', 'U0010');

INSERT INTO Demandas VALUES ('U0001', 1, TO_DATE('2023-01-10', 'YYYY-MM-DD'), 'Casa', 50000000);
INSERT INTO Demandas VALUES ('U0002', 2, TO_DATE('2023-02-10', 'YYYY-MM-DD'), 'Apartamento', 60000000);
INSERT INTO Demandas VALUES ('U0003', 3, TO_DATE('2023-03-10', 'YYYY-MM-DD'), 'Casa', 70000000);
INSERT INTO Demandas VALUES ('U0004', 4, TO_DATE('2023-04-10', 'YYYY-MM-DD'), 'Apartamento', 80000000);
INSERT INTO Demandas VALUES ('U0005', 5, TO_DATE('2023-05-10', 'YYYY-MM-DD'), 'Casa', 90000000);
INSERT INTO Demandas VALUES ('U0006', 6, TO_DATE('2023-06-10', 'YYYY-MM-DD'), 'Apartamento', 100000000);
INSERT INTO Demandas VALUES ('U0007', 7, TO_DATE('2023-07-10', 'YYYY-MM-DD'), 'Casa', 110000000);
INSERT INTO Demandas VALUES ('U0008', 8, TO_DATE('2023-08-10', 'YYYY-MM-DD'), 'Apartamento', 120000000);
INSERT INTO Demandas VALUES ('U0009', 9, TO_DATE('2023-09-10', 'YYYY-MM-DD'), 'Casa', 130000000);
INSERT INTO Demandas VALUES ('U0010', 10, TO_DATE('2023-10-10', 'YYYY-MM-DD'), 'Apartamento', 140000000);


INSERT INTO Avisos VALUES (70, 'A0001',  TO_DATE('2023-01-11', 'YYYY-MM-DD'), 'Mensaje 1',  'Juan');
INSERT INTO Avisos VALUES (71, 'A0002',  TO_DATE('2023-02-11', 'YYYY-MM-DD'), 'Mensaje 2','Carlos');
INSERT INTO Avisos VALUES (72, 'A0003',  TO_DATE('2023-03-11', 'YYYY-MM-DD'), 'Mensaje 3', 'Luis');
INSERT INTO Avisos VALUES (73, 'A0004',  TO_DATE('2023-04-11', 'YYYY-MM-DD'), 'Mensaje 4',  'Ana');
INSERT INTO Avisos VALUES (74, 'A0005',  TO_DATE('2023-05-11', 'YYYY-MM-DD'), 'Mensaje 5',  'Marta');
INSERT INTO Avisos VALUES (75, 'A0006',  TO_DATE('2023-06-11', 'YYYY-MM-DD'), 'Mensaje 6',  'Jose');
INSERT INTO Avisos VALUES (76, 'A0007',  TO_DATE('2023-07-11', 'YYYY-MM-DD'), 'Mensaje 7',  'Maria');
INSERT INTO Avisos VALUES (77, 'A0008',  TO_DATE('2023-08-11', 'YYYY-MM-DD'), 'Mensaje 8', 'Pedro');
INSERT INTO Avisos VALUES (78, 'A0009',  TO_DATE('2023-09-11', 'YYYY-MM-DD'), 'Mensaje 9','Laura');
INSERT INTO Avisos VALUES (79, 'A0010',  TO_DATE('2023-10-11', 'YYYY-MM-DD'), 'Mensaje 10',  'Sofia');

INSERT INTO OrigenFondos VALUES (70, 30000000, 'CreditpBancario', 'Si');
INSERT INTO OrigenFondos VALUES (71, 40000000, 'Ahorros', 'No');
INSERT INTO OrigenFondos VALUES (72, 50000000, 'PrestFamiliar', 'Si');
INSERT INTO OrigenFondos VALUES (73, 60000000, 'CHipotecario', 'Si');
INSERT INTO OrigenFondos VALUES (74, 70000000, 'Ahorros', 'No');
INSERT INTO OrigenFondos VALUES (75, 80000000, 'CreditoBancario', 'Si');
INSERT INTO OrigenFondos VALUES (76, 90000000, 'PrestFamiliar', 'Si');
INSERT INTO OrigenFondos VALUES (77, 100000000, 'Ahorros', 'No');
INSERT INTO OrigenFondos VALUES (78, 110000000, 'CHipotecario', 'Si');
INSERT INTO OrigenFondos VALUES (79, 120000000, 'CreditoBancario', 'No');

INSERT INTO Ubicaciones VALUES ('LOC00000001', 100, 200, 'Bogota', 'Norte', 'Usaquen');
INSERT INTO Ubicaciones VALUES ('LOC00000002', 101, 201, 'Bogota', 'Sur', 'Kennedy');
INSERT INTO Ubicaciones VALUES ('LOC00000003', 102, 202, 'Medellin', 'Centro', 'Laureles');
INSERT INTO Ubicaciones VALUES ('LOC00000004', 103, 203, 'Medellin', 'Norte', 'Bello');
INSERT INTO Ubicaciones VALUES ('LOC00000005', 104, 204, 'Cali', 'Sur', 'SanFerd');
INSERT INTO Ubicaciones VALUES ('LOC00000006', 105, 205, 'Cali', 'Norte', 'SantaMar');
INSERT INTO Ubicaciones VALUES ('LOC00000007', 106, 206, 'Honda', 'Centro', 'Alto Prado');
INSERT INTO Ubicaciones VALUES ('LOC00000008', 107, 207, 'Cartagena', 'Centro', 'Getsemani');
INSERT INTO Ubicaciones VALUES ('LOC00000009', 108, 208, 'Bogota', 'Oeste', 'Suba');
INSERT INTO Ubicaciones VALUES ('LOC00000010', 109, 209, 'Medellin', 'Este', 'Envigado');


INSERT INTO InteresEn VALUES ('LOC00000001', 70, 'Alta');
INSERT INTO InteresEn VALUES ('LOC00000002', 71, 'Media');
INSERT INTO InteresEn VALUES ('LOC00000003', 72, 'Alta');
INSERT INTO InteresEn VALUES ('LOC00000004', 73, 'Baja');
INSERT INTO InteresEn VALUES ('LOC00000005', 74, 'Media');
INSERT INTO InteresEn VALUES ('LOC00000006', 75, 'Alta');
INSERT INTO InteresEn VALUES ('LOC00000007', 76, 'Baja');
INSERT INTO InteresEn VALUES ('LOC00000008', 77, 'Media');
INSERT INTO InteresEn VALUES ('LOC00000009', 78, 'Alta');
INSERT INTO InteresEn VALUES ('LOC00000010', 79, 'Baja');

INSERT INTO Ofertas VALUES ('LOC00000001', 1, TO_DATE('2023-01-20', 'YYYY-MM-DD'), 'Calle 123', 'Casa', 100000000, NULL, 'Activo', 'U0001');
INSERT INTO Ofertas VALUES ('LOC00000002', 2, TO_DATE('2023-02-20', 'YYYY-MM-DD'), 'Carrera 45', 'Apartamento', 150000000, NULL, 'Activo', 'U0002');
INSERT INTO Ofertas VALUES ('LOC00000003', 3, TO_DATE('2023-03-20', 'YYYY-MM-DD'), 'Calle 123', 'Casa', 200000000, 'PDF1', 'Activo', 'U0003');
INSERT INTO Ofertas VALUES ('LOC00000004', 4, TO_DATE('2023-04-20', 'YYYY-MM-DD'), 'Carrera 45', 'Apartamento', 250000000, NULL, 'Activo', 'U0004');
INSERT INTO Ofertas VALUES ('LOC00000005', 5, TO_DATE('2023-05-20', 'YYYY-MM-DD'), 'Calle 123', 'Casa', 300000000, NULL, 'Activo', 'U0005');
INSERT INTO Ofertas VALUES ('LOC00000006', 6, TO_DATE('2023-06-20', 'YYYY-MM-DD'), 'Carrera 45', 'Apartamento', 350000000, NULL, 'Activo', 'U0006');
INSERT INTO Ofertas VALUES ('LOC00000007', 7, TO_DATE('2023-07-20', 'YYYY-MM-DD'), 'Calle 123', 'Casa', 400000000, 'PDF2', 'Activo', 'U0007');
INSERT INTO Ofertas VALUES ('LOC00000008', 8, TO_DATE('2023-08-20', 'YYYY-MM-DD'), 'Carrera 45', 'Apartamento', 450000000, 'PDF3', 'Activo', 'U0008');
INSERT INTO Ofertas VALUES ('LOC00000009', 9, TO_DATE('2023-09-20', 'YYYY-MM-DD'), 'Calle 123', 'Casa', 500000000, NULL, 'Activo', 'U0009');
INSERT INTO Ofertas VALUES ('LOC00000010', 10, TO_DATE('2023-10-20', 'YYYY-MM-DD'), 'Carrera 45', 'Apartamento', 550000000, 'PDF4', 'Activo', 'U0010');

INSERT INTO Fotografias VALUES ('Foto1', '/ruta/foto1.jpg', 'Fotodelacasa');
INSERT INTO Fotografias VALUES ('Foto2', '/ruta/foto2.jpg', 'Fotodelapartamento');
INSERT INTO Fotografias VALUES ('Foto3', '/ruta/foto3.jpg', 'Fotodelexterior');
INSERT INTO Fotografias VALUES ('Foto4', '/ruta/foto4.jpg', 'Fotodelasala');
INSERT INTO Fotografias VALUES ('Foto5', '/ruta/foto5.jpg', 'Fotodelcomedor');
INSERT INTO Fotografias VALUES ('Foto6', '/ruta/foto6.jpg', 'Fotodelacocina');
INSERT INTO Fotografias VALUES ('Foto7', '/ruta/foto7.jpg', 'Fotodeldormitorio');
INSERT INTO Fotografias VALUES ('Foto8', '/ruta/foto8.jpg', 'Fotodelbano');
INSERT INTO Fotografias VALUES ('Foto9', '/ruta/foto9.jpg', 'Fotodelbalcon');
INSERT INTO Fotografias VALUES ('Foto10', '/ruta/foto10.jpg', 'Fotodelgaraje');

INSERT INTO PermiteFotografias VALUES (113, 'Foto1');
INSERT INTO PermiteFotografias VALUES (114, 'Foto2');
INSERT INTO PermiteFotografias VALUES (115, 'Foto3');
INSERT INTO PermiteFotografias VALUES (116, 'Foto4');
INSERT INTO PermiteFotografias VALUES (117, 'Foto5');
INSERT INTO PermiteFotografias VALUES (118, 'Foto6');
INSERT INTO PermiteFotografias VALUES (119, 'Foto7');
INSERT INTO PermiteFotografias VALUES (120, 'Foto8');
INSERT INTO PermiteFotografias VALUES (121, 'Foto9');
INSERT INTO PermiteFotografias VALUES (122, 'Foto10');

INSERT INTO OpcionesCreditos VALUES (12, 1000000, 141);
INSERT INTO OpcionesCreditos VALUES (24, 1500000, 114);
INSERT INTO OpcionesCreditos VALUES (36, 2000000, 115);
INSERT INTO OpcionesCreditos VALUES (48, 2500000, 116);
INSERT INTO OpcionesCreditos VALUES (60, 3000000, 117);
INSERT INTO OpcionesCreditos VALUES (72, 3500000, 118);
INSERT INTO OpcionesCreditos VALUES (84, 4000000, 119);
INSERT INTO OpcionesCreditos VALUES (96, 4500000, 120);
INSERT INTO OpcionesCreditos VALUES (108, 5000000, 121);
INSERT INTO OpcionesCreditos VALUES (120, 5500000,122);


/*REGISTRA OFERTA*/

-------/*ADICIONAR*/-------
 
-- El numero, fecha y estado de la oferta es autogenerado
CREATE SEQUENCE id_num1
    INCREMENT BY 1
    START WITH 1
    MINVALUE 1
    MAXVALUE 99999
    CYCLE;
 
-- Disparador para registrar oferta
CREATE OR REPLACE TRIGGER TG_OFERTAS_BI
BEFORE INSERT ON Ofertas
FOR EACH ROW
DECLARE
    num_oferta NUMBER;
BEGIN
    SELECT id_num1.NEXTVAL INTO num_oferta FROM dual;
    :NEW.NUMERO := num_oferta;
    :NEW.FECHA := SYSDATE;
    :NEW.ESTADO := 'Disponible';
END;
/

 
-- Se asume que todas las viviendas tienen una opciï¿½n de crï¿½dito a 12 meses con cuotas mensuales equivalentes al costo mï¿½s 10% dividido en 12.
CREATE OR REPLACE TRIGGER TG_OPCIONESCREDITOS_BI
BEFORE INSERT ON OpcionesCreditos
FOR EACH ROW
DECLARE
    COSTO_1 NUMBER;
BEGIN
    SELECT costo INTO COSTO_1
    FROM Ofertas
    WHERE numero = :NEW.numeroOferta; 
    :NEW.valorMensual := COSTO_1 * 1.1 / 12; 
    :NEW.plazo := 12; 
END;
/

 
-- Solo se pueden modificar los anexos, las fotografï¿½as y la opciï¿½n de crï¿½dito
CREATE OR REPLACE TRIGGER TG_OFERTAS2_BI
BEFORE UPDATE OF codigoUbicacion, numero, fecha, direccion, tipoVivienda, costo, estado, idusuario ON Ofertas
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20001, 'No se puede modificar el nï¿½mero, fecha, direcciï¿½n, tipoVivienda, costo, estado, idusuarios');
END;
/

 
-- Se pueden adicionar o eliminar fotografï¿½as a la galeria
CREATE OR REPLACE TRIGGER TG_FOTOGRAFIAS_BI
BEFORE UPDATE ON Fotografias
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20002, 'Solo se puede insertar o eliminar fotografï¿½as');
END;
/

 
-- Se puede eliminar la opciï¿½n de crï¿½dito o modificar las condiciones. Las cuotas por el nï¿½mero de meses debe ser mayor o igual al costo
CREATE OR REPLACE TRIGGER TG_OPCIONESCREDITOS2_BI
BEFORE UPDATE OF plazo, valormensual ON OpcionesCreditos
FOR EACH ROW
DECLARE
    COSTO NUMBER;
BEGIN
    SELECT costo INTO COSTO
    FROM Ofertas
    WHERE numero = :NEW.numeroOferta;

    IF (:NEW.plazo * :NEW.valormensual) < COSTO THEN
        RAISE_APPLICATION_ERROR(-20003, 'La multiplicaciï¿½n del plazo por las cuotas debe ser mayor o igual al costo');
    END IF;
END;
/

 
-- Una oferta puede ser eliminada siempre y cuando sea la ï¿½ltima
CREATE OR REPLACE TRIGGER TG_OFERTAS3_BI
BEFORE DELETE ON Ofertas
FOR EACH ROW
DECLARE
    num NUMBER;
BEGIN
    SELECT COUNT(*) INTO num FROM Ofertas WHERE idusuario = :OLD.idusuario;
    IF num > :OLD.numero THEN
        RAISE_APPLICATION_ERROR(-20004, 'Solo se puede eliminar si es la ï¿½ltima oferta.');
    END IF;
END;
/

 
-- Secuencia Para Demanda Punto 1 --
CREATE SEQUENCE id_num_demanda
    INCREMENT BY 1
    START WITH 1
    MINVALUE 1
    MAXVALUE 99999
    CYCLE;


/*REGISTRAR DEMANDA*/

-------/*ADICIONAR*/-------

-- El nï¿½mero y la fecha se generan automï¿½ticamente
CREATE OR REPLACE TRIGGER TG_DEMANDAS1_BI
BEFORE INSERT ON Demandas
FOR EACH ROW
DECLARE
    num_demanda NUMBER;
BEGIN
    SELECT id_num_demanda.NEXTVAL INTO num_demanda FROM dual;
    :NEW.NUMERO := num_demanda;
    :NEW.FECHA := SYSDATE;
END;
/

 
-- Si no se indica el tipo de vivienda, se asume que es casa.
CREATE OR REPLACE TRIGGER TG_DEMANDAS2_BI
BEFORE INSERT ON Demandas
FOR EACH ROW
BEGIN
    IF :NEW.tipoVivienda IS NULL THEN
        :NEW.tipoVivienda := 'casa';
    END IF;
END;
/
 
 
-- Se asume que solicitï¿½ un prestamo por el valor total de la compra.
CREATE OR REPLACE TRIGGER TG_DEMANDAS3_BI
AFTER INSERT ON Demandas
FOR EACH ROW
BEGIN
    INSERT INTO OrigenFondos (
        numeroDemanda,
        valor,
        credito,
        estaAprobado)
    VALUES (:NEW.numero,:NEW.maxCompra,'TRUE','FALSE' );
END;
/



-------/*MODIFICAR*/-------
-- Puede indicar si el prestamo fue aprobado o no.
CREATE OR REPLACE TRIGGER TG_ORIGENFONDOOS_BI
BEFORE UPDATE ON OrigenFondos
FOR EACH ROW
BEGIN
    IF :NEW.numeroDemanda <> :OLD.numeroDemanda OR 
       :NEW.valor <> :OLD.valor OR 
       :NEW.credito <> :OLD.credito THEN
        RAISE_APPLICATION_ERROR(-20006, 'Solo se puede actualizar estaAprovado');
    END IF;
END;
/


-- Puede adicionar ubicaciones de interes, no eliminarlas ni modificarlas.
CREATE OR REPLACE TRIGGER TG_INTERESEN2_BI
BEFORE UPDATE ON InteresEn
FOR EACH ROW
BEGIN
   RAISE_APPLICATION_ERROR(-20002, 'No se Puede Actualizar Tabla');
END;
/


CREATE OR REPLACE TRIGGER TG_INTERESEN_DE
BEFORE DELETE ON InteresEn
FOR EACH ROW
BEGIN
   RAISE_APPLICATION_ERROR(-20002, 'No se Puede Eliminar Tabla');
END;
/


-------/*ELIMINAR*/-------
---unicamente se pueden eliminar, si es la ultima demanda.
 
CREATE OR REPLACE TRIGGER TG_DEMANDAS_DE
BEFORE DELETE ON Demandas
FOR EACH ROW
DECLARE
    num NUMBER;
BEGIN
    SELECT COUNT(*) INTO num FROM demandas WHERE idusuario = :OLD.idusuario;
    IF num > :OLD.numero
     THEN RAISE_APPLICATION_ERROR(-20003,'Solo se puede eliminar si es la ultima demanda.');
    END IF;
END;
/

/*************************************/

INSERT INTO Ofertas (
    codigoUbicacion,
    direccion,
    tipoVivienda,
    costo,
    anexos,
    idusuario
)
VALUES (
    'LOC00000003',  
    'Carrera 50 #12-34',
    'Casa',
    250000000,   
    'Anexo1.pdf',  
    'U0003'      
);

/*2*/

INSERT INTO Ofertas (
    codigoUbicacion,
    direccion,
    tipoVivienda,
    costo,
    anexos,
    idusuario
)
VALUES (
    'LOC00000004',  
    'Avenida 30 #15-45',
    'Apartamento',
    350000000,      
    NULL,           
    'U0004'          
);


/*3*/

UPDATE Ofertas
SET anexos = 'NuevoDocumento.pdf'
WHERE numero = 5;  

/*4*/

INSERT INTO Fotografias (
    nombre,
    ruta,
    descripcion
)
VALUES (
    'Foto11',              
    '/ruta/foto11.jpg',    
    'Fotodeljardin'       
);

DELETE FROM Fotografias
WHERE nombre = 'Foto11'; 

/*5*/


UPDATE OpcionesCreditos
SET plazo = 12,                
    valorMensual = 30000000   
WHERE numeroOferta = 5;       

/*6*/

DELETE FROM Ofertas
WHERE numero = 82;

/*7*/

INSERT INTO Demandas (
    idusuario,
    tipoVivienda,
    maxCompra
)
VALUES (
    'U0003',        
    'Apartamento',  
    80000000      
);

/*8*/

INSERT INTO Demandas (
    idusuario,
    maxCompra
)
VALUES (
    'U0003',    
    90000000    
);

/*9*/
INSERT INTO Demandas (
    idusuario,
    tipoVivienda,
    maxCompra
)
VALUES (
    'U0007',        
    'Casa',         
    120000000      
);

/*10*/

UPDATE OrigenFondos
SET estaAprobado = 'TRUE' 
WHERE numeroDemanda = 6; 

/*11*/

INSERT INTO InteresEn (
    codigoUbicacion,
    numeroDemanda,
    nivel
)
VALUES (
    'LOC00000006',  
    3,        
    'Alta'         
);

/*12*/
DELETE FROM Demandas
WHERE numero = '23';


/****************************************/


/*NoOk*/


/*3*/

UPDATE Ofertas
SET costo = 400000000  -- Modificar el costo NO esta permitido
WHERE numero = 5;       

/*4*/

UPDATE Fotografias
SET descripcion = 'Nueva descripcion de la fotografia' -- Modificacion NO permitida 
WHERE nombre = 'Foto1'; 

/*5*/

UPDATE OpcionesCreditos
SET plazo = 6,                
    valorMensual = 10000000    -- Valor mensual menor que no cumple la condicion
WHERE numeroOferta = 5;       

/*6*/

DELETE FROM Ofertas
WHERE numero = 2 AND idusuario = 'U0004';  -- No es la Ultima oferta del usuario
 
/*10*/

UPDATE OrigenFondos
SET valor = 130000000 
WHERE numeroDemanda = 'D0006'; -- ActualizaciÃ³n NO permitida

/*11*/


DELETE FROM InteresEn
WHERE codigoUbicacion = 'LOC00000008' AND numeroDemanda = 'D0007';

/*12*/
DELETE FROM Demandas
WHERE numero = 2 AND idusuario = 'U0007';  

---------/*LAB05*/-------------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM mbda.data;


/*
INSERT INTO mbda.data VALUES ('christian.romero@mail.escuelaing.edu.co', '123-435-3432',NULL, 1000099014, 'Christian Romero',NULL);
INSERT INTO mbda.data VALUES ('juan.puentes@mail.escuelaing.edu.co', '323-520-7883',null, 1000100444, 'Juan Puentes',NULL);

DELETE FROM mbda.data WHERE CORREO='cromero@gmail.com';
UPDATE mbda.data SET CORREO ='christian.romero@mail.escuelaing.edu.co' WHERE correo = 'cromero@gmail.com' ;*/


/*IMPORTAR A USUARIOS*/
CREATE SEQUENCE seq_id_usuarios
START WITH 1
INCREMENT BY 1
NOCACHE;

INSERT INTO Usuarios (id, fechaRegistro, correoElectronico)
SELECT 
    'LT' || TO_CHAR(seq_id_usuarios.NEXTVAL, 'FM000') AS id, 
    SYSDATE AS fechaRegistro,
    CORREO
FROM (
    SELECT DISTINCT CORREO
    FROM mbda.data
) subquery
WHERE CORREO IS NOT NULL 
AND NOT EXISTS (
    SELECT 1 
    FROM Usuarios 
    WHERE correoElectronico = subquery.CORREO
);




/*IMPORTAR A PERSONANATURALES*/
INSERT INTO PersonaNaturales (tipoDocumento, numeroDocumento, nombres, nacionalidad, idusuario)
SELECT 
    'CC',                       
    NUMERO,                       
    NOMBRES,                      
    'Colombiano',                 
    (SELECT DISTINCT id FROM Usuarios WHERE ROWNUM = 1)
FROM (
    SELECT DISTINCT NUMERO, NOMBRES
    FROM mbda.data
    WHERE NOMBRES IS NOT NULL AND RAZON IS NULL
) subquery;


/*IMPORTAR A EMPRESAS*/
CREATE SEQUENCE seq_NIT
START WITH 1
INCREMENT BY 1
NOCACHE;

INSERT INTO Empresas (nit, razonSocial, idusuario)
SELECT 
    TO_CHAR(seq_NIT.NEXTVAL, 'FM00000000') || '-1',
    RAZON,                                 
    (SELECT id FROM Usuarios WHERE correoElectronico = mbda.data.CORREO AND ROWNUM = 1)
FROM mbda.data 
WHERE RAZON IS NOT NULL 
AND NOMBRES IS NULL;

/*IMPORTAR A NUMEROSCONTACTOS*/

INSERT INTO numerosContactos (numeroContacto, idusuario)
SELECT 
    CONTACTO1, 
    (SELECT id FROM Usuarios WHERE correoElectronico = mbda.data.CORREO AND ROWNUM = 1)
FROM mbda.data
WHERE NOT EXISTS (                
    SELECT 1 
    FROM numerosContactos 
    WHERE numeroContacto = mbda.data.CONTACTO1
);


/*CRUDE*/
CREATE OR REPLACE PACKAGE PC_OFERTAS IS
    PROCEDURE AD_OFERTA(x_codigoUbicacion IN VARCHAR, x_numero IN NUMBER, x_fecha IN DATE, x_direccion IN VARCHAR, x_tipoVivienda IN VARCHAR, x_costo IN NUMBER, x_anexos IN VARCHAR, x_estado IN VARCHAR, x_idUsuario IN VARCHAR);
    PROCEDURE AD_FOTOGRAFIAS(x_nombre IN VARCHAR, x_ruta IN VARCHAR,x_descripcion IN VARCHAR);
    PROCEDURE DEL_FOTOGRAFIAS(x_nombre IN VARCHAR);
    PROCEDURE MO_FOTOGRAFIAS(x_nombre IN VARCHAR, x_ruta IN VARCHAR,x_descripcion IN VARCHAR);
    PROCEDURE DEL_OFERTAS(x_numero IN NUMBER);
    PROCEDURE DEL_OPCIONCREDITO(x_numeroOferta IN NUMBER);
    PROCEDURE MO_OPCIONCREDITO(x_plazo IN NUMBER, x_valorMensual IN NUMBER, x_numeroOferta IN NUMBER);
    FUNCTION CO_USUARIO_OFERTAS RETURN SYS_REFCURSOR;

END PC_OFERTAS;


/*CRUDI*/
CREATE OR REPLACE PACKAGE BODY PC_OFERTAS IS

    PROCEDURE AD_OFERTA(x_codigoUbicacion IN VARCHAR, x_numero IN NUMBER, x_fecha IN DATE, x_direccion IN VARCHAR, x_tipoVivienda IN VARCHAR, x_costo IN NUMBER, x_anexos IN VARCHAR, x_estado IN VARCHAR, x_idusuario IN VARCHAR) IS
    BEGIN
        INSERT INTO Ofertas(codigoUbicacion, numero,fecha, direccion, tipoVivienda, costo, anexos, estado, idusuario) VALUES (x_codigoUbicacion, x_numero, x_fecha, x_direccion, x_tipoVivienda, x_costo, x_anexos, x_estado, x_idusuario);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20101, 'Error al generar Oferta');
    END;

    PROCEDURE AD_FOTOGRAFIAS(x_nombre IN VARCHAR, x_ruta IN VARCHAR,x_descripcion IN VARCHAR) IS
    BEGIN 
        INSERT INTO Fotografias(nombre,ruta,descripcion) VALUES (x_nombre,x_ruta,x_descripcion);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20100, 'Error No se Pueden Adicionar Fotografias');
    END;

    PROCEDURE DEL_FOTOGRAFIAS(x_nombre IN VARCHAR) IS
    BEGIN 
        DELETE FROM Fotografias WHERE nombre = x_nombre;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20102, 'Error al eliminar en Fotografias');
    END;    

    PROCEDURE MO_FOTOGRAFIAS(x_nombre IN VARCHAR, x_ruta IN VARCHAR,x_descripcion IN VARCHAR) IS 
    BEGIN 
        UPDATE Fotografias SET ruta  = x_ruta , descripcion = x_descripcion WHERE nombre = x_nombre ;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20103, 'Error al modificar en Fotografias');
    END;

    PROCEDURE DEL_OFERTAS(x_numero IN NUMBER) IS
    BEGIN 
        DELETE FROM Ofertas WHERE numero = x_numero; 
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20104, 'Error al eliminar en Ofertas');
    END;

    PROCEDURE DEL_OPCIONCREDITO(x_numeroOferta IN NUMBER) IS
    BEGIN 
        DELETE FROM OpcionesCreditos WHERE numeroOferta = x_numeroOferta; 
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20105, 'Error al eliminar en OpcionCredito');
    END;

    PROCEDURE MO_OPCIONCREDITO(x_plazo IN NUMBER, x_valorMensual IN NUMBER, x_numeroOferta IN NUMBER) IS
    BEGIN 
        UPDATE OpcionesCreditos SET plazo = x_plazo , valorMensual = x_valorMensual WHERE numeroOferta = x_numeroOferta;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20106, 'Error al modificar en Opcion De Credito');
    END;
    
    FUNCTION CO_USUARIO_OFERTAS RETURN SYS_REFCURSOR IS
        cur_ofertas SYS_REFCURSOR;
    BEGIN
        OPEN cur_ofertas FOR
            SELECT idusuario, COUNT(numero) AS Ofertas
            FROM Ofertas
            GROUP BY idusuario;
        RETURN cur_ofertas;
    END CO_USUARIO_OFERTAS;
    
END PC_OFERTAS;

/*CRUDOK*/

-- AD_FOTOGRAFIAS 
BEGIN
    PC_OFERTAS.MO_FOTOGRAFIAS('Foto1','/ViajeImagenes/foto1.jpg','Vista Playa');
    DBMS_OUTPUT.PUT_LINE('Tanto ruta como estado cambiados exitosamente');
END;

SELECT * FROM Ofertas WHERE numero = 2;

BEGIN
    PC_OFERTAS.DEL_OFERTAS(2);
    DBMS_OUTPUT.PUT_LINE('La oferta fue eliminada');
END;


BEGIN
    PC_OFERTAS.AD_FOTOGRAFIAS('fotoapto','/ruta/fotoapto.jpg','Fotodelapartamento');
    DBMS_OUTPUT.PUT_LINE('Se agrego la fotografia');
END;


BEGIN
    PC_OFERTAS.DEL_OPCIONCREDITO(2);
    DBMS_OUTPUT.PUT_LINE('La opcion fue exitosa');
END;

BEGIN
    PC_OFERTAS.MO_OPCIONCREDITO(48,46000500,2);
    DBMS_OUTPUT.PUT_LINE('La actualizacion fue exitosa');
END;

/*CRUD NOoK*/
BEGIN
    PC_OFERTAS.AD_ALEATORIO(1,TO_DATE('2023-01-20', 'YYYY-MM-DD'),'Activo');
    DBMS_OUTPUT.PUT_LINE('Error al insertar');
END;

BEGIN
    PC_OFERTAS.MO_OPCIONCREDITO(13,'cincuenta millones',1);
    DBMS_OUTPUT_LINE('La actualizacion fue exitosa');
END;

BEGIN
    PC_OFERTAS.AD_FOTOGRAFIAS('Foto1','/ruta/fotoapto.jpg','Fotodelapartamento');
    DBMS_OUTPUT.PUT_LINE('Se agrego la fotografia');
END;

/*PC_DEMANDAS*/
CREATE OR REPLACE PACKAGE PC_DEMANDAS IS
    PROCEDURE AD_DEMANDAS(x_idusuario IN VARCHAR, x_numero IN NUMBER ,x_fecha IN DATE , x_tipoVivienda IN VARCHAR , x_maxCompra IN NUMBER);
    PROCEDURE AD_UBICACION_INTERES(x_codigoUbicacion IN VARCHAR, x_numeroDemanda IN VARCHAR, x_nivel IN VARCHAR);
    PROCEDURE MO_ORIGENFONDOS(x_numeroDemanda IN VARCHAR, x_estaAprobado IN VARCHAR);
    PROCEDURE DEL_DEMANDAS(x_numero IN NUMBER);
    FUNCTION CO_DEMANDAS RETURN SYS_REFCURSOR;
 
END PC_DEMANDAS;

/*CUERPO PC_DEMANDAS*/
CREATE OR REPLACE PACKAGE BODY PC_DEMANDAS IS
    PROCEDURE AD_DEMANDAS(x_idusuario IN VARCHAR, x_numero IN NUMBER, x_fecha IN DATE, x_tipoVivienda IN VARCHAR, x_maxCompra IN NUMBER) IS
    BEGIN
        INSERT INTO Demandas(idusuario, numero, fecha, tipoVivienda, maxCompra) VALUES (x_idusuario, x_numero,x_fecha,x_tipoVivienda,x_maxCompra);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20107, 'Error al Insertar En Demandas');
    END;
 
    PROCEDURE AD_UBICACION_INTERES(x_codigoUbicacion IN VARCHAR, x_numeroDemanda IN VARCHAR , x_nivel IN VARCHAR) IS
    BEGIN
        INSERT INTO InteresEn(codigoUbicacion, numeroDemanda, nivel) VALUES (x_codigoUbicacion, x_numeroDemanda, x_nivel);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20108, 'Error al Insertar En Ubicacion Interes');
    END;
 
    PROCEDURE MO_ORIGENFONDOS(x_numeroDemanda IN VARCHAR, x_estaAprobado IN VARCHAR) IS
    BEGIN
        UPDATE ORIGENFONDOS SET estaAprobado = x_estaAprobado WHERE numeroDemanda = x_numeroDemanda;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20109, 'Error al modificar en OrigenFondos');
    END;
 
    PROCEDURE DEL_DEMANDAS(x_numero IN NUMBER) IS
    BEGIN
        DELETE FROM Demandas WHERE numero = x_numero;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20110, 'Error al eliminar en Demandas');
    END;
 
    
    FUNCTION CO_DEMANDAS RETURN SYS_REFCURSOR IS
        cur_demandas_viviendas SYS_REFCURSOR;
    BEGIN
        OPEN cur_demandas_viviendas FOR
            SELECT numero, tipoVivienda, maxCompra
            FROM Demandas;
        RETURN cur_demandas_viviendas;
    END CO_DEMANDAS;
    
END PC_DEMANDAS;

/*PC_UBICACION*/
CREATE OR REPLACE PACKAGE PC_UBICACION IS
    PROCEDURE AD_UBICACION(x_codigo IN VARCHAR, x_latitud IN NUMBER, x_longitud IN NUMBER, x_ciudad IN VARCHAR, x_zona IN VARCHAR, x_barrio IN VARCHAR);
    PROCEDURE MO_UBICACION(x_codigo IN VARCHAR, x_latitud IN NUMBER, x_longitud IN NUMBER, x_ciudad IN VARCHAR, x_zona IN VARCHAR, x_barrio IN VARCHAR);
    PROCEDURE DEL_UBICACION(x_codigo IN VARCHAR);
    FUNCTION CO_UBICACION RETURN SYS_REFCURSOR;

END PC_UBICACION;

-- CUERPO PC_UBICACION*/
CREATE OR REPLACE PACKAGE BODY PC_UBICACION IS
    PROCEDURE AD_UBICACION(x_codigo IN VARCHAR, x_latitud IN NUMBER, x_longitud IN NUMBER, x_ciudad IN VARCHAR, x_zona IN VARCHAR, x_barrio IN VARCHAR) IS
    BEGIN
        INSERT INTO Ubicaciones(codigo,latitud,longitud,ciudad,zona,barrio) VALUES (x_codigo, x_latitud, x_longitud, x_ciudad, x_zona, x_barrio);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20111, 'Error al insertar ubicación');
    END;
    
    PROCEDURE MO_UBICACION(x_codigo IN VARCHAR, x_latitud IN NUMBER, x_longitud IN NUMBER, x_ciudad IN VARCHAR, x_zona IN VARCHAR, x_barrio IN VARCHAR) IS
    BEGIN
        UPDATE Ubicaciones SET latitud = x_latitud, longitud = x_longitud, ciudad = x_ciudad, zona = x_zona, barrio = x_barrio WHERE codigo = x_codigo;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20112, 'Error al modificar ubicación');
    END;
    
    PROCEDURE DEL_UBICACION(x_codigo IN VARCHAR) IS
    BEGIN
        DELETE FROM Ubicaciones
        WHERE codigo = x_codigo;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20113, 'Error al eliminar ubicación');
    END;
        
    FUNCTION CO_UBICACION RETURN SYS_REFCURSOR IS
        cur_ubicacion SYS_REFCURSOR;
    BEGIN
        OPEN cur_ubicacion FOR
            SELECT latitud, longitud, ciudad, zona, barrio
            FROM Ubicaciones;
        RETURN cur_ubicacion;
    END CO_UBICACION;

END PC_UBICACION;

/*PC_USUARIO*/
CREATE OR REPLACE PACKAGE PC_USUARIO IS
    PROCEDURE AD_USUARIO(x_id IN VARCHAR, x_fechaRegistro IN DATE, x_correoElectronico IN VARCHAR);
    FUNCTION CO_USUARIO RETURN SYS_REFCURSOR;
END PC_USUARIO;

/*CUERPO_USUARIO*/ 
CREATE OR REPLACE PACKAGE BODY PC_USUARIO IS

    PROCEDURE AD_USUARIO(x_id IN VARCHAR, x_fechaRegistro IN DATE, x_correoElectronico IN VARCHAR) IS
    BEGIN
        INSERT INTO Usuarios(id,fechaRegistro,correoElectronico) VALUES (x_id, x_fechaRegistro, x_correoElectronico);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20114, 'Error al insertar usuario');
    END;
    
    FUNCTION CO_USUARIO RETURN SYS_REFCURSOR IS
        cur_usuario SYS_REFCURSOR;
    BEGIN
        OPEN cur_usuario FOR
            SELECT Usuarios.id, Usuarios.fechaRegistro, Usuarios.correoElectronico, COUNT(Ofertas.idusuario)
            FROM Usuarios
            JOIN Ofertas ON Usuarios.id = Ofertas.idusuario
            GROUP BY Usuarios.id, Usuarios.fechaRegistro, Usuarios.correoElectronico
            ORDER BY Ofertas.idusuario DESC;
        RETURN cur_usuario;
    END CO_USUARIO;
    
END PC_USUARIO;

/*ACTORES E*/ -- USUARIO
CREATE OR REPLACE PACKAGE PA_USUARIO IS
    PROCEDURE AD_OFERTA(x_codigoUbicacion IN VARCHAR, x_numero IN NUMBER, x_fecha IN DATE, x_direccion IN VARCHAR, x_tipoVivienda IN VARCHAR, x_costo IN NUMBER, x_anexos IN VARCHAR, x_estado IN VARCHAR, x_idusuario IN VARCHAR);
    PROCEDURE AD_FOTOGRAFIAS(x_nombre IN VARCHAR, x_ruta IN VARCHAR,x_descripcion IN VARCHAR);
    PROCEDURE DEL_FOTOGRAFIAS(x_nombre IN VARCHAR);
    PROCEDURE MO_FOTOGRAFIAS(x_nombre IN VARCHAR, x_ruta IN VARCHAR,x_descripcion IN VARCHAR);
    PROCEDURE DEL_OFERTAS(x_numero IN NUMBER);
    PROCEDURE DEL_OPCIONCREDITO(x_numeroOferta IN NUMBER);
    PROCEDURE MO_OPCIONCREDITO(x_plazo IN NUMBER, x_valorMensual IN NUMBER, x_numeroOferta IN NUMBER);
    PROCEDURE AD_USUARIO(x_id IN VARCHAR, x_fechaRegistro IN DATE, x_correoElectronico IN VARCHAR);
    FUNCTION CO_USUARIO_OFERTAS RETURN SYS_REFCURSOR;
    FUNCTION  CO_USUARIO RETURN SYS_REFCURSOR;
    PROCEDURE AD_DEMANDAS(xidusuario IN VARCHAR, xnumero IN NUMBER, xfecha IN DATE, xtipoVivienda IN VARCHAR, xmaxCompra IN NUMBER);
    PROCEDURE AD_UBICACIONDEINTERES(x_codigo IN VARCHAR, x_latitud IN VARCHAR,x_longitud IN VARCHAR, x_ciudad IN VARCHAR, x_zona IN VARCHAR, x_barrio IN VARCHAR);
    PROCEDURE DEL_DEMANDAS(xnumero IN NUMBER);
    FUNCTION CO_DEMANDAS RETURN SYS_REFCURSOR;
    
END PA_Usuario;

/*ACTORES I*/ -- USUARIO
CREATE OR REPLACE PACKAGE BODY PA_USUARIO IS

    PROCEDURE AD_OFERTA(
        x_codigoUbicacion IN VARCHAR, 
        x_numero IN NUMBER, 
        x_fecha IN DATE, 
        x_direccion IN VARCHAR, 
        x_tipoVivienda IN VARCHAR, 
        x_costo IN NUMBER, 
        x_anexos IN VARCHAR, 
        x_estado IN VARCHAR, 
        x_idusuario IN VARCHAR
    ) IS
    BEGIN
        PC_OFERTAS.AD_OFERTA(
            x_codigoUbicacion, x_numero, x_fecha, x_direccion, 
            x_tipoVivienda, x_costo, x_anexos, x_estado, x_idusuario
        );
    END AD_OFERTA;

    PROCEDURE AD_FOTOGRAFIAS(
        x_nombre IN VARCHAR, 
        x_ruta IN VARCHAR,
        x_descripcion IN VARCHAR
    ) IS
    BEGIN
        PC_OFERTAS.AD_FOTOGRAFIAS(x_nombre, x_ruta, x_descripcion);
    END AD_FOTOGRAFIAS;

    PROCEDURE DEL_FOTOGRAFIAS(x_nombre IN VARCHAR) IS
    BEGIN
        PC_OFERTAS.DEL_FOTOGRAFIAS(x_nombre);
    END DEL_FOTOGRAFIAS;

    PROCEDURE MO_FOTOGRAFIAS(
        x_nombre IN VARCHAR, 
        x_ruta IN VARCHAR,
        x_descripcion IN VARCHAR
    ) IS
    BEGIN
        PC_OFERTAS.MO_FOTOGRAFIAS(x_nombre, x_ruta, x_descripcion);
    END MO_FOTOGRAFIAS;

    PROCEDURE DEL_OFERTAS(x_numero IN NUMBER) IS
    BEGIN
        PC_OFERTAS.DEL_OFERTAS(x_numero);
    END DEL_OFERTAS;

    PROCEDURE DEL_OPCIONCREDITO(x_numeroOferta IN NUMBER) IS
    BEGIN
        PC_OFERTAS.DEL_OPCIONCREDITO(x_numeroOferta);
    END DEL_OPCIONCREDITO;

    PROCEDURE MO_OPCIONCREDITO(
        x_plazo IN NUMBER, 
        x_valorMensual IN NUMBER, 
        x_numeroOferta IN NUMBER
    ) IS
    BEGIN
        PC_OFERTAS.MO_OPCIONCREDITO(x_plazo, x_valorMensual, x_numeroOferta);
    END MO_OPCIONCREDITO;

    PROCEDURE AD_USUARIO(
        x_id IN VARCHAR, 
        x_fechaRegistro IN DATE, 
        x_correoElectronico IN VARCHAR
    ) IS
    BEGIN
        PC_USUARIO.AD_USUARIO(x_id, x_fechaRegistro, x_correoElectronico);
    END AD_USUARIO;

    FUNCTION CO_USUARIO_OFERTAS RETURN SYS_REFCURSOR IS
        CO_U1 SYS_REFCURSOR;
    BEGIN
        CO_U1 := PC_OFERTAS.CO_USUARIO_OFERTAS;
        RETURN CO_U1;
    END CO_USUARIO_OFERTAS;

    FUNCTION CO_USUARIO RETURN SYS_REFCURSOR IS
        CO_USU1 SYS_REFCURSOR;
    BEGIN
        CO_USU1 := PC_USUARIO.CO_USUARIO;
        RETURN CO_USU1;
    END CO_USUARIO;

    PROCEDURE AD_DEMANDAS(
        xidusuario IN VARCHAR, 
        xnumero IN NUMBER, 
        xfecha IN DATE, 
        xtipoVivienda IN VARCHAR, 
        xmaxCompra IN NUMBER
    ) IS
    BEGIN
        PC_DEMANDAS.AD_DEMANDAS(xidusuario, xnumero, xfecha, xtipoVivienda, xmaxCompra);
    END AD_DEMANDAS;

    PROCEDURE AD_UBICACIONDEINTERES(
        x_codigo IN VARCHAR, 
        x_latitud IN VARCHAR, 
        x_longitud IN VARCHAR,
        x_ciudad IN VARCHAR, 
        x_zona IN VARCHAR, 
        x_barrio IN VARCHAR
    ) IS
    BEGIN
        PC_UBICACION.AD_UBICACION(x_codigo, x_latitud,x_longitud, x_ciudad, x_zona, x_barrio);
    END AD_UBICACIONDEINTERES;

    PROCEDURE DEL_DEMANDAS(xnumero IN NUMBER) IS
    BEGIN
        PC_DEMANDAS.DEL_DEMANDAS(xnumero);
    END DEL_DEMANDAS;

    FUNCTION CO_DEMANDAS RETURN SYS_REFCURSOR IS
        CO_D SYS_REFCURSOR;
    BEGIN
        CO_D := PC_DEMANDAS.CO_DEMANDAS;
        RETURN CO_D;
    END CO_DEMANDAS;

END PA_USUARIO;
/


/*ACTORES E*/ -- ADMINISTRADOR
CREATE OR REPLACE PACKAGE PA_ANALISTA IS
    PROCEDURE AD_UBICACION(x_codigo IN VARCHAR, x_latitud IN NUMBER, x_longitud IN NUMBER, x_ciudad IN VARCHAR, x_zona IN VARCHAR, x_barrio IN VARCHAR);
    PROCEDURE MO_UBICACION(x_codigo IN VARCHAR, x_latitud IN NUMBER, x_longitud IN NUMBER, x_ciudad IN VARCHAR, x_zona IN VARCHAR, x_barrio IN VARCHAR);
    PROCEDURE DEL_UBICACION(x_codigo IN VARCHAR);
    FUNCTION CO_UBICACION RETURN SYS_REFCURSOR;
END PA_Analista;

/*ACTORES I*/ -- ADMINISTRADOR
CREATE OR REPLACE PACKAGE BODY PA_Analista IS
    PROCEDURE AD_UBICACION(x_codigo IN VARCHAR, x_latitud IN NUMBER, x_longitud IN NUMBER, x_ciudad IN VARCHAR, x_zona IN VARCHAR, x_barrio IN VARCHAR) IS
        BEGIN
         PC_UBICACION.AD_UBICACION(x_codigo,x_latitud,x_longitud,x_ciudad,x_zona,x_barrio);
        END;
    PROCEDURE MO_UBICACION(x_codigo IN VARCHAR, x_latitud IN NUMBER, x_longitud IN NUMBER, x_ciudad IN VARCHAR, x_zona IN VARCHAR, x_barrio IN VARCHAR) IS
        BEGIN
        PC_UBICACION.MO_UBICACION(x_codigo, x_latitud, x_longitud, x_ciudad, x_zona, x_barrio);
        END;
    PROCEDURE DEL_UBICACION(x_codigo IN VARCHAR) is
        BEGIN
        PC_UBICACION.DEL_UBICACION(x_codigo);
        END;
    FUNCTION CO_UBICACION RETURN SYS_REFCURSOR IS CO_UBI SYS_REFCURSOR;
    BEGIN
        CO_UBI := PC_UBICACION.CO_UBICACION;
        RETURN CO_UBI;
    END;
END PA_Analista;

/* SEGURIDAD */ 
CREATE ROLE Usuario;
CREATE ROLE Administrador;
GRANT EXECUTE ON PA_USUARIO TO Usuario;
GRANT EXECUTE ON PA_ANALISTA TO Administrador;

GRANT Usuario TO bd1000100419;
GRANT Administrador TO bd1000100444;

/*XSEGURIDAD*/
DROP ROLE Usuario;
DROP ROLE Administrador;

-------PRUEBAS--------------------------------------------------------------------------------------
--José es un joven profesional que está buscando una nueva vivienda y ofertando la suya. Utiliza una plataforma inmobiliaria para administrar sus demandas y encontrar ubicaciones de interés, asi como, su oferta. 

-- 1. Para llevar acabo su busqueda debe registrarse como Usuario.
BEGIN 
    PC_USUARIO.AD_USUARIO( 'J1001',TO_DATE('2024-11-21', 'YYYY-MM-DD'),'jose@gmail.com');
END;

-- 2.José quiere registrar su interés en encontrar una vivienda en la plataforma con las características deseadas, como el tipo de vivienda y el costo máximo que está dispuesto a pagar.
BEGIN
    PC_DEMANDAS.AD_DEMANDAS(
        'J1001', 1, TO_DATE('2024-11-21', 'YYYY-MM-DD'),'Apartamento',1500000 );
END;
/

-- 3.Después de registrar su demanda, José identifica una ubicación que le interesa y la agrega a su perfil.
BEGIN
    PC_DEMANDAS.AD_UBICACION_INTERES(
        '98765432100',1,'Alta' );
END;
/
-- 4. Luego, José quiere asegurarse de que su demanda fue registrada correctamente. Decide consultar todas las demandas registradas en el sistema.
DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := PA_USUARIO.CO_DEMANDAS();
    DBMS_SQL.RETURN_RESULT(v_cursor);
END;
/

-- 5. José actualiza el estado de aprobación de la fuente de fondos asociada con su demanda.

BEGIN
    PC_DEMANDAS.MO_ORIGENFONDOS( 11, 'Aprobado' );
END;
/

-- 6. Finalmente, José encuentra la vivienda ideal fuera de la plataforma y decide eliminar su demanda registrada.
BEGIN
    PC_DEMANDAS.DEL_DEMANDAS(1);
END;
/

-- 7.Sin embargo, José quiere vender su casa para usar ese dinero como parte de pago de su nueva propiedad, por lo que decide añadir una oferta.

BEGIN 
    PC_OFERTAS.AD_OFERTA('98765432100', 1, TO_DATE('2024/09/25', 'yyyy/mm/dd'), 'Calle 123 #45-67', 'Bodega', 450000000, NULL, 'Pendiente', 'J1001');
END;

-- 8. Para asegurarse de que su oferta fue añadida correctamente hace una consulta.

DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := PA_USUARIO.CO_USUARIO_OFERTAS();
    DBMS_SQL.RETURN_RESULT(v_cursor);
END;
/

-- 9. José olvido añadir fotografias de su casa entonces dicidio añadirlas.
BEGIN 
    PC_OFERTAS.AD_FOTOGRAFIAS('FOTO #1','/imagenes/foto1.jpg', 'FOTOS ' );
END;

-- 10. El comprador se contacto con José y logro concretar un acuerdo, por lo que decidio eliminar su oferta.

BEGIN 
    PC_OFERTAS.DEL_OFERTAS(1);
END;






/*XPoblar*/
DELETE FROM Usuarios;
DELETE FROM PersonaNaturales;
DELETE FROM Empresas;
DELETE FROM Demandas;
DELETE FROM Avisos;
DELETE FROM OrigenFondos;
DELETE FROM InteresEn;
DELETE FROM Ofertas;
DELETE FROM Fotografias;
DELETE FROM PermiteFotografias;
DELETE FROM OpcionesCreditos;
DELETE FROM Ubicaciones;

/*XTablas*/
DROP TABLE Usuarios CASCADE CONSTRAINTS;
DROP TABLE PersonaNaturales CASCADE CONSTRAINTS;
DROP TABLE Empresas CASCADE CONSTRAINTS;
DROP TABLE Demandas CASCADE CONSTRAINTS;
DROP TABLE Avisos CASCADE CONSTRAINTS;
DROP TABLE OrigenFondos CASCADE CONSTRAINTS;
DROP TABLE InteresEn CASCADE CONSTRAINTS;
DROP TABLE Ofertas CASCADE CONSTRAINTS;
DROP TABLE Fotografias CASCADE CONSTRAINTS;
DROP TABLE PermiteFotografias CASCADE CONSTRAINTS;
DROP TABLE OpcionesCreditos CASCADE CONSTRAINTS;
DROP TABLE Ubicaciones CASCADE CONSTRAINTS;
DROP TABLE Alertas CASCADE CONSTRAINTS;
DROP TABLE Notificaciones CASCADE CONSTRAINTS;
DROP TABLE numerosContactos CASCADE CONSTRAINTS;   

/*XDisparadores*/
DROP TRIGGER TG_OFERTAS_BI;
DROP TRIGGER TG_OPCIONESCREDITOS_BI;
DROP TRIGGER TG_OFERTAS2_BI;
DROP TRIGGER TG_FOTOGRAFIAS_BI;
DROP TRIGGER TG_OPCIONESCREDITOS2_BI;
DROP TRIGGER TG_OFERTAS3_BI;
DROP TRIGGER IN_NUM_DATE;
DROP TRIGGER TG_DEMANDAS1_BI;
DROP TRIGGER TG_DEMANDAS2_BI;
DROP TRIGGER TG_DEMANDAS3_BI;
DROP TRIGGER TG_ORIGENFONDOOS_BI;
DROP TRIGGER TG_INTERESEN2_BI;
DROP TRIGGER TG_INTERESEN_DE;
DROP TRIGGER TG_DEMANDAS_DE;
  
--CRUDEX
DROP PACKAGE BODY PC_OFERTAS;
DROP PACKAGE PC_OFERTAS;

DROP PACKAGE BODY PC_DEMANDAS;
DROP PACKAGE PC_DEMANDAS;

DROP PACKAGE PC_UBICACION;

DROP PACKAGE PA_USUARIO;
DROP PACKAGE PA_ANALISTA;

DROP SEQUENCE seq_NIT;
DROP SEQUENCE seq_id_usuarios;



