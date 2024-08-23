/*
----------------------------------------------------------
Institucion: Universidad Latinoamericana de Ciencia y Tecnologia.
Curso: Servicios Web
Asunto: Creacion de la base de datos del proyecto final
Autor: Jos[e Andres Gomez Castro
Fecha: 28-07-2024
----------------------------------------------------------
*/

--Crear Base de Datos TicoGourmet

use master
GO

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'TicoGourmet')
CREATE DATABASE TicoGourmet
GO

USE TicoGourmet
GO

--Dropear las tablas viejas

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Meseros')
DROP TABLE Meseros
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Empleados')
DROP TABLE Empleados
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Reservas')
DROP TABLE Reservas
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Mesas')
DROP TABLE Mesas
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Personas')
DROP TABLE Personas
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Contactos')
DROP TABLE Contactos
GO

--Crear las tablas nuevas

CREATE TABLE Personas (
    ID_Persona INT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    [Password] VARCHAR(100) NOT NULL,
    Rol CHAR(1) CHECK (Rol IN ('E', 'C')) NOT NULL,--E: Empleado C: Cliente
);
GO

CREATE TABLE Empleados (
    ID_Persona INT NOT NULL,
    Rol CHAR(1) CHECK (Rol IN ('M', 'C', 'D')) NOT NULL,-- M: Mesero C: Chef D: Dependiente
    Turno VARCHAR(50) NOT NULL,
    Estado CHAR(1) CHECK (Estado IN ('A', 'I')) NOT NULL,-- A: Activo I: Inactivo
    PRIMARY KEY (ID_Persona),
    CONSTRAINT FK_Empleados_Personas FOREIGN KEY (ID_Persona) REFERENCES Personas(ID_Persona)
);
GO

CREATE TABLE Meseros (
    ID_Persona INT NOT NULL,
    MesasAtendidas INT NOT NULL,
    PRIMARY KEY (ID_Persona),
    CONSTRAINT FK_Meseros_Empleados FOREIGN KEY (ID_Persona) REFERENCES Empleados(ID_Persona)
);
GO

CREATE TABLE Mesas (
    ID_Mesa INT PRIMARY KEY,
    CantidadAsientos INT NOT NULL
);
GO

CREATE TABLE Reservas (
    ID_Reserva INT PRIMARY KEY,
    FechaHora DATETIME NOT NULL,
    ID_Persona INT NOT NULL,
    ID_Mesa INT NOT NULL,
    Estado CHAR(1) CHECK (Estado IN ('P', 'C')) NOT NULL,-- P: Pendiente C: Cerrada
    CONSTRAINT FK_Reservas_Personas FOREIGN KEY (ID_Persona) REFERENCES Personas(ID_Persona),
    CONSTRAINT FK_Reservas_Mesas FOREIGN KEY (ID_Mesa) REFERENCES Mesas(ID_Mesa)
);
GO

CREATE TABLE Contactos (
    ID_Contacto INT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Correo VARCHAR(50) NOT NULL,
    Asunto VARCHAR(50) NOT NULL,
    Mensaje VARCHAR(255) NOT NULL
);
GO

--Crear los triggers

