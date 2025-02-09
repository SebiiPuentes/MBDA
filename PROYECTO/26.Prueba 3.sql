--Prueba
------------CONDUCTOR---------------
--Camilo es un estudiante de la escuela colombiana de ingenieria, y se dirigue a la universiada en su carro, Camilo quiere hacer dinero extra por medio de la plataforma ECI WHEELS.

-- 1. Para ingresar a la plataforma se debe verificarse primero.
--
EXECUTE pa_conductores.ad_verificacion('A1B2C3D4','Aprobado');

--2. Debe ingresar sus datos como usuario.
--
EXECUTE pa_conductores.ad_usuario('12345678901','12345678901','Camilo','Gomez','Camilo.Gomez@mail.escuelaing.edu.co',null,'Activo','A1B2C3D4');
select * from usuarios where idUsuario = '12345678901';
--3. Luego debe ingrsar datos adicionales por se conductor como el numero de licencia
--
EXECUTE pa_conductores.ad_conductor('12345678901','678923457239649',null, to_date('2024-09-12', 'RRRR-MM-DD'));

--4. Camilo debe ingrsar los datos de su vehiculo, entre los que destaca soat y tecnicomecanica, para asegurar un servicio seguro a sus ocupantes
--
EXECUTE pa_conductores.ad_vehiculo('AUU123', to_date('2019-01-01', 'RRRR-MM-DD'),'Dodge','Azul', '396911485385847',to_date('2025-12-15', 'RRRR-MM-DD'),'396911485385847',to_date('2025-12-15', 'RRRR-MM-DD'),'Activo',4,'12345678901');

--5. Al tener un auto debe informar la cantidad de puertas que tiene se vehiculo
--
EXECUTE pa_conductores.ad_auto('AUU123',4);

--6. Camilo debe informar su recorrido es decir, donde inicia y donde finaliza.
--
EXECUTE pa_conductores.ad_recorrido('Centro Comercial Santa Fe','Escuela Colombiana de Ingenieria Julio Garavito','AUU123');
select * from recorridos where placaVehiculo = 'AUU123';

--7. Adicionalmente debe informar sus horarios para saber cuando tendra disponible su recorrido
--
EXECUTE pa_conductores.ad_horarios('15:55', '07:31', 'lunes', 4005);

--8. Camilo puede crear un viaje para esperar sus pasajeros
--
EXECUTE pa_conductores.ad_viaje('120000055512345', 'Bogota', 'Santa', 'Programado' , 1,  NULL, '12345678901');

--

--10. Camilo inia el viajes, por lo que lo actualiza a activo
--
EXECUTE pa_conductores.mo_viaje('120000055512345','En Progreso',3);

--11. Al terminar el viaje, Camilo genera el pago con el costo

EXECUTE pa_conductores.ad_pago('000000000002001', null, 'Pendiente', 5000, '120000055512345' );



-- 13. Luego el conductor actualiza viaje y lo finaliza

EXECUTE pa_conductores.mo_viaje('120000055512345','Finalizado',3);




----------PASAJERO--------------------
--Camila es una estudiante de la escuela colombiana de ingenieria que busca transporte como y segura para ir a la univerisidad

-- 1. Para ingresar a la plataforma se debe verificarse primero.

EXECUTE pa_pasajeros.ad_verificacion('A453C4D5','Aprobado');

--2. Debe ingresar sus datos como usuario.

EXECUTE pa_pasajeros.ad_usuario('23455678901','23455678901','Camila','Soto','Camila.soto@mail.escuelaing.edu.co',null,'Activo','A453C4D5');

EXECUTE pa_pasajeros.ad_pasajero('23455678901',2,SYSDATE);

--3. Camila consulta los viajes disppnible

DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := pa_pasajeros.CO_VIAJES;
END;
/


--4. toma el viaje de Camilo que inicia en una ubicacion conveniente, y se agrega

EXECUTE pa_pasajeros.mo_viaje2('120000055512345','Centro','23455678901');


-- En caso que camila no encuentre su ubicacion, la agregara

EXECUTE pa_pasajeros.ad_ubicacion('Cuatro esquinas');

--






--Administrador 

--El administrador se encarga de verificar los pagos y hacer seguimiento de reportes, multas y notificaciones.



--5. Al llegar Camila genera un pago y el administrador al verificarlo, lo modifica

EXECUTE pa_administradores.mo_pago('000000000002001','Pago');

--El administrador genera la multa

EXECUTE pa_administradores.ad_multa('00000001001', 'Pasajero no tomo el viaje', SYSDATE, 'Pendiente', '120000055512345');


-- Si le hacen una multa al pasajero, este puede pagarla y el administrador actualiza

EXECUTE pa_administradores.mo_multa('00000001001','Pago');


-- Durante el viaje, Camilo no realizo maniobras con su vehiculo prudentes, por lo que, Camila decidio enviar un reporte.

EXECUTE pa_pasajeros.ad_reporte('0000001001','Maniobras indebidas', 'En Revision','120000055512345');

---Al enviar este reporte automaticamente el administrador envia una notificacion a Camilo.
EXECUTE pa_administradores.ad_notificacion('0000001001', SYSDATE, 'SMS');



