/*************************************************************************/
/*   Archivo:              sp_estructura_cobis.sp		                 */
/*   Stored procedure:     sp_estructura_cobis                           */
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
/*   Genera reporte Estructura_COBIS_D_AAAAMMDD.txt                      */
/*   del requerimiento 172199                                            */
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

IF OBJECT_ID ('dbo.sp_estructura_cobis') IS NOT NULL
	DROP PROCEDURE dbo.sp_estructura_cobis
GO

CREATE proc [dbo].[sp_estructura_cobis](
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

--Reporte 6.2 Estructura_COBIS_D_AAAAMMDD.txt

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

IF OBJECT_ID('tempdb..##tmp_estructura') IS NOT NULL DROP TABLE ##tmp_estructura

IF OBJECT_ID('tempdb..#estructura') IS NOT NULL DROP TABLE #estructura


create table #estructura(
codigo_direccion int     null,
id_direccion	char(4)  null,  --Identificador de dirección
codido_sub      int      null,
direccion       char(30) null,--	Nombre de la direccion Comercial
id_subdireccion	char(4)  null,--Identificador de Subdireccion
subdireccion    char(30) null,--30	Nombre de la Subdireccion
id_region	char(4)  null,--	Identificador de Region
codigo_region   int      null,
Region		char(30) null,--	Nombre de la Region
id_oficina	char(5)  null,--	5	Clave Centro de Costos
Oficina	        char(30) null--	30	Nombre Oficina
)

truncate table #estructura

insert into #estructura(id_oficina, Oficina, codigo_region)
select of_oficina, substring(of_nombre,1,30), of_regional
from cobis..cl_oficina
where of_subtipo = 'O'

update #estructura set
id_region = convert(varchar,codigo_region),
Region    = substring(of_nombre,1,30)
from cobis..cl_oficina R
where codigo_region = of_oficina
and of_subtipo = 'R'

--select * from #estructura where id_oficina = 9002
update #estructura set
codido_sub      = of_oficina_padre
from cob_conta..cb_oficina
where codigo_region = of_oficina

update #estructura set
codigo_direccion = of_oficina_padre,
id_subdireccion  = cobis.dbo.fn_llena_0(convert(varchar,codido_sub),4),
subdireccion     = substring(of_descripcion,1,30) 
from cob_conta..cb_oficina
where codido_sub = of_oficina

update #estructura set
codigo_direccion = 255
where codigo_direccion is null

update #estructura set
id_direccion  = cobis.dbo.fn_llena_0(convert(varchar,codigo_direccion),4),
direccion     = substring(of_descripcion,1,30) 
from cob_conta..cb_oficina
where codigo_direccion = of_oficina

--co.of_regional se divide en 100 para quitarle los dos 0 del final y coincida con el layout del requerimiento

select
of_datos = concat(convert(VARCHAR(34),concat(id_direccion,direccion,REPLICATE(' ',34-len(concat(id_direccion,direccion))))),
convert(VARCHAR(34),concat(id_subdireccion,subdireccion,REPLICATE(' ',34-len(concat(id_subdireccion,subdireccion))))),
convert(VARCHAR(34),concat(id_region,Region,REPLICATE(' ',34-len(concat(id_region,Region))))),
convert(VARCHAR(35),concat(cobis.dbo.fn_llena_0(id_oficina,5),Oficina,REPLICATE(' ',35-len(concat(id_oficina,Oficina))))))
INTO ##tmp_estructura
FROM #estructura



select @w_reporte = 'Estructura_COBIS_D_'
select @w_sql = 'select * from ##tmp_estructura'


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
