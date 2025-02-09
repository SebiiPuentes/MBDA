CREATE OR REPLACE VIEW RESUMEN_VIAJE AS

SELECT 
    v.idViaje,
    v.ciudad,
    v.estadoViaje,
    v.capacidad,
    m.idMulta,
    m.descripcion AS descripcionMulta,
    m.estado AS estadoMulta,
    m.fecha AS fechaMulta,
    r.numeroReporte,
    r.descripcion AS descripcionReporte,
    r.estadoReporte,
    p.idPago,
    p.metodoPago,
    p.estadoPago,
    p.valorPagar
FROM 
    Viajes v
LEFT JOIN 
    Multas m ON v.idViaje = m.idViaje
LEFT JOIN 
    Reportes r ON v.idViaje = r.idViaje
LEFT JOIN 
    Pagos p ON v.idViaje = p.idViaje;
    
/

    
CREATE OR REPLACE VIEW PASAJEROS_RECORRIDOS AS
SELECT 
    V.idViaje,
    R.puntoInicio,
    R.puntoFin,
    Vh.placa AS placaVehiculo,
    PR.fechaHora
FROM 
    Viajes V
JOIN 
    Recorridos R ON V.idViaje = R.id
JOIN 
    Vehiculos Vh ON R.placaVehiculo = Vh.placa
JOIN 
    PuntosDeRecogida PR ON V.idViaje = PR.idViaje;
    
/

CREATE OR REPLACE VIEW VIAJES_EN_PROGRESO AS
SELECT 
    V.idViaje,
    V.estadoViaje,
    Vh.placa AS placaVehiculo,
    U.idUsuario AS idPasajero,
    U.nombre AS nombrePasajero,
    U.apellido AS apellidoPasajero
FROM 
    Viajes V
JOIN 
    Vehiculos Vh ON Vh.placa = (
        SELECT R.placaVehiculo
        FROM Recorridos R
        WHERE R.id = (
            SELECT PR.idRecorrido
            FROM PuntosDeRecogida PR
            WHERE PR.idViaje = V.idViaje
            FETCH FIRST 1 ROW ONLY
        )
    )
JOIN 
    Pasajeros P ON P.idUsuarioPasajero = V.idPasajero
JOIN 
    Usuarios U ON U.idUsuario = P.idUsuarioPasajero
WHERE 
    V.estadoViaje = 'En Progreso';
/

CREATE OR REPLACE VIEW CONDUCTORES_ALTA_CALIFICACION AS
SELECT 
    C.idUsuarioConductor,
    U.nombre AS nombreConductor,
    U.apellido AS apellidoConductor,
    C.calificacionPromedio
FROM 
    Conductores C
JOIN 
    Usuarios U ON C.idUsuarioConductor = U.idUsuario
WHERE 
    C.calificacionPromedio BETWEEN 4 AND 5;
/
CREATE OR REPLACE VIEW MULTAS_PENDIENTES_USUARIOS AS
SELECT 
    M.idMulta,
    M.descripcion AS descripcionMulta,
    M.fecha AS fechaMulta,
    M.estado AS estadoMulta,
    V.idViaje,
    P.idUsuarioPasajero AS idPasajero,
    UP.nombre AS nombrePasajero,
    UP.apellido AS apellidoPasajero,
    C.idUsuarioConductor AS idConductor,
    UC.nombre AS nombreConductor,
    UC.apellido AS apellidoConductor
FROM 
    Multas M
JOIN 
    Viajes V ON M.idViaje = V.idViaje
JOIN 
    Pasajeros P ON V.idPasajero = P.idUsuarioPasajero
JOIN 
    Usuarios UP ON P.idUsuarioPasajero = UP.idUsuario
JOIN 
    Conductores C ON V.idConductor = C.idUsuarioConductor
JOIN 
    Usuarios UC ON C.idUsuarioConductor = UC.idUsuario
WHERE 
    M.estado = 'Pendiente';


