/************************************************************************/
/*      Archivo           :  rptanula.sp                                  */
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
/*      Este sp anula todas las operaciones que quedaron como ING       */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR           RAZON                           */
/*      21/OCT/16     J. Vidal Z        Emision Inicial                 */ 
/*      04/ENE/17     A. Zuluaga        Ajustes VBatch                  */
/************************************************************************/

use cob_pfijo
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_rptanula')
  drop procedure sp_rptanula
go
create procedure  sp_rptanula
( 
       @i_param1           varchar(255)
) 

as declare 
           @w_sp_name            varchar(32), 
           @w_retorno            int,
           @w_retorno_ej         int,
           @w_error_msg          varchar(250),
           @w_tabla              varchar(250),
           @w_archivo_bcp        descripcion,
           @w_errores            descripcion,
           @w_path_s_app         varchar(30),
           @w_path               varchar(250),
           @w_error              int,
           @w_cmd                varchar(250),
           @w_comando            varchar(250),
           @w_fecha              datetime,
           @w_fecha_proceso      datetime
		
select @w_fecha  = convert(datetime, @i_param1)

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso
   
Select @w_sp_name = 'sp_rptanula'

select op_operacion into #tmp_pf_operacion2 
from pf_operacion
where (op_estado = 'ACT' OR op_estado = 'ANU')
and   op_fecha_valor = @w_fecha

exec @w_retorno = sp_anula
     @i_fecha = @w_fecha 
     
if @w_retorno <> 0
begin
   select @w_retorno_ej = 14000, @w_error_msg = 'ERROR EN EJECUCION <sp_anula>'
   goto ERROR
end

--INSERTA EN TABLA TICKETS
truncate table cob_reportes..rep_dpf_reporte_anula

insert into cob_reportes..rep_dpf_reporte_anula
SELECT st_num_banco, 'Operacion debe ser Activada, ya que ha ingresado dinero a Caja'
from pf_secuen_ticket
where st_estado    = 'C'

if @@rowcount = 0 begin
    insert into cob_reportes..rep_dpf_reporte_anula
    SELECT 'XXXXXXXXXXXX', 'Operaciones anuladas con Exito a la fecha ' + convert(varchar, @w_fecha)
end

select @w_path_s_app = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'S_APP'

if @w_path_s_app is null begin
   select @w_error_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
   goto ERROR
end

/* REALIZO BCP */
select @w_path_s_app = @w_path_s_app + 's_app'

select @w_path = pa_float
from   cobis..cl_parametro
where  pa_nemonico  = 'PBCP'
and    pa_producto  = 'PFI'

if @@rowcount = 0 begin
   select @w_retorno_ej = 14000, @w_error_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL RBCPPFI'
   goto ERROR
end

select
@w_archivo_bcp = @w_path  + 'rep_dpf_reporte_anula.ls',
@w_errores     = @w_path  + 'rep_dpf_reporte_anula.err',
@w_cmd         = @w_path_s_app + ' bcp -auto -login cob_reportes..rep_dpf_reporte_anula out '

select @w_comando = @w_cmd + @w_archivo_bcp + ' -b5000 -c -e'+@w_errores  +  ' -config '+ @w_path_s_app + '.ini'

exec @w_error = xp_cmdshell @w_comando
   
if @w_error <> 0 begin
   select @w_error_msg = 'ERROR AL GENERAR ARCHIVO '+@w_archivo_bcp+ ' '+ convert(varchar, @w_error)
   goto ERROR
end

if @@rowcount = 0
begin
    select @w_retorno_ej = 14000, @w_error_msg = 'No existen Registros Consultados'
    goto ERROR
end


--ELIMINA TICKETS
delete from pf_secuen_ticket
 where st_operacion in (select op_operacion   from pf_operacion
                         where (op_estado = 'ACT' OR op_estado = 'ANU')                                                                                                                                                                                                                
                           and op_fecha_valor = @w_fecha)
                           and (st_estado  = 'C' or st_estado = 'A' or st_estado = 'N' 
                                or st_estado = 'R')
if @@error <> 0 
begin
    select @w_error_msg = 'ERROR AL ELIMINAR TICKETS'
    goto ERROR
end

return 0

ERROR:

exec @w_retorno = cob_pfijo..sp_errorlog
     @i_fecha       = @w_fecha_proceso, 
     @i_error       = @w_retorno_ej, 
     @i_usuario     = 'OPERADOR',
     @i_tran        = 14000, 
     @i_tran_name   = @w_sp_name, 
     @i_rollback    = 'N',
     @i_cuenta      = 'sp_rptanula', 
     @i_descripcion = @w_error_msg

if @w_retorno > 0
    return @w_retorno
else
    return @w_retorno_ej 
go
