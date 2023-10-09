--El cliente #6407 Mari Cruz Cortés Pérez actualmente se encuentra asignada 
--al asesor David Juárez se solicita el cambio al asesor Alberto Sandoval Barrios.

USE cobis 
go

--actualizacion en la cl_ente
UPDATE cobis..cl_ente 
SET    en_oficial=58,
       c_funcionario='asandovalba',
	   en_oficina=3345
 WHERE en_ente = 6407

go
