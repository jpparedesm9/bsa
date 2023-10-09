/************************************************************************/
/*   Archivo:              sp_carga_negative_file.sp                    */
/*   Stored procedure:     sp_carga_negative_file                       */
/*   Base de datos:        cob_credito                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Adriana Chiluisa                             */
/*   Fecha de escritura:   Abril 2018                                   */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                                   PROPOSITO                          */
/*   Extrae un archivo de texto e ingresa en la tabla su información    */
/*                              CAMBIOS                                 */
/*   23/04/2018               A. Chiluisa         Versión Inicial       */
/*   02/04/2018               A. Chiluisa         Mod. para trabajar con*/
/*   02/04/2018               A. Chiluisa         @i_ con espacios      */
/************************************************************************/

use cob_credito
go
IF OBJECT_ID ('dbo.sp_carga_negative_file') IS NOT NULL
	DROP PROCEDURE dbo.sp_carga_negative_file
GO

CREATE PROCEDURE sp_carga_negative_file(
    @i_nombre_archivo     varchar(30) = null
)
AS
begin 
DECLARE
	@w_negative_file_path VARCHAR(30),
	@w_negative_file_file VARCHAR(30),
	@w_command NVARCHAR(MAX),
	@w_total_rows INT,
	@w_fecha_proceso datetime,
	@w_error_code int;

SELECT @w_error_code = 0;

SELECT @w_negative_file_path = pa_char
FROM cobis..cl_parametro
WHERE pa_producto = 'CRE'
AND pa_nemonico = 'PHNFDE';

--Fecha--
SELECT @w_fecha_proceso = fp_fecha FROM cobis..ba_fecha_proceso

IF @w_negative_file_path IS NULL
BEGIN
    RAISERROR ('No se ha definido el parámetro PHNFDE (Ruta del archivo de Negative File)', 13, 1);
	return -1;
END

SELECT @w_negative_file_file = @i_nombre_archivo

IF @w_negative_file_file IS NULL
BEGIN
	RAISERROR ('No se ha definido Nombre del archivo de Negative File)', 13, 1);
	return -1;
END

if not exists (select 1 from cobis..cl_dias_feriados where df_fecha = @w_fecha_proceso) 
begin

    SELECT * 
    INTO #cr_negative_file
    FROM cr_negative_file
    
    TRUNCATE TABLE cr_negative_file
    
    DBCC CHECKIDENT ('cr_negative_file', RESEED, 1)
    
    SELECT @w_command =
    'INSERT INTO cr_negative_file
    	(   nf_tipo_documento       ,
            nf_rfc_pasaporte        ,
            nf_genero               ,
            nf_ape_paterno          ,
            nf_ape_materno          ,
            nf_apellidos            ,
            nf_nombre_razon_social  ,
            nf_fecha_nac            ,
            nf_alias                ,
            nf_relacionado_con      ,
            nf_codigo_negative      ,
            nf_tipologia_operacion  ,
            nf_vinculacion_operacion,
            nf_entidad_reportada    ,
            nf_fuente_nf            ,
            nf_zona_geografica      ,
            nf_fecha_inclusion      ,
            nf_fecha_vencimiento    ,
            nf_fecha_inhabilitación ,
            nf_fecha_rehabilitación ,
            nf_fecha_veredicto      ,
            nf_fecha_envio          ,
            nf_datos_identificacion ,
            nf_acciones
    	)
    	SELECT 
    	    nf_tipo_documento       ,
            nf_rfc_pasaporte        ,
            nf_genero               ,
            nf_ape_paterno          ,
            nf_ape_materno          ,
            nf_apellidos            ,
            nf_nombre_razon_social  ,
            nf_fecha_nac            ,
            nf_alias                ,
            nf_relacionado_con      ,
            nf_codigo_negative      ,
            nf_tipologia_operacion  ,
            nf_vinculacion_operacion,
            nf_entidad_reportada    ,
            nf_fuente_nf            ,
            nf_zona_geografica      ,
            nf_fecha_inclusion      ,
            nf_fecha_vencimiento    ,
            nf_fecha_inhabilitación ,
            nf_fecha_rehabilitación ,
            nf_fecha_veredicto      ,
            nf_fecha_envio          ,
            nf_datos_identificacion ,
            nf_acciones
    	  FROM  OPENROWSET (BULK ''' + @w_negative_file_path + @w_negative_file_file + ''',
    	  FORMATFILE = ''' + @w_negative_file_path + 'negative_file_format.xml''
    	   ) AS ln;'
    
    EXEC sp_executesql @w_command;
    
    SELECT @w_total_rows = COUNT(*)
    FROM cr_negative_file;
    
    IF @w_total_rows = 0
    BEGIN
    	INSERT INTO cr_negative_file
    	(   
    	    nf_fecha_ultima_carga   ,
    		nf_tipo_documento       ,
            nf_rfc_pasaporte        ,
            nf_genero               ,
            nf_ape_paterno          ,
            nf_ape_materno          ,
            nf_apellidos            ,
            nf_nombre_razon_social  ,
            nf_fecha_nac            ,
            nf_alias                ,
          nf_relacionado_con      ,
            nf_codigo_negative      ,
            nf_tipologia_operacion  ,
            nf_vinculacion_operacion,
            nf_entidad_reportada    ,
            nf_fuente_nf            ,
            nf_zona_geografica      ,
            nf_fecha_inclusion      ,
            nf_fecha_vencimiento    ,
            nf_fecha_inhabilitación ,
            nf_fecha_rehabilitación ,
            nf_fecha_veredicto      ,
            nf_fecha_envio          ,
            nf_datos_identificacion ,
            nf_acciones
    	)
    	SELECT
    	    getdate()               ,
    		nf_tipo_documento       ,
            nf_rfc_pasaporte        ,
            nf_genero               ,
            nf_ape_paterno          ,
            nf_ape_materno          ,
            nf_apellidos            ,
            nf_nombre_razon_social  ,
            nf_fecha_nac            ,
            nf_alias                ,
            nf_relacionado_con      ,
            nf_codigo_negative      ,
            nf_tipologia_operacion  ,
            nf_vinculacion_operacion,
            nf_entidad_reportada    ,
            nf_fuente_nf            ,
            nf_zona_geografica      ,
            nf_fecha_inclusion      ,
            nf_fecha_vencimiento    ,
            nf_fecha_inhabilitación ,
            nf_fecha_rehabilitación ,
            nf_fecha_veredicto      ,
            nf_fecha_envio          ,
            nf_datos_identificacion ,
            nf_acciones
    	FROM #cr_negative_file;
    
    	SELECT @w_error_code = 99
    	
    END
    else
    begin
        update cr_negative_file 
    	set    nf_fecha_ultima_carga = getdate()		
    end
    
    DROP TABLE #cr_negative_file
end
print '--->>>'+convert(varchar(4), @w_error_code) 
return @w_error_code
end
go
