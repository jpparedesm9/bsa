
/* ***********************************************/
---No Bug: 77134
---Título del Bug: 
---Fecha: 18/Jul/2016
--Descripción del Problema: Autorización de transacciones y procedimiento
--Descripción de la Solución: Se registra procedimiento y producto transaccion, 
--Autor: Walther Toledo
/* *************************************************/
print 'Transacciones Remesas'
use cobis
go
-- --------------------------------------------Seccion 1-------------------------------------------------------------
declare @w_rol      int,
        @w_moneda   tinyint,
        @w_producto tinyint

select @w_rol = ro_rol
from ad_rol
-- where ro_descripcion like 'ADMINISTRADOR'
where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
from  cobis..cl_parametro
where pa_nemonico = 'CMNAC'
and   pa_producto = 'ADM'

select @w_producto = 10 --->PRODUCTO 10 - REMESAS

-- -----------------------------------> re_protran.sql

delete from ad_pro_transaccion where pt_producto=@w_producto and pt_moneda=@w_moneda and pt_transaccion=740 and pt_procedure=717
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, 740, 'V', getdate(), 717, NULL)

-- -----------------------------------> re_proc.sql
delete from ad_procedure where pd_procedure=717
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (717, 'sp_causal_ndc_oficina', 'cob_remesas', 'V', getdate(), 'causndcofi.sp')

-- --------------------------------------------Seccion 2-------------------------------------------------------------
-- -----------------------------------> cc_proc.sql
delete from ad_procedure where pd_procedure = 49
INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (49, 'sp_casilla', 'cob_cuentas', 'V', getdate(), 'casi.sp')

go

