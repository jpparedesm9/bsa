-- Script de Visual Batch, para el nuevo esquema de seguridades unificada.
-- Elaborado por E. Carrera
use cobis
go

print 'Eliminacion de registros de Seguridad unificada Visual Batch'
go
delete an_transaction_component from an_transaction_component,an_component where co_prod_name = 'M-ADMVBA' and co_id = tc_co_id
delete an_transaction_component where tc_oc_nemonic = 'M-ADMVBA'
delete an_operation_component from an_operation_component,an_component where co_prod_name = 'M-ADMVBA' and co_id = oc_co_id
delete an_referenced_components from an_referenced_components,an_component where co_prod_name = 'M-ADMVBA' and co_id = rc_parent_co_id
go

print 'Creacion de prodname Visual Batch en catalogo an_product'
go

if  not exists( select 1 from  cl_catalogo  where codigo ='M-ADMVBA')
begin
 declare @w_codigo int 
 select @w_codigo=codigo from cl_tabla where tabla='an_product'
 insert into  cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'M-ADMVBA' ,'VISUALBATCH','V')
end
go

--Parametrizacion ECA
insert into an_transaction_component values (0, 8004, 'M-ADMVBA')
insert into an_transaction_component values (0, 8005, 'M-ADMVBA')
insert into an_transaction_component values (0, 8006, 'M-ADMVBA')
insert into an_transaction_component values (0, 8014, 'M-ADMVBA')
insert into an_transaction_component values (0, 8016, 'M-ADMVBA')
insert into an_transaction_component values (0, 8017, 'M-ADMVBA')
insert into an_transaction_component values (0, 8031, 'M-ADMVBA')
insert into an_transaction_component values (0, 8032, 'M-ADMVBA')
insert into an_transaction_component values (0, 8033, 'M-ADMVBA')
insert into an_transaction_component values (0, 8035, 'M-ADMVBA')
insert into an_transaction_component values (0, 8062, 'M-ADMVBA')
insert into an_transaction_component values (0, 8067, 'M-ADMVBA')
insert into an_transaction_component values (0, 8068, 'M-ADMVBA')
insert into an_transaction_component values (0, 8070, 'M-ADMVBA')
insert into an_transaction_component values (0, 8071, 'M-ADMVBA')
insert into an_transaction_component values (0, 8090, 'M-ADMVBA')
insert into an_transaction_component values (0, 8099, 'M-ADMVBA')
insert into an_transaction_component values (0, 8101, 'M-ADMVBA')
insert into an_transaction_component values (0, 8118, 'M-ADMVBA')
insert into an_transaction_component values (0, 15031, 'M-ADMVBA')
insert into an_transaction_component values (0, 15289, 'M-ADMVBA')
--Adicionales
insert into an_transaction_component values (0, 1570, 'M-ADMVBA')
insert into an_transaction_component values (0, 1577, 'M-ADMVBA')
insert into an_transaction_component values (0, 15037, 'M-ADMVBA')
insert into an_transaction_component values (0, 15168, 'M-ADMVBA')
insert into an_transaction_component values (0, 15315, 'M-ADMVBA')
insert into an_transaction_component values (0, 15316, 'M-ADMVBA')
insert into an_transaction_component values (0, 15317, 'M-ADMVBA')
insert into an_transaction_component values (0, 15318, 'M-ADMVBA')
insert into an_transaction_component values (0, 15319, 'M-ADMVBA')
insert into an_transaction_component values (0, 15320, 'M-ADMVBA')
insert into an_transaction_component values (0, 568, 'M-ADMVBA')
go
--Parametrizacion ECA

-- Registros para: PI.ADMVBA.FPathProcClass
print 'Registros para: PI.ADMVBA.FPathProcClass'
--Parametrizacion ECA
declare @w_la_id int, @w_co_id int
select @w_co_id = isnull(max(co_id), 0) + 1 from an_component where co_name = 'ADMVBA.FPathProc' and co_class = 'FPathProcClass'

if not exists (select 1 from an_label where la_label = 'Modificación de Path por Producto') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, 'ES_EC', 'Modificación de Path por Producto', 'M-ADMVBA')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else select @w_la_id = la_id from an_label where la_label = 'Modificación de Path por Producto'

