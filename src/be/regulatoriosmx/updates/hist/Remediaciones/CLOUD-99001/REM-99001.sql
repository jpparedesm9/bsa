--jjmondragon  66
--gdnegrete  97
USE cobis 
go
--1.-
--actualizacion en la cl_ente
UPDATE cobis..cl_ente SET en_oficial=97,
c_funcionario='gdnegrete' WHERE en_ente 
IN (1231)

SELECT * FROM cobis..cl_ente WHERE en_ente IN (1231)

go