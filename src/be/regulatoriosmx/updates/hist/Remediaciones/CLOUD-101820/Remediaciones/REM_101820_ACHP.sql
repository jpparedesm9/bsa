--Buen dia se solicita la reasignacion de dos personas actualmente se 
--encuentra con el asesor JESSICA CORONA MARTINEZ USUARIO:ZTURINCIO y 
--el asesor que se va a reasignar es 
--a DANTE ALEJANDRO VAZQUEZ SAAVEDRA USUARIO: JCORONA

--3486 Elizabeth Hernandez Ibañez
--3568 Ofelia Ibañez Martinez

USE cobis
go

UPDATE cobis..cl_ente 
SET en_oficial    = 43,
    c_funcionario = 'jcorona',
    en_oficina    = 3348
WHERE en_ente in (3486,3568)

go
