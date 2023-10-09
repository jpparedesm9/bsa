--ASESOR ASIGNADO: JOEL OROCIO Usuario: jcorocio-Correcto: jorocio - 112
--ASESOR A REASIGNAR: JOSE GUSTAVO HUESCA Usuario jghuesca-jghuescas      301  
--
--PROSPECTOS:
--9844 MARTINA GUADALUPE RODRGUEZ REYES

USE cobis 
go

declare @w_oficial_login varchar(14), @w_oficial_cod int
select @w_oficial_login = 'jghuescas' -- antes jorocio
select @w_oficial_cod = 301 -- antes 112

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login
WHERE  en_ente in (9844)
go

--ASESOR ASIGNADO: JOEL OROCIO Usuario: jcorocio-Correcto: jorocio -  112
--ASESOR A REASIGNAR: ANYULI MICHELLE GUTIERREZ GOMEZ Usuario amgutierrez-amgutierrez    130 
--
--7327 MARIA CONCEPCION CASTILLO HERNANDEZ

USE cobis 
go

declare @w_oficial_login varchar(14), @w_oficial_cod int
select @w_oficial_login = 'amgutierrez' -- antes jorocio
select @w_oficial_cod = 130 -- antes 112

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login
WHERE  en_ente in (7327)
go
