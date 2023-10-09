--El cliente #6407 Mari Cruz Cortés Pérez actualmente se encuentra asignada 
--al asesor David Juárez se solicita el cambio al asesor Alberto Sandoval Barrios.

USE cobis 
go
--1.-
--actualizacion en la cl_ente
UPDATE cobis..cl_ente 
SET    en_oficial=78,
       c_funcionario='drjuarez',
	   en_oficina=3345
 WHERE en_ente = 6407

go
