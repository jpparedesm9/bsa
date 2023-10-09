/******************************************************/
--Fecha Creación del Script: 2016/06/24               */
--Insertar Transacciones autorizadas 4145             */
--Modulo : AHORROS                                    */
/******************************************************/
use cobis
go
-- ---------------------------------------------------------------------------------------------------------
declare @w_rol      int,
        @w_moneda   tinyint,
        @w_producto TINYINT,
        @w_transaccion int
        
select @w_rol = ro_rol
from ad_rol
-- where ro_descripcion like 'ADMINISTRADOR'
where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
from  cobis..cl_parametro
where pa_nemonico = 'CMNAC'
and   pa_producto = 'ADM'

select @w_producto = 4 --->AHORR

select @w_transaccion = 4145

if not exists (select 1 from cl_ttransaccion where tn_trn_code = @w_transaccion)
BEGIN
    INSERT cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
    VALUES (@w_transaccion, 'ACTIVACION DE CUENTAS SIN DEPOSITO INICIAL', '4145', 'ACTIVACION DE CUENTAS SIN DEPOSITO INICIAL')
end
GO
