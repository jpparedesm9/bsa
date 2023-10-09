USE cobis
GO
/* ********************************************************************* */
/*      Archivo:                sp_cl_masiva_carga.sp                    */
/*      Stored procedure:       sp_cl_masiva_carga                       */
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
/*  Carga archivos para crear Clientes/Direcciones/negocio/referencias   */
/* ********************************************************************* */
/*                              MODIFICACIONES                           */
/*      FECHA           AUTOR                RAZON                       */
/*      12/Sep/2017     LGU                  Version Inicial             */
/*                                                                       */
/* ********************************************************************* */

if exists (select 1 from sysobjects where name = 'sp_cl_masiva_carga')
   drop proc sp_cl_masiva_carga
go
create proc sp_cl_masiva_carga
   @i_param1            varchar(255) = null -- fecha proceso
as
declare
@w_sp_name      varchar(40),
@w_s_app        varchar(40),
@w_origen       VARCHAR(32),
@w_msg          varchar(1200),
@w_fecha_r      varchar(10),
@w_mes          varchar(2),
@w_dia          varchar(2),
@w_anio         varchar(4),
@w_return       INT,
@w_bcp          varchar(2000),
@w_path_destino varchar(200),
@w_file_cl      varchar(40),
@w_file_di      varchar(40),
@w_file_te      varchar(40),
@w_file_ne      varchar(40),
@w_file_rf      varchar(40),
@w_file_co      varchar(40),
@w_file_rpt     varchar(40),

@w_file_cl_in   varchar(140),
@w_file_di_in   varchar(140),
@w_file_te_in   varchar(140),
@w_file_ne_in   varchar(140),
@w_file_rf_in   varchar(140),
@w_file_co_in   varchar(140),

@w_file_cl_out varchar(140),
@w_file_di_out varchar(140),
@w_file_te_out varchar(140),
@w_file_ne_out varchar(140),
@w_file_rf_out varchar(140),
@w_file_co_out varchar(140),

@w_file_rpt_1   varchar(140),

@w_file_cl_log  varchar(140),
@w_file_di_log  varchar(140),
@w_file_te_log  varchar(140),
@w_file_ne_log  varchar(140),
@w_file_rf_log  varchar(140),
@w_file_co_log  varchar(140),

@w_file_rpt_1_log varchar(140),

