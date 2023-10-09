--SE SOLICITA REALIZAR EL UPDATE DE LA SIGUIENTE FORMA:
--CAMBIAR LA NOMBREOTORGANTE = “BANCO” POR “MICROFINANCIERA” DE LAS CUENTAS CON FECHAAPERTURACUENTA = "31012019"
--GRUPO PROMO 4441 - ALFOLI

declare @w_grupo int
select  @w_grupo = 4441

select bc_nombre_otorgante, bc_fecha_apertura_cuenta, * 
from cob_credito..cr_buro_cuenta 
where bc_id_cliente in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo and cg_estado = 'V')

update cob_credito..cr_buro_cuenta
set    bc_nombre_otorgante = 'MICROFINANCIERA' -- antes: BANCO solo el cliente  111039 los demas estan con MICROFINANCIERA
where  bc_fecha_apertura_cuenta = '31012019'
and    bc_id_cliente in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo and cg_estado = 'V')

select bc_nombre_otorgante, bc_fecha_apertura_cuenta, * 
from cob_credito..cr_buro_cuenta 
where bc_id_cliente in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo and cg_estado = 'V')

go
