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
        RAISERROR ('Solo los usuarios con el rol ''E'' de empleados, pueden hacer ingresar a esta tabla.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO Empleados (ID_Persona, Rol, Turno, Estado)
        SELECT ID_Persona, Rol, Turno, Estado
        FROM inserted;
    END
END;
