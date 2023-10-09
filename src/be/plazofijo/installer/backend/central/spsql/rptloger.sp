/************************************************************************/
/*      Archivo           :  rptloger.sp                                */
/*      Stored procedure  :  sp_rptloger                                */
/*      Base de datos     :  cob_pfijo                                  */
/*      Producto          :  Plazo_fijo                                 */
/*      Realizado por     :  Nancy Martillo                             */
/*      Fecha de escritura:  05/10/2016                                 */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Este reporte, lista los diferentes errores producidos durante la    */
/*  corrida en batch de los procesos de fin de dia e inicio de dia.     */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*  FECHA        AUTOR                RAZON                             */
/*  05-Oct-2016  N.Martillo           Emisión Inicial                   */
/*  05-Ene-2017  N. Martillo          Ajustes VBatch                    */
/************************************************************************/

use cob_pfijo
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_rptloger')
  drop procedure sp_rptloger
go
create procedure  sp_rptloger
with encryption
as declare @w_sp_name            varchar(32), 
           @w_retorno            int,
           @w_retorno_ej         int,
           @w_error_msg          varchar(250),
           @w_tabla              varchar(250),
           @w_fecha_proceso      datetime
   
select @w_sp_name = 'sp_rptloger'

select @w_fecha_proceso = fp_fecha
from   cobis..ba_fecha_proceso

delete from cob_reportes..rep_dpf_loger

insert into cob_reportes..rep_dpf_loger (
lo_fecha_proc,       lo_cuenta,         lo_nombre,            lo_id_error,
lo_mensaje_error,    lo_descripcion,    lo_cta_pagrec,        lo_tran,
lo_usuario)
select
er_fecha_proc,        er_cuenta,        op_descripcion,        er_error,
mensaje,              er_descripcion,   er_cta_pagrec,         er_tran,
er_usuario
from  cobis..cl_errores,
      cob_pfijo..pf_errorlog LEFT JOIN cob_pfijo..pf_operacion on er_cuenta = op_num_banco
where er_error = numero and er_cuenta = op_num_banco

if @@error <> 0 
    begin 
        select @w_retorno_ej = 14000, @w_tabla = 'cob_reporte..rep_dpf_loger',
            @w_error_msg = '[' + @w_sp_name + '] ' + 'Error al registrar datos en ' + '- ' + @w_tabla
        goto ERROR 
     End   
return 0

ERROR:

exec @w_retorno     = cob_pfijo..sp_errorlog
     @i_fecha       = @w_fecha_proceso, 
     @i_error       = @w_retorno_ej, 
     @i_usuario     = 'OPERADOR',
     @i_tran        = 14000, 
     @i_tran_name   = @w_sp_name, 
     @i_rollback    = 'N',
     @i_cuenta      = 'sp_rptloger', 
     @i_descripcion = @w_error_msg

if @w_retorno > 0
    return @w_retorno
else
    return @w_retorno_ej

go