insert into an_operation_component values (@w_co_id, 'UPD_PATH_PRO', @w_la_id, 'Modificación de Path por Producto', 'BUTTON')
insert into an_transaction_component values (@w_co_id, 8102, 'UPD_PATH_PRO')
--Parametrizacion ECA
go

-- Registros para: PI.ADMVBA.FManteniClass
print 'Registros para: PI.ADMVBA.FManteniClass'
----Parametrizacion ECA
declare @w_la_id int, @w_co_id int
select @w_co_id = co_id from an_component where co_name = 'ADMVBA.FManteni' and co_class = 'FManteniClass'

if not exists (select 1 from an_label where la_label = 'Inserción de Programas') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, 'ES_EC', 'Inserción de Programas', 'M-ADMVBA')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else select @w_la_id = la_id from an_label where la_label = 'Inserción de Programas'

insert into an_operation_component values (@w_co_id, 'INS_PROGRAMA', @w_la_id, 'Inserción de Programas', 'BUTTON')
insert into an_transaction_component values (@w_co_id, 8001, 'INS_PROGRAMA')

if not exists (select 1 from an_label where la_label = 'Actualización de Programas') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, 'ES_EC', 'Actualización de Programas', 'M-ADMVBA')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else select @w_la_id = la_id from an_label where la_label = 'Actualización de Programas'

insert into an_operation_component values (@w_co_id, 'UPD_PROGRAMA', @w_la_id, 'Actualización de Programas', 'BUTTON')
insert into an_transaction_component values (@w_co_id, 8002, 'UPD_PROGRAMA')

if not exists (select 1 from an_label where la_label = 'Eliminación de Programas') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, 'ES_EC', 'Eliminación de Programas', 'M-ADMVBA')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else select @w_la_id = la_id from an_label where la_label = 'Eliminación de Programas'

insert into an_operation_component values (@w_co_id, 'DEL_PROGRAMA', @w_la_id, 'Eliminación de Programas', 'BUTTON')
insert into an_transaction_component values (@w_co_id, 8003, 'DEL_PROGRAMA')
----Parametrizacion ECA
go

-- Registros para: PI.ADMVBA.FLotesClass
print 'Registros para: PI.ADMVBA.FLotesClass'
----Parametrizacion ECA
declare @w_co_id int
select @w_co_id = co_id from an_component where co_name = 'ADMVBA.FLotes' and co_class = 'FLotesClass'

insert into an_transaction_component values (@w_co_id, 8083, null)
insert into an_transaction_component values (@w_co_id, 8100, null)
----Parametrizacion ECA
go

-- Registros para: PI.ADMVBA.FFCierreClass
print 'Registros para: PI.ADMVBA.FFCierreClass'
--Parametrizacion ECA
declare @w_la_id int, @w_co_id int
select @w_co_id = co_id from an_component where co_name = 'ADMVBA.FFCierre' and co_class = 'FFCierreClass'

if not exists (select 1 from an_label where la_label = 'Actualizar Fechas de Cierre') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, 'ES_EC', 'Actualizar Fechas de Cierre', 'M-ADMVBA')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else select @w_la_id = la_id from an_label where la_label = 'Actualizar Fechas de Cierre'

insert into an_operation_component values (@w_co_id, 'UPD_FECH_CIERRE', @w_la_id, 'Actualizar Fechas de Cierre', 'BUTTON')
insert into an_transaction_component values (@w_co_id, 8082, 'UPD_FECH_CIERRE')

if not exists (select 1 from an_label where la_label = 'Buscar Fechas de Cierre') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, 'ES_EC', 'Buscar Fechas de Cierre', 'M-ADMVBA')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else select @w_la_id = la_id from an_label where la_label = 'Buscar Fechas de Cierre'

insert into an_operation_component values (@w_co_id, 'CONS_FECH_CIERRE', @w_la_id, 'Buscar Fechas de Cierre', 'BUTTON')
insert into an_transaction_component values (@w_co_id, 8081, 'CONS_FECH_CIERRE')
--Parametrizacion ECA
go

-- Registros para: PI.ADMVBA.FAutorizacionClass
print 'Registros para: PI.ADMVBA.FAutorizacionClass'
--Parametrizacion ECA
declare @w_co_id int
select @w_co_id = co_id from an_component where co_name = 'ADMVBA.FAutorizacion' and co_class = 'FAutorizacionClass'

