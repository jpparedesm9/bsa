/************************************************************************/
/*      Archivo           :  rptdeceval.sp                              */
/*      Base de datos     :  cob_pfijo                                  */
/*      Producto          :  Plazo Fijo                                 */
/*      Disenado por      :  Jorge Vidal Z.                             */
/*      Fecha de escritura:  21/Sep/16                                  */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este reporte lista los depositos aprobados y rechazados por     */
/*      DECEVAL.                                                        */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR           RAZON                           */
/*      05/OCT/16     J. Vidal Z        Emision Inicial                 */ 
/*      05-Ene-2017   N. Martillo       Ajustes VBatch                  */
/************************************************************************/
use cob_pfijo
go
 
SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'rptdeceval')
  drop procedure rptdeceval
go
create procedure  rptdeceval
with encryption
as declare
   @w_sp_name            varchar(32),
   @w_retorno            int,
   @w_retorno_ej         int,
   @w_error_msg          varchar(250),
   @w_fecha_proceso datetime
   
Select @w_sp_name = 'rptdeceval'

select @w_fecha_proceso = fp_fecha
from   cobis..ba_fecha_proceso

truncate table cob_reportes..rep_dpf_deceval    
    
insert into cob_reportes..rep_dpf_deceval(    
    de_archivo,          de_num_banco,          de_op_deceval,
    de_isin,             de_monto,              de_observacion,
    de_tipo_ced,
    de_ced_ruc,
    de_nomlar,
    de_num_dias,         de_tasa_efectiva,    de_fecha_ven,
    de_ppago,            de_operacion,        de_estado,
    de_archivo_out)
    SELECT
    de_archivo,          op_num_banco,         de_op_deceval,
    de_isin,             op_monto,             de_observacion,
    (select en_tipo_ced from cobis..cl_ente where en_ente = O.op_ente),
    (select en_ced_ruc  from cobis..cl_ente where en_ente = O.op_ente),
    (SELECT case when en_subtipo = 'P' then en_nombre + ' ' + p_p_apellido  + ' ' + p_s_apellido else en_nomlar end 
            from cobis..cl_ente where en_ente = O.op_ente),
    op_num_dias,         op_tasa_efectiva,     op_fecha_ven,
    op_ppago,            op_operacion,         op_estado,
    ed_archivo_out
    from   cob_pfijo..pf_det_envios_dcv,
           cob_pfijo..pf_envios_dcv, 
           cob_pfijo..pf_operacion O,
           cobis..cl_oficina
    where  op_operacion = de_operacion
    and    op_oficina   = of_oficina
    and    de_archivo   = ed_archivo  
if @@rowcount = 0
begin
    select @w_retorno_ej = 14000,
           @w_error_msg = '[' + @w_sp_name + '] ' + 'No existen Registros Consultados'
    goto ERROR
end

return 0

ERROR:

exec @w_retorno     = cob_pfijo..sp_errorlog
     @i_fecha       = @w_fecha_proceso, 
     @i_error       = @w_retorno_ej, 
     @i_usuario     = 'OPERADOR',
     @i_tran        = 14000, 
     @i_tran_name   = @w_sp_name, 
     @i_rollback    = 'N',
     @i_cuenta      = 'sp_rptnewinv', 
     @i_descripcion = @w_error_msg

if @w_retorno > 0
    return @w_retorno
else
    return @w_retorno_ej 


GO
