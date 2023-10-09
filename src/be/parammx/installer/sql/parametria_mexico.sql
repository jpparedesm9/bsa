/************************************************************************/
/*    ARCHIVO:         parametria_mexico.sql                            */
/*    NOMBRE LOGICO:   parametria_mexico.sql                            */
/*    PRODUCTO:        AHORROS                                          */
/************************************************************************/
/*                     IMPORTANTE                                       */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                     PROPOSITO                                        */
/*   Script de validación catalogo tipo de documento                    */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      26/08/2016     Karen Meza           Emision Inicial             */  
/************************************************************************/

USE cobis
go

---VALIDACION CATALOGOS TIPOS DE DOCUMENTO


/*if exists (select 1 from cobis..cl_tipo_documento  where ct_codigo in ('CURP','RFC','PA'))

  delete cobis..cl_tipo_documento  where ct_codigo in ('CURP','RFC','PA')

INSERT INTO cobis..cl_tipo_documento (ct_codigo, ct_sexo, ct_subtipo, ct_descripcion, ct_mascara, ct_estado, ct_valida_fecha_exp, ct_valor_exp, ct_num_dijitos_docu, ct_campo_incluido, ct_formato_fecha, ct_rango_campo_inclu, ct_valor_cade_campo_inclu, ct_tipo_dato, ct_longitud_unica, ct_num_dijitos_docu_max, ct_valida_nit, ct_valida_nui, ct_rango_nui, ct_feccha_exp)
VALUES ('CURP', 'O', 'P', 'CLAVE UNICA DE REGISTRO DE POBLACION', '####,######,#,##,###,##', 'V', 'N', NULL, 1, 'N', NULL, NULL, 'N', 'A', 'U', 18, 'S', 'N', NULL, NULL)

INSERT INTO cobis..cl_tipo_documento (ct_codigo, ct_sexo, ct_subtipo, ct_descripcion, ct_mascara, ct_estado, ct_valida_fecha_exp, ct_valor_exp, ct_num_dijitos_docu, ct_campo_incluido, ct_formato_fecha, ct_rango_campo_inclu, ct_valor_cade_campo_inclu, ct_tipo_dato, ct_longitud_unica, ct_num_dijitos_docu_max, ct_valida_nit, ct_valida_nui, ct_rango_nui, ct_feccha_exp)
VALUES ('RFC', 'O', 'P', 'REGISTRO FEDERAL DE CONTRIBUYENTES', '####,######,###', 'V', 'N', NULL, 1, 'N', NULL, NULL, 'N', 'A', 'U', 13, 'S', 'N', NULL, NULL)

INSERT INTO cobis..cl_tipo_documento (ct_codigo, ct_sexo, ct_subtipo, ct_descripcion, ct_mascara, ct_estado, ct_valida_fecha_exp, ct_valor_exp, ct_num_dijitos_docu, ct_campo_incluido, ct_formato_fecha, ct_rango_campo_inclu, ct_valor_cade_campo_inclu, ct_tipo_dato, ct_longitud_unica, ct_num_dijitos_docu_max, ct_valida_nit, ct_valida_nui, ct_rango_nui, ct_feccha_exp)
VALUES ('PA', 'O', 'P', 'PASAPORTE', 'AAAAAAAAAAAAAA', 'V', 'N', NULL, 3, 'N', NULL, NULL, 'N', 'A', 'V', 14, 'N', 'N', NULL, NULL)

GO
*/
DECLARE @w_cod_curp INT, @w_desc CHAR(10)
SELECT  @w_cod_curp = codigo FROM cobis..cl_tabla WHERE tabla ='cl_tipo_documento'
SELECT @w_desc = codigo FROM cobis..cl_catalogo WHERE tabla= @w_cod_curp AND codigo = 'CURP'
IF EXISTS ( SELECT 1 from cobis..cl_catalogo  WHERE tabla =@w_cod_curp AND codigo = 'CURP')
DELETE cobis..cl_catalogo  WHERE tabla =@w_cod_curp AND codigo = @w_desc

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod_curp, 'CURP', 'CLAVE UNICA DE REGISTRO DE POBLACION', 'V', NULL, NULL, NULL)
GO

DECLARE @w_cod_rfc INT, @w_desrfc CHAR(10)
SELECT  @w_cod_rfc = codigo FROM cobis..cl_tabla WHERE tabla ='cl_tipo_documento'
SELECT @w_desrfc = codigo FROM cobis..cl_catalogo WHERE tabla= @w_cod_rfc AND codigo = 'RFC'
IF EXISTS ( SELECT 1 from cobis..cl_catalogo  WHERE tabla =@w_cod_rfc AND codigo = 'RFC')
DELETE cobis..cl_catalogo  WHERE tabla =@w_cod_rfc AND codigo = @w_desrfc

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod_rfc, 'RFC', 'REGISTRO FEDERAL DE CONTRIBUYENTES', 'V', NULL, NULL, NULL)
GO


DECLARE @w_cod_pa INT, @w_despa CHAR(10)
SELECT  @w_cod_pa = codigo FROM cobis..cl_tabla WHERE tabla ='cl_tipo_documento'
SELECT @w_despa = codigo FROM cobis..cl_catalogo WHERE tabla= @w_cod_pa AND codigo = 'PA'
IF EXISTS ( SELECT 1 from cobis..cl_catalogo  WHERE tabla =@w_cod_pa AND codigo = 'PA')
DELETE cobis..cl_catalogo  WHERE tabla =@w_cod_pa AND codigo = @w_despa

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod_pa, 'PA' , 'PASAPORTE', 'V', NULL, NULL, NULL)

