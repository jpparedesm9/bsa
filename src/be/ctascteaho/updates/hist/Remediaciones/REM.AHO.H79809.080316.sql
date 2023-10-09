/*************************************************/
---No Bug: AHO-H79809
---Título de la Historia: Mantenimiento de UDIS
---Fecha: 03/08/2016
--Descripción del la Historia:  Agregar la logica de Cotizacion para soporte de 
--                              la conversion de la Unidad de Conversion UDI
--Descripción de la Solución: Se crea el parametro UDI
--Autor: Walther Toledo
/*************************************************/
use cobis
go
declare @w_pais smallint,
        @w_id_moneda int,
        @w_descripcion varchar(100),
        @w_tabla int
-------------------------------------------------------------------------------------------------
--Obtener el codigo del pais - ah_datosini.sql
SELECT @w_pais = pa_smallint 
  FROM cobis..cl_parametro
 WHERE pa_nemonico = 'CP' 
   AND pa_producto = 'ADM'
select @w_descripcion = 'UNIDADES DE INVERSION'

delete from cl_moneda
 where mo_nemonico = 'UDI'
   and mo_pais=@w_pais

SELECT @w_id_moneda = max(mo_moneda) + 1
  FROM cobis..cl_moneda
INSERT INTO cl_moneda (mo_moneda, mo_descripcion, mo_pais, mo_estado, mo_decimales, mo_simbolo, mo_nemonico, mo_cod_ctaunico)
VALUES (@w_id_moneda, @w_descripcion , @w_pais, 'V', 'S', 'UDI', 'UDI', NULL)

-------------------------------------------------------------------------------------------------
-- adm_catlgo.sql
SELECT @w_tabla = codigo 
  FROM cobis..cl_tabla 
 WHERE tabla = 'cl_moneda'

delete from cobis..cl_catalogo 
 where tabla = @w_tabla 
   and codigo = convert(varchar(10),@w_id_moneda)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, convert(varchar(10),@w_id_moneda), @w_descripcion, 'V', NULL, NULL, NULL)

-------------------------------------------------------------------------------------------------

delete from cobis..cl_parametro where pa_nemonico='IUDI' and pa_producto = 'AHO'
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('IDENTIFICADOR UDIS', 'IUDI', 'C', 'UDI', NULL, NULL, NULL, NULL, NULL, null, 'AHO')

-------------------------------------------------------------------------------------------------

INSERT INTO cob_conta..cb_cotizacion (ct_moneda, ct_fecha, ct_valor, ct_compra, ct_venta, ct_factor1, ct_factor2)
VALUES (@w_id_moneda, getdate(), 1, 1, 1, 5.42305400, 1)

go



