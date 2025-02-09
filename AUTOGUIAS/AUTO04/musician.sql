CREATE TABLE musician(
             m_no NUMBER(11) NOT NULL,
             m_name VARCHAR(20),
             born DATE,
             died DATE,
             born_in NUMBER(11),
             living_in NUMBER(11));
             
CREATE TABLE band(
             band_no NUMBER(11) NOT NULL,
             band_name VARCHAR(20),
             band_home NUMBER(11) NOT NULL,
             band_type VARCHAR(10),
             b_date DATE,
             band_contact NUMBER(11) NOT NULL);
             
CREATE TABLE composer(
             comp_no NUMBER(11) NOT NULL,
             comp_is NUMBER(11) NOT NULL,
             comp_type VARCHAR(10));
             
CREATE TABLE performer(
             perf_no NUMBER(11) NOT NULL,
             perf_is NUMBER(11),
             instrument VARCHAR(10) NOT NULL,
             perf_type VARCHAR(10));
             
CREATE TABLE performance(
             pfrmnc_no NUMBER(11) NOT NULL,
             gave NUMBER(11),
             performed NUMBER(11),
             conducted_by NUMBER(11),
             performed_in	NUMBER(11));
             
CREATE TABLE concert(
             concert_no	NUMBER(11) NOT NULL,
             concert_venue	varchar(20),
             concert_in	NUMBER(11) NOT NULL,
             con_date	DATE,
             concert_orgniser	NUMBER(11));
             
CREATE TABLE composition(
             c_no	NUMBER(11) NOT NULL,
             comp_date	DATE,
             c_title	VARCHAR(40) NOT NULL,
             c_in	NUMBER(11));
             
CREATE TABLE place(
             place_no	NUMBER(11) NOT NULL,
             place_town	VARCHAR(20),
             place_country	VARCHAR(20));
             
CREATE TABLE has_composed(
             cmpr_no	NUMBER(11)	NOT NULL,
             cmpn_no	NUMBER(11)	NOT NULL);
             
CREATE TABLE plays_in(
             player	NUMBER(11)	NOT NULL,
             band_id	NUMBER(11)	NOT NULL);
             
/*PK*/
ALTER TABLE musician ADD CONSTRAINT PK_musician PRIMARY KEY(m_no);
ALTER TABLE band ADD CONSTRAINT PK_band PRIMARY KEY(band_no);

/*UK*/
ALTER TABLE band ADD CONSTRAINT UK_band_name UNIQUE (band_name);

/*FK*/
ALTER TABLE performer ADD CONSTRAINT FK_performer_musician FOREIGN KEY(perf_is) REFERENCES musician(m_no);
ALTER TABLE composer ADD CONSTRAINT FK_composer_musician FOREIGN KEY(comp_is) REFERENCES musician(m_no);
ALTER TABLE band ADD CONSTRAINT FK_band_musician FOREIGN KEY(band_contact) REFERENCES musician(m_no);

/* Restricciones Declarativas*/
ALTER TABLE band
ADD CONSTRAINT CK_BAND_BAND_NO CHECK(LENGTH(band_no) BETWEEN 0 AND 9);

ALTER TABLE band
ADD CONSTRAINT CK_BAND_BAND_NAME CHECK (LENGTH(band_name) BETWEEN 1 AND 20);

ALTER TABLE band
ADD CONSTRAINT CK_BAND_BAND_TYPE CHECK (band_type IN('rock','classical','jazz','blues','pop','soul'));

/*AtributosOK*/
INSERT INTO musician VALUES(1,'Sebas Romero',TO_DATE('1925/05/04','YYYY/MM/DD'),TO_DATE('1971/04/04','YYYY/MM/DD'),3,5);
INSERT INTO band VALUES(1,'Rolling Stones',4,'rock',TO_DATE('1960/04/23','YYYY/MM/DD'),1); /*Se valida la longitud del numero de banda y asi mismo el nombre, ademas, que tipo de banda se encuentre dentro de los establecidos*/
INSERT INTO band VALUES(2,'Desmos',5,'blues',TO_DATE('1931/01/12','YYYY/MM/DD'),1); /*Se valida la longitud del numero de banda y asi mismo el nombre, ademas, que tipo de banda se encuentre dentro de los establecidos*/

/*AtributosNoOK*/
INSERT INTO band VALUES(1011111111,'ROP',2,'rock',TO_DATE('1900/04/23','YYYY/MM/DD'),2); /*Se va a rechazar ya que se coloco un número de longitud mayor a 9*/
INSERT INTO band VALUES(1011,'Givenchy',7,'DanceHall',TO_DATE('2005/05/04','YYYY/MM/DD'),4); /*Se va a rechazar ya que el tipo de banda DanceHall no existe  */

/*Acciones*/

/*Si eliminamos un dato de la tabla musician y esta esta relacionada con una clave foranea de otra tabla afectara la integridad de la bases de datos*/

