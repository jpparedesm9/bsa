USE cob_credito;
GO

IF EXISTS (SELECT 1 FROM sysobjects o, sysusers u WHERE o.uid = u.uid AND o.name = 'sp_carga_lista_negra' AND u.name = 'dbo' AND o.type = 'P')
    DROP PROCEDURE sp_carga_lista_negra;
GO

CREATE PROCEDURE sp_carga_lista_negra
AS
BEGIN

DECLARE
	@w_black_list_path VARCHAR(30),
	@w_black_list_file VARCHAR(30),
	@w_command NVARCHAR(MAX),
	@w_total_rows INT,
	@w_error_code INT;

SELECT @w_error_code = 0;

SELECT @w_black_list_path = pa_char
FROM cobis..cl_parametro
WHERE pa_producto = 'CRE'
AND pa_nemonico = 'BLPATH';

IF @w_black_list_path IS NULL
BEGIN
	RAISERROR ('No se ha definido el par�metro BLPATH (Ruta del archivo de Lista Negra)', 13, 1);
	RETURN -1;
END

SELECT @w_black_list_file = pa_char
FROM cobis..cl_parametro
WHERE pa_producto = 'CRE'
AND pa_nemonico = 'BLNAME'

IF @w_black_list_file IS NULL
BEGIN
	RAISERROR ('No se ha definido el par�metro BLNAME (Nombre del archivo de Lista Negra)', 13, 1);
	RETURN -1;
END

SELECT * 
INTO #cr_lista_negra
FROM cr_lista_negra;

TRUNCATE TABLE cr_lista_negra;

DBCC CHECKIDENT ('cr_lista_negra', RESEED, 1);

SELECT @w_command =
'INSERT INTO cr_lista_negra
	(
		ln_id_lista        ,
		ln_nombre          ,
		ln_apellido_paterno,
		ln_apellido_materno,
		ln_curp            ,
		ln_rfc             ,
		ln_fecha_nac       ,
		ln_tipo_lista      ,
		ln_estado          ,
		ln_dependencia     ,
		ln_puesto          ,
		ln_iddispo         ,
		ln_curp_ok         ,
		ln_id_rel          ,
		ln_parentesco      ,
		ln_razon_social    ,
		ln_rfc_moral       ,
		ln_num_seg_social  ,
		ln_imss            ,
		ln_ingresos        ,
		ln_nom_completo    ,
		ln_apellidos       ,
		ln_entidad         ,
		ln_sexo            ,
		ln_area
	)
	SELECT
		ln_id_lista        ,
		ln_nombre          ,
		ln_apellido_paterno,
		ln_apellido_materno,
		ln_curp            ,
		ln_rfc             ,
		ln_fecha_nac       ,
		ln_tipo_lista      ,
		ln_estado          ,
		ln_dependencia     ,
		ln_puesto          ,
		ln_iddispo         ,
		ln_curp_ok         ,
		ln_id_rel          ,
		ln_parentesco      ,
		ln_razon_social    ,
		ln_rfc_moral       ,
		ln_num_seg_social  ,
		ln_imss            ,
		ln_ingresos        ,
		ln_nom_completo    ,
		ln_apellidos       ,
		ln_entidad         ,
		ln_sexo            ,
		ln_area
	  FROM  OPENROWSET (BULK ''' + @w_black_list_path + @w_black_list_file + ''',
	  FORMATFILE = ''' + @w_black_list_path + 'lista_negra_format.xml''
	   ) AS ln;'

--PRINT @w_command;

EXEC sp_executesql @w_command;

SELECT @w_total_rows = COUNT(*)
FROM cr_lista_negra;

IF @w_total_rows = 0
BEGIN
	INSERT INTO cr_lista_negra
	(
		ln_fecha_reg	   ,
		ln_id_lista        ,
		ln_nombre          ,
		ln_apellido_paterno,
		ln_apellido_materno,
		ln_curp            ,
		ln_rfc             ,
		ln_fecha_nac       ,
		ln_tipo_lista      ,
		ln_estado          ,
		ln_dependencia     ,
		ln_puesto          ,
		ln_iddispo         ,
		ln_curp_ok         ,
		ln_id_rel          ,
		ln_parentesco      ,
		ln_razon_social    ,
		ln_rfc_moral       ,
		ln_num_seg_social  ,
		ln_imss            ,
		ln_ingresos        ,
		ln_nom_completo    ,
		ln_apellidos       ,
		ln_entidad         ,
		ln_sexo            ,
		ln_area
	)
	SELECT
		ln_fecha_reg	   ,
		ln_id_lista        ,
		ln_nombre          ,
		ln_apellido_paterno,
		ln_apellido_materno,
		ln_curp            ,
		ln_rfc             ,
		ln_fecha_nac       ,
		ln_tipo_lista      ,
		ln_estado          ,
		ln_dependencia     ,
		ln_puesto          ,
		ln_iddispo         ,
		ln_curp_ok         ,
		ln_id_rel          ,
		ln_parentesco      ,
		ln_razon_social    ,
		ln_rfc_moral       ,
		ln_num_seg_social  ,
		ln_imss            ,
		ln_ingresos        ,
		ln_nom_completo    ,
		ln_apellidos       ,
		ln_entidad         ,
		ln_sexo            ,
		ln_area
	FROM #cr_lista_negra;

	SELECT @w_error_code = 999
END

DROP TABLE #cr_lista_negra;

RETURN @w_error_code

END

GO
