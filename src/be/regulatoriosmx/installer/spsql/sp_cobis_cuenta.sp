/*************************************************************************/
/*   Archivo:              sp_cobis_cuenta.sp                            */
/*   Stored procedure:     sp_cobis_cuenta                               */
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
/*   Genera reporte COBIS_CUENTA.txt del requerimiento 172199            */
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

IF OBJECT_ID ('dbo.sp_cobis_cuenta') IS NOT NULL
	DROP PROCEDURE dbo.sp_cobis_cuenta
GO

CREATE proc [dbo].[sp_cobis_cuenta](
   @i_param1  DATETIME
)
AS

DECLARE
@w_formato_fecha int,
@w_fecha datetime,
@w_batch int,
@w_empresa INT,
@w_ruta_arch varchar(255),
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

--Reporte 6.3 COBIS_CUENTA.txt

select  @w_formato_fecha = 111, 
		@w_batch = 36430, 
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

IF OBJECT_ID('tempdb..##tmp_cobis_cuenta') IS NOT NULL DROP TABLE ##tmp_cobis_cuenta


SELECT
datos =
REPLACE
(REPLACE(REPLACE(REPLACE(REPLACE((cobis.dbo.fn_llena_0('78',4) + --V_COD_EMPRESA,
cobis.dbo.fn_llena_0(convert(char(15),cu_cuenta),15)+ --cobis.dbo.fn_llena_0(cu_cuenta,15) + --V_COD_CUENTA,
convert(char(65),substring(ltrim(rtrim(cu_nombre)),1,65))+ --V_DESC_CUENTA,
case when cu_movimiento = 'S' then '1' else '0' end + --N_CONCILIADOR
cobis.dbo.fn_llena_vacio(cu_cuenta_padre,15) + --V_COD_PADRE
case
when substring(cu_cuenta,1,1) = '1' then 'A' --V_TIPO_CUENTA
when substring(cu_cuenta,1,1) = '2' then 'P' --V_TIPO_CUENTA
when substring(cu_cuenta,1,1) = '4' then 'C' --V_TIPO_CUENTA
when substring(cu_cuenta,1,1) = '5' or substring(cu_cuenta,1,1) = '6' then 'R'
when substring(cu_cuenta,1,1) = '7' or substring(cu_cuenta,1,1) = '8' then 'O'
END),'Á','A'),'É','E'),'Í','I'),'Ó','O'),'Ú','U')
INTO ##tmp_cobis_cuenta
FROM cob_conta..cb_cuenta


select @w_reporte = 'COBIS_CUENTA'
select @w_sql = 'select * from ##tmp_cobis_cuenta'


select	@w_sql_bcp = 'bcp "' + @w_sql + '" queryout "' + @w_ruta_arch + @w_reporte +'".txt"'+'" -C -c -t";" -T'

EXEC xp_cmdshell @w_sql_bcp


IF NOT EXISTS (select 1 from cobis..cl_log_notificador where ln_nemonico = 'COPYBTI' and ln_report_name = @w_reporte +'.txt' and ln_gen_process_date = @w_fecha)
BEGIN
	INSERT INTO cobis..cl_log_notificador (ln_nemonico, ln_report_name, ln_generation_date, ln_gen_process_date, ln_upload_date, ln_copy_date, ln_report_pattern, ln_status)
	VALUES ('COPYBTI', @w_reporte  +'.txt', GETDATE(),@w_fecha, null, null, @w_reporte +'.txt', null)
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
