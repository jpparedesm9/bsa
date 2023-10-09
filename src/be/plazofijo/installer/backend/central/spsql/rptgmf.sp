/************************************************************************/
/*      Archivo           :  rptgmf.sp                                  */
/*      Stored procedure  :  sp_rptgmf                                 */
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
/*      Emite el diario de operaciones monetarias por oficina           */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR           RAZON                           */
/*      21/Sep/16     J. Vidal Z        Emision Inicial                 */ 
/*      05-Ene-2017   N. Martillo       Ajustes VBatch                  */
/************************************************************************/

use cob_pfijo
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_rptgmf')
  drop procedure sp_rptgmf
go
create procedure  sp_rptgmf
( 
           @i_param1           varchar(255) 
) 
with encryption
as declare @w_sp_name            varchar(32), 
           @w_retorno            int,
           @w_retorno_ej         int,
           @w_error_msg          varchar(250),
           @w_tabla              varchar(250),
           @w_fecha_proceso      datetime
   
Select @w_sp_name = 'sp_rptgmf', 
       @w_fecha_proceso = convert(datetime, @i_param1)

exec cob_pfijo..sp_reportes_gmf
    @i_param1      = @w_fecha_proceso,
    @i_param2      = 'CDT'

truncate table cob_reportes..rep_dpf_reporte_gmf_cdt

insert into cob_reportes..rep_dpf_reporte_gmf_cdt
Select 
     codigo_ofi,            desc_ofi,         nombre_titular,       rgc_concepto,
     ident_titular,         estado_cdt,       nro_cdt,              fecha_aper_cdt,
     fecha_canc_cdt,        vlr_cdt,          int_pagados,          base_gmf_int,
     base_gmf_cap,          valor_gmf_cap,    valor_gmf_int
from pf_reporte_gmf_cdt, pf_reporte_gmf_cdt_det 
     where rgc_nro_cdt = nro_cdt 
if @@error > 0
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
     @i_cuenta      = 'sp_rptgmf', 
     @i_descripcion = @w_error_msg

if @w_retorno > 0
    return @w_retorno
else
    return @w_retorno_ej
go
