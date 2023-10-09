/************************************************************************/
/*      Archivo:            param_pfcontable_cat.sql                    */
/*      Base de datos:      cobis                                       */
/*      Producto:           Plazo Fijo                                  */
/*      Disenado por:       Karen Meza                                  */
/*      Fecha de escritura: 22/Sept/2016                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a COBISCorp para    */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Este programa realiza la creación de la parametrización contable    */
/*  de los catalogos de pf_plazo_contable.                              */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR        RAZON                              */
/*  22/Sept/2016      Karen Meza     Emision Inicial                    */
/************************************************************************/

use cobis
go

DECLARE @w_codigo INT
SELECT @w_codigo= codigo FROM cl_tabla where tabla = 'pf_plazo_contable'
delete cobis..cl_tabla where codigo=@w_codigo

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_codigo, 'pf_plazo_contable', 'Plazos para contabilizacion')


--inserta cl_catalogo_pro

if exists( select 1 from cobis..cl_catalogo_pro where cp_tabla= @w_codigo)
delete cobis..cl_catalogo_pro where cp_tabla= @w_codigo

insert into dbo.cl_catalogo_pro (cp_producto, cp_tabla)
values ('PFI', @w_codigo)
go


---insert cl_catalogo
DECLARE @w_codigo INT
SELECT @w_codigo= codigo FROM cl_tabla where tabla = 'pf_plazo_contable'

if exists (select 1 from cobis..cl_catalogo where tabla = @w_codigo)
begin
    delete cobis..cl_catalogo where tabla = @w_codigo
end

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_codigo, '-180D','MENOR A 180 DIAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_codigo, '-360D','IGUAL A 180 DIAS Y MENOR A 360 DIAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_codigo, '-540D','IGUAL A 360 DIAS Y MENOR A 540 DIAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_codigo, '+540D','IGUAL O SUPERIOR A 540 DIAS','V')

go

