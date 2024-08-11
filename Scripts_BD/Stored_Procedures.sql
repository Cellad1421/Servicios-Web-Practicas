
-------------------------------------------CRUD Personas
--Insertar datos en la Tabla Personas
CREATE PROCEDURE Personas_Insert
	@ID_Persona INT,
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Email VARCHAR(100),
    @Password VARCHAR(100),
    @Rol CHAR(1)
AS
BEGIN
    INSERT INTO Personas (ID_Persona, Nombre, Apellido, Email, [Password], Rol)
    VALUES (@ID_Persona, @Nombre, @Apellido, @Email, @Password, @Rol);
END;
GO

--Actualizar datos en la Tabla Personas
CREATE PROCEDURE Personas_Update
    @ID_Persona INT,
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Email VARCHAR(100),
    @Password VARCHAR(100),
    @Rol CHAR(1)
AS
BEGIN
    UPDATE Personas
    SET Nombre = @Nombre,
        Apellido = @Apellido,
        Email = @Email,
        [Password] = @Password,
        Rol = @Rol
    WHERE ID_Persona = @ID_Persona;
END;
GO

--Borrar datos en la Tabla Personas
CREATE PROCEDURE Personas_Delete
    @ID_Persona INT
AS
BEGIN
    DELETE FROM Reservas WHERE ID_Persona = @ID_Persona;
    DELETE FROM Meseros WHERE ID_Persona = @ID_Persona;
    DELETE FROM Empleados WHERE ID_Persona = @ID_Persona;
    DELETE FROM Personas WHERE ID_Persona = @ID_Persona;
END;
GO

--Buscar datos en la Tabla Personas
CREATE PROCEDURE Personas_Select
    @ID_Persona INT
AS
BEGIN
        SELECT 
       [ID_Persona] as [Codigo Persona]
      ,[Nombre] as [Nombres]
      ,[Apellido] as [Apellidos]
      ,[Email] as [Correo]
      ,[Password] as [Contrasena]
      ,[Rol] as [Rol Persona]
  FROM [Personas]
  WHERE ID_Persona = @ID_Persona;
END;
GO

-------------------------------------------CRUD Empleados
--Insertar datos en la Tabla Empleados
CREATE PROCEDURE Empleados_Insert
    @ID_Persona INT,
    @Rol CHAR(1),
    @Turno VARCHAR(50),
    @Estado CHAR(1)
AS
BEGIN
    INSERT INTO Empleados (ID_Persona, Rol, Turno, Estado)
    VALUES (@ID_Persona, @Rol, @Turno, @Estado);
END;
GO

--Actualizar datos en la Tabla Empleados
CREATE PROCEDURE Empleados_Update
    @ID_Persona INT,
    @Rol CHAR(1),
    @Turno VARCHAR(50),
    @Estado CHAR(1)
AS
BEGIN
    UPDATE Empleados
    SET Rol = @Rol,
        Turno = @Turno,
        Estado = @Estado
    WHERE ID_Persona = @ID_Persona;
END;
GO

--Borrar datos en la Tabla Empleados
CREATE PROCEDURE Empleados_Delete
    @ID_Persona INT
AS
BEGIN
    DELETE FROM Meseros WHERE ID_Persona = @ID_Persona;
    DELETE FROM Empleados WHERE ID_Persona = @ID_Persona;
END;
GO

--Buscar datos en la Tabla Empleados
CREATE PROCEDURE Empleados_Select
    @ID_Persona INT
AS
BEGIN
        SELECT 
            [ID_Persona] as [Codigo Empleado],
            [Rol] as [Rol Empleado],
            [Turno] as [Horario],
            [Estado] as [Actividad]
        FROM [Empleados]
        WHERE ID_Persona = @ID_Persona;
END;
GO


-------------------------------------------CRUD Meseros
--Insertar datos en la Tabla Meseros
CREATE PROCEDURE Meseros_Insert
    @ID_Persona INT,
    @MesasAtendidas INT
AS
BEGIN
    INSERT INTO Meseros (ID_Persona, MesasAtendidas)
    VALUES (@ID_Persona, @MesasAtendidas);
END;
GO

