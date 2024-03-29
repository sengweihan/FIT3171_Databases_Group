-- Generated by Oracle SQL Developer Data Modeler 21.4.1.349.1605
--   at:        2022-04-28 04:50:41 CST
--   site:      Oracle Database 12c
--   type:      Oracle Database 12c

SET ECHO ON
SPOOL wc_schema_output.txt

DROP TABLE address CASCADE CONSTRAINTS;

DROP TABLE cabin CASCADE CONSTRAINTS;

DROP TABLE commentary_language CASCADE CONSTRAINTS;

DROP TABLE country CASCADE CONSTRAINTS;

DROP TABLE cruise CASCADE CONSTRAINTS;

DROP TABLE cruise_port CASCADE CONSTRAINTS;

DROP TABLE manifest CASCADE CONSTRAINTS;

DROP TABLE operator CASCADE CONSTRAINTS;

DROP TABLE passenger CASCADE CONSTRAINTS;

DROP TABLE port CASCADE CONSTRAINTS;

DROP TABLE port_temperature CASCADE CONSTRAINTS;

DROP TABLE port_tour CASCADE CONSTRAINTS;

DROP TABLE ship CASCADE CONSTRAINTS;

DROP TABLE tour CASCADE CONSTRAINTS;

DROP TABLE tour_report CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE address (
    addr_id       NUMBER(6) NOT NULL,
    addr_street   VARCHAR2(30) NOT NULL,
    addr_town     VARCHAR2(20) NOT NULL,
    addr_postcode VARCHAR2(10) NOT NULL,
    addr_country  VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN address.addr_id IS
    'address id';

COMMENT ON COLUMN address.addr_street IS
    'address street';

COMMENT ON COLUMN address.addr_town IS
    'address town';

COMMENT ON COLUMN address.addr_postcode IS
    'address post code';

COMMENT ON COLUMN address.addr_country IS
    'address country';

ALTER TABLE address ADD CONSTRAINT address_pk PRIMARY KEY ( addr_id );

ALTER TABLE address
    ADD CONSTRAINT address_nk UNIQUE ( addr_street,
                                       addr_town,
                                       addr_postcode,
                                       addr_country );

CREATE TABLE cabin (
    cabin_num      NUMBER(6) NOT NULL,
    cabin_capacity NUMBER(1) NOT NULL,
    cabin_class    CHAR(1) NOT NULL,
    ship_code      NUMBER(6) NOT NULL
);

ALTER TABLE cabin
    ADD CONSTRAINT chk_cabin_class CHECK ( cabin_class IN ( 'B', 'I', 'O', 'S' ) );

COMMENT ON COLUMN cabin.cabin_num IS
    'cabin number';

COMMENT ON COLUMN cabin.cabin_capacity IS
    'cabin capacity';

COMMENT ON COLUMN cabin.cabin_class IS
    'cabin class';

COMMENT ON COLUMN cabin.ship_code IS
    'ship code';

ALTER TABLE cabin ADD CONSTRAINT cabin_pk PRIMARY KEY ( cabin_num,
                                                        ship_code );

CREATE TABLE commentary_language (
    cl_language CHAR(2) NOT NULL,
    tour_num    NUMBER(2) NOT NULL,
    port_code   VARCHAR2(10) NOT NULL
);

COMMENT ON COLUMN commentary_language.cl_language IS
    'commentary language';

COMMENT ON COLUMN commentary_language.tour_num IS
    'tour number';

COMMENT ON COLUMN commentary_language.port_code IS
    'port code';

ALTER TABLE commentary_language ADD CONSTRAINT language_pk PRIMARY KEY ( tour_num,
                                                                         port_code );

CREATE TABLE country (
    country_code CHAR(2) NOT NULL,
    country_name VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN country.country_code IS
    'country code';

COMMENT ON COLUMN country.country_name IS
    'country name';

ALTER TABLE country ADD CONSTRAINT country_pk PRIMARY KEY ( country_code );

CREATE TABLE cruise (
    cruise_id          NUMBER(5) NOT NULL,
    cruise_name        VARCHAR2(30) NOT NULL,
    cruise_description VARCHAR2(50) NOT NULL,
    ship_code          NUMBER(6) NOT NULL
);

COMMENT ON COLUMN cruise.cruise_id IS
    'cruise id';

COMMENT ON COLUMN cruise.cruise_name IS
    'cruise''s name';

COMMENT ON COLUMN cruise.cruise_description IS
    'cruise''s description';

COMMENT ON COLUMN cruise.ship_code IS
    'ship code';

ALTER TABLE cruise ADD CONSTRAINT cruise_pk PRIMARY KEY ( cruise_id );

CREATE TABLE cruise_port (
    cp_depart_arrival_datetime DATE NOT NULL,
    cruise_id                  NUMBER(5) NOT NULL,
    port_code                  VARCHAR2(10) NOT NULL,
    cp_id                      NUMBER(6) NOT NULL
);

COMMENT ON COLUMN cruise_port.cp_depart_arrival_datetime IS
    'crusie port arrival and departure date and time';

COMMENT ON COLUMN cruise_port.cruise_id IS
    'cruise id';

COMMENT ON COLUMN cruise_port.port_code IS
    'port code';

COMMENT ON COLUMN cruise_port.cp_id IS
    'cruise port id';

ALTER TABLE cruise_port ADD CONSTRAINT cruise_port_pk PRIMARY KEY ( cp_id );

ALTER TABLE cruise_port
    ADD CONSTRAINT cruise_port_nk UNIQUE ( cp_depart_arrival_datetime,
                                           cruise_id,
                                           port_code );

CREATE TABLE manifest (
    manifest_board_datetime DATE NOT NULL,
    cabin_num               NUMBER(6) NOT NULL,
    ship_code               NUMBER(6) NOT NULL,
    pas_id                  NUMBER(6) NOT NULL,
    cruise_id               NUMBER(5) NOT NULL
);

COMMENT ON COLUMN manifest.manifest_board_datetime IS
    'boarding date time';

COMMENT ON COLUMN manifest.cabin_num IS
    'cabin number';

COMMENT ON COLUMN manifest.ship_code IS
    'ship code';

COMMENT ON COLUMN manifest.pas_id IS
    'passenger id';

COMMENT ON COLUMN manifest.cruise_id IS
    'cruise id';

ALTER TABLE manifest ADD CONSTRAINT manifest_pk PRIMARY KEY ( pas_id,
                                                              cruise_id );

CREATE TABLE operator (
    op_id           NUMBER(6) NOT NULL,
    op_company_name VARCHAR2(20) NOT NULL,
    op_ceo_name     VARCHAR2(15) NOT NULL
);

COMMENT ON COLUMN operator.op_id IS
    'operator id';

COMMENT ON COLUMN operator.op_company_name IS
    'operator''s company name';

COMMENT ON COLUMN operator.op_ceo_name IS
    'operator''s CEO name';

ALTER TABLE operator ADD CONSTRAINT operator_pk PRIMARY KEY ( op_id );

CREATE TABLE passenger (
    pas_id                        NUMBER(6) NOT NULL,
    pas_fname                     VARCHAR2(10),
    pas_lname                     VARCHAR2(10),
    pas_phone_num                 CHAR(10) NOT NULL,
    pas_gender                    CHAR(1),
    pas_dob                       DATE NOT NULL,
    guard_id                      NUMBER(6),
    addr_id                       NUMBER(6) NOT NULL,
    pas_principal_spoken_language CHAR(2) NOT NULL
);

COMMENT ON COLUMN passenger.pas_id IS
    'passenger id';

COMMENT ON COLUMN passenger.pas_fname IS
    'passenger first name';

COMMENT ON COLUMN passenger.pas_lname IS
    'passenger last name';

COMMENT ON COLUMN passenger.pas_phone_num IS
    'passenger phone''s number';

COMMENT ON COLUMN passenger.pas_gender IS
    'passenger''s gender';

COMMENT ON COLUMN passenger.pas_dob IS
    'passenger date of birth';

COMMENT ON COLUMN passenger.guard_id IS
    'passenger id';

COMMENT ON COLUMN passenger.addr_id IS
    'address id';

COMMENT ON COLUMN passenger.pas_principal_spoken_language IS
    'passenger principal spoken language';

ALTER TABLE passenger ADD CONSTRAINT passenger_pk PRIMARY KEY ( pas_id );

CREATE TABLE port (
    port_code       VARCHAR2(10) NOT NULL,
    port_name       VARCHAR2(20) NOT NULL,
    port_country    VARCHAR2(20) NOT NULL,
    port_population NUMBER(7),
    port_latitude   NUMBER(10, 7) NOT NULL,
    port_longitude  NUMBER(10, 7) NOT NULL,
    country_code    CHAR(2) NOT NULL
);

COMMENT ON COLUMN port.port_code IS
    'port code';

COMMENT ON COLUMN port.port_name IS
    'port name';

COMMENT ON COLUMN port.port_country IS
    'port country';

COMMENT ON COLUMN port.port_population IS
    'port population';

COMMENT ON COLUMN port.port_latitude IS
    'port latitude';

COMMENT ON COLUMN port.port_longitude IS
    'port longitude';

COMMENT ON COLUMN port.country_code IS
    'country code';

ALTER TABLE port ADD CONSTRAINT port_pk PRIMARY KEY ( port_code );

CREATE TABLE port_temperature (
    pt_month    CHAR(4) NOT NULL,
    pt_avg_high NUMBER(2) NOT NULL,
    pt_avg_low  NUMBER(2) NOT NULL,
    port_code   VARCHAR2(10) NOT NULL
);

ALTER TABLE port_temperature
    ADD CONSTRAINT chk_port_month CHECK ( pt_month IN ( 'Apr', 'Aug', 'Dec', 'Feb', 'Jan',
                                                        'July', 'Jun', 'Mar', 'May', 'Nov',
                                                        'Oct', 'Sep' ) );

COMMENT ON COLUMN port_temperature.pt_month IS
    'port month';

COMMENT ON COLUMN port_temperature.pt_avg_high IS
    'port temperature average high';

COMMENT ON COLUMN port_temperature.pt_avg_low IS
    'port temperature average low';

COMMENT ON COLUMN port_temperature.port_code IS
    'port code';

ALTER TABLE port_temperature ADD CONSTRAINT port_temperature_pk PRIMARY KEY ( pt_month,
                                                                              port_code );

CREATE TABLE port_tour (
    pt_id     NUMBER(6) NOT NULL,
    tour_date DATE NOT NULL,
    tour_num  NUMBER(2) NOT NULL,
    port_code VARCHAR2(10) NOT NULL
);

COMMENT ON COLUMN port_tour.pt_id IS
    'port tour id';

COMMENT ON COLUMN port_tour.tour_date IS
    'tour date';

COMMENT ON COLUMN port_tour.tour_num IS
    'tour number';

COMMENT ON COLUMN port_tour.port_code IS
    'port code';

ALTER TABLE port_tour ADD CONSTRAINT port_tour_pk PRIMARY KEY ( pt_id );

ALTER TABLE port_tour
    ADD CONSTRAINT port_tour_nk UNIQUE ( tour_date,
                                         tour_num,
                                         port_code );

CREATE TABLE ship (
    ship_code               NUMBER(6) NOT NULL,
    ship_name               VARCHAR2(15) NOT NULL,
    ship_date_commision     DATE NOT NULL,
    ship_tonnage            NUMBER(7, 2) NOT NULL,
    ship_max_capacity       NUMBER(6, 2) NOT NULL,
    ship_country_registered VARCHAR2(10) NOT NULL,
    op_id                   NUMBER(6) NOT NULL
);

COMMENT ON COLUMN ship.ship_code IS
    'ship code';

COMMENT ON COLUMN ship.ship_name IS
    'ship name';

COMMENT ON COLUMN ship.ship_date_commision IS
    'ship date commision';

COMMENT ON COLUMN ship.ship_tonnage IS
    'ship tonnage';

COMMENT ON COLUMN ship.ship_max_capacity IS
    'ship''s max capacity';

COMMENT ON COLUMN ship.ship_country_registered IS
    'ship country registered';

COMMENT ON COLUMN ship.op_id IS
    'operator id';

ALTER TABLE ship ADD CONSTRAINT ship_pk PRIMARY KEY ( ship_code );

CREATE TABLE tour (
    tour_num                NUMBER(2) NOT NULL,
    tour_name               VARCHAR2(15) NOT NULL,
    tour_descrip            VARCHAR2(200) NOT NULL,
    tour_hours_req          NUMBER(2, 1) NOT NULL,
    tour_cost_per_person    NUMBER(3, 2) NOT NULL,
    tour_wheel_chair_access CHAR(1) NOT NULL,
    tour_avil               VARCHAR2(20) NOT NULL,
    tour_start_time         DATE NOT NULL,
    port_code               VARCHAR2(10) NOT NULL
);

ALTER TABLE tour
    ADD CONSTRAINT chk_wheel_chair_access CHECK ( tour_wheel_chair_access IN ( 'N', 'Y' ) );

COMMENT ON COLUMN tour.tour_num IS
    'tour number';

COMMENT ON COLUMN tour.tour_name IS
    'tour name';

COMMENT ON COLUMN tour.tour_descrip IS
    'tour description';

COMMENT ON COLUMN tour.tour_hours_req IS
    'tour hours required';

COMMENT ON COLUMN tour.tour_cost_per_person IS
    'tour cost per person';

COMMENT ON COLUMN tour.tour_wheel_chair_access IS
    'tour wheel chair access';

COMMENT ON COLUMN tour.tour_avil IS
    'tour availablity';

COMMENT ON COLUMN tour.tour_start_time IS
    'tour start time';

COMMENT ON COLUMN tour.port_code IS
    'port code';

ALTER TABLE tour ADD CONSTRAINT tour_pk PRIMARY KEY ( tour_num,
                                                      port_code );

CREATE TABLE tour_report (
    tr_id               NUMBER(6) NOT NULL,
    tr_payment_received CHAR(1) NOT NULL,
    pt_id               NUMBER(6) NOT NULL
);

ALTER TABLE tour_report
    ADD CONSTRAINT chk_tour_payment_received CHECK ( tr_payment_received IN ( 'N', 'Y' ) );

COMMENT ON COLUMN tour_report.tr_id IS
    'tour report id';

COMMENT ON COLUMN tour_report.tr_payment_received IS
    'tour payment recevied';

COMMENT ON COLUMN tour_report.pt_id IS
    'port tour id';

ALTER TABLE tour_report ADD CONSTRAINT tour_report_pk PRIMARY KEY ( tr_id );

ALTER TABLE tour_report ADD CONSTRAINT tour_report_nk UNIQUE ( pt_id );

ALTER TABLE passenger
    ADD CONSTRAINT address_passenger FOREIGN KEY ( addr_id )
        REFERENCES address ( addr_id );

ALTER TABLE manifest
    ADD CONSTRAINT cabin_manifest FOREIGN KEY ( cabin_num,
                                                ship_code )
        REFERENCES cabin ( cabin_num,
                           ship_code );

ALTER TABLE port
    ADD CONSTRAINT country_port FOREIGN KEY ( country_code )
        REFERENCES country ( country_code );

ALTER TABLE cruise_port
    ADD CONSTRAINT cruise_cruiseport FOREIGN KEY ( cruise_id )
        REFERENCES cruise ( cruise_id );

ALTER TABLE manifest
    ADD CONSTRAINT cruise_manifest FOREIGN KEY ( cruise_id )
        REFERENCES cruise ( cruise_id );

ALTER TABLE ship
    ADD CONSTRAINT operator_ship FOREIGN KEY ( op_id )
        REFERENCES operator ( op_id );

ALTER TABLE manifest
    ADD CONSTRAINT passenger_manifest FOREIGN KEY ( pas_id )
        REFERENCES passenger ( pas_id );

ALTER TABLE passenger
    ADD CONSTRAINT "PASSENGER_PASSENGER(Guard)" FOREIGN KEY ( guard_id )
        REFERENCES passenger ( pas_id );

ALTER TABLE cruise_port
    ADD CONSTRAINT port_cruiseport FOREIGN KEY ( port_code )
        REFERENCES port ( port_code );

ALTER TABLE port_temperature
    ADD CONSTRAINT port_port_temperature FOREIGN KEY ( port_code )
        REFERENCES port ( port_code );

ALTER TABLE tour
    ADD CONSTRAINT port_tour FOREIGN KEY ( port_code )
        REFERENCES port ( port_code );

ALTER TABLE tour_report
    ADD CONSTRAINT port_tour_tour_report FOREIGN KEY ( pt_id )
        REFERENCES port_tour ( pt_id );

ALTER TABLE cabin
    ADD CONSTRAINT ship_cain FOREIGN KEY ( ship_code )
        REFERENCES ship ( ship_code );

ALTER TABLE cruise
    ADD CONSTRAINT ship_cruise FOREIGN KEY ( ship_code )
        REFERENCES ship ( ship_code );

ALTER TABLE commentary_language
    ADD CONSTRAINT tour_language FOREIGN KEY ( tour_num,
                                               port_code )
        REFERENCES tour ( tour_num,
                          port_code );

ALTER TABLE port_tour
    ADD CONSTRAINT tour_port_tour FOREIGN KEY ( tour_num,
                                                port_code )
        REFERENCES tour ( tour_num,
                          port_code );

CREATE OR REPLACE TRIGGER fkntm_manifest BEFORE
    UPDATE OF cruise_id ON manifest
BEGIN
    raise_application_error(-20225, 'Non Transferable FK constraint  on table MANIFEST is violated');
END;
/

SPOOL OFF
SET ECHO OFF

-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            15
-- CREATE INDEX                             0
-- ALTER TABLE                             39
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
-- CREATE SEQUENCE                          0
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
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
