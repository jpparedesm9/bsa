/*************************************************************************/
/*   Archivo:              sp_cobis_clacon.sp                            */
/*   Stored procedure:     sp_cobis_clacon                               */
/*   Base de datos:        cob_conta_super                               */
/*   Producto:             Regulatorios                                  */
/*   Disenado por:         Dario Cumbal - Daniel Berrio                  */
/*   Fecha de escritura:   Abril 2022                                    */
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
/*   Genera reporte COBIS_CLACON_D_AAAAMMDD.txt del requerimiento 172199 */
/*                                                                       */
/*       Parametros de Entrada                                           */
/*			Fecha de proceso                                             */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    04/Abril/2022          DBM              emision inicial            */
/*************************************************************************/


USE [cob_conta_super]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID ('dbo.sp_cobis_clacon') IS NOT NULL
	DROP PROCEDURE dbo.sp_cobis_clacon
GO

CREATE proc [dbo].[sp_cobis_clacon](
   @i_param1  DATETIME
)
AS

DECLARE
@w_formato_fecha int,
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
@w_ciudad int

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

select @w_fecha  = @i_param1

--Se resta un día al proceso porque se ejecutará al inicio de día del día siguiente
select @w_fecha  = dateadd(dd,-1, @w_fecha )

while exists (select 1 from cobis..cl_dias_feriados where df_fecha = @w_fecha  and df_ciudad = @w_ciudad)
begin
                select @w_fecha  = dateadd(dd,-1, @w_fecha )
end

--Reporte 6.6 COBIS_CLACON_D_AAAAMMDD.txt

select  @w_formato_fecha = 111, 
		@w_batch = 36430, 
		@w_empresa = 1 

select	
@w_ruta_arch	= ba_path_destino,
--@w_nombre_arch	= replace(convert(varchar,@i_param1, 106), ' ', '_')
@w_nombre_arch	= CONVERT(varchar,DATEPART(yyyy, @w_fecha),4)+CONVERT(varchar,cobis.dbo.fn_llena_0(DATEPART(mm, @w_fecha),2),2)+CONVERT(varchar,cobis.dbo.fn_llena_0(DATEPART(dd, @w_fecha),2),2)

from cobis..ba_batch
where ba_batch = @w_batch

if @@error != 0 or @@rowcount != 1 or isnull(@w_ruta_arch, '') = '' or isnull(@w_nombre_arch, '') = ''
begin
   select @w_error = 70134
   goto ERROR_PROCESO
END

IF OBJECT_ID('tempdb..##tmp_clacon') IS NOT NULL DROP TABLE ##tmp_clacon


SELECT 
datos = cobis.dbo.fn_llena_vacio_derecha(concat(substring(ltrim(rtrim(c.codigo)),1,3),substring(ltrim(rtrim(c.valor)),1,30)),33)
INTO ##tmp_clacon
FROM cobis..cl_catalogo c, cobis..cl_tabla t
WHERE c.tabla = t.codigo
AND t.tabla = 'cl_cla_con'

select @w_reporte = 'COBIS_CLACON_D_'
select @w_sql = 'select * from ##tmp_clacon'


select	@w_sql_bcp = 'bcp "' + @w_sql + '" queryout "' + @w_ruta_arch + @w_reporte + @w_nombre_arch +'".txt"'+'" -C -c -t";" -T'

EXEC xp_cmdshell @w_sql_bcp


IF NOT EXISTS (select 1 from cobis..cl_log_notificador where ln_nemonico = 'COPYBTI' and ln_report_name = @w_reporte + @w_nombre_arch +'.txt' and ln_gen_process_date = @w_fecha)
BEGIN
	INSERT INTO cobis..cl_log_notificador (ln_nemonico, ln_report_name, ln_generation_date, ln_gen_process_date, ln_upload_date, ln_copy_date, ln_report_pattern, ln_status)
	VALUES ('COPYBTI', @w_reporte + @w_nombre_arch +'.txt', GETDATE(),@w_fecha, null, null, @w_reporte +'{PPD:yyyyMMdd}.txt', null)
END
ELSE
BEGIN
	UPDATE cobis..cl_log_notificador
	SET
		ln_generation_date = GETDATE(),
		ln_status = NULL
	where ln_nemonico = 'COPYBTI' and ln_report_name = @w_reporte + @w_nombre_arch +'.txt' and ln_gen_process_date = @w_fecha
END

IF NOT EXISTS (select 1 from cobis..cl_log_notificador where ln_nemonico = 'CHARITS' and ln_report_name = @w_reporte + @w_nombre_arch +'.txt' and ln_gen_process_date = @w_fecha)
BEGIN
	INSERT INTO cobis..cl_log_notificador (ln_nemonico, ln_report_name, ln_generation_date, ln_gen_process_date, ln_upload_date, ln_copy_date, ln_report_pattern, ln_status)
	VALUES ('CHARITS', @w_reporte + @w_nombre_arch +'.txt', GETDATE(),@w_fecha, null, null, @w_reporte +'{PPD:yyyyMMdd}.txt', null)
END
ELSE
BEGIN
	UPDATE cobis..cl_log_notificador
	SET
		ln_generation_date = GETDATE(),
		ln_status = NULL
	where ln_nemonico = 'CHARITS' and ln_report_name = @w_reporte + @w_nombre_arch +'.txt' and ln_gen_process_date = @w_fecha
END

return 0

ERROR_PROCESO:

select @w_msg = mensaje
from cobis..cl_errores with (nolock)
where numero = @w_error