--Actualizar datos en la Tabla Meseros
CREATE PROCEDURE Meseros_Update
    @ID_Persona INT,
    @MesasAtendidas INT
AS
BEGIN
    UPDATE Meseros
    SET MesasAtendidas = @MesasAtendidas
    WHERE ID_Persona = @ID_Persona;
END;
GO

--Borrar datos en la Tabla Meseros
CREATE PROCEDURE Meseros_Delete
    @ID_Persona INT
AS
BEGIN
    DELETE FROM Meseros WHERE ID_Persona = @ID_Persona;
END;
GO

--Buscar datos en la Tabla Meseros
CREATE PROCEDURE Meseros_Select
    @ID_Persona INT
AS
BEGIN
        SELECT 
            [ID_Persona] as [Codigo Persona],
            [MesasAtendidas] as [Cantidad de Mesas Atendidas]
        FROM [Meseros]
        WHERE ID_Persona = @ID_Persona;
END;
GO

-------------------------------------------CRUD Mesas
--Insertar datos en la Tabla Mesas
CREATE PROCEDURE Mesas_Insert
	@Id_Mesa INT,
    @CantidadAsientos INT
AS
BEGIN
    INSERT INTO Mesas (ID_Mesa, CantidadAsientos)
    VALUES (@ID_Mesa, @CantidadAsientos);
END;
GO

--Actualizar datos en la Tabla Mesas
CREATE PROCEDURE Mesas_Update
    @ID_Mesa INT,
    @CantidadAsientos INT
AS
BEGIN
    UPDATE Mesas
    SET CantidadAsientos = @CantidadAsientos
    WHERE ID_Mesa = @ID_Mesa;
END;
GO

--Borrar datos en la Tabla Mesas
CREATE PROCEDURE Mesas_Delete
    @ID_Mesa INT
AS
BEGIN
    DELETE FROM Reservas WHERE ID_Mesa = @ID_Mesa;
    DELETE FROM Mesas WHERE ID_Mesa = @ID_Mesa;
END;
GO

--Buscar datos en la Tabla Mesas
CREATE PROCEDURE Mesas_Select
    @ID_Mesa INT
AS
BEGIN
        SELECT 
            [ID_Mesa] as [Codigo Mesa],
            [CantidadAsientos] as [Cantidad de Asientos]
        FROM [Mesas]
        WHERE ID_Mesa = @ID_Mesa;
END;
GO

-------------------------------------------CRUD Reservas
--Insertar datos en la Tabla Reservas
CREATE PROCEDURE Reservas_Insert
	@ID_Reserva INT,
    @FechaHora DATETIME,
    @ID_Persona INT,
    @ID_Mesa INT,
    @Estado CHAR(1)
AS
BEGIN
    INSERT INTO Reservas (ID_Reserva, FechaHora, ID_Persona, ID_Mesa, Estado)
    VALUES (@ID_Reserva, @FechaHora, @ID_Persona, @ID_Mesa, @Estado);
END;
GO

--Actualizar datos en la Tabla Reservas
CREATE PROCEDURE Reservas_Update
    @ID_Reserva INT,
    @FechaHora DATETIME,
    @ID_Persona INT,
    @ID_Mesa INT,
    @Estado CHAR(1)
AS
BEGIN
    UPDATE Reservas
    SET FechaHora = @FechaHora,
        ID_Persona = @ID_Persona,
        ID_Mesa = @ID_Mesa,
        Estado = @Estado
    WHERE ID_Reserva = @ID_Reserva;
END;
GO

--Borrar datos en la Tabla Reservas
CREATE PROCEDURE Reservas_Delete
    @ID_Reserva INT
AS
BEGIN
    DELETE FROM Reservas WHERE ID_Reserva = @ID_Reserva;
END;
GO

--Buscar datos en la Tabla Reservas
CREATE PROCEDURE Reservas_Select
    @ID_Reserva INT
AS
BEGIN
        SELECT 
            [ID_Reserva] as [Codigo Reserva],
            [FechaHora] as [Fecha y Hora de la Reserva],
            [ID_Persona] as [Cliente],
            [ID_Mesa] as [Codigo Mesa],
            [Estado] as [Estado de la Reserva]
        FROM [Reservas]
        WHERE ID_Reserva = @ID_Reserva;
END;
GO