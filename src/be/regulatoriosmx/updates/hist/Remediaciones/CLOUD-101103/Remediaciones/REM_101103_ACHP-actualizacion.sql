--Buen dia favor de apoyarnos con los siguientes cambios de prospectos.
--PERTENECEN: Maria Antonieta Gijon Salazar
--USUARIO: magijon
--RE ASIGNACION: Jessica Corona Martinez
--USUARIO. jcorona

USE cobis 
go
--1.-
--actualizacion en la cl_ente de slovera a jcorona 
UPDATE cobis..cl_ente 
SET en_oficial    = 43,
    c_funcionario = 'jcorona',
    en_oficina    = 3348
WHERE en_ente in (388,384,389,387,379,382,376,374,185)

--2.-
--actualizacion en la ca_operacion de slovera a jcorona  
--*

UPDATE cob_cartera..ca_operacion 
SET op_oficial = 43 
WHERE op_cliente in (388,384,389,387,379,382,376,374,185)

go

--3.-
--actualizacion en la cr_tramite de slovera a jcorona 
--*
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = 'jcorona',
    tr_usuario_apr= 'jcorona',
    tr_oficial    = 43
WHERE tr_cliente in (388,384,389,387,379,382,376,374,185)

go
