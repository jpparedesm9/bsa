/************************************************************************/
/*    ARCHIVO:         reg_menu_dependencia.sql                         */
/*    NOMBRE LOGICO:   reg_menu_dependencia.sql                         */
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
/*   Script de creacion de dependencias de menu de regulatorios         */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      25/08/2016      Ignacio Yupa            Emision Inicial         */  
/************************************************************************/
-------------------------------------------------------------------------------
--Dependencias REC
----------------------------------------------------------------------------------
-- COBISCorp.tCOBIS.REC.Resources .
-- COBISCorp.tCOBIS.REC.SharedLibrary 
-- COBISCorp.tCOBIS.REC.Query 

use cobis
go
set nocount ON

delete cobis..an_module_dependency from cobis..an_module_dependency, cobis..an_module
where md_mo_id = mo_id and mo_name like 'REC.%'

declare @codigo_depen int, @mod_actual int, @mod_actual2 int, @modulo varchar(100), @modulo_depen varchar(100)
print 'REGISTRO DE DEPENDENCIAS'

--------------------------------------------------
--  RESOURCES 
--------------------------------------------------
select @codigo_depen = 0
select @mod_actual = 0		
select @mod_actual = mo_id 
from cobis..an_module 
where mo_filename = 'COBISCorp.tCOBIS.REC.Resources.dll'

print 'COD DEPEN: ' + convert(varchar,@codigo_depen)
print 'mod_actual: ' + convert(varchar,@mod_actual)

print 'Dependencia: COBISCorp.tCOBIS.REC.Resources.dll'
if (@mod_actual is not null )
    if exists(select 1 from cobis..an_module_dependency where md_mo_id = @mod_actual and md_dependency_id = @codigo_depen ) begin
    print 'Ya existe dependencia registrada'
    end else begin
    insert cobis..an_module_dependency  (md_mo_id, md_dependency_id ) values (@mod_actual, @codigo_depen )
    print 'Dependencia registrada'
    end
else print 'NO EXISTE CODIGO DE MODULO O DEPENDENCIA'

--------------------------------------------------
--  SHAREDLIBRARY 
--------------------------------------------------
select @modulo_depen = 'COBISCorp.tCOBIS.REC.Resources.dll'
select @modulo = 'COBISCorp.tCOBIS.REC.SharedLibrary.dll'

select @codigo_depen = mo_id from cobis..an_module 
where mo_filename = @modulo_depen
select @mod_actual = mo_id from cobis..an_module 
where mo_filename = @modulo
update cobis..an_module set mo_id_parent = @codigo_depen
where mo_filename = @modulo

print 'COD DEPEN: ' + convert(varchar,@codigo_depen)
print 'mod_actual: ' + convert(varchar,@mod_actual)

print 'Dependencia: ' + @modulo
if (@mod_actual is not null )
    if exists(select 1 from cobis..an_module_dependency where md_mo_id = @mod_actual and md_dependency_id = @codigo_depen ) begin
    print 'Ya existe dependencia registrada'
    end else begin
    insert cobis..an_module_dependency  (md_mo_id, md_dependency_id ) values (@mod_actual, @codigo_depen )
    print 'Dependencia registrada'
    end
else print 'NO EXISTE CODIGO DE MODULO O DEPENDENCIA'

--------------------------------------------------
--  Query 
--------------------------------------------------
select @modulo_depen = 'COBISCorp.tCOBIS.REC.SharedLibrary.dll'
select @modulo = 'COBISCorp.tCOBIS.REC.Query.dll'

select @codigo_depen = mo_id from cobis..an_module 
where mo_filename = @modulo_depen
select @mod_actual = mo_id from cobis..an_module 
where mo_filename = @modulo
update cobis..an_module set mo_id_parent = @codigo_depen
where mo_filename = @modulo

print 'COD DEPEN: ' + convert(varchar,@codigo_depen)
print 'mod_actual: ' + convert(varchar,@mod_actual)

print 'Dependencia: ' + @modulo
if (@mod_actual is not null )
if exists(select 1 from cobis..an_module_dependency where md_mo_id = @mod_actual and md_dependency_id = @codigo_depen ) begin
print 'Ya existe dependencia registrada'
end else begin
insert cobis..an_module_dependency  (md_mo_id, md_dependency_id ) values (@mod_actual, @codigo_depen )
print 'Dependencia registrada'
end
else print 'NO EXISTE CODIGO DE MODULO O DEPENDENCIA'
