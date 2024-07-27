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