insert into an_transaction_component values (@w_co_id, 8069, null)
--Parametrizacion ECA
go

-- Registros para: PI.ADMVBA.FAutBatchClass 
print 'Registros para: PI.ADMVBA.FAutBatchClass'
--Parametrizacion ECA
declare @w_la_id int, @w_co_id int
select @w_co_id = co_id from an_component where co_name = 'ADMVBA.FAutBatch' and co_class = 'FAutBatchClass'

insert into an_transaction_component values (@w_co_id, 8068, null)
insert into an_transaction_component values (@w_co_id, 8111, null)
insert into an_transaction_component values (@w_co_id, 8112, null)
--Parametrizacion ECA
go

-- Registros para: PI.ADMVBA.frmFTPClass                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
print 'Registros para: PI.ADMVBA.frmFTPClass'
--Parametrizacion ECA
declare @w_co_id int
select @w_co_id = co_id from an_component where co_name = 'ADMVBA.frmFTP' and co_class = 'frmFTPClass'

insert into an_transaction_component values (@w_co_id, 15291, null)
--Parametrizacion ECA
go

-- Registros para: PI.ADMVBA.FAprobacionParamClass
print 'Registros para: PI.ADMVBA.FAprobacionParamClass'
--Parametrizacion ECA
declare @w_la_id int, @w_co_id int
select @w_co_id = co_id from an_component where co_name = 'ADMVBA.FAprobacionParam' and co_class = 'FAprobacionParamClass'

insert into an_transaction_component values (@w_co_id, 8027, null)
insert into an_transaction_component values (@w_co_id, 8085, null)
insert into an_transaction_component values (@w_co_id, 8088, null)
insert into an_transaction_component values (@w_co_id, 8089, null)
insert into an_transaction_component values (@w_co_id, 8113, null)
--Parametrizacion ECA
go 

-- Registros para: PI.ADMVBA.FEjecLotesClass
print 'Registros para: PI.ADMVBA.FEjecLotesClass'
--Parametrizacion ECA
declare @w_la_id int, @w_co_id int
select @w_co_id = co_id from an_component where co_name = 'ADMVBA.FEjecLotes' and co_class = 'FEjecLotesClass'

insert into an_transaction_component values (@w_co_id, 8091, null)
insert into an_transaction_component values (@w_co_id, 8092, null)
insert into an_transaction_component values (@w_co_id, 8093, null)
insert into an_transaction_component values (@w_co_id, 8094, null)
insert into an_transaction_component values (@w_co_id, 8095, null)
insert into an_transaction_component values (@w_co_id, 8096, null)
insert into an_transaction_component values (@w_co_id, 8097, null)
insert into an_transaction_component values (@w_co_id, 8098, null)
insert into an_transaction_component values (@w_co_id, 8103, null)
insert into an_transaction_component values (@w_co_id, 8105, null)
insert into an_transaction_component values (@w_co_id, 8114, null)

if not exists (select 1 from an_label where la_label = 'Secuencia de Ejecución Gráfica') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, 'ES_EC', 'Secuencia de Ejecución Gráfica', 'M-ADMVBA')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else select @w_la_id = la_id from an_label where la_label = 'Secuencia de Ejecución Gráfica'

insert into an_operation_component values (@w_co_id, 'SEC_EXE_GRAF', @w_la_id, 'Secuencia de Ejecución Gráfica', 'BUTTON')

--Parametrizacion ECA
go

-- Registros para: PI.ADMVBA.FBuscaEstatusClass
print 'Registros para: PI.ADMVBA.FBuscaEstatusClass'
--Parametrizacion ECA
declare @w_la_id int, @w_co_id int
select @w_co_id = co_id from an_component where co_name = 'ADMVBA.FBuscaEstatus' and co_class = 'FBuscaEstatusClass'

if not exists (select 1 from an_label where la_label = 'Consulta del Log') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, 'ES_EC', 'Consulta del Log', 'M-ADMVBA')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else select @w_la_id = la_id from an_label where la_label = 'Consulta del Log'

insert into an_operation_component values (@w_co_id, 'CONS_LOG', @w_la_id, 'Consulta del Log Opción Search', 'BUTTON')
insert into an_transaction_component values (@w_co_id, 8045, 'CONS_LOG')
--Parametrizacion ECA
go