ALTER TABLE band DROP CONSTRAINT FK_band_musician; 
ALTER TABLE band ADD CONSTRAINT FK_band_musician  
FOREIGN KEY(band_contact) REFERENCES musician(m_no) ON DELETE CASCADE;

ALTER TABLE performer DROP CONSTRAINT FK_performer_musician;
ALTER TABLE performer ADD CONSTRAINT FK_performer_musician  
FOREIGN KEY(perf_is) REFERENCES musician(m_no) ON DELETE CASCADE;

ALTER TABLE composer DROP CONSTRAINT FK_composer_musician;
ALTER TABLE composer ADD CONSTRAINT FK_composer_musician  
FOREIGN KEY(comp_is) REFERENCES musician(m_no) ON DELETE CASCADE;


/*AccionesOK*/
/*DELETE FROM musician WHERE m_no = 1;*/

/*Disparadores*/

/* 1) Máximo pueden existir 10 músicos en una banda*/
CREATE OR REPLACE TRIGGER numeromusicos
BEFORE INSERT ON plays_in
FOR EACH ROW
DECLARE
    musicos NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO musicos
    FROM plays_in
    WHERE band_id = :NEW.band_id;
    
    IF musicos >= 10 THEN
        RAISE_APPLICATION_ERROR(-20001, 'La banda ya tiene 10 músicos');
    END IF;
END;
/

/*DisparadoresOK*/
INSERT INTO plays_in (player, band_id) VALUES (1, 1); 
INSERT INTO plays_in (player, band_id) VALUES (2, 1); 
INSERT INTO plays_in (player, band_id) VALUES (3, 1);
INSERT INTO plays_in (player, band_id) VALUES (4, 1); 
INSERT INTO plays_in (player, band_id) VALUES (5, 1); 
INSERT INTO plays_in (player, band_id) VALUES (6, 1); 
INSERT INTO plays_in (player, band_id) VALUES (7, 1);
INSERT INTO plays_in (player, band_id) VALUES (8, 1); 
INSERT INTO plays_in (player, band_id) VALUES (9, 1);
INSERT INTO plays_in (player, band_id) VALUES (10, 1); 

/*DisparadoresNoOK*/
INSERT INTO plays_in (player, band_id) VALUES (11, 1);

DROP TRIGGER numeromusicos;

/*2)Si no se indica el tipo de banda, se asume que es 'rock'*/
CREATE OR REPLACE TRIGGER tipobanda
BEFORE INSERT ON band
FOR EACH ROW
BEGIN
    IF :NEW.band_type IS NULL THEN
        :NEW.band_type := 'rock';
    END IF;
END;
/

/*DisparadoresOK*/
INSERT INTO band VALUES (10, 'The Beatles', 6,NULL, TO_DATE('1960/01/15', 'YYYY/MM/DD'), 1);
INSERT INTO band VALUES (11, 'The Palmas', 6,NULL, TO_DATE('1960/02/15', 'YYYY/MM/DD'), 1);
INSERT INTO band VALUES (12, 'The Suaves', 6,NULL, TO_DATE('1960/03/15', 'YYYY/MM/DD'), 1);

/*DisparadoresNoOK*/
/*No Hay*/


DROP TRIGGER tipobanda;

/*3)Siempre se pueden eliminar*/

/*ALTER TABLE band DROP CONSTRAINT FK_band_musician; 
ALTER TABLE band ADD CONSTRAINT FK_band_musician  
FOREIGN KEY(band_contact) REFERENCES musician(m_no) ON DELETE CASCADE;/*

/*4)El nombre de la banda debe tener mínimo una palabra*/
ALTER TABLE band ADD CONSTRAINT CK_min_palabra CHECK (band_name IS NOT NULL);

/*DisparadoresOK*/
INSERT INTO band VALUES(4, 'The Triggers', 6,NULL, TO_DATE('1960/07/15', 'YYYY/MM/DD'), 1); 
INSERT INTO band VALUES(5, 'Chain', 6,NULL, TO_DATE('1960/02/18', 'YYYY/MM/DD'), 1); 
INSERT INTO band VALUES(6, 'Hello', 6,NULL, TO_DATE('1954/02/8', 'YYYY/MM/DD'), 1); 

/*DisparadoresNoOK*/
INSERT INTO band VALUES(7, NULL, 6,'rock', TO_DATE('1945/07/15', 'YYYY/MM/DD'), 1); 
INSERT INTO band VALUES(8, NULL, 6,'blues', TO_DATE('1944/08/16', 'YYYY/MM/DD'), 1); 
INSERT INTO band VALUES(9, NULL, 6,'soul', TO_DATE('1943/09/17', 'YYYY/MM/DD'), 1); 

/*CRUDE */

