CREATE TABLE Usuarios(
             idUsuario CHAR(11) NOT NULL,
             cedula CHAR(11) NOT NULL,
             nombre VARCHAR(45) NOT NULL,
             apellido VARCHAR (45) NOT NULL,
             correoInstitucional VARCHAR(100) NOT NULL,
             calificacion NUMBER,
             estadoUsuario VARCHAR(15),
             numeroVerificacion VARCHAR(11) NOT NULL);

CREATE TABLE Pasajeros(
             idUsuarioPasajero CHAR(11) NOT NULL,
             numeroViajes NUMBER NOT NULL,
             fechaRegistro DATE NOT NULL);
             
CREATE TABLE Conductores(
             idUsuarioConductor CHAR(11) NOT NULL,
             numeroLicencia CHAR(15) NOT NULL,
             calificacionPromedio NUMBER,
             fechaRegistro DATE NOT NULL);
        
             
CREATE TABLE Verificaciones(
             numeroVerificacion VARCHAR(11) NOT NULL,
             estado VARCHAR(25) NOT NULL );  
             
CREATE TABLE Calificaciones(
             idCalificacion VARCHAR(11) NOT NULL,
             numerocalificacion NUMBER NOT NULL,
             descripcion VARCHAR(100),
             idUsuario CHAR(11) NOT NULL,
             idViaje CHAR(15) NOT NULL
             );

CREATE TABLE Vehiculos(
             placa CHAR(6) NOT NULL,
             modelo DATE NOT NULL,
             marca VARCHAR(30)NOT NULL,
             color  VARCHAR(20) NOT NULL,
             soat CHAR(15),
             fechaSoat DATE ,
             tecnomecanica CHAR(15) ,
             fechaTecnomecanica DATE,
             estado VARCHAR(30) NOT NULL,
             numeroPuestos NUMBER NOT NULL,
             idConductor CHAR(11) NOT NULL);

CREATE TABLE Autos(
             idVehiculo CHAR(6) NOT NULL,
             numeroPuertas NUMBER NOT NULL);
             
CREATE TABLE Motos(
             idVehiculo CHAR(6) NOT NULL,
             tipoCilindraje VARCHAR(25) NOT NULL);

CREATE TABLE Recorridos(
             id NUMBER NOT NULL,
             puntoInicio VARCHAR(100) NOT NULL,
             puntoFin VARCHAR(100) NOT NULL,
             placaVehiculo CHAR(6));
            

CREATE TABLE Horarios(
             idHorario NUMBER NOT NULL,
             horarioLlegada VARCHAR(30) NOT NULL,
             horarioSalida VARCHAR(30) NOT NULL,
             dia VARCHAR(30),
             idRecorrido NUMBER NOT NULL);

CREATE TABLE PuntosDeRecogida(
             idPunto NUMBER NOT NULL,
             fechaHora DATE NOT NULL,
             idViaje CHAR(15) NOT NULL,
             idRecorrido NUMBER NOT NULL,
             idUbicacion NUMBER NOT NULL);

CREATE TABLE Ubicaciones(
            idUbicacion NUMBER NOT NULL,
            nombre VARCHAR(100) NOT NULL);

CREATE TABLE Viajes(
             idViaje CHAR(15) NOT NULL,
             ciudad VARCHAR(25) NOT NULL,
             paradaPasajero VARCHAR(60),
             estadoViaje VARCHAR (25) NOT NULL,
             capacidad NUMBER NOT NULL,
             idPasajero CHAR(11),
             idConductor CHAR(11) NOT NULL);
             
CREATE TABLE Multas(
             idMulta CHAR(11) NOT NULL,
             descripcion VARCHAR(100) NOT NULL,
             fecha DATE NOT NULL,
             estado VARCHAR(25) NOT NULL,
             idViaje CHAR(15) NOT NULL);

CREATE TABLE Pagos(
             idPago CHAR(15) NOT NULL,
             metodoPago VARCHAR(25),
             estadoPago VARCHAR(25) NOT NULL,
             valorPagar NUMBER NOT NULL,
             idViaje CHAR(15) NOT NULL);
             
CREATE TABLE Reportes(
             numeroReporte CHAR(10) NOT NULL,
             descripcion VARCHAR(100) NOT NULL,
             estadoReporte VARCHAR(30) NOT NULL,
             idViaje CHAR(15) NOT NULL);

CREATE TABLE Notificaciones(
             fechaNotificacion DATE NOT NULL,
             medioNotificacion VARCHAR(30),
             idReporte CHAR(10) NOT NULL);