--ASESOR ASIGNADO: Jorge Alberto Villa Bahena Usuario AVILLA-javilla        195 
--ASESOR A REASIGNAR: Janette Martinez Valdez Usuario JMARTINEZVA-jmartinezva    163
--
--CLIENTE
--17168 - SANTA OLVERA ALARCON


USE cobis 
go

declare @w_oficial_login varchar(14), @w_oficial_cod int
select @w_oficial_login = 'javilla' -- antes javilla
select @w_oficial_cod = 195 -- antes 195

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login
WHERE  en_ente in (17168)
go