--Verifica que solo las personas con el rol de empleados E puedan ingresar a la tabla Empleados.
CREATE TRIGGER trg_CheckRolOnInsert_Empleados
ON Empleados
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Personas p ON i.ID_Persona = p.ID_Persona
        WHERE p.Rol <> 'E'
    )
    BEGIN
        RAISERROR ('Solo las personas con el rol de empleados ''E'', pueden ingresar a esta tabla.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO Empleados (ID_Persona, Rol, Turno, Estado)
        SELECT ID_Persona, Rol, Turno, Estado
        FROM inserted;
    END
END;
GO

--Verifica que solo los empleados con el rol de meseros M puedan ingresar a la tabla Meseros.
CREATE TRIGGER trg_CheckRolOnInsert_Meseros
ON Meseros
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Empleados e ON i.ID_Persona = e.ID_Persona
        WHERE e.Rol <> 'M'
    )
    BEGIN
        RAISERROR ('Solo los empleados con el rol de meseros ''M'', pueden ingresar a esta tabla.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO Meseros (ID_Persona, MesasAtendidas)
        SELECT ID_Persona, MesasAtendidas
        FROM inserted;
    END
END;
GO

--Verifica que solo las personas con el rol de cliente C puedan ingresar a la tabla Reservas.
CREATE TRIGGER trg_CheckRolOnInsert_Reservas
ON Reservas
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Personas p ON i.ID_Persona = p.ID_Persona
        WHERE p.Rol <> 'C'
    )
    BEGIN
        RAISERROR ('Solo las personas con el rol de cliente ''C'', pueden ingresar a esta tabla.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO Reservas (ID_Reserva, FechaHora, ID_Persona, ID_Mesa, Estado)
        SELECT ID_Reserva, FechaHora, ID_Persona, ID_Mesa, Estado
        FROM inserted;
    END
END;
GO
--Insertar datos en las tablas nuevas

--Tabla Personas
insert into Personas (ID_Persona, Nombre, Apellido, Email, [Password], Rol) values (118000943, 'Jose Andres', 'Gomez Castro', 'jgomezc943@gmail.com', '1234', 'E');
insert into Personas (ID_Persona, Nombre, Apellido, Email, [Password], Rol) values (604630096, 'Luis Alfredo', 'Castro Castro', 'lcastroc096@gmail.com', '5678', 'C');
insert into Personas (ID_Persona, Nombre, Apellido, Email, [Password], Rol) values (604210014, 'Kevin Daniel', 'Garcia Sibaja', 'kgarcias021@gmail.com', '12345678', 'C');
insert into Personas (ID_Persona, Nombre, Apellido, Email, [Password], Rol) values (414630201, 'Elend', 'Venture', 'eventure028@gmail.com', 'Luthadel5678', 'E');
GO
--Tabla Empleados
insert into Empleados (ID_Persona, Rol, Turno, Estado) values (118000943, 'M', 'Diurno', 'A');
insert into Empleados (ID_Persona, Rol, Turno, Estado) values (414630201, 'M', 'Diurno', 'A');
GO

--Tabla Meseros
insert into Meseros (ID_Persona, MesasAtendidas) values (118000943, 14);
insert into Meseros (ID_Persona, MesasAtendidas) values (414630201, 7);
GO

--Tabla Mesas
insert into Mesas (ID_Mesa, CantidadAsientos) values (1, 8);
insert into Mesas (ID_Mesa, CantidadAsientos) values (2, 8);
insert into Mesas (ID_Mesa, CantidadAsientos) values (3, 6);
insert into Mesas (ID_Mesa, CantidadAsientos) values (4, 6);
insert into Mesas (ID_Mesa, CantidadAsientos) values (5, 6);
insert into Mesas (ID_Mesa, CantidadAsientos) values (6, 6);
insert into Mesas (ID_Mesa, CantidadAsientos) values (7, 4);
insert into Mesas (ID_Mesa, CantidadAsientos) values (8, 4);
insert into Mesas (ID_Mesa, CantidadAsientos) values (9, 4);
insert into Mesas (ID_Mesa, CantidadAsientos) values (10, 2);
insert into Mesas (ID_Mesa, CantidadAsientos) values (11, 2);
insert into Mesas (ID_Mesa, CantidadAsientos) values (12, 2);
GO
--Tabla Reservas
insert into Reservas (ID_Reserva, FechaHora, ID_Persona, ID_Mesa, Estado) values (1, '2024-08-01 19:00:00', 604630096, 11, 'P');
insert into Reservas (ID_Reserva, FechaHora, ID_Persona, ID_Mesa, Estado) values (2, '2024-08-04 15:00:00', 604210014, 7, 'P');
GO