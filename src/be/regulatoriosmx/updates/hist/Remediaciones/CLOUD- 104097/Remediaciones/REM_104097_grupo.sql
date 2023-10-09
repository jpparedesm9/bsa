--Buenos días,
--Se solicita realizar la reasignacion al asesor correcto.
--Asesor actual María de los Ángeles Obregón Elizalde con usuario mobregon 
--Asesor para reasignar Jorge Armando Piña Salazar con usuario japina.
--
--Usuarios
--6748 AMERICA ANAHI RAMIREZ GALINDO
--6751 AMERICA JOCELYN PACHECO MARTINEZ
--6908 GRACIELA JACQUELINE VELASCO RODRIGUEZ
--6909 LEONILA JIMENEZ GONZALEZ
--6911 DONOVAN MARTINEZ GONZALEZ
--6912 MA DE LOURDES BELLO VALVERDE
--6913 VIRIDIANA JAQUELINE BARRERA BELLO
--7008 ALEJANDRA CALDERON MALDONADO
--7064 SILVIA RODRIGUEZ ACEVEDO
--7166 SAMANTA CORZO ARAGON
--
--Grupo Arboleda id 271

USE cobis 
go

declare @w_grupo int, @w_oficial_login varchar(14), @w_oficial_cod int, @w_oficina int
select @w_grupo = 271
select @w_oficial_login = 'japina'
select @w_oficial_cod = 160
select @w_oficina = 2381

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login,
       en_oficina    = @w_oficina
WHERE  en_ente in (6748,6751,6908,6909,6911,6912,6913,7008,7064,7166)

UPDATE cob_cartera..ca_operacion 
SET    op_oficial = @w_oficial_cod 
WHERE  op_cliente in (6748,6751,6908,6909,6911,6912,6913,7008,7064,7166)

UPDATE cob_credito..cr_tramite 
SET    tr_usuario    = @w_oficial_login,
       tr_usuario_apr= @w_oficial_login,
       tr_oficial    = @w_oficial_cod
WHERE  tr_cliente in (6748,6751,6908,6909,6911,6912,6913,7008,7064,7166)

UPDATE cob_cartera..ca_operacion_his 
SET    oph_oficial = @w_oficial_cod 
WHERE  oph_cliente in (6748,6751,6908,6909,6911,6912,6913,7008,7064,7166)

--Grupo
update cobis..cl_grupo
set    gr_oficial = @w_oficial_cod
where  gr_grupo   = @w_grupo

update cobis..cl_cliente_grupo  
set    cg_usuario = @w_oficial_login
where  cg_grupo   = @w_grupo
and    cg_ente  in (6748,6751,6908,6909,6911,6912,6913,7008,7064,7166)

UPDATE cob_cartera..ca_operacion 
SET    op_oficial = @w_oficial_cod 
WHERE  op_cliente = @w_grupo

UPDATE cob_credito..cr_tramite
SET    tr_usuario     = @w_oficial_login,
       tr_usuario_apr = @w_oficial_login,
       tr_oficial     = @w_oficial_cod
WHERE  tr_cliente     = @w_grupo

go
