
use cobis
go

IF OBJECT_ID ('dbo.sp_ba_respaldo_sql_ej') IS NOT NULL
	DROP PROCEDURE dbo.sp_ba_respaldo_sql_ej
go

create proc sp_ba_respaldo_sql_ej
/************************************************************************/
/*      Archivo              :  ba_respaldo_syb_ej.sp                   */
/*      Base de datos        :  cobis                                   */
/*      Producto             :  Visual Batch                            */
/*      Disenado por         :  Alfonso Duque                           */
/*      Fecha de escritura   :  07/Jul/2013                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "Cobiscorp", representantes exclusivos para el Ecuador de la    */
/*      "Cobiscorp CORPORATION".                                        */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de Cobiscorp o su representante.          */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Realizar respaldo full de las bases de datos de COBIS           */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      07/Jul/2013     Alfonso Duque   Emision inicial                 */
/*      16/Jul/2013     J. Hidalgo      Estandarizacion para VBatch     */
/*      06/Oct/2017     J. Salazar      CGS-S138784                     */
/************************************************************************/
(
  @t_show_version  bit               = 0,    -- show the version of the stored procedure
  @i_codigo        int               = 1,    -- Codigo de ruta donde se realizara el respaldo
                                             -- Ejemplo: 0 = Path de respaldos antes del fin de dia
                                             --          1 = Path de respaldos antes del inicio de dia
-- parametros para registro de log de ejecucion
  @i_sarta         int               = null,
  @i_batch         int               = null,
  @i_secuencial    int               = null,
  @i_corrida       int               = null,
  @i_intento       int               = null
)
as
declare @w_sp_name          varchar(30),
        @w_retorno          int,
        @w_retorno_ej       int,
        @w_destino          varchar(255),
        @w_path             varchar(255),
        @w_fecha            varchar(16),
        @w_name             varchar(64),
        @w_name_backup      varchar(255),
		@w_week_backup      int, 
		@w_fecha_proc       datetime,
		@w_ciudad           int,
		@w_error            int,
		@w_msg              varchar(255)  

select @w_sp_name = 'sp_ba_respaldo_sql_ej'

---- VERSIONAMIENTO DEL PROGRAMA --------------------------------
if @t_show_version = 1 begin
   print 'Stored procedure sp_ba_respaldo_sql_ej, Version 4.0.0.0'
   return 0
end
-----------------------------------------------------------------

select @w_week_backup = pa_tinyint 
from  cl_parametro
where pa_nemonico = 'SEMBK' --SEMANAS PARA BACKUP
if @@rowcount = 0 begin
   select 
   @w_error  = 609318,
   @w_msg    = 'ERROR: NO EXISTE PARAMETRO SEMBK'
   goto ERROR
end

select @w_fecha_proc = fp_fecha from cobis..ba_fecha_proceso 


select @w_ciudad = pa_smallint 
from  cl_parametro
where pa_nemonico = 'CFN'

if @@rowcount = 0 begin
   select 
   @w_error  = 609318,
   @w_msg    = 'ERROR: NO EXISTE PARAMETRO CFN'
   goto ERROR
end



select @w_path = re_path, @w_fecha = convert(varchar(15),getdate(),102) + '.' + convert(varchar(2),datepart(hh,getdate())) + '.' + convert(varchar(2),datepart(mi,getdate()))
from ad_respaldo
where re_codigo=@i_codigo

if (@w_path is not null)
begin
        declare cur_bases cursor for
        select name
        from master..sysdatabases
        where name not in ('master', 'model', 'sybpcidb', 'sybsystemdb', 'sybsystemprocs', 'tempdb','msdb','distribution')

        open cur_bases
        fetch cur_bases into @w_name

        while @@fetch_status = 0
        begin
               
		      if (@w_name = 'cob_cartera_his') begin 
					--ESTE PROCESO NO SE EJECUTA SI EL DIA DE AYER NO ES FERIADO POR EL INICIO DE DIA DEL BATCH 
					if not exists( select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad and df_fecha = dateadd(dd,-1,@w_fecha_proc ))  GOTO SIGUIENTE 

					--ESTO SE EJECUTA CADA N SEMANAS DE ACUERDO A LO QUE INDICA EL PARAMETRO 
					if  (datepart (ww, @w_fecha_proc)%@w_week_backup)  <> 0  GOTO SIGUIENTE 

			  end 

			   select @w_destino = @w_path + '/' + @w_name + '-' + @w_fecha + '.bak',
                       @w_name_backup = @w_name + '-Full Database Backup'

                BACKUP DATABASE @w_name TO DISK = @w_destino WITH NOFORMAT, NOINIT, NAME = @w_name_backup, SKIP, NOREWIND, NOUNLOAD,  STATS = 10
                SIGUIENTE: 
                fetch cur_bases into @w_name
        end

        close cur_bases
        deallocate cur_bases

        return 0
end
else
begin
        print 'No existe configuracion de directorio de destino'
        return -1
end


return 0 
ERROR:

return @w_error