CREATE OR REPLACE PACKAGE PKG_BAND IS
    PROCEDURE AD(xband_name IN VARCHAR, xband_type IN VARCHAR, xb_date IN DATE);
    PROCEDURE MO(xband_no IN NUMBER, xb_date IN DATE);
    PROCEDURE AD_MUSICIAN(xband_no IN NUMBER, xmusician_no IN NUMBER);
    PROCEDURE DEL_MUSICIAN(xband_no IN NUMBER, xmusician_no IN NUMBER);
    PROCEDURE DEL(xband_no IN NUMBER);
    FUNCTION CO RETURN NUMBER;
    FUNCTION CO_MUSICIANS RETURN SYS_REFCURSOR;
    FUNCTION CO_BANDS RETURN SYS_REFCURSOR;
END PKG_BAND;

/*CRUDI*/

CREATE OR REPLACE PACKAGE BODY PKG_BAND IS 
    PROCEDURE AD(xband_name IN VARCHAR, xband_type IN VARCHAR, xb_date IN DATE) IS
    BEGIN
        INSERT INTO band(band_name, band_type, b_date) VALUES (xband_name, xband_type, xb_date);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20101, 'Error al insertar');
    END;

    PROCEDURE MO(xband_no IN NUMBER, xb_date IN DATE) IS
    BEGIN 
        UPDATE band SET b_date = xb_date WHERE band_no = xband_no;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20103, 'Error al modificar');
    END;

    PROCEDURE AD_MUSICIAN(xband_no IN NUMBER, xmusician_no IN NUMBER) IS
    BEGIN 
        INSERT INTO band(band_no, band_contact) VALUES (xband_no, xmusician_no);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20101, 'Error al insertar');
    END;

    PROCEDURE DEL_MUSICIAN(xband_no IN NUMBER, xmusician_no IN NUMBER) IS
    BEGIN 
        DELETE FROM band WHERE band_no = xband_no AND band_contact = xmusician_no;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20102, 'Error al eliminar');
    END;

    PROCEDURE DEL(xband_no IN NUMBER) IS
    BEGIN 
        DELETE FROM band WHERE band_no = xband_no;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20102, 'Error al eliminar');
    END;

    FUNCTION CO RETURN NUMBER IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM band;
        RETURN v_count;
    END;

    FUNCTION CO_MUSICIANS RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT * FROM musician;
        RETURN v_cursor;
    END;

    FUNCTION CO_BANDS RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT * FROM band;
        RETURN v_cursor;
    END;
END PKG_BAND;

/*CRUDOK*/


--  MO (Modificar banda)
BEGIN
    PKG_BAND.MO(1, TO_DATE('2023-01-01', 'YYYY-MM-DD'));
END;
/


--  CO (Contar bandas)
DECLARE
    v_count NUMBER;
BEGIN
    v_count := PKG_BAND.CO;
    DBMS_OUTPUT.PUT_LINE(v_count);
END;
/


BEGIN
    PKG_BAND.DEL_MUSICIAN(1, 2);
    DBMS_OUTPUT.PUT_LINE('Músico eliminado de la banda exitosamente');
END;
/


BEGIN
    PKG_BAND.DEL(1);
    DBMS_OUTPUT.PUT_LINE('Banda eliminada exitosamente');
END;
/

----

/*CRUDOk*/

--MO
BEGIN
    PKG_BAND.MO(2, TO_DATE('2024-01-01', 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('Fecha de banda modificada exitosamente');
END;
/


--CO_MUSICIANS
DECLARE
    v_cursor SYS_REFCURSOR;
    v_musician_name VARCHAR2(100);
BEGIN
    v_cursor := PKG_BAND.CO_MUSICIANS;
    IF v_cursor  % ISOPEN THEN
        DBMS_OUTPUT.PUT_LINE('Musicos listados:');
        DBMS_OUTPUT.PUT_LINE(v_musician_name);
    ELSE
        DBMS_OUTPUT.PUT_LINE('No hay musicos disponibles.');
    END IF;
END;
/

/*CRUD NoOK*/
BEGIN
    PKG_BAND.AD_MUSICIAN(5, 101);
END;


BEGIN
    PC_BANDS.AD(3, 'Jazz Band', 'jazz', TO_DATE('2023-05-01', 'YYYY-MM-DD'), 5, 999);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;




/*XCRUDE*/
DROP PACKAGE PKG_BAND;
DROP PACKAGE BODY PKG_BAND;


/*XTablas*/
DROP TABLE band CASCADE CONSTRAINTS;
DROP TABLE composition CASCADE CONSTRAINTS;
DROP TABLE concert CASCADE CONSTRAINTS;
DROP TABLE musician CASCADE CONSTRAINTS;
DROP TABLE performance CASCADE CONSTRAINTS;
DROP TABLE place CASCADE CONSTRAINTS;
DROP TABLE composer  CASCADE CONSTRAINTS;
DROP TABLE has_composed CASCADE CONSTRAINTS;
DROP TABLE performer CASCADE  CONSTRAINTS;
DROP TABLE plays_in CASCADE CONSTRAINTS;










