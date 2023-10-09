--ljimenezp--LUIS BERNARDO RAFAEL JIMENEZ PALE--2379-Oficina ATIZAPAN--119
--mghernandezba--María Guadalupe Hernández Barrio--2379-Oficina ATIZAPAN--143

USE cobis 
go
--1.-
--actualizacion en la cl_ente
UPDATE cobis..cl_ente SET en_oficial=143,
c_funcionario='mghernandezba'
 WHERE en_ente 
 IN (6787)

go