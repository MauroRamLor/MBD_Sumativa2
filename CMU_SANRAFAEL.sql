-- Generado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   en:        2025-09-13 23:40:43 CLST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE AFP ( 
     cod_afp    VARCHAR2 (10)  NOT NULL , 
     nombre_afp VARCHAR2 (60)  NOT NULL 
    );

ALTER TABLE AFP 
ADD CONSTRAINT PK_AFP 
PRIMARY KEY ( cod_afp );

CREATE TABLE ATENCION_MEDICA ( 
     id_atencion                  NUMBER (10)  NOT NULL , 
     fecha_hora                   DATE  NOT NULL , 
     tipo_atencion                VARCHAR2 (12)  NOT NULL , 
     diagnostico                  VARCHAR2 (500) , 
     modalidad                    VARCHAR2 (10)  NOT NULL , 
     PACIENTE_rut_paciente        VARCHAR2 (12)  NOT NULL , 
     MEDICO_rut_medico            VARCHAR2 (12)  NOT NULL , 
     PAGO_ATENCION_id_pago        NUMBER (12)  NOT NULL , 
     ESPECIALIDAD_id_especialidad NUMBER (3)  NOT NULL 
    );

ALTER TABLE ATENCION_MEDICA 
ADD CONSTRAINT CK_TIPO_ATENCION 
CHECK (tipo_atencion IN ('GENERAL', 'PREVENTIVA', 'URGENCIA'));

ALTER TABLE ATENCION_MEDICA 
ADD CONSTRAINT CK_MODALIDAD 
CHECK (modalidad IN ('PRESENCIAL', 'VIRTUAL'));

CREATE UNIQUE INDEX ATENCION_MEDICA__IDX 
ON ATENCION_MEDICA ( PAGO_ATENCION_id_pago ASC );

ALTER TABLE ATENCION_MEDICA 
ADD CONSTRAINT PK_ATENCION_MEDICA 
PRIMARY KEY ( id_atencion );

CREATE TABLE COMUNA ( 
     id_comuna        NUMBER (5)  NOT NULL , 
     nombre_comuna    VARCHAR2 (60)  NOT NULL , 
     REGION_id_region NUMBER (3)  NOT NULL 
    );

ALTER TABLE COMUNA 
ADD CONSTRAINT PK_COMUNA 
PRIMARY KEY ( id_comuna );

CREATE TABLE DETALLE_ORDEN_EXAMEN ( 
     DETALLE_ORDEN_EXAMEN_ID       NUMBER  NOT NULL , 
     observaciones                 VARCHAR2 (500) , 
     EXAMEN_cod_examen             VARCHAR2 (12)  NOT NULL , 
     ORDEN_EXAMEN_id_orden         NUMBER (12)  NOT NULL , 
     RESULTADO_EXAMEN_id_resultado NUMBER (12)  NOT NULL 
    );
    
CREATE UNIQUE INDEX DETALLE_ORDEN_EXAMEN__IDX 
ON DETALLE_ORDEN_EXAMEN ( RESULTADO_EXAMEN_id_resultado ASC );

ALTER TABLE DETALLE_ORDEN_EXAMEN 
ADD CONSTRAINT PK_DETALLE_ORDEN_EXAMEN 
PRIMARY KEY ( DETALLE_ORDEN_EXAMEN_ID );

CREATE TABLE ESPECIALIDAD ( 
     id_especialidad   NUMBER (3)  NOT NULL , 
     name_especialidad VARCHAR2 (60)  NOT NULL 
    );

ALTER TABLE ESPECIALIDAD 
ADD CONSTRAINT PK_ESPECIALIDAD 
PRIMARY KEY ( id_especialidad );

CREATE TABLE EXAMEN ( 
     cod_examen   VARCHAR2 (12)  NOT NULL , 
     name_examen  VARCHAR2 (80)  NOT NULL , 
     tipo_muestra VARCHAR2 (40)  NOT NULL , 
     preparacion  VARCHAR2 (120) 
    );

COMMENT ON COLUMN EXAMEN.preparacion IS 'eje: "ayuno"' 
;

ALTER TABLE EXAMEN 
ADD CONSTRAINT PK_EXAMEN 
PRIMARY KEY ( cod_examen );

CREATE TABLE INSTITUCION_SALUD ( 
     cod_inst_salud VARCHAR2 (10)  NOT NULL , 
     name_ins_salud VARCHAR2 (60)  NOT NULL 
    );

ALTER TABLE INSTITUCION_SALUD 
ADD CONSTRAINT PK_INSTITUCION_SALUD 
PRIMARY KEY ( cod_inst_salud );

