-------------------------------------------------------------------------------
--Dependencias CTA
----------------------------------------------------------------------------------
--  Resources
--  SharedLibrary 
-- *	AccountingAdmAccounts						- sharedlibrary
-- 		ExchangeAdmCenters							- sharedlibrary
-- 		RemittanceProcess							- sharedlibrary
-- *	Admin										- sharedlibrary
-- 		Correspondents 								- sharedlibrary
-- *		AccountsAdmCatalogs 					- sharedlibrary
-- 				QueryMovements 						- sharedlibrary, resources, AccountsAdmCatalogs
-- 					QueryBackOffice						- sharedlibrary, resources
-- *					CausalAdmAccounts				- sharedlibrary, resources, QueryBackOffice
-- 							Query 						- sharedLibrary, resources, AccountsAdmCatalogs, Querybackoffice
-- *							BackOfficeProcesses		- sharedlibrary, resources, AccountsAdmCatalogs, Query
-- 									QueryBalances		- sharedlibrary, resources, AccountsAdmCatalogs, Query
-- 										CustService 	- sharedlibrary, resources, query, querybalances, QueryMovements, BackOfficeProcesses, AccountsAdmCatalogs, Correspondents

use cobis
go
set nocount ON

delete cobis..an_module_dependency from cobis..an_module_dependency, cobis..an_module
where md_mo_id = mo_id and mo_name like 'CTA.%'

-- delete from cobis..an_module_dependency
-- where md_mo_id in (select mo_id from cobis..an_module where mo_name like 'CTA%')

declare @codigo_depen int, @mod_actual int, @mod_actual2 int, @modulo varchar(100), @modulo_depen varchar(100)
print 'REGISTRO DE DEPENDENCIAS'

--------------------------------------------------
--  RESOURCES 
--------------------------------------------------
select @codigo_depen = 0
select @mod_actual = 0		
select @mod_actual = mo_id 
from cobis..an_module 
where mo_filename = 'COBISCorp.tCOBIS.CTA.Resources.dll'

print 'COD DEPEN: ' + convert(varchar,@codigo_depen)
print 'mod_actual: ' + convert(varchar,@mod_actual)

print 'Dependencia: COBISCorp.tCOBIS.CTA.Resources.dll'
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
select @modulo_depen = 'COBISCorp.tCOBIS.CTA.Resources.dll'
select @modulo = 'COBISCorp.tCOBIS.CTA.SharedLibrary.dll'

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
--  AccountingAdmAccounts 
--------------------------------------------------
select @modulo_depen = 'COBISCorp.tCOBIS.CTA.SharedLibrary.dll'
select @modulo = 'COBISCorp.tCOBIS.CTA.Ahos.AccountingAdmAccounts.dll'

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
--  ExchangeAdmCenters 
--------------------------------------------------
select @modulo_depen = 'COBISCorp.tCOBIS.CTA.SharedLibrary.dll'
select @modulo = 'COBISCorp.tCOBIS.CTA.Ahos.ExchangeAdmCenters.dll'

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
--  RemittanceProcess 
--------------------------------------------------
select @modulo_depen = 'COBISCorp.tCOBIS.CTA.SharedLibrary.dll'
select @modulo = 'COBISCorp.tCOBIS.CTA.Ahos.RemittanceProcess.dll'

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
--  Admin 
--------------------------------------------------
select @modulo_depen = 'COBISCorp.tCOBIS.CTA.SharedLibrary.dll'
select @modulo = 'COBISCorp.tCOBIS.CTA.Ahos.Admin.dll'

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
--  Chamber 
--------------------------------------------------
select @modulo_depen = 'COBISCorp.tCOBIS.CTA.SharedLibrary.dll'
select @modulo = 'COBISCorp.tCOBIS.CTA.Ctes.Chamber.dll'

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
--  Correspondents 
--------------------------------------------------
select @modulo_depen = 'COBISCorp.tCOBIS.CTA.SharedLibrary.dll'
select @modulo = 'COBISCorp.tCOBIS.CTA.Ahos.Correspondents.dll'

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
--  AccountsAdmCatalogs 
--------------------------------------------------
select @modulo_depen = 'COBISCorp.tCOBIS.CTA.Ahos.Correspondents.dll'
select @modulo = 'COBISCorp.tCOBIS.CTA.Ahos.AccountsAdmCatalogs.dll'

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
--  QueryMovements 
--------------------------------------------------
select @modulo_depen = 'COBISCorp.tCOBIS.CTA.Ahos.AccountsAdmCatalogs.dll'
select @modulo = 'COBISCorp.tCOBIS.CTA.Ahos.QueryMovements.dll'

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
--  QueryBackOffice 
--------------------------------------------------
select @modulo_depen = 'COBISCorp.tCOBIS.CTA.Ahos.QueryMovements.dll'
select @modulo = 'COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice.dll'

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
--  CausalAdmAccounts 
--------------------------------------------------
select @modulo_depen = 'COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice.dll'
select @modulo = 'COBISCorp.tCOBIS.CTA.Ahos.CausalAdmAccounts.dll'

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
select @modulo_depen = 'COBISCorp.tCOBIS.CTA.Ahos.CausalAdmAccounts.dll'
select @modulo = 'COBISCorp.tCOBIS.CTA.Ahos.Query.dll'

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
--  BackOfficeProcesses 
--------------------------------------------------
select @modulo_depen = 'COBISCorp.tCOBIS.CTA.Ahos.Query.dll'
select @modulo = 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses.dll'

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
--  QueryBalances 
--------------------------------------------------
select @modulo_depen = 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses.dll'
select @modulo = 'COBISCorp.tCOBIS.CTA.Ahos.QueryBalances.dll'

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
--  CustService 
--------------------------------------------------
select @modulo_depen = 'COBISCorp.tCOBIS.CTA.Ahos.QueryBalances.dll'
select @modulo = 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll'

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
