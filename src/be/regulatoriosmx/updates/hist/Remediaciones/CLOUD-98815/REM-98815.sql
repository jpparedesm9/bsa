--El cliente #6407 Mari Cruz Cort�s P�rez actualmente se encuentra asignada 
--al asesor David Ju�rez se solicita el cambio al asesor Alberto Sandoval Barrios.

USE cobis 
go

--actualizacion en la cl_ente
UPDATE cobis..cl_ente 
SET    en_oficial=58,
       c_funcionario='asandovalba',
	   en_oficina=3345
 WHERE en_ente = 6407

go
