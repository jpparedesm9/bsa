/************************************************************************/
/*    ARCHIVO:         04_catalogo.sql                                  */
/*    NOMBRE LOGICO:   04_catalogo.sql                                  */
/*    PRODUCTO:        REGULATORIOS                                     */
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
/*   Script de creacion de catálogo y actualización de cl_seqnos        */
/*   para el reporte de clave-concepto                                  */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      05/04/2022      Daniel Berrio           Emision Inicial         */
/************************************************************************/


use cobis
GO

DECLARE
@w_tabla int

--Entramos borrando
SELECT @w_tabla = codigo FROM cobis..cl_tabla WHERE tabla = 'cl_cla_con'

DELETE FROM cobis..cl_catalogo where tabla = @w_tabla

DELETE FROM cobis..cl_tabla where codigo = @w_tabla

--Tomo valor de la tabla de la cl_seqnos
SELECT @w_tabla = (SELECT MAX(codigo) FROM cobis..cl_tabla ) + 1

--Hago los inserts de la tabla y catálogo con el valor tomado
INSERT INTO cobis..cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'cl_cla_con', 'Catalogo clave concepto conciliador contable')

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'CAS', 'CASTIGO DE OPERACIONES', 'V', NULL, NULL, NULL)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'CLC', 'CANCELACION ANTICIPADA LCR', 'V', NULL, NULL, NULL)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'DES', 'DESEMBOLSO', 'V', NULL, NULL, NULL)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'DGL', 'DEVOLUCION GARANTIAS LIQUIDAS', 'V', NULL, NULL, NULL)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'DSC', 'DESCUENTO DE TASA', 'V', NULL, NULL, NULL)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'DSE', 'DEVOLUCION SEGUROS EXTERNOS', 'V', NULL, NULL, NULL)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'DSP', 'DESPLAZAMIENTO DE CUOTAS', 'V', NULL, NULL, NULL)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'EST', 'CAMBIO DE ESTADO', 'V', NULL, NULL, NULL)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'ETM', 'CAMBIO DE ESTADO MANUAL', 'V', NULL, NULL, NULL)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'FND', 'ADMINISTRACION DE FONDOS', 'V', NULL, NULL, NULL)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'GAR', 'ADMINISTRACION DE GARANTIAS', 'V', NULL, NULL, NULL)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'GCM', 'GENERACION CUOTA MINIMA', 'V', NULL, NULL, NULL)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'IOC', 'INGRESO DE OTROS CARGOS', 'V', NULL, NULL, NULL)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'PAG', 'PAGOS', 'V', NULL, NULL, NULL)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'PRV', 'CAUSACION DE INTERESES', 'V', NULL, NULL, NULL)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'REG', 'REGULARIZACION PAGOS OBJETADOS', 'V', NULL, NULL, NULL)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'RES', 'REESTRUCCTURACION', 'V', NULL, NULL, NULL)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'RPA', 'REGISTRO DE PAGOS', 'V', NULL, NULL, NULL)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'SEG', 'SEGUROS EXTERNOS', 'V', NULL, NULL, NULL)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'TCO', 'TRASLADO CONTABLE DE OFICINAS', 'V', NULL, NULL, NULL)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'VEN', 'VENCIMIENTO DE DIVIDENDOS', 'V', NULL, NULL, NULL)

--Actualizo la cl_seqnos

UPDATE cobis..cl_seqnos
SET siguiente = @w_tabla + 1
WHERE tabla = 'cl_tabla'
