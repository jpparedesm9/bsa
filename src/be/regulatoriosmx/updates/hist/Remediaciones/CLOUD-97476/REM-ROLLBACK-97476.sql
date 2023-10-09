
--fjramirez
--jibarron
USE cobis 
go
--1.-
--actualizacion en la cl_ente
UPDATE cobis..cl_ente SET en_oficial=54,
c_funcionario='fjramirez' WHERE en_ente 
IN
(4582)


SELECT en_oficial,c_funcionario,* FROM cobis..cl_ente WHERE en_ente IN (4582)

go