use cobis
GO

set nocount on
 
declare 
     @w_rol      int,
     @w_moneda   tinyint,
     @w_producto tinyint

select @w_producto = 4

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
  from cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'
   

delete from cobis..ad_procedure
where pd_stored_procedure = 'sp_rem_parctocble'


delete cobis..ad_pro_transaccion
where  pt_producto = 4 and  pt_transaccion = 719  and pt_moneda = @w_moneda  and pt_tipo = 'R' 

delete cl_ttransaccion
 where tn_trn_code in (719)
 
delete ad_tr_autorizada 
where ta_producto = @w_producto
   and ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_transaccion = 719
 
--Validados en  
--\CtaAhorro\backend\sql\ah_protran.sql
--\CtaAhorro\backend\sql\ah_tran.sql
--\CtaAhorro\backend\sql\ah_traut.sql

INSERT INTO cobis..ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (708, 'sp_rem_parctocble', 'cob_remesas', 'V', getdate(), 'rem_parctocble')

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 719, 'V', getdate(), 708, NULL)

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (719, 'CONSULTA CONCEPTO CONTABLE', 'CPCC', 'CONSULTA CONCEPTO CONTABLE')
  
INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 719, @w_rol, getdate(), 1, 'V', getdate())




DELETE FROM cobis..an_role_page 
WHERE rp_pa_id IN (SELECT pa_id FROM cobis..an_page 
                    WHERE pa_name IN ('PP.CTA.FTran493','PP.CTA.FConcTrn'))
go

use cob_remesas
go


declare @w_return              int,
        @w_codigo              int,
        @w_descripcion         varchar(100),
        @w_fecha_proceso       datetime

select @w_descripcion = 'AHORRO NORMAL',
       @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

   
-- ..\Person\Backend\sql\pe_parametria.sql

-- Producto Bancario CUENTA NORMAL
	if exists(select 1 from cobis..cl_parametro where pa_producto = 'AHO' and pa_nemonico = 'PCANOR')
	begin
		print 'Parámetro ya existe ' + 'AHO' + '-- PCANOR'
    end
	else
	begin
		INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
			VALUES ( @w_descripcion, 'PCANOR', 'I', NULL, NULL, NULL, @w_codigo, NULL, NULL, NULL, 'AHO')
	
	if @@error != 0 
		print 'Error al crear cl_parametro PCANOR'

    end
go