@i_fecha_outeso           DATETIME


    select @i_fecha_outeso = convert(datetime, @i_param1,101)

    SELECT @w_sp_name = 'sp_cl_masiva_carga'

    select @w_s_app = pa_char
    from   cobis..cl_parametro
    where  pa_producto = 'ADM'
    and    pa_nemonico = 'S_APP'

    select
       @w_path_destino = pp_path_destino
    from cobis..ba_path_pro
    where pp_producto = 2

    select @w_mes         = substring(convert(varchar,@i_fecha_outeso, 101),1,2)
    select @w_dia         = substring(convert(varchar,@i_fecha_outeso, 101),4,2)
    select @w_anio        = substring(convert(varchar,@i_fecha_outeso, 101),7,4)

    select @w_fecha_r = @w_mes + @w_dia + @w_anio

    select @w_file_cl = 'ente'
    select @w_file_di = 'direccion'
    select @w_file_te = 'telefono'
    select @w_file_ne = 'negocio'
    select @w_file_rf = 'referencia'
    select @w_file_co = 'conyuge'
    select @w_file_rpt = 'rpt_carga'

    select @w_file_cl_in     = @w_path_destino + 'in\' + @w_fecha_r + '_' + @w_file_cl + '.txt'
    select @w_file_di_in     = @w_path_destino + 'in\' + @w_fecha_r + '_' + @w_file_di + '.txt'
    select @w_file_te_in     = @w_path_destino + 'in\' + @w_fecha_r + '_' + @w_file_te + '.txt'
    select @w_file_ne_in     = @w_path_destino + 'in\' + @w_fecha_r + '_' + @w_file_ne + '.txt'
    select @w_file_rf_in     = @w_path_destino + 'in\' + @w_fecha_r + '_' + @w_file_rf + '.txt'
    select @w_file_co_in     = @w_path_destino + 'in\' + @w_fecha_r + '_' + @w_file_co + '.txt'

    select @w_file_cl_log    = @w_path_destino + 'in\' + @w_fecha_r + '_' + @w_file_cl + '.log'
    select @w_file_di_log    = @w_path_destino + 'in\' + @w_fecha_r + '_' + @w_file_di + '.log'
    select @w_file_te_log    = @w_path_destino + 'in\' + @w_fecha_r + '_' + @w_file_te + '.log'
    select @w_file_ne_log    = @w_path_destino + 'in\' + @w_fecha_r + '_' + @w_file_ne + '.log'
    select @w_file_rf_log    = @w_path_destino + 'in\' + @w_fecha_r + '_' + @w_file_rf + '.log'
    select @w_file_co_log    = @w_path_destino + 'in\' + @w_fecha_r + '_' + @w_file_co + '.log'

    select @w_file_rpt_1     = @w_path_destino + 'in\' + @w_fecha_r + '_' + @w_file_rpt + '.txt'
    select @w_file_rpt_1_log = @w_path_destino + 'in\' + @w_fecha_r + '_' + @w_file_rpt + '.log'

    select @w_file_cl_out   = @w_path_destino + 'out\' + @w_fecha_r + '_'+ @w_file_cl + '.txt'
    select @w_file_di_out   = @w_path_destino + 'out\' + @w_fecha_r + '_'+ @w_file_di + '.txt'
    select @w_file_te_out   = @w_path_destino + 'out\' + @w_fecha_r + '_'+ @w_file_te + '.txt'
    select @w_file_ne_out   = @w_path_destino + 'out\' + @w_fecha_r + '_'+ @w_file_ne + '.txt'
    select @w_file_rf_out   = @w_path_destino + 'out\' + @w_fecha_r + '_'+ @w_file_rf + '.txt'
    select @w_file_co_out   = @w_path_destino + 'out\' + @w_fecha_r + '_'+ @w_file_co + '.txt'


    if exists (select 1 from cobis..sysobjects where name = 'cl_ente_std_aux')
        EXECUTE ('drop table cobis..cl_ente_std_aux')
    if exists (select 1 from cobis..sysobjects where name = 'cl_direccion_std_aux')
        EXECUTE ('drop table cobis..cl_direccion_std_aux')
    if exists (select 1 from cobis..sysobjects where name = 'cl_telefono_std_aux')
        EXECUTE ('drop table cobis..cl_telefono_std_aux')
    if exists (select 1 from cobis..sysobjects where name = 'cl_negocio_std_aux')
        EXECUTE ('drop table cobis..cl_negocio_std_aux')
    if exists (select 1 from cobis..sysobjects where name = 'cl_referencia_std_aux')
        EXECUTE ('drop table cobis..cl_referencia_std_aux')
    if exists (select 1 from cobis..sysobjects where name = 'cl_conyuge_std_aux')
        EXECUTE ('drop table cobis..cl_conyuge_std_aux')

    select * into  cobis..cl_ente_std_aux       from cobis..cl_ente_std       where 1=2
    select * into  cobis..cl_direccion_std_aux  from cobis..cl_direccion_std  where 1=2
    select * into  cobis..cl_telefono_std_aux   from cobis..cl_telefono_std   where 1=2
    select * into  cobis..cl_negocio_std_aux    from cobis..cl_negocio_std    where 1=2
    select * into  cobis..cl_referencia_std_aux from cobis..cl_referencia_std where 1=2
    select * into  cobis..cl_conyuge_std_aux    from cobis..cl_conyuge_std    where 1=2

    SELECT @w_bcp = @w_s_app + 's_app bcp -auto -login ' + 'cobis..cl_ente_std_aux' + ' in ' + @w_file_cl_in + ' -c -t"|" -b 5000 '+ ' -config ' + @w_s_app + 's_app.ini >' + @w_file_cl_log  
	PRINT '----------------1 CLIENTES'

    --Ejecucion para Generar Archivo Datos
    exec @w_return = xp_cmdshell @w_bcp
    PRINT @w_bcp +  '  RETORNO : ' + convert(VARCHAR, @w_return)
    if @w_return <> 0 begin
        select @w_msg = 'ERROR: ' + @w_bcp
        SELECT @w_origen = 'BCP CLIENTES'
        GOTO ERROR
    END

    SELECT @w_bcp = @w_s_app + 's_app bcp -auto -login ' + 'cobis..cl_direccion_std_aux' + ' in ' + @w_file_di_in + ' -c -t"|" -b 5000 '+ ' -config ' + @w_s_app + 's_app.ini >' + @w_file_di_log 
	PRINT '----------------2 DIRECCIONES'
    --Ejecucion para Generar Archivo Datos
    exec @w_return = xp_cmdshell @w_bcp
    PRINT @w_bcp +  '  RETORNO : ' + convert(VARCHAR, @w_return)
    if @w_return <> 0 begin
        select @w_msg = 'ERROR: ' + @w_bcp
        SELECT @w_origen = 'BCP DIRECCIONES'
        GOTO ERROR
    end

	PRINT '----------------3 TELEFONOS'
    SELECT @w_bcp = @w_s_app + 's_app bcp -auto -login ' + 'cobis..cl_telefono_std_aux' + ' in ' + @w_file_te_in + ' -c -t"|" -b 5000 ' + ' -config ' + @w_s_app + 's_app.ini >' + @w_file_te_log  
    --Ejecucion para Generar Archivo Datos
    exec @w_return = xp_cmdshell @w_bcp
    PRINT @w_bcp +  '  RETORNO : ' + convert(VARCHAR, @w_return)
    if @w_return <> 0 begin
        select @w_msg = 'ERROR: ' + @w_bcp
        SELECT @w_origen = 'BCP TELEFONOS'
        GOTO ERROR
    end

	PRINT '----------------4 NEGOCIOS'
    SELECT @w_bcp = @w_s_app + 's_app bcp -auto -login ' + 'cobis..cl_negocio_std_aux' + ' in ' + @w_file_ne_in + ' -c -t"|" -b 5000 ' + ' -config ' + @w_s_app + 's_app.ini >'+ @w_file_ne_log   
    --Ejecucion para Generar Archivo Datos
    exec @w_return = xp_cmdshell @w_bcp
    PRINT @w_bcp +  '  RETORNO : ' + convert(VARCHAR, @w_return)
    if @w_return <> 0 begin
        select @w_msg = 'ERROR: ' + @w_bcp
        SELECT @w_origen = 'BCP NEGOCIOS'
        GOTO ERROR
    end

	PRINT '----------------5 REFERENCIAS'
    SELECT @w_bcp = @w_s_app + 's_app bcp -auto -login ' + 'cobis..cl_referencia_std_aux' + ' in ' + @w_file_rf_in + ' -c -t"|" -b 5000 ' + ' -config ' + @w_s_app + 's_app.ini >' + @w_file_rf_log
    --Ejecucion para Generar Archivo Datos
    exec @w_return = xp_cmdshell @w_bcp
    PRINT @w_bcp +  '  RETORNO : ' + convert(VARCHAR, @w_return)
    if @w_return <> 0 begin
        select @w_msg = 'ERROR: ' + @w_bcp
        SELECT @w_origen = 'BCP REFERENCIAS'
        GOTO ERROR
    end

	PRINT '----------------6 CONYUGES'
    SELECT @w_bcp = @w_s_app + 's_app bcp -auto -login ' + 'cobis..cl_conyuge_std_aux' + ' in ' + @w_file_co_in + ' -c -t"|" -b 5000 ' + ' -config ' + @w_s_app + 's_app.ini >' +  @w_file_co_log    
    --Ejecucion para Generar Archivo Datos
    exec @w_return = xp_cmdshell @w_bcp
    PRINT @w_bcp +  '  RETORNO : ' + convert(VARCHAR, @w_return)
    if @w_return <> 0 begin
        select @w_msg = 'ERROR: ' + @w_bcp
        SELECT @w_origen = 'BCP CONYUGE'
        GOTO ERROR
    end

    INSERT into  cobis..cl_ente_std       select * from cobis..cl_ente_std_aux
    INSERt into  cobis..cl_direccion_std  select * from cobis..cl_direccion_std_aux
    INSERt into  cobis..cl_telefono_std   select * from cobis..cl_telefono_std_aux
    INSERt into  cobis..cl_negocio_std    select * from cobis..cl_negocio_std_aux
    INSERt into  cobis..cl_referencia_std select * from cobis..cl_referencia_std_aux 
    INSERt into  cobis..cl_conyuge_std    select * from cobis..cl_conyuge_std_aux 


    TRUNCATE TABLE cl_reporte_tmp

    INSERT INTO cl_reporte_tmp  select 'REPORTE DE CARGA DE ARCHIVOS'
    INSERT INTO cl_reporte_tmp  select 'FECHA (MM/DD/YYYY):' + CONVERT(VARCHAR,@i_fecha_outeso, 101)
    INSERT INTO cl_reporte_tmp  select 'EMPRESA |ENTIDAD |TOTAL'

    INSERT INTO cl_reporte_tmp
    select ens_entidad + '|'   + 'CLIENTES'   + '|' + convert(varchar(200),count(1)) from cobis..cl_ente_std_aux        group by ens_entidad
    INSERT INTO cl_reporte_tmp
    select dis_entidad + '|'   + 'DIRECCIONES'+ '|' + convert(varchar(200),count(1)) from cobis..cl_direccion_std_aux   group by dis_entidad
    INSERT INTO cl_reporte_tmp
    select tes_entidad + '|'   + 'TELEFONOS'  + '|' + convert(varchar(200),count(1)) from cobis..cl_telefono_std_aux    group by tes_entidad
    INSERT INTO cl_reporte_tmp
    select nes_entidad + '|'   + 'NEGOCIOS'   + '|' + convert(varchar(200),count(1)) from cobis..cl_negocio_std_aux     group by nes_entidad
    INSERT INTO cl_reporte_tmp
    select rfs_entidad + '|'   + 'REFERENCIAS'+ '|' + convert(varchar(200),count(1)) from cobis..cl_referencia_std_aux  group by rfs_entidad
    INSERT INTO cl_reporte_tmp
    select cos_entidad_c + '|' + 'CONYUGE'    + '|' + convert(varchar(200),count(1)) from cobis..cl_conyuge_std_aux     group by cos_entidad_c

    SELECT @w_bcp = @w_s_app + 's_app bcp -auto -login ' + 'cobis..cl_reporte_tmp' + ' out ' + @w_file_rpt_1 + ' -c -t"|" -b 5000 ' + ' -config ' + @w_s_app + 's_app.ini >' + @w_file_rpt_1_log   
    SELECT @w_bcp

    --Ejecucion para Generar Archivo Datos
    exec @w_return = xp_cmdshell @w_bcp
    if @w_return <> 0 begin
        select @w_msg = 'ERROR: ' + @w_bcp
        SELECT @w_origen = 'BCP REPORTE DE CARGA'
        GOTO ERROR
    end

    -- renombrar los archivos para no cargar nuevamente
    SELECT @w_bcp = 'move /Y ' + @w_file_cl_in + ' ' + @w_file_cl_out
    SELECT @w_bcp
    exec @w_return = xp_cmdshell @w_bcp
    SELECT @w_bcp = 'move /Y ' + @w_file_di_in + ' ' + @w_file_di_out
    exec @w_return = xp_cmdshell @w_bcp
    SELECT @w_bcp = 'move /Y ' + @w_file_te_in + ' ' + @w_file_te_out
    exec @w_return = xp_cmdshell @w_bcp
    SELECT @w_bcp = 'move /Y ' + @w_file_ne_in + ' ' + @w_file_ne_out
    exec @w_return = xp_cmdshell @w_bcp
    SELECT @w_bcp = 'move /Y ' + @w_file_rf_in + ' ' + @w_file_rf_out
    exec @w_return = xp_cmdshell @w_bcp
    SELECT @w_bcp = 'move /Y ' + @w_file_co_in + ' ' + @w_file_co_out
    exec @w_return = xp_cmdshell @w_bcp


RETURN 0

ERROR:
    SELECT @w_origen = @w_origen + ' Return: ' + convert(VARCHAR,isnull(@w_return,0))
    exec cob_conta_super..sp_errorlog
        @i_fecha_fin     = @i_fecha_outeso,
        @i_fuente        = @w_sp_name,
        @i_operacion     = 'I',
        @i_origen_error  = @w_origen,
        @i_descrp_error  = @w_msg

    return @w_return

GO



