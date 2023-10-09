--DE: heolvera 44
--Hacia : ncastillora 48

USE cobis 
go
--1.-
--actualizacion en la cl_ente
UPDATE cobis..cl_ente SET en_oficial=48,
c_funcionario='ncastillora'
 WHERE en_ente 
 IN(8951,8953)

go