/***************************************************************************/
/*  SCRIPTS DE CREACION DE TRANSACCIONES SEGUN EL NUEVO ESQUEMA DE ADMIN   */
/*  SEGURIDADES                                                            */
/***************************************************************************/
print '***  CREACION DE TRANSACCIONES SEGUN EL NUEVO ESQUEMA DE ADMIN SEGURIDADES  ***'
go

/* Parametrizacion ECA */

/* Parametrizacion de pantallas en sp_cen_catalogar */
/* Pantalla FErrProc */
print 'Pantalla FErrProc'
declare @w_co_id int
select @w_co_id = co_id from an_component where co_name = 'ADMVBA.FErrProc' and co_class = 'FErrProcClass'

insert into an_transaction_component values (@w_co_id, 8205, null)
go

/* Pantalla FSeguridad 
print 'Pantalla FSeguridad'
declare @w_co_id int, @w_la_id int
select @w_co_id = co_id from an_component where co_name = 'ADMVBA.FSeguridadVB' and co_class = 'FSeguridadVBClass'

insert into an_transaction_component values (@w_co_id, 8118, null)

if not exists (select 1 from an_label where la_label = 'Inserción Catálogo Acceso Lectura') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, 'ES_EC', 'Inserción Catálogo Acceso Lectura', 'M-ADMVBA')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else select @w_la_id = la_id from an_label where la_label = 'Inserción Catálogo Acceso Lectura'

insert into an_operation_component values (@w_co_id, 'ING_CAT_LECT', @w_la_id, 'Inserción en Catálogo de Acceso a Lectura', 'BUTTON')
insert into an_transaction_component values (@w_co_id, 8061, 'ING_CAT_LECT')

go*/
/* Parametrizacion ECA */

/* Parametrizacion ECA */
/* Pantallas relacionadas */

declare @w_rol int
select @w_rol = ro_rol from   ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
if @w_rol is null
begin
    print 'NO EXISTE ROL MENU POR PROCESOS'
end

/* Pantalla FManteni y FBUSPARA */
print 'Pantalla FManteni y FBUSPARA'
declare @w_co_id int, @w_la_id int, @w_sco_id int, @w_mo_id int
if not exists (select 1 from an_component where co_name = 'ADMVBA.FBUSPARA' and co_class = 'FBuscaParametrosClass')
begin
  select @w_sco_id  = isnull(max(co_id), 0) + 1 from an_component
  select @w_mo_id = mo_id from an_module where mo_name = 'ADMVBA.Administration'
  insert into an_component values (@w_sco_id, @w_mo_id, 'ADMVBA.FBUSPARA', 'FBuscaParametrosClass', 'COBISCorp.tCOBIS.ADMVBA.Administration', 'SV', '', 'M-ADMVBA')
  insert into an_role_component values (@w_sco_id, @w_rol) 
end
else
begin
  select @w_sco_id = co_id from an_component where co_name = 'ADMVBA.FBUSPARA' and co_class = 'FBuscaParametrosClass'
end
go

declare @w_co_id int, @w_la_id int, @w_sco_id int, @w_mo_id int
if not exists (select 1 from an_label where la_label = 'Mantenimiento de Parámetros del Programa') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, 'ES_EC', 'Mantenimiento de Parámetros del Programa', 'M-ADMVBA')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else select @w_la_id = la_id from an_label where la_label = 'Mantenimiento de Parámetros del Programa'
select @w_co_id = co_id from an_component where co_name = 'ADMVBA.FManteni' and co_class = 'FManteniClass'
select @w_sco_id = co_id from an_component where co_name = 'ADMVBA.FBUSPARA' and co_class = 'FBuscaParametrosClass'
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)
go

/* Pantalla FManteni y FBUSPROC */
print 'Pantalla FManteni y FBUSPROC'
declare @w_rol int
select @w_rol = ro_rol from   ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
if @w_rol is null
begin
    print 'NO EXISTE ROL MENU POR PROCESOS'
end

declare @w_co_id int, @w_la_id int, @w_sco_id int, @w_mo_id int
if not exists (select 1 from an_component where co_name = 'ADMVBA.FBUSPROC' and co_class = 'FBuscaProcClass')
begin
  select @w_sco_id  = isnull(max(co_id), 0) + 1 from   an_component
  select @w_mo_id = mo_id from an_module where mo_name = 'ADMVBA.Query'
  insert into an_component values (@w_sco_id, @w_mo_id, 'ADMVBA.FBUSPROC', 'FBuscaProcClass', 'COBISCorp.tCOBIS.ADMVBA.Query', 'SV', '', 'M-ADMVBA')
  insert into an_role_component values (@w_sco_id, @w_rol)
