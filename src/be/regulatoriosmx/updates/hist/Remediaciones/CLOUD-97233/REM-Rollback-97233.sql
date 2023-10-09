USE cobis 
go
--1.-
--actualizacion en la cl_ente
UPDATE cobis..cl_ente SET en_oficial=77,
c_funcionario='cyhuerta' WHERE en_ente 
IN(3211,3221)

SELECT * FROM cobis..cl_ente WHERE en_ente IN (3211,3221)

go