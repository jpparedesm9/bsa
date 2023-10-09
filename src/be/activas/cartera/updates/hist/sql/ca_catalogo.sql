/************************************************************************/
/*      Archivo:            ca_catlgo.sql                               */
/*      Base de datos:      cob_cartera                                 */
/*      Producto:           Cartera                                     */
/*      Disenado por:       Javier Calder[on]                           */
/*      Fecha de escritura: 29/Nov/2016                                 */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*      Este programa realiza la creacion de catalogos                  */
/*      para el modulo de cartera                                       */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    29/Nov/2016      Javier calderon     COBIS CLOUD                  */
/************************************************************************/
use cobis
go

/*************/
/*   TABLA   */
/*************/

delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('cr_clase_cartera','cr_tipo_calif', 'ca_subtipo_linea')
  and codigo = cp_tabla


delete cl_catalogo  from cl_tabla
 where cl_tabla.tabla in ('cr_clase_cartera','cr_tipo_calif', 'ca_subtipo_linea')
   and cl_tabla.codigo = cl_catalogo.tabla


delete cl_tabla
 where cl_tabla.tabla in ('cr_clase_cartera','cr_tipo_calif', 'ca_subtipo_linea')

declare @w_maxtabla smallint
select @w_maxtabla = isnull(max(codigo), 0) + 1
from cl_tabla

update cl_seqnos
set siguiente = @w_maxtabla
where tabla = 'cl_tabla'

declare @w_codigo smallint
select @w_codigo = siguiente + 1
  from cl_seqnos
 where tabla = 'cl_tabla'



select @w_codigo= @w_codigo + 1
print 'Codigos de categoria prestamo cr_clase_cartera'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'cr_clase_cartera', ' Tabla cr_clase_cartera')
insert into cl_catalogo_pro values ('CRE', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '1',  'CREDITOS COMERCIALES', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '2',  'CREDITOS DE CONSUMO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '3',  'VIVIENDA' , 'V')



select @w_codigo= @w_codigo + 1
print ' Tipo de prestamo cr_tipo_calif'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'cr_tipo_calif', 'TIPO DE CARTERA')
insert into cl_catalogo_pro values ('CRE', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '1',  'Actividad Empresarial o Comercial', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '2',  'Liquidez a Otras Cooperativas', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '3',  'Tarjeta De Crédito' , 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '4',  'Personales' , 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '5',  'Nómina', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '6',  'Automotriz', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '7',  'Adquisición De Bienes Muebles' , 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '8',  'Operaciones De Arrendamiento Capitalizable' , 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '9',  'Otros Créditos De Consumo', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '10', 'Media y Residencial', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '11', 'Interés Social', 'V')


select @w_codigo= @w_codigo + 1
print 'Codigos de subtipo prestamo ca_subtipo_linea'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ca_subtipo_linea', 'SUBTIPO DE CARTERA')
insert into cl_catalogo_pro values ('CCA', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '01',  'Quirografarias', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '02',  'Prendarias', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '03',  'Factoraje' , 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '04',  'Arrendamiento Capitalizable' , 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '05',  'Microcréditos', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '06',  'Liquidez a otras Cooperativas', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '07',  'Otros' , 'V')



go

