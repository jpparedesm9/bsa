USE cobis
GO
/* ********************************************************************* */
/*      Archivo:                sp_cl_masiva_rpt.sp                      */
/*      Stored procedure:       sp_cl_masiva_rpt                         */
/*      Base de datos:          cobis                                    */
/*      Producto:               Clientes                                 */
/*      Disenado por:           Luis Guachamin                           */
/*      Fecha de escritura:     12-Sep-2017                              */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "MACOSA", representantes exclusivos para el Ecuador de la        */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/* ********************************************************************* */
/*                              PROPOSITO                                */
/*   reporte de creacion masivas de Clientes/Direcciones/negocio...      */
/* ********************************************************************* */
/*                              MODIFICACIONES                           */
/*      FECHA           AUTOR                RAZON                       */
/*      12/Sep/2017     LGU                  Version Inicial             */
/*                                                                       */
/* ********************************************************************* */

if exists (select 1 from sysobjects where name = 'sp_cl_masiva_rpt')
   drop proc sp_cl_masiva_rpt
go
create proc sp_cl_masiva_rpt
    @i_param1       varchar(255) = NULL -- fecha proceso

AS

DECLARE 
@s_date           DATETIME,
@w_file_rpt       varchar(40),
@w_file_rpt_1     varchar(140),
@w_file_rpt_1_out varchar(140),
@w_bcp            varchar(2000),
@w_path_destino   varchar(200),
@w_origen         VARCHAR(32),
@w_s_app          varchar(40),
@w_fecha_r        varchar(10),
@w_mes            varchar(2),
@w_dia            varchar(2),
@w_anio           varchar(4),
@w_return         INT


    select @s_date = convert(datetime, isnull(@i_param1, getdate()),101)

	select @w_s_app = pa_char
	from   cobis..cl_parametro
	where  pa_producto = 'ADM'
	and    pa_nemonico = 'S_APP'
	
	select
	   @w_path_destino = pp_path_destino
	from cobis..ba_path_pro
	where pp_producto = 2

	select @w_mes         = substring(convert(varchar,@s_date, 101),1,2)
	select @w_dia         = substring(convert(varchar,@s_date, 101),4,2)
	select @w_anio        = substring(convert(varchar,@s_date, 101),7,4)
	
	select @w_fecha_r = @w_mes + @w_dia + @w_anio
	
	select @w_file_rpt = 'rpt_creacion'
	select @w_file_rpt_1     = @w_path_destino + 'in\' + @w_file_rpt + @w_fecha_r + '.txt'
	select @w_file_rpt_1_out = @w_path_destino + 'in\' + @w_file_rpt + '_1.log'

	SELECT @w_bcp = @w_s_app + 's_app bcp -auto -login ' + 'cobis..cl_reporte_tmp' + ' out ' + @w_file_rpt_1 + ' -c -t"|" -b 5000 -e' + @w_file_rpt_1_out	+ ' -config ' + @w_s_app + 's_app.ini'
	SELECT @w_bcp 
	
	--Ejecucion para Generar Archivo Datos
	exec @w_return = xp_cmdshell @w_bcp
--	if @w_return <> 0 begin
--		select @w_msg = 'ERROR: ' + @w_bcp
--		SELECT @w_origen = 'BCP REPORTE DE CARGA'
--		GOTO ERROR
--	end
--

RETURN 0

GO


