--adrigarciar--132--2379
--efaustino--105--2404

USE cobis 
go
--1.-
--actualizacion en la cl_ente
UPDATE cobis..cl_ente SET en_oficial=105,
c_funcionario='efaustino',en_oficina=2404
 WHERE en_ente IN(9035,9005 ,9436)

go