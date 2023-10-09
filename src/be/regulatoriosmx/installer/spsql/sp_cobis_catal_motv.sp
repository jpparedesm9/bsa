/*************************************************************************/
/*   Archivo:              sp_cobis_catal_motv.sp                        */
/*   Stored procedure:     sp_cobis_catal_motv                           */
/*   Base de datos:        cob_conta_super                               */
/*   Producto:             Regulatorios                                  */
/*   Disenado por:         Daniel Berrio                                 */
/*   Fecha de escritura:   Enero 2023                                    */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/*   Genera reporte de catálogo COBIS_CATAL_MOTV.txt                     */
/*   del requerimiento 195961                                            */
/*                                                                       */
/*       Parametros de Entrada                                           */
/*			Fecha de proceso                                             */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    01/Febrero/2023        DBM              emision inicial            */
/*************************************************************************/


USE [cob_conta_super]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID ('dbo.sp_cobis_catal_motv') IS NOT NULL
	DROP PROCEDURE dbo.sp_cobis_catal_motv
GO

CREATE proc [dbo].[sp_cobis_catal_motv](
	@i_param1  DATETIME
)
AS

DECLARE
@w_fecha datetime,
@w_batch int,
@w_empresa INT,
@w_ruta_arch varchar(255),
@w_nombre_arch varchar(30),
@w_error int,
@w_reporte varchar(24),
@w_sql varchar(5000),
@w_sql_bcp varchar(5000),
@w_msg varchar(150),
@w_ciudad int,
@w_comando varchar(6000),
@w_path_obj varchar(255)

declare 
@resultadobcp table (linea varchar(max))

--obtiene parametro DISTRITO FERIADO NACIONAL
select @w_ciudad = pa_smallint 
	from cobis..cl_parametro 
	where pa_nemonico = 'CFN' 
	AND pa_producto = 'ADM'

if @@error != 0 or @@ROWCOUNT != 1
begin
   select @w_error = 609318
   goto ERROR_PROCESO
end

select @w_path_obj = ba_path_fuente
from cobis..ba_batch
where ba_batch = 36007

select @w_fecha  = @i_param1

--Se resta un día al proceso porque se ejecutará al inicio de día del día siguiente
select @w_fecha  = dateadd(dd,-1, @w_fecha )

while exists (select 1 from cobis..cl_dias_feriados where df_fecha = @w_fecha  and df_ciudad = @w_ciudad)
begin
                select @w_fecha  = dateadd(dd,-1, @w_fecha )
end

--Reporte COBIS_CATAL_MOTV.txt

select  @w_batch = 36430, 
		@w_empresa = 1 

select	
@w_ruta_arch	= ba_path_destino
from cobis..ba_batch
where ba_batch = @w_batch

if @@error != 0 or @@rowcount != 1 or isnull(@w_ruta_arch, '') = ''
begin
   select @w_error = 70134
   goto ERROR_PROCESO
END

IF OBJECT_ID('tempdb..##cl_catalogo_motv') IS NOT NULL DROP TABLE ##cl_catalogo_motv


SELECT 
datos = cobis.dbo.fn_llena_vacio_derecha(concat(substring(cobis.dbo.fn_llena_vacio_derecha(ltrim(rtrim(cm_codigo)),6),1,6),substring(ltrim(rtrim(cm_descripcion)),1,150)),156)
INTO ##cl_catalogo_motv
FROM cob_cartera..cl_catalogo_motv

update ##cl_catalogo_motv set
datos = replace(replace(replace(replace(replace(datos,'ó','o'),'é','e'),'á','a'),'Ó','O'),'É','E')


select @w_reporte = 'COBIS_CATAL_MOTV'
select @w_sql = 'select * from ##cl_catalogo_motv'


select	@w_sql_bcp = 'bcp "' + @w_sql + '" queryout "' + @w_ruta_arch + @w_reporte +'".txt"'+'" -C -c -t";" -T'

EXEC xp_cmdshell @w_sql_bcp


select @w_comando = @w_path_obj + 'reg_archivos.bat ' + @w_ruta_arch + @w_reporte+'.txt' + ' ' + @w_path_obj

/* EJECUTAR CON CMDSHELL */
delete from @resultadobcp
insert into @resultadobcp
exec xp_cmdshell @w_comando

select * from @resultadobcp

IF NOT EXISTS (select 1 from cobis..cl_log_notificador where ln_nemonico = 'COPYBTI' and ln_report_name = @w_reporte +'.txt' and ln_gen_process_date = @w_fecha)
BEGIN
	INSERT INTO cobis..cl_log_notificador (ln_nemonico, ln_report_name, ln_generation_date, ln_gen_process_date, ln_upload_date, ln_copy_date, ln_report_pattern, ln_status)
	VALUES ('COPYBTI', @w_reporte +'.txt', GETDATE(),@w_fecha, null, null, @w_reporte +'.txt', null)
END
ELSE
BEGIN
	UPDATE cobis..cl_log_notificador
	SET
		ln_generation_date = GETDATE(),
		ln_status = NULL
	where ln_nemonico = 'COPYBTI' and ln_report_name = @w_reporte +'.txt' and ln_gen_process_date = @w_fecha
END

IF NOT EXISTS (select 1 from cobis..cl_log_notificador where ln_nemonico = 'CHARITS' and ln_report_name = @w_reporte +'.txt' and ln_gen_process_date = @w_fecha)
BEGIN
	INSERT INTO cobis..cl_log_notificador (ln_nemonico, ln_report_name, ln_generation_date, ln_gen_process_date, ln_upload_date, ln_copy_date, ln_report_pattern, ln_status)
	VALUES ('CHARITS', @w_reporte +'.txt', GETDATE(),@w_fecha, null, null, @w_reporte +'.txt', null)
END
ELSE
BEGIN
	UPDATE cobis..cl_log_notificador
	SET
		ln_generation_date = GETDATE(),
		ln_status = NULL
	where ln_nemonico = 'CHARITS' and ln_report_name = @w_reporte +'.txt' and ln_gen_process_date = @w_fecha
END


return 0

ERROR_PROCESO:

select @w_msg = mensaje
from cobis..cl_errores with (nolock)
where numero = @w_error