end
else
begin
  select @w_sco_id = co_id from an_component where co_name = 'ADMVBA.FBUSPROC' and co_class = 'FBuscaProcClass'
end
go

declare @w_co_id int, @w_la_id int, @w_sco_id int, @w_mo_id int
if not exists (select 1 from an_label where la_label = 'Consulta de Programas') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, 'ES_EC', 'Consulta de Programas', 'M-ADMVBA')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else select @w_la_id = la_id from an_label where la_label = 'Consulta de Programas'
select @w_co_id = co_id from an_component where co_name = 'ADMVBA.FManteni' and co_class = 'FManteniClass'
select @w_sco_id = co_id from an_component where co_name = 'ADMVBA.FBUSPROC' and co_class = 'FBuscaProcClass'
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)
go

/* Pantalla FConsutaTiempos y FConsTiemP */
print 'Pantalla FConsutaTiempos y FConsTiemP'
declare @w_rol int
select @w_rol = ro_rol from   ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
if @w_rol is null
begin
    print 'NO EXISTE ROL MENU POR PROCESOS'
end
declare @w_co_id int, @w_la_id int, @w_sco_id int, @w_mo_id int
if not exists (select 1 from an_component where co_name = 'ADMVBA.FConsTiemP')
begin
  select @w_sco_id  = isnull(max(co_id), 0) + 1 from   an_component
  select @w_mo_id = mo_id from an_module where mo_name = 'ADMVBA.Query'
  insert into an_component values (@w_sco_id, @w_mo_id, 'ADMVBA.FConsTiemP', 'FConsTiemPClass', 'COBISCorp.tCOBIS.ADMVBA.Query', 'SV', '', 'M-ADMVBA')
  insert into an_role_component values (@w_sco_id, @w_rol)
end
go

--declare @w_co_id int, @w_la_id int, @w_sco_id int, @w_mo_id int
--select @w_co_id = co_id from an_component where co_name = 'ADMVBA.FConsTiem' and co_class = 'FConsTiemClass'
--select @w_sco_id = co_id from an_component where co_name = 'ADMVBA.FConsTiemP' and co_class = 'FConsTiemPClass'
--if not exists (select 1 from an_label where la_label = 'Consulta de Tiempos de Procesos') 
--begin                                                                                                                                                                            
--   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label                                                                                                                                                                                                  
--   insert into an_label values (@w_la_id, 'ES_EC', 'Consulta de Tiempos de Procesos', 'M-ADMVBA')                                                                                                                                                                         
--end                                                                                                                                                                                                                                                                 
--else select @w_la_id = la_id from an_label where la_label = 'Consulta de Tiempos de Procesos'
--insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)
--go

/* Pantalla FLotes y FPropiedades */
print 'Pantalla FLotes y FPropiedades'
declare @w_rol int
select @w_rol = ro_rol from   ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
if @w_rol is null
begin
    print 'NO EXISTE ROL MENU POR PROCESOS'
end
declare @w_co_id int, @w_la_id int, @w_sco_id int, @w_mo_id int
if not exists (select 1 from an_component where co_name = 'ADMVBA.FPropiedades' and co_class = 'FPropiedadesClass')
begin
  select @w_sco_id  = isnull(max(co_id), 0) + 1 from   an_component
  select @w_mo_id = mo_id from an_module where mo_name = 'ADMVBA.Aux'
  insert into an_component values (@w_sco_id, @w_mo_id, 'ADMVBA.FPropiedades', 'FPropiedadesClass', 'COBISCorp.tCOBIS.ADMVBA.Aux', 'SV', '', 'M-ADMVBA')
  insert into an_transaction_component values (@w_sco_id, 1504, null)
  insert into an_role_component values (@w_sco_id, @w_rol)
end
go

