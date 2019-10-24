DROP TABLE MANTENIMIENTO;
DROP TABLE PROVEEDOR;
DROP TABLE MAQUINARIA;

CREATE TABLE MAQUINARIA (
    ID              SMALLSERIAL PRIMARY KEY,
    NUMERO          SMALLINT,
    DESCRIPCION     VARCHAR,
    MARCA           VARCHAR,
    MODELO          VARCHAR,
    NSERIE          VARCHAR,
    PERIODO         VARCHAR,
    ACTIVO_FIJO     VARCHAR,
    ZONA            VARCHAR,
    PLANTA          VARCHAR(1),
    FECHA_COMPRA    DATE,
    EN_USO          BOOLEAN     DEFAULT TRUE,
    EN_SERVICIO     BOOLEAN     DEFAULT TRUE,
    CAUSA           VARCHAR
);

CREATE TABLE PROVEEDOR (
    ID              SMALLSERIAL PRIMARY KEY,
    NOMBRE          VARCHAR,
    COMPANIA        VARCHAR
);

CREATE TABLE MANTENIMIENTO (
    ID              SMALLSERIAL PRIMARY KEY,
    MAQUINA         INT         REFERENCES MAQUINARIA(ID),
    PROVEEDOR       INT         REFERENCES PROVEEDOR(ID), -- FOREIGN KEY TO PROVEEDORES
    FECHA           DATE,
    DESCRIPCION     VARCHAR,
    EMERGENCIA      BOOLEAN,
    REFACCIONES     BOOLEAN,
    REEMPLAZO       BOOLEAN,
    GARANTIA        BOOLEAN,
    COSTO           FLOAT,
    NUMEROORDEN     VARCHAR
);