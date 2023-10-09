--SOLICITAMOS DE SU APOYO PARA EL CAMBIO DE CUENTA DEL CLIENTE 58850 ALICIA SAAVEDRA GOMEZ
--CUENTA INCORRECTA 56750907263
--CUENTA CORRECTA 250018499525 -- escrito
--                25001849525  -- en la imagen

use cobis
go

print 'Caso 111629 - Cliente: 58850'
declare @w_cliente int, @w_cuenta varchar(24)
select @w_cliente = 58850
select @w_cuenta = '25001849525' -- antes cuenta 56750907263

select 'CUENTA' = ea_cta_banco, * from cobis..cl_ente_aux where ea_ente = @w_cliente
update cobis..cl_ente_aux 
set    ea_cta_banco = @w_cuenta
where ea_ente = @w_cliente

go
