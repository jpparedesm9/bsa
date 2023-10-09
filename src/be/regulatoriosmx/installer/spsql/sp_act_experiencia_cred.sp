/************************************************************************/
/*   Archivo:                 sp_act_experiencia_cred.sp                */
/*   Stored procedure:        sp_act_experiencia_cred                   */
/*   Base de Datos:           cob_cartera                               */
/*   Producto:                Cartera                                   */
/*   Disenado por:                                                      */
/*   Fecha de Documentacion:  11 de Noviembre de 2019                   */
/************************************************************************/
/*                            IMPORTANTE                                */
/*   Este programa es parte de los paquetes bancario s propiedad de     */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier autorizacion o agregado hecho por alguno de sus          */
/*   usuario sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante                 */
/************************************************************************/
/*                         PROPOSITO                                    */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*   Fecha      Nombre            Proposito                             */
/*   11/11/2019 Miguel Escalona   Emision Inicial                       */
/*   15/09/2020 Juan Sarzosa      Optimizacion                          */
/************************************************************************/

use cob_conta_super
go

if not object_id('sp_act_experiencia_cred') is null
   drop proc sp_act_experiencia_cred
go

CREATE proc [dbo].[sp_act_experiencia_cred]
   
as 

DECLARE 
@w_fecha_ini         DATE, 
@w_fecha_proceso     DATE,
@w_est_cancelado     TINYINT,
@w_param_cc_abiertas INT,
@w_param_cc_cerradas INT 

select @w_param_cc_abiertas = pa_int 
from cobis..cl_parametro
where pa_nemonico = 'NDCCAB'

select @w_param_cc_cerradas = pa_int 
from cobis..cl_parametro
where pa_nemonico = 'NDCCCE'

/*DETERMINAR LA FECHA DE PROCESO */
select 
@w_fecha_proceso = fc_fecha_cierre,
@w_fecha_ini     = dateadd(dd,1-datepart(dd,fc_fecha_cierre), fc_fecha_cierre)
from cobis..ba_fecha_cierre
where fc_producto = 7

/* ESTADOS DE CARTERA */
exec cob_cartera..sp_estados_cca
@o_est_cancelado  = @w_est_cancelado out

select DISTINCT cop_cliente = op_cliente, cop_resultado = 'N'
into #operaciones
from cob_cartera..ca_operacion , cob_cartera..ca_estado
where op_estado   = es_codigo
and  (es_procesa  = 'S' 
      --> OPERACIONES CANCELADAS DURANTE EL MES DE PROCESO
      or (op_estado=@w_est_cancelado and op_fecha_ult_proceso between @w_fecha_ini and @w_fecha_proceso)     
      
      --> OPERACIONES CANCELADAS DURANTE EL MES DE PROCESO CON FECHA VALOR A MESES ANTERIORES)
      or (op_estado=@w_est_cancelado and op_fecha_ult_proceso < @w_fecha_ini and op_fecha_ult_mov between @w_fecha_ini and @w_fecha_proceso)
      -- OPERACIONES REVOLVENTES QUE AUN NO TERMINAN O TERMINARON EN EL MES DE PROCESO
      or (op_tipo_amortizacion = 'ROTATIVA' and op_fecha_fin >= @w_fecha_ini) 
     )
ORDER BY op_cliente 
	     
create CLUSTERED index idx1 on #operaciones(cop_cliente)

SELECT 'TOTAL CLIENTE' = count(1) FROM #operaciones

/*APERTURAS*/
select DISTINCT
fecha = ib_fecha,
apertura = convert(DATE, substring(bc_fecha_apertura_cuenta, 1, 2) + '/' + substring(bc_fecha_apertura_cuenta, 3, 2) + '/' + substring(bc_fecha_apertura_cuenta, 5, 4),103),
cliente = ib_cliente,
resultado = 'N',
dias = convert(INT, 0)
INTO #aperturas
from cob_credito..cr_buro_cuenta, cob_credito..cr_interface_buro, #operaciones
where ib_cliente             = cop_cliente
AND   bc_ib_secuencial = ib_secuencial
and   bc_fecha_cierre_cuenta is  null 
and   bc_nombre_otorgante    not in ( select c.valor from
                                      cobis..cl_tabla t,cobis..cl_catalogo c
                                      where  t.tabla  = 'cr_tipo_negocio'
                                      and t.codigo = c.tabla )
and   ib_estado              = 'V'
ORDER BY ib_cliente

UPDATE #aperturas SET dias = datediff(dd, apertura, fecha)
UPDATE #aperturas SET resultado = 'S' WHERE dias > @w_param_cc_abiertas

UPDATE #operaciones
SET cop_resultado = resultado
FROM #aperturas
WHERE cop_cliente = cliente
AND resultado = 'S'

/*CIERRES*/
select DISTINCT 
fecha = ib_fecha,
cierre = convert(DATE, substring(bc_fecha_cierre_cuenta, 1, 2) + '/' + substring(bc_fecha_cierre_cuenta, 3, 2) + '/' + substring(bc_fecha_cierre_cuenta, 5, 4),103),
cliente = ib_cliente,
resultado = 'N',
dias = convert(INT, 0)
INTO #cierres
from cob_credito..cr_buro_cuenta,cob_credito..cr_interface_buro, #operaciones
WHERE ib_cliente = cop_cliente
AND cop_resultado = 'N'
AND bc_ib_secuencial = ib_secuencial
and bc_fecha_cierre_cuenta is not null 
and bc_nombre_otorgante not in (select c.valor from
                                cobis..cl_tabla t,cobis..cl_catalogo c
                                where  t.tabla  = 'cr_tipo_negocio'
                                and t.codigo = c.tabla)
and ib_estado = 'V'
ORDER BY ib_cliente

UPDATE #cierres SET dias = datediff(dd, cierre, fecha)

UPDATE #cierres SET resultado = 'S' WHERE dias < @w_param_cc_cerradas

UPDATE #operaciones
SET cop_resultado = resultado
FROM #cierres
WHERE cop_cliente = cliente
AND resultado = 'S'
AND cop_resultado = 'N'

update cobis..cl_ente_aux 
set ea_experiencia = cop_resultado
FROM #operaciones 
where ea_ente = cop_cliente

return 0
GO

