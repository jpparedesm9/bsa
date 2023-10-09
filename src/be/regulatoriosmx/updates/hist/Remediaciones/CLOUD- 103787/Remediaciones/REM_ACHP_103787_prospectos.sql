--Solicito de su apoyo para la reasignación de los clientes 
--al asesor jgalindo Jaqueline Galindo Reyes 
--y están actualmente con el usuario de Rocio Hernández Galindo con usuario rhernandezg.
--
--11373 MARIA DE LOS ANGELES SANCHEZ GARCIA
--11359 MA TERESA ESPINOZA RUIZ
--11207 BERTHA LORENZO GERONIMO
--11327 CASILDA ZAMORA ROSALES
--11181 MARIANA SANCHEZ MATA
--11177 MARIA SANCHEZ MATA


USE cobis 
go

declare @w_grupo int, @w_oficial_login varchar(14), @w_oficial_cod int, @w_oficina int
select @w_oficial_login = 'jgalindo'
select @w_oficial_cod = 172
select @w_oficina = 2404

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login,
       en_oficina    = @w_oficina
WHERE  en_ente in (11373,11359,11207,11327,11181,11177)
go
