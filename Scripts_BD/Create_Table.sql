Use TicoGourmet
Go

CREATE TABLE Personas (
    ID_Persona INT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    [Password] VARCHAR(100) NOT NULL,
    Rol CHAR(1) CHECK (Rol IN ('E', 'C')) NOT NULL,--E: Empleado C: Cliente
);

CREATE TABLE Empleados (
    ID_Persona INT NOT NULL,
    Rol CHAR(1) CHECK (Rol IN ('M', 'C', 'D')) NOT NULL,-- M: Mesero C: Chef D: Dependiente
    Turno VARCHAR(50) NOT NULL,
    Estado CHAR(1) CHECK (Estado IN ('A', 'I')) NOT NULL,-- A: Activo I: Inactivo
    PRIMARY KEY (ID_Persona),
    CONSTRAINT FK_Empleados_Personas FOREIGN KEY (ID_Persona) REFERENCES Personas(ID_Persona)
);

CREATE TABLE Meseros (
    ID_Persona INT NOT NULL,
    MesasAtendidas INT NOT NULL,
    PRIMARY KEY (ID_Persona),
    CONSTRAINT FK_Meseros_Empleados FOREIGN KEY (ID_Persona) REFERENCES Empleados(ID_Persona)
);

CREATE TABLE Mesas (
    ID_Mesa INT PRIMARY KEY,
    CantidadAsientos INT NOT NULL
);

CREATE TABLE Reservas (
    ID_Reserva INT PRIMARY KEY,
    FechaHora DATETIME NOT NULL,
    ID_Persona INT NOT NULL,
    ID_Mesa INT NOT NULL,
    Estado CHAR(1) CHECK (Estado IN ('P', 'C')) NOT NULL,-- P: Pendiente C: Cerrada
    CONSTRAINT FK_Reservas_Personas FOREIGN KEY (ID_Persona) REFERENCES Personas(ID_Persona),
    CONSTRAINT FK_Reservas_Mesas FOREIGN KEY (ID_Mesa) REFERENCES Mesas(ID_Mesa)
);
