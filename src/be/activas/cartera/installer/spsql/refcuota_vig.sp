/************************************************************************/
/*   Archivo:              refcuota_vig.sp                              */
/*   Stored procedure:     sp_cons_ref_cuota_vigente                    */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         SMO                                          */
/*   Fecha de escritura:   Mayo/2019                                    */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                           PROPOSITO                                  */
/*   Procedimiento para consultar la información de referencia de       */
/*   Pago Corresponsal para enviar por mail                             */
/************************************************************************/
/*                              CAMBIOS                                 */
/*      FECHA                   AUTOR         CAMBIO                    */
/*  05/22/2019        Santiago Mosquera    Emisión Inicial              */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_cons_ref_cuota_vigente')
   drop proc sp_cons_ref_cuota_vigente
go

create proc sp_cons_ref_cuota_vigente
(
    @i_banco       cuenta	 = null
)
as 

select 
'fecha_inicio'    = grv_op_fecha_liq, 
'nombre_cliente'  = grv_grupo_name,
'fecha_vigencia'  = grv_di_fecha_vig, 
'nro_pago'        = grv_di_dividendo,
'monto'           = grv_di_monto,
'sucursal'        = of_nombre,
'mail1'           = grv_dest_email1, 
'mail2'           = grv_dest_email2,
'mail3'           = grv_dest_email3
from
ca_gen_ref_cuota_vigente,cobis..cl_oficina
where grv_op_oficina = of_oficina

select 
'institucion' = grvd_institucion,
'referencia'  = grvd_referencia,
'convenio'    = grvd_convenio
from ca_gen_ref_cuota_vigente_det
   
return 0
go