GO

--Al validar la descripcion del parametro ABPAIS del Admin, este debe tener ABREVIATURA COBIS
UPDATE cobis..cl_parametro 
SET  pa_parametro  = 'ABREVIATURA COBIS' 
WHERE  pa_nemonico = 'ABPAIS'
AND pa_producto    = 'ADM'
go
--El producto bancario de corresponsalia no existe, se cambia a 0 su valor
UPDATE cobis..cl_parametro  SET pa_smallint = 0 
WHERE pa_producto = 'AHO' 
and pa_nemonico  = 'PBCB'
go

--DESCRIPCION MONEDA
DECLARE @w_cod INT

SELECT @w_cod = codigo FROM cobis..cl_tabla WHERE tabla ='cl_moneda'
if exists (select 1 from cobis..cl_catalogo where tabla =@w_cod and codigo ='0')
delete cobis..cl_catalogo where tabla = @w_cod and codigo ='0'

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '0', 'PESOS MEXICANOS', 'V', NULL, NULL, NULL)
GO

DECLARE @w_pais SMALLINT 

IF EXISTS (SELECT 1 FROM cobis..cl_parametro WHERE pa_nemonico = 'CP' AND pa_producto = 'ADM')
DELETE cobis..cl_parametro WHERE pa_nemonico = 'CP' AND pa_producto = 'ADM'


INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO DE PAIS (MEXICO)', 'CP', 'S', NULL, NULL,    484, NULL, NULL, NULL, NULL, 'ADM')
GO

declare  @w_cod_pais int
--IF EXISTS (SELECT 1 FROM cobis..cl_moneda WHERE mo_moneda=0)
   DELETE cobis..cl_moneda

 SELECT  @w_cod_pais = pa_smallint from cobis..cl_parametro WHERE pa_nemonico='CP' AND pa_producto='ADM'
INSERT INTO cl_moneda (mo_moneda, mo_descripcion, mo_pais, mo_estado, mo_decimales, mo_simbolo, mo_nemonico, mo_cod_ctaunico)
VALUES (0, 'PESOS', @w_cod_pais, 'V', 'S', 'MX', 'MXN', NULL)
GO

INSERT INTO cl_moneda (mo_moneda, mo_descripcion, mo_pais, mo_estado, mo_decimales, mo_simbolo, mo_nemonico, mo_cod_ctaunico)
VALUES (2, 'DOLARES ESTADOUNIDENSES', 840, 'V', 'S', 'US$', 'USD', NULL)

--descripcion de localidad
if exists (select 1 from cobis..cl_tabla  WHERE tabla    = 'cl_parroquia')
UPDATE cobis..cl_tabla SET descripcion = 'Localidad' WHERE tabla    = 'cl_parroquia'
go

if exists (select 1 from cobis..cl_tabla  WHERE tabla    = 'cl_ciudad')

UPDATE cl_tabla SET descripcion = 'Municipio' WHERE tabla    = 'cl_ciudad'
go

if exists (select 1 from cobis..cl_tabla  WHERE tabla    = 'cl_provincia')
UPDATE cl_tabla SET descripcion = 'Estados'   WHERE tabla    = 'cl_provincia'  
go

use cobis

go

IF EXISTS (SELECT 1 FROM cobis..cl_catalogo_pro WHERE cp_tabla IN(14,15,16) AND cp_producto='ADM')

 DELETE cobis..cl_catalogo_pro WHERE cp_tabla IN(14,15,16) AND cp_producto='ADM'

INSERT INTO cobis..cl_catalogo_pro (cp_producto, cp_tabla)
VALUES ('ADM', 16)
GO

INSERT INTO cobis..cl_catalogo_pro (cp_producto, cp_tabla)
VALUES ('ADM', 15)
GO


INSERT INTO cobis..cl_catalogo_pro (cp_producto, cp_tabla)
VALUES ('ADM', 14)
GO


declare @w_cod int 
select @w_cod = codigo FROM 
cobis..cl_tabla 
WHERE tabla='cl_tparroquia' 


DELETE cobis..cl_catalogo WHERE  codigo = 'U' and tabla=@w_cod
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, 'U', 'Localidades', 'V', NULL, NULL, NULL)
GO

declare @w_cod int 
select @w_cod = codigo 
FROM cobis..cl_tabla 
WHERE tabla='cl_zona' 
DELETE cobis..cl_catalogo WHERE  codigo ='DM' and tabla=@w_cod
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, 'DM', 'zonas', 'V', NULL, NULL, NULL)
GO


declare @w_cod int 

DELETE cobis..cl_catalogo WHERE tabla in (select codigo from cobis..cl_tabla WHERE tabla = 'cl_moneda')
DELETE cobis..cl_catalogo_pro WHERE cp_tabla in (select codigo from cobis..cl_tabla WHERE tabla = 'cl_moneda')
DELETE cobis..cl_tabla WHERE tabla = 'cl_moneda'

select @w_cod = max(codigo) + 1
FROM cobis..cl_tabla  


INSERT INTO cobis..cl_tabla (codigo, tabla, descripcion)
VALUES (@w_cod, 'cl_moneda', 'PRODUCTOS COBIS')

INSERT INTO cobis..cl_catalogo_pro (cp_producto, cp_tabla)
VALUES ('ADM', @w_cod)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '0', 'PESOS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '2', 'DOLARES ESTADOUNIDENSES', 'V', NULL, NULL, NULL)
GO

