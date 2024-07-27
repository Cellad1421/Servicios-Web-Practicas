Use TicoGourmet
Go

insert into Personas (ID_Persona, Nombre, Apellido, Email, [Password], Rol) values (118000943, 'Jose Andres', 'Gomez Castro', 'jgomezc943@gmail.com', '1234', 'E');
insert into Personas (ID_Persona, Nombre, Apellido, Email, [Password], Rol) values (604630096, 'Luis Alfredo', 'Castro Castro', 'lcastroc096@gmail.com', '5678', 'C');
insert into Personas (ID_Persona, Nombre, Apellido, Email, [Password], Rol) values (604210014, 'Kevin Daniel', 'Garcia Sibaja', 'kgarcias021@gmail.com', '12345678', 'C');
insert into Personas (ID_Persona, Nombre, Apellido, Email, [Password], Rol) values (414630201, 'Elend', 'Venture', 'eventure028@gmail.com', 'Luthadel5678', 'E');

insert into Empleados (ID_Persona, Rol, Turno, Estado) values (118000943, 'M', 'Diurno', 'A');
insert into Empleados (ID_Persona, Rol, Turno, Estado) values (414630201, 'M', 'Diurno', 'A');

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


insert into Reservas (ID_Reserva, FechaHora, ID_Persona, ID_Mesa, Estado) values (1, '2024-08-01 19:00:00', 604630096, 11, 'P');
insert into Reservas (ID_Reserva, FechaHora, ID_Persona, ID_Mesa, Estado) values (2, '2024-08-04 15:00:00', 604210014, 7, 'P');