CREATE TABLE MEDICO ( 
     rut_medico                   VARCHAR2 (12)  NOT NULL , 
     nombres                      VARCHAR2 (30)  NOT NULL , 
     primer_ap                    VARCHAR2 (20)  NOT NULL , 
     segundo_ap                   VARCHAR2 (20)  NOT NULL , 
     fecha_ingreso                DATE  NOT NULL , 
     UNIDAD_ATENCION_id_unidad    NUMBER (3)  NOT NULL , 
     ESPECIALIDAD_id_especialidad NUMBER (3) , 
     AFP_cod_afp                  VARCHAR2 (10)  NOT NULL , 
     INSTITUCION_SALUD_cod        VARCHAR2 (10)  NOT NULL , 
     MEDICO_rut_medico            VARCHAR2 (12)  NOT NULL 
    );
    
CREATE UNIQUE INDEX MEDICO__IDX 
ON MEDICO ( rut_medico ASC );

ALTER TABLE MEDICO 
ADD CONSTRAINT PK_MEDICO 
PRIMARY KEY ( rut_medico );

CREATE TABLE ORDEN_EXAMEN ( 
     id_orden                    NUMBER (12)  NOT NULL , 
     fecha_solicitud             DATE  NOT NULL , 
     ATENCION_MEDICA_id_atencion NUMBER (10)  NOT NULL 
    );

ALTER TABLE ORDEN_EXAMEN 
ADD CONSTRAINT PK_ORDEN_EXAMEN 
PRIMARY KEY ( id_orden );

CREATE TABLE PACIENTE ( 
     rut_paciente     VARCHAR2 (12)  NOT NULL , 
     nombres          VARCHAR2 (40)  NOT NULL , 
     primer_ap        VARCHAR2 (20)  NOT NULL , 
     segundo_ap       VARCHAR2 (20)  NOT NULL , 
     sexo             CHAR (1)  NOT NULL , 
     fecha_nac        DATE  NOT NULL , 
     direccion        VARCHAR2 (120)  NOT NULL , 
     tipo_usuario     VARCHAR2 (15)  NOT NULL , 
     email            VARCHAR2 (120) , 
     telefono         VARCHAR2 (20) , 
     COMUNA_id_comuna NUMBER (5) 
    );

ALTER TABLE PACIENTE 
ADD CONSTRAINT CK_sexo 
CHECK (sexo IN ('F', 'M', 'X'));

ALTER TABLE PACIENTE 
ADD CONSTRAINT CK_tipo_usuario 
CHECK (tipo_usuario IN ('ACADEMICO', 'ESTUDIANTE', 'ADMINISTRATIVO'));

ALTER TABLE PACIENTE 
ADD CONSTRAINT PK_PACIENTE 
PRIMARY KEY ( rut_paciente );

CREATE TABLE PAGO_ATENCION ( 
     id_pago      NUMBER (12)  NOT NULL , 
     tipo_pago    VARCHAR2 (12)  NOT NULL , 
     monto_pagado NUMBER (10,2)  NOT NULL 
    );

ALTER TABLE PAGO_ATENCION 
    ADD CONSTRAINT CK_TIPO_PAGO 
    CHECK (tipo_pago IN ('CONVENIO', 'EFECTIVO', 'TARJETA'));

ALTER TABLE PAGO_ATENCION 
ADD CONSTRAINT PK_PAGO_ATENCION 
PRIMARY KEY ( id_pago );

CREATE TABLE REGION ( 
     id_region     NUMBER (3)  NOT NULL , 
     nombre_region VARCHAR2 (60)  NOT NULL 
    );

ALTER TABLE REGION 
ADD CONSTRAINT PK_REGION 
PRIMARY KEY ( id_region );

ALTER TABLE REGION 
ADD CONSTRAINT UK_REGION_nombre_region 
UNIQUE ( nombre_region );

CREATE TABLE RESULTADO_EXAMEN ( 
     id_resultado    NUMBER (12)  NOT NULL , 
     fecha_resultado DATE  NOT NULL , 
     valor_resultado VARCHAR2 (120) , 
     observaciones   VARCHAR2 (400) 
    );

ALTER TABLE RESULTADO_EXAMEN 
ADD CONSTRAINT PK_RESULTADO_EXAMEN 
PRIMARY KEY ( id_resultado );

CREATE TABLE UNIDAD_ATENCION ( 
     id_unidad     NUMBER (3)  NOT NULL , 
     nombre_unidad VARCHAR2 (50)  NOT NULL 
    );

ALTER TABLE UNIDAD_ATENCION 
ADD CONSTRAINT CK_NOMBRE_UNIDAD 
CHECK (nombre_unidad IN ('LABORATORIO', 'MEDICINA_GENERAL', 'SALUD_MENTAL'));