declare @w_co_id int, @w_la_id int, @w_sco_id int, @w_mo_id int
select @w_co_id = co_id from an_component where co_name = 'ADMVBA.FLotes' and co_class = 'FLotesClass'
select @w_sco_id = co_id from an_component where co_name = 'ADMVBA.FPropiedades' and co_class = 'FPropiedadesClass'
if not exists (select 1 from an_label where la_label = 'Propiedades del Proceso') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, 'ES_EC', 'Propiedades del Proceso', 'M-ADMVBA')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else select @w_la_id = la_id from an_label where la_label = 'Propiedades del Proceso'
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)
go

/* Pantalla FLotes y FBusNodo */
print 'Pantalla FLotes y FBusNodo'
declare @w_rol int
select @w_rol = ro_rol from   ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
if @w_rol is null
begin
    print 'NO EXISTE ROL MENU POR PROCESOS'
end
declare @w_co_id int, @w_la_id int, @w_sco_id int, @w_mo_id int
if not exists (select 1 from an_component where co_name = 'ADMVBA.FBusNodo' and co_class = 'FBusNodoClass')
begin
  select @w_sco_id  = isnull(max(co_id), 0) + 1 from   an_component
  select @w_mo_id = mo_id from an_module where mo_name = 'ADMVBA.SharedLibrary'
  insert into an_component values (@w_sco_id, @w_mo_id, 'ADMVBA.FBusNodo', 'FBusNodoClass', 'COBISCorp.tCOBIS.ADMVBA.SharedLibrary', 'SV', '', 'M-ADMVBA')
  insert into an_role_component values (@w_sco_id, @w_rol)
end
go

declare @w_co_id int, @w_la_id int, @w_sco_id int, @w_mo_id int
select @w_co_id = co_id from an_component where co_name = 'ADMVBA.FLotes' and co_class = 'FLotesClass'
select @w_sco_id = co_id from an_component where co_name = 'ADMVBA.FBusNodo' and co_class = 'FBusNodoClass'
if not exists (select 1 from an_label where la_label = 'Búsqueda de Nodos') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, 'ES_EC', 'Búsqueda de Nodos', 'M-ADMVBA')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else select @w_la_id = la_id from an_label where la_label = 'Búsqueda de Nodos'
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)
go

/* Pantalla FLotes y FTools */
print 'Pantalla FLotes y FTools'
declare @w_rol int
select @w_rol = ro_rol from   ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
if @w_rol is null
begin
    print 'NO EXISTE ROL MENU POR PROCESOS'
end
declare @w_co_id int, @w_la_id int, @w_sco_id int, @w_mo_id int
if not exists (select 1 from an_component where co_name = 'ADMVBA.FTools' and co_class = 'FToolsClass')
begin
  select @w_sco_id  = isnull(max(co_id), 0) + 1 from   an_component
  select @w_mo_id = mo_id from an_module where mo_name = 'ADMVBA.SharedLibrary'
  insert into an_component values (@w_sco_id, @w_mo_id, 'ADMVBA.FTools', 'FToolsClass', 'COBISCorp.tCOBIS.ADMVBA.SharedLibrary', 'SV', '', 'M-ADMVBA')
  insert into an_transaction_component values (@w_sco_id, 8015, null)
  insert into an_role_component values (@w_sco_id, @w_rol)
end
go

declare @w_co_id int, @w_la_id int, @w_sco_id int, @w_mo_id int
select @w_co_id = co_id from an_component where co_name = 'ADMVBA.FLotes' and co_class = 'FLotesClass'
select @w_sco_id = co_id from an_component where co_name = 'ADMVBA.FTools' and co_class = 'FToolsClass'
if not exists (select 1 from an_label where la_label = 'Selección de Lotes/Programas') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, 'ES_EC', 'Selección de Lotes/Programas', 'M-ADMVBA')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else select @w_la_id = la_id from an_label where la_label = 'Selección de Lotes/Programas'
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)
go

/* Pantalla FEjecLote y FPropiedades */
print 'Pantalla FEjecLote y FPropiedades'
declare @w_co_id int, @w_la_id int, @w_sco_id int
select @w_co_id = co_id from an_component where co_name = 'ADMVBA.FEjecLotes' and co_class = 'FEjecLotesClass'
select @w_sco_id = co_id from an_component where co_name = 'ADMVBA.FPropiedades' and co_class = 'FPropiedadesClass'
if not exists (select 1 from an_label where la_label = 'Propiedades del Proceso') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, 'ES_EC', 'Propiedades del Proceso', 'M-ADMVBA')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else select @w_la_id = la_id from an_label where la_label = 'Propiedades del Proceso'
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)
go

