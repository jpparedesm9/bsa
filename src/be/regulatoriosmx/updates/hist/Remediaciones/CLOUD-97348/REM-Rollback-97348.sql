
--drjuarez
--asandovalba
USE cobis 
go
--1.-
--actualizacion en la cl_ente
UPDATE cobis..cl_ente SET en_oficial=78,
c_funcionario='drjuarez' WHERE en_ente 
IN(4115,4102,4092,1809,4096)

SELECT * FROM cobis..cl_ente WHERE en_ente

 IN(4115,4102,4092,1809,4096) 


go