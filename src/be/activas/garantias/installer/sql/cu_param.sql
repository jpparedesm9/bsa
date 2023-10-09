/************************************************************************/
/*  Archivo:            cu_param.sql                                    */
/*  Base de datos:      cobis                                           */
/*  Producto:           Custodia                                        */
/*  Disenado por:       Jorge Salazar                                   */
/*  Fecha de escritura: 31/Octubre/2016                                 */
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
/*  Este programa realiza la creacion de los parametros generales       */
/*  para el modulo de cuentas de garantias                              */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA             AUTOR           RAZON                             */
/*  31/Octubre/2016   Jorge Salazar   Migración a CEN                   */
/************************************************************************/
use cobis
go

print '---------> Parametros Generales de Garantias'
go

delete cl_parametro
 where pa_producto = 'GAR'
   and pa_nemonico in ('CODPAC','CODFNG','CODFAG','CODUSA','CODFGA','CODGAR','GARESP','GPE','GARLIQ')
go

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
values ('CODIGO DEL PAGARE DE CARTERA', 'CODPAC', 'C', '1200', 'GAR')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
values ('DESCRIPCION DEL CODIGO DE GARANTIA FNG', 'CODFNG', 'C', '2200', 'GAR')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
values ('DESCRIPCION DEL CODIGO DE GARANTIA FNG', 'CODFAG', 'C', '2200', 'GAR')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
values ('Codigo de garantia USAID', 'CODUSA', 'C', '2400', 'GAR')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
values ('CODIGO GARANTIA FGA', 'CODFGA', 'C', '2500', 'GAR')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
values ('PADRE GARANTIAS UNIVERSAL', 'CODGAR', 'C', '2600', 'GAR')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
values ('TIPO GARANTIAS ESPECIALES', 'GARESP', 'C', '2000', 'GAR')

insert into cobis..cl_parametro(pa_parametro,pa_nemonico,pa_tipo,pa_char,pa_producto)
values('TIPO CUSTODIA PERSONAL','GPE','C','PERSONAL','GAR')

insert into cobis..cl_parametro(pa_parametro,pa_nemonico,pa_tipo,pa_char,pa_producto)
values('TIPO GARANTIA LIQUIDA','GARLIQ','C','AHORRO','GAR')

insert into cobis..cl_parametro(pa_parametro,pa_nemonico,pa_tipo,pa_char,pa_producto)
values ('CATEGORIA GARANTIA PERSONAL', 'GARPER', 'C', 'PERSONAL','GAR')


go