ALTER TABLE UNIDAD_ATENCION 
ADD CONSTRAINT PK_UNIDAD_ATENCION 
PRIMARY KEY ( id_unidad );

ALTER TABLE COMUNA 
ADD CONSTRAINT COMUNA_REGION_FK 
FOREIGN KEY ( REGION_id_region ) 
REFERENCES REGION ( id_region );

ALTER TABLE ATENCION_MEDICA 
ADD CONSTRAINT FK_ATENCION_MED_ESPECIALI 
FOREIGN KEY ( ESPECIALIDAD_id_especialidad ) 
REFERENCES ESPECIALIDAD ( id_especialidad );

ALTER TABLE ATENCION_MEDICA 
ADD CONSTRAINT FK_ATENCION_MED_MEDICO 
FOREIGN KEY ( MEDICO_rut_medico ) 
REFERENCES MEDICO ( rut_medico );

ALTER TABLE ATENCION_MEDICA 
ADD CONSTRAINT FK_ATENCION_MED_PACIENTE 
FOREIGN KEY ( PACIENTE_rut_paciente ) 
REFERENCES PACIENTE ( rut_paciente );

ALTER TABLE ATENCION_MEDICA 
ADD CONSTRAINT FK_ATENCION_MED_PAGO 
FOREIGN KEY ( PAGO_ATENCION_id_pago )
REFERENCES PAGO_ATENCION ( id_pago );

ALTER TABLE DETALLE_ORDEN_EXAMEN 
ADD CONSTRAINT FK_DET_ORD_EXAM_ORD_EXAM 
FOREIGN KEY ( ORDEN_EXAMEN_id_orden ) 
REFERENCES ORDEN_EXAMEN ( id_orden );

ALTER TABLE DETALLE_ORDEN_EXAMEN 
ADD CONSTRAINT FK_DET_ORD_EXAM_RESUL_EXAM 
FOREIGN KEY ( RESULTADO_EXAMEN_id_resultado ) 
REFERENCES RESULTADO_EXAMEN ( id_resultado );

ALTER TABLE DETALLE_ORDEN_EXAMEN 
ADD CONSTRAINT FK_DETALLE_ORDEN_EXAMEN_EXAM 
FOREIGN KEY ( EXAMEN_cod_examen )
REFERENCES EXAMEN ( cod_examen );

ALTER TABLE MEDICO 
ADD CONSTRAINT FK_MEDICO_AFP 
FOREIGN KEY ( AFP_cod_afp ) 
REFERENCES AFP ( cod_afp );

ALTER TABLE MEDICO 
ADD CONSTRAINT FK_MEDICO_ESPECIALIDAD 
FOREIGN KEY ( ESPECIALIDAD_id_especialidad ) 
REFERENCES ESPECIALIDAD ( id_especialidad );

ALTER TABLE MEDICO 
ADD CONSTRAINT FK_MEDICO_INSTITUCION_SALUD 
FOREIGN KEY ( INSTITUCION_SALUD_cod ) 
REFERENCES INSTITUCION_SALUD ( cod_inst_salud );

ALTER TABLE MEDICO 
ADD CONSTRAINT FK_MEDICO_MEDICO 
FOREIGN KEY ( MEDICO_rut_medico ) 
REFERENCES MEDICO ( rut_medico );

ALTER TABLE MEDICO 
ADD CONSTRAINT FK_MEDICO_UNIDAD_ATENCION 
FOREIGN KEY ( UNIDAD_ATENCION_id_unidad ) 
REFERENCES UNIDAD_ATENCION ( id_unidad );

ALTER TABLE ORDEN_EXAMEN 
ADD CONSTRAINT FK_ORD_EXAM_ATENCION_MED 
FOREIGN KEY ( ATENCION_MEDICA_id_atencion ) 
REFERENCES ATENCION_MEDICA ( id_atencion );

ALTER TABLE PACIENTE 
ADD CONSTRAINT PACIENTE_COMUNA_FK 
FOREIGN KEY ( COMUNA_id_comuna ) 
REFERENCES COMUNA ( id_comuna );

CREATE SEQUENCE DETALLE_ORDEN_EXAMEN_DETALLE_O 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER DETALLE_ORDEN_EXAMEN_DETALLE_O 
BEFORE INSERT ON DETALLE_ORDEN_EXAMEN 
FOR EACH ROW 
WHEN (NEW.DETALLE_ORDEN_EXAMEN_ID IS NULL) 
BEGIN 
    :NEW.DETALLE_ORDEN_EXAMEN_ID := DETALLE_ORDEN_EXAMEN_DETALLE_O.NEXTVAL; 
END;
/



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            14
-- CREATE INDEX                             3
-- ALTER TABLE                             36
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           1
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          1
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
