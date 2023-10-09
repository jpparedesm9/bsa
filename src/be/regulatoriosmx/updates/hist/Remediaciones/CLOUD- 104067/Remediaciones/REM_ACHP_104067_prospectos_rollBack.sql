--Buen dia favor de reasignar a los prospectos en mencion.
--
--Maria del Carmen Genchi Marban 27615
--ASESOR ACTUAL: RAUL MARTINEZ RIOS rmartinezrio
--ASESOR PARA REASIGNAR: RAFAEL AQUINO ALTAMIRANO raquino.
--
--Martha de la Vega Mendoza 27598
--ASESOR ACTUAL: RAUL MARTINEZ RIOS rmartinezrio
--ASESOR PARA REASIGNAR: RAFAEL AQUINO ALTAMIRANO raquino.

USE cobis 
go

declare @w_grupo int, @w_oficial_login varchar(14), @w_oficial_cod int, @w_oficina int
select @w_oficial_login = 'rmartinezrio'
select @w_oficial_cod = 260
select @w_oficina = 1037

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login,
       en_oficina    = @w_oficina
WHERE  en_ente in (27615,27598)
go

