USE cob_credito
GO
/************************************************************/
/*   ARCHIVO:         sp_grupal_reglas.sp                   */
/*   NOMBRE LOGICO:   sp_grupal_reglas                      */
/*   PRODUCTO:        COBIS CREDITO                         */
/************************************************************/
/*                     IMPORTANTE                           */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de MACOSA S.A.                               */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de MACOSA.                                 */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor y por las convenciones  internacionales de    */
/*   propiedad intelectual.  Su uso  no  autorizado dara    */
/*   derecho a MACOSA para obtener ordenes  de secuestro    */
/*   o  retencion  y  para  perseguir  penalmente a  los    */
/*   autores de cualquier infraccion.                       */
/************************************************************/
/*                     PROPOSITO                            */
/*  verifica la existenia de una persona en las listas      */
/*  negras. Devuelve S/N y el cargon                        */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR               RAZON                */
/* 06/NOV/2017     LGU                 Emision Inicial      */
/************************************************************/

IF OBJECT_ID ('dbo.sp_valida_pep') IS NOT NULL
	DROP PROCEDURE sp_valida_pep
GO

CREATE PROC sp_valida_pep
@i_ente INT,
@o_es_pep  VARCHAR(10) OUTPUT,
@o_puesto  VARCHAR(200) OUTPUT
as
DECLARE
 @w_curp       VARCHAR(32)
,@w_rfc        VARCHAR(20)
,@w_ente       INT
,@w_contador   INT 
,@w_nombre     VARCHAR(200)
,@w_p_nombre   VARCHAR(64)
,@w_s_nombre   VARCHAR(20)
,@w_p_apellido VARCHAR(16)
,@w_s_apellido VARCHAR(16)
,@w_fecha_nac  VARCHAR(10)
,@w_puesto     VARCHAR(200)
,@w_es_pep     VARCHAR(10)

SELECT @w_es_pep = 'N'
SELECT @w_puesto = ''

	SELECT 
		@w_curp       = lower(replace(en_ced_ruc ,' ','') ),
		@w_rfc        = lower(replace(en_rfc     ,' ','') ),
		@w_ente       = en_ente,
		@w_p_nombre   = lower(replace(isnull(en_nombre   , ''), ' ', '')), 
		@w_s_nombre   = lower(replace(isnull(p_s_nombre  , ''), ' ', '')), 
		@w_p_apellido = lower(replace(isnull(p_p_apellido, ''), ' ', '')), 
		@w_s_apellido = lower(replace(isnull(p_s_apellido, ''), ' ', '')), 
		@w_fecha_nac  = convert(VARCHAR, p_fecha_nac, 112)
	FROM cobis..cl_ente 
	WHERE en_ente = @i_ente

	SELECT @w_nombre = rtrim(@w_p_nombre + ' ' + @w_s_nombre) + ' ' +  rtrim(@w_p_apellido + ' ' + @w_s_apellido)

	PRINT 'nombre =' +  '*'+@w_nombre +'*'

	-- coinciden RFC
	IF EXISTS (SELECT 1 FROM cob_credito..cr_lista_negra
				WHERE ln_rfc = @w_rfc AND ln_tipo_lista  IN  ('ppe','func','fami', 'venc')) 
		AND @w_rfc IS NOT NULL AND @w_rfc <> ''
	BEGIN
		PRINT 'rfc ---' + '*'+ @w_rfc+'*'
		SELECT 
			@w_puesto = ln_puesto,
			@w_es_pep = 'S'
		FROM cob_credito..cr_lista_negra
		WHERE ln_rfc = @w_rfc
		AND ln_tipo_lista  IN  ('ppe','func','fami', 'venc')

		GOTO FIN
	END

	-- coinciden CURP
	IF EXISTS (SELECT * FROM cob_credito..cr_lista_negra
				WHERE rtrim(ln_curp) = rtrim(@w_curp) AND ln_tipo_lista  IN  ('ppe','func','fami', 'venc')) 
		AND @w_curp IS NOT NULL 
		AND @w_curp <> ''
	BEGIN
		PRINT '@w_curp ---' + '*'+@w_curp+'*'
		SELECT 
			@w_puesto = ln_puesto,
			@w_es_pep = 'S'
		FROM cob_credito..cr_lista_negra
		WHERE ln_curp = @w_curp
		AND ln_tipo_lista  IN  ('ppe','func','fami', 'venc')

		GOTO FIN
	END
	
	-- coinciden nombres --> entonces buscar por fecha
	SELECT @w_contador = count(1) FROM cob_credito..cr_lista_negra
	WHERE ln_nom_completo = @w_nombre 
	AND ln_tipo_lista  IN  ('ppe','func','fami', 'venc')

	PRINT ' contador '	  + convert(VARCHAR, @w_contador)

	IF @w_contador > 1
	BEGIN
		IF EXISTS (SELECT 1 FROM cob_credito..cr_lista_negra
					WHERE ln_nom_completo = @w_nombre 
					AND ln_fecha_nac      = @w_fecha_nac
					AND ln_tipo_lista  IN  ('ppe','func','fami', 'venc'))
		BEGIN
			SELECT 
				@w_puesto = ln_puesto,
				@w_es_pep = 'S'
			FROM cob_credito..cr_lista_negra
			WHERE ln_nombre = @w_p_nombre + ' ' + @w_s_nombre 
			AND ln_apellido_paterno = @w_p_apellido
			AND ln_apellido_materno = @w_s_apellido
			AND ln_fecha_nac        = @w_fecha_nac
			AND ln_tipo_lista  IN  ('ppe','func','fami', 'venc')
			
			PRINT ' nombre y SI fecha---' + @w_curp

			GOTO FIN
		END 
		ELSE
		BEGIN
			PRINT ' nombre y NO FECHA---' + @w_curp
			SELECT 
				@w_puesto = '',
				@w_es_pep = 'N' 

			GOTO FIN
		END 
	END
	ELSE
		IF @w_contador = 1
		BEGIN
			SELECT 
				@w_puesto = ln_puesto,
				@w_es_pep = 'S'
			FROM cob_credito..cr_lista_negra
			WHERE ln_nom_completo = @w_nombre 
			AND ln_tipo_lista  IN  ('ppe','func','fami', 'venc')
			
			PRINT ' solo nombre ---  ' + @w_curp

			GOTO FIN
		END
	
FIN:

SELECT 
	@o_puesto = @w_puesto ,
	@o_es_pep = @w_es_pep 

RETURN 0
GO



