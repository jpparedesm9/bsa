/*************************************************************************/
/*   Archivo:            sp_cal_pagos_elavon.sp                          */
/*   Stored procedure:   sp_cal_pagos_elavon                             */
/*   Base de datos:      cobis                                           */
/*   Producto:           Cartera                                         */
/*   Disenado por:       PEDRO ROMERO A.                                 */
/*   Fecha de escritura: 27/10/2020                                      */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'MACOSA', representantes exclusivos para el Ecuador de NCR          */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBISCORP o su representante.              */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este programa calcula el numero de pagos completos elavon           */
/*************************************************************************/
/*                               OPERACIONES                             */
/*   OPER. OPCION                     DESCRIPCION                        */
/*     C                    Ejecuta la matriz                            */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA        AUTOR                       RAZON                      */
/* 27/10/2018   PRO         	     Version Inicial                     */
/* 02/09/2022   DCU                  Caso Cambio #189772                 */
/*************************************************************************/
use cob_cartera
go

if object_id ('sp_cal_pagos_elavon') is not null
   drop procedure sp_cal_pagos_elavon
go

create proc sp_cal_pagos_elavon (
       @i_operacion int,
	   @i_debug		char(1) = 'N',
	   @o_num_pagos	int = 0 out
)
as

declare @w_referencia_grupal varchar(14)

select @w_referencia_grupal = op_banco
from cob_cartera..ca_operacion
where op_operacion = @i_operacion

--Validacion por secuenciales
SELECT cd_sec_ing, cd_operacion, co_monto INTO #temp_corresp 
FROM ca_corresponsal_det, ca_corresponsal_trn
WHERE cd_secuencial = co_secuencial
and co_corresponsal='ELAVON'
AND co_codigo_interno= @i_operacion 
AND co_estado in('P','I')

--SELECT * FROM #temp_corresp
SELECT ab_secuencial_ing, ab_secuencial_pag, ab_operacion
INTO #temp_corresp_montos_div
FROM ca_abono, #temp_corresp 
WHERE ab_operacion=cd_operacion 
and ab_estado <> 'RV'
AND cd_sec_ing=ab_secuencial_ing

--validacion por montos.
create table #operaciones_hijas (tg_operacion int)

insert into #operaciones_hijas
select tg_operacion
from cob_credito..cr_tramite_grupal
where tg_referencia_grupal = @w_referencia_grupal
and  tg_referencia_grupal <> tg_prestamo
and  tg_participa_ciclo = 'S'

if (select count(1) from #operaciones_hijas) = 0
begin
   insert into #operaciones_hijas (tg_operacion) values(@i_operacion)
end 

select di_dividendo, di_fecha_ini, di_fecha_ven, cuota = sum(am_cuota)
into #valores_operaciones
from #operaciones_hijas,
cob_cartera..ca_dividendo,
cob_cartera..ca_amortizacion
where di_operacion = tg_operacion
and   di_operacion = am_operacion
and   di_dividendo = am_dividendo
group by di_dividendo,di_fecha_ini, di_fecha_ven

SELECT dtr_dividendo, monto_pago = sum(dtr_monto) 
into #pagos_elavon_dividendo
FROM #temp_corresp_montos_div,
     cob_cartera..ca_det_trn  
WHERE dtr_operacion =ab_operacion
AND dtr_secuencial=ab_secuencial_pag
and dtr_concepto <> 'VAC0'
group by dtr_dividendo

select @o_num_pagos=count(1)
from #valores_operaciones,
#pagos_elavon_dividendo
where di_dividendo = dtr_dividendo
and   monto_pago   = cuota

print '@o_num_pagos: ' + convert(varchar(20),@o_num_pagos)

return 0
go