/* Pantalla FEjecLote y FConfPass */
print 'Pantalla FEjecLote y FConfPass'
declare @w_rol int
select @w_rol = ro_rol from   ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
if @w_rol is null
begin
    print 'NO EXISTE ROL MENU POR PROCESOS'
end
declare @w_co_id int, @w_la_id int, @w_sco_id int, @w_mo_id int
if not exists (select 1 from an_component where co_name = 'ADMVBA.FFConfPass' and co_class = 'FConfPassClass')
begin
  select @w_sco_id  = isnull(max(co_id), 0) + 1 from   an_component
  select @w_mo_id = mo_id from an_module where mo_name = 'ADMVBA.Security'
  insert into an_component values (@w_sco_id, @w_mo_id, 'ADMVBA.FFConfPass', 'FConfPassClass', 'COBISCorp.tCOBIS.ADMVBA.Security', 'SV', '', 'M-ADMVBA')
  insert into an_transaction_component values (@w_sco_id, 15222, null)
  insert into an_role_component values (@w_sco_id, @w_rol)
end
go

declare @w_co_id int, @w_la_id int, @w_sco_id int, @w_mo_id int
select @w_co_id = co_id from an_component where co_name = 'ADMVBA.FEjecLotes' and co_class = 'FEjecLotesClass'
select @w_sco_id = co_id from an_component where co_name = 'ADMVBA.FFConfPass' and co_class = 'FConfPassClass'
if not exists (select 1 from an_label where la_label = 'Ingreso Password Supervisor Batch') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, 'ES_EC', 'Ingreso Password Supervisor Batch', 'M-ADMVBA')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else select @w_la_id = la_id from an_label where la_label = 'Ingreso Password Supervisor Batch'
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)
go

/* Pantalla FEjecLote y FBusNodo */
print 'Pantalla FEjecLote y FBusNodo'
declare @w_co_id int, @w_la_id int, @w_sco_id int
select @w_co_id = co_id from an_component where co_name = 'ADMVBA.FEjecLotes' and co_class = 'FEjecLotesClass'
select @w_sco_id = co_id from an_component where co_name = 'ADMVBA.FBusNodo' and co_class = 'FBusNodoClass'
if not exists (select 1 from an_label where la_label = 'Búsqueda de Nodos') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, 'ES_EC', 'Búsqueda de Nodos', 'M-ADMVBA')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else select @w_la_id = la_id from an_label where la_label = 'Búsqueda de Nodos'
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)
go

/* Pantalla FEjecLote y FTools */
print 'Pantalla FEjecLote y FTools'
declare @w_co_id int, @w_la_id int, @w_sco_id int
select @w_co_id = co_id from an_component where co_name = 'ADMVBA.FEjecLotes' and co_class = 'FEjecLotesClass'
select @w_sco_id = co_id from an_component where co_name = 'ADMVBA.FTools' and co_class = 'FToolsClass'
if not exists (select 1 from an_label where la_label = 'Selección de Lotes/Programas') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, 'ES_EC', 'Selección de Lotes/Programas', 'M-ADMVBA')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else select @w_la_id = la_id from an_label where la_label = 'Selección de Lotes/Programas'
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)
go

/* Pantalla Fayuda */
print 'Pantalla Fayuda'
declare @w_rol int
select @w_rol = ro_rol from   ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
if @w_rol is null
begin
    print 'NO EXISTE ROL MENU POR PROCESOS'
end
declare @w_sco_id int, @w_mo_id int
if not exists (select 1 from an_component where co_name = 'ADMVBA.FAyuda' and co_class = 'FAyudaClass')
begin
  select @w_sco_id  = isnull(max(co_id), 0) + 1 from   an_component
  select @w_mo_id = mo_id from an_module where mo_name = 'ADMVBA.SharedLibrary'
  insert into an_component values (@w_sco_id, @w_mo_id, 'ADMVBA.FAyuda', 'FAyudaClass', 'COBISCorp.tCOBIS.ADMVBA.SharedLibrary', 'SV', '', 'M-ADMVBA')
  insert into an_transaction_component values (@w_sco_id, 8007, null)
  insert into an_role_component values (@w_sco_id, @w_rol)
end
go
/* Parametrizacio ECA */