CREATE OR REPLACE TYPE premio AS OBJECT (
  nombre     VARCHAR2(100),
  categoria  VARCHAR2(100),
  año        NUMBER
);
/

CREATE OR REPLACE TYPE caracteristicas_fisicas AS OBJECT (
  atributo   VARCHAR2(100),
  detalle    VARCHAR2(100)
);
/

CREATE OR REPLACE TYPE caracteristicas_sociales AS OBJECT (
  youtube        VARCHAR2(100),
  suscriptores   NUMBER
);
/

CREATE OR REPLACE TYPE musicos_info AS OBJECT (
  premios                 XMLTYPE,  
  sitio_web               VARCHAR2(200),
  caracteristicas_fisicas XMLTYPE,  
  caracteristicas_sociales XMLTYPE  
);
/

CREATE TABLE musician (
  m_no        NUMBER(11) NOT NULL,
  m_name      VARCHAR2(20),
  born        DATE,
  died        DATE,
  born_in     NUMBER(11),
  living_in   NUMBER(11),
  info        musicos_info,
  CONSTRAINT musician_pk PRIMARY KEY (m_no)
);
/

INSERT INTO musician (m_no, m_name, born, died, born_in, living_in, info)
VALUES (
  1,
  'Artista Ejemplo',
  TO_DATE('1980-05-15', 'YYYY-MM-DD'), 
  NULL,  
  101, 
  102,  
  musicos_info(
    XMLTYPE(
      '<?xml version="1.0"?>
      <!DOCTYPE premios [
        <!ELEMENT premios (premio+)>
        <!ELEMENT premio (nombre, categoria, año)>
        <!ELEMENT nombre (#PCDATA)>
        <!ELEMENT categoria (#PCDATA)>
        <!ELEMENT año (#PCDATA)>
      ]>
      <premios>
        <premio><nombre>Grammy</nombre><categoria>Mejor Artista</categoria><año>2022</año></premio>
        <premio><nombre>MTV Music Award</nombre><categoria>Mejor Video</categoria><año>2021</año></premio>
      </premios>'
    ),
    'https://www.artistaejemplo.com',  
    XMLTYPE(
      '<caracteristicas>' ||
        '<caracteristica><atributo>Altura</atributo><detalle>1.75 m</detalle></caracteristica>' ||
        '<caracteristica><atributo>Ojos</atributo><detalle>Color marrón</detalle></caracteristica>' ||
        '<caracteristica><atributo>Cabello</atributo><detalle>Negro</detalle></caracteristica>' ||
      '</caracteristicas>'
    ),
    XMLTYPE(
      '<?xml version="1.0"?>
      <!DOCTYPE social [
        <!ELEMENT social (youtube, suscriptores)>
        <!ELEMENT youtube (#PCDATA)>
        <!ELEMENT suscriptores (#PCDATA)>
      ]>
      <social>
        <youtube>https://www.youtube.com/c/ArtistaEjemplo</youtube>
        <suscriptores>1000000</suscriptores>
      </social>'
    )
  )
);
/

SELECT 
  m.m_name,
  premio.nombre AS premio_nombre,
  premio.categoria AS categoria,
  premio.año AS año
FROM 
  musician m,
  XMLTABLE(
    '/premios/premio' 
    PASSING m.info.premios         
    COLUMNS
      nombre     VARCHAR2(100) PATH 'nombre',
      categoria  VARCHAR2(100) PATH 'categoria',
      año        NUMBER PATH 'año'
  ) premio
WHERE 
  m.m_no = 1;
/

SELECT 
  m.m_name,
  caract.atributo,
  caract.detalle
FROM 
  musician m,
  XMLTABLE(
    '/caracteristicas/caracteristica' 
    PASSING m.info.caracteristicas_fisicas
    COLUMNS
      atributo   VARCHAR2(100) PATH 'atributo',
      detalle    VARCHAR2(100) PATH 'detalle'
  ) caract
WHERE 
  m.m_no = 1;
/

SELECT 
  m.m_name,
  social.youtube,
  social.suscriptores
FROM 
  musician m,
  XMLTABLE(
    '/social' 
    PASSING m.info.caracteristicas_sociales
    COLUMNS
      youtube        VARCHAR2(100) PATH 'youtube',
      suscriptores   NUMBER PATH 'suscriptores'
  ) social
WHERE 
  m.m_no = 1;
/

SELECT 
  DBMS_XMLGEN.GETXMLTYPE(
    'SELECT 
        m.m_name,
        m.born,
        m.died,
        m.born_in,
        m.living_in,
        m.info.sitio_web
     FROM musician m
     WHERE m.m_no = 1'
  ) AS musician_xml
FROM dual;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE musician CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TYPE musicos_info';
  EXECUTE IMMEDIATE 'DROP TYPE caracteristicas_sociales';
  EXECUTE IMMEDIATE 'DROP TYPE caracteristicas_fisicas';
  EXECUTE IMMEDIATE 'DROP TYPE premio';
END;
/
