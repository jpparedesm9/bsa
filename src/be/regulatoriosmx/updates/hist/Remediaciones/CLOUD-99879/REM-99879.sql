--DE: cyhuerta 77
--Hacia : egonzalezor 96

USE cobis 
go
--1.-
--actualizacion en la cl_ente
UPDATE cobis..cl_ente SET en_oficial=96,
c_funcionario='egonzalezor'
 WHERE en_ente 
 IN (9946,9935 )

go