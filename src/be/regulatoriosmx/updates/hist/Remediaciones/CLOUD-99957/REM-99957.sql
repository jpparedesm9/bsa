--zturincio--ZAIRA TURINCIO PASCUAL--3348-Oficina Chalco--51
--jherrerame--JAIME HERRERA MENDEZ--3348-Oficina Chalco--68
USE cobis 
go
--1.-
--actualizacion en la cl_ente
UPDATE cobis..cl_ente SET en_oficial=68,
c_funcionario='jherrerame'
 WHERE en_ente 
 IN (8078, 8578)

go