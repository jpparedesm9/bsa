use cobis
go

delete  from cobis..cl_parametro where pa_nemonico = 'CRFINP' and pa_producto = 'CON'
delete  from cobis..cl_errores where numero in (601315, 601316,601317,601318, 601319, 601320)

                 

use cob_conta
go

delete from cob_conta..cb_listado_reportes_reg where lr_reporte = 'CIERRE' 
                      
declare 
	@w_proceso_cierre   INT ,
	@w_nemonico         VARCHAR(6),
	@w_secuencial       INT ,
	@w_mes_ing          SMALLINT,
	@w_ctr_cuenta_mn    VARCHAR(30),
	@w_ctr_cuenta_usd   VARCHAR(30),
	@w_moneda_mn        SMALLINT,
	@w_moneda_usd       SMALLINT

SELECT @w_proceso_cierre  = 6078 --- CIERRE DE CUENTAS DE PYG 
SELECT @w_nemonico        = 'MESFPE'
SELECT @w_mes_ing         = 1
SELECT @w_ctr_cuenta_mn   = '420301'
SELECT @w_ctr_cuenta_usd  = '420302'
SELECT @w_moneda_mn       = 0
SELECT @w_moneda_usd      = 1
--///////////////////////////////

DELETE FROM cobis..cl_parametro WHERE pa_nemonico = @w_nemonico
DELETE cb_cuenta_proceso WHERE cp_empresa = 1 AND cp_proceso = @w_proceso_cierre
DELETE cb_cuenta_asociada WHERE ca_empresa = 1 AND ca_proceso = @w_proceso_cierre
