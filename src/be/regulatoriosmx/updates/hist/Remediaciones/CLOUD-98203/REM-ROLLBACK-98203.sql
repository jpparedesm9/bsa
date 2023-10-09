--JESSYCA LOZADA CERVANTES id=90 oficina=2381 login=jlozadace
--OSCAR AGUSTIN MENDOZA VILCHIS id=47 oficina=3348 login=oamendozavi

USE cobis 
go
--1.-
--actualizacion en la cl_ente
UPDATE cobis..cl_ente SET en_oficial=90,
c_funcionario='jlozadace',en_oficina=2381
 WHERE en_ente IN(6451,6458,6465,6604)

go