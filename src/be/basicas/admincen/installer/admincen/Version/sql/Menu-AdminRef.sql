/******************************************************************/	
/*	 Archivo: 	              Menu-AdminRef.sql                    */
/*	 Base de datos:           cobis                                */
/*	 Producto: 	              ADMIN-REF                            */
/*	 Disenado por:            Jorge Salazar                        */
/*	 Fecha de documentacion:  04/Ago/2012                          */
/******************************************************************/
/*			                   IMPORTANTE                         */
/*	 Este programa es parte de los paquetes bancarios propiedad de*/
/*	 "MACOSA", representantes exclusivos para el Ecuador de "NCR".*/
/*	 Su uso no autorizado queda expresamente prohibido asi como	  */
/*	 cualquier alteracion o agregado hecho por alguno de sus	  */
/*	 usuarios sin el debido consentimiento por escrito de la 	  */
/*	 Presidencia Ejecutiva de MACOSA o su representante.		  */
/******************************************************************/
/*			                   PROPOSITO                          */
/*  Este script permite crear las opciones de menu para la        */
/*  administracion de seguridades                                 */
/******************************************************************/
/*	                          MODIFICACIONES		              */
/*	 FECHA		   AUTOR		  RAZON				              */
/*  01/Jul/2012   J. Mora    Catalogos                            */
/*  01/Nov/2012   J. Mite    Autorizacion de Funcionalidades      */
/*  15/Ago/2013   J. Tagle   Autorizacion de Funcionalidades      */
/*  21-04-2016    BBO        Migracion Sybase-SQL FAL             */
/******************************************************************/

use cobis
go

declare @w_codigo int 
select @w_codigo=codigo from cl_tabla where tabla='an_product'
if not exists( select 1 from  cl_catalogo  where tabla=@w_codigo and codigo ='M-ADM.Ref')
   insert into  cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'M-ADM.Ref','ADMINISTRADOR DE REFERENCIAS','V')  
go

print '=====> INICIO DE SCRIPTS'

declare @w_co_id     int,
   @w_sco_id         int,
   @w_co_mo_id       int,
   @w_co_namespace   varchar(255),
   @w_co_prod_name   varchar(10),
   @w_la_cod         varchar(10),
   @w_la_id          int,
   @w_nemonic        varchar(10),
   @w_la_label       varchar(100),
   @w_mo_id          int
		
select @w_la_cod = 'ES_EC'

--QUERY DE SECUENCIAL PARA TABLA DE DISTRIBUCION
delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15172 and tc_oc_nemonic = 'M-ADM.Ref' -- BASE_PROD_NAME
insert into an_transaction_component values (0, 15172, 'M-ADM.Ref')

delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1522 and tc_oc_nemonic = 'M-ADM.Ref' -- BASE_PROD_NAME
insert into an_transaction_component values (0, 15222, 'M-ADM.Ref')

--ACTUALIZACION DE USUARIO
delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 568 and tc_oc_nemonic = 'M-ADM.Ref' -- BASE_PROD_NAME
insert into an_transaction_component values (0, 568, 'M-ADM.Ref')

--====================================================
-- FILIALES
--====================================================

print '******** Filiales [FGFilial] ************'
delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1570 and tc_oc_nemonic = 'M-ADM.Ref' -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1570, 'M-ADM.Ref')

delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1577 and tc_oc_nemonic = 'M-ADM.Ref' -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1577, 'M-ADM.Ref')

select @w_co_id = co_id, @w_co_mo_id = co_mo_id, @w_co_namespace = co_namespace, @w_co_prod_name = co_prod_name 
from an_component
where co_name = 'ADM.Ref.FGFilial'

delete from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 1569 and tc_oc_nemonic  is null -- BASE_COMPONENT
insert into an_transaction_component values (@w_co_id, 1569, null)

if not exists (select 1 from an_component where co_name = 'ADM.Ref.FFilial')
begin
   select @w_sco_id = isnull(max(co_id), 0) + 1 from an_component                                                                        
   insert into an_component values(@w_sco_id, @w_co_mo_id, 'ADM.Ref.FFilial', 'FFilialClass', 
                                          @w_co_namespace, 'SV', null, @w_co_prod_name)  
end
else
   select @w_sco_id = co_id from an_component where co_name = 'ADM.Ref.FFilial'

--Autorizacion de Funcionalidades =====> Habilita SubComponentes - Inicio
/*
--====================================================
-- FILIALES -----> FILIAL
--====================================================

if not exists (select 1 from an_label where la_label = 'Filial' and la_prod_name = 'M-ADM.Ref') 
begin
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label
   insert into an_label values (@w_la_id, @w_la_cod, 'Filial', 'M-ADM.Ref')
end
else
   select @w_la_id = la_id from an_label where la_label = 'Filial' and la_prod_name = 'M-ADM.Ref'
delete from an_referenced_components where rc_parent_co_id = @w_co_id and rc_child_co_id = @w_sco_id -- REFERENCE_COMPONENT  
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)

print '******** Filial [FFilial] ************'
delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code in (596, 597) and tc_oc_nemonic = 'M-ADM.Ref' -- BASE_PROD_NAME
insert into an_transaction_component values (0, 596, 'M-ADM.Ref')
insert into an_transaction_component values (0, 597, 'M-ADM.Ref')
--Autorizacion de Funcionalidades =====> Habilita SubComponentes - Fin */

--====================================================
-- MANTENIMIENTO (OFICINAS)
--====================================================

print '******** Oficinas - Mantenimento [FGOficina] ************'
delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1573 and tc_oc_nemonic = 'M-ADM.Ref' -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1573, 'M-ADM.Ref')

select @w_co_id = co_id, @w_co_mo_id = co_mo_id, @w_co_namespace = co_namespace, @w_co_prod_name = co_prod_name 
from an_component
where co_name = 'ADM.Ref.FGOficina'

delete from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (1513,1572,15395) and tc_oc_nemonic  is null -- BASE_COMPONENT
insert into an_transaction_component values (@w_co_id, 1513, null)
insert into an_transaction_component values (@w_co_id, 1572, null)
insert into an_transaction_component values (@w_co_id, 15395, null)


if not exists (select 1 from an_component where co_name = 'ADM.Ref.FOficina')
begin
   select @w_sco_id = isnull(max(co_id), 0) + 1 from an_component
   insert into an_component values (@w_sco_id, @w_co_mo_id, 'ADM.Ref.FOficina', 'FOficinaClass', @w_co_namespace, 'SV', null, @w_co_prod_name)
end
else
   select @w_sco_id = co_id from an_component where co_name = 'ADM.Ref.FOficina'

--Autorizacion de Funcionalidades =====> Habilita SubComponentes - Inicio
/*
--====================================================
-- MANTENIMIENTO (OFICINAS) -----> OFICINA
--====================================================

if not exists (select 1 from an_label where la_label = 'Oficina' and la_prod_name = 'M-ADM.Ref') 
begin       
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label
   insert into an_label values (@w_la_id, @w_la_cod, 'Oficina', 'M-ADM.Ref')
end
else
   select @w_la_id = la_id from an_label where la_label = 'Oficina' and la_prod_name = 'M-ADM.Ref'

delete from an_referenced_components where rc_parent_co_id = @w_co_id and rc_child_co_id = @w_sco_id -- REFERENCE_COMPONENT     
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)

print '******** Oficina [FOficina] ************'
select @w_co_id = co_id, @w_co_mo_id = co_mo_id, @w_co_namespace = co_namespace, @w_co_prod_name = co_prod_name 
from an_component
where co_name = 'ADM.Ref.FOficina'

delete from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (1513, 1514) and tc_oc_nemonic  is null -- BASE_COMPONENT
insert into an_transaction_component values (@w_co_id, 1513, null)
insert into an_transaction_component values (@w_co_id, 1514, null)

delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code in (1571, 1562, 1574) and tc_oc_nemonic = 'M-ADM.Ref' -- BASE_PROD_NAME

insert into an_transaction_component values (0, 1571, 'M-ADM.Ref')
insert into an_transaction_component values (0, 1562, 'M-ADM.Ref')
insert into an_transaction_component values (0, 1574, 'M-ADM.Ref')

--====================================================
-- MANTENIMIENTO (OFICINAS) -----> OFICINA -----> TELEFONOS
--====================================================

if not exists (select 1 from an_component where co_name = 'ADM.Ref.Ftelfofi')
begin
   select @w_sco_id = isnull(max(co_id), 0) + 1 from an_component
   insert into an_component values (@w_sco_id, @w_co_mo_id, 'ADM.Ref.Ftelfofi', 'FtelfofiClass', @w_co_namespace, 'SV', null, @w_co_prod_name)
end
else
   select @w_sco_id = co_id from an_component where co_name = 'ADM.Ref.Ftelfofi'
   
if not exists (select 1 from an_label where la_label = 'Telefonos' and la_prod_name = 'M-ADM.Ref') 
begin
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label
   insert into an_label values (@w_la_id, @w_la_cod, 'Telefonos', 'M-ADM.Ref')
end
else
   select @w_la_id = la_id from an_label where la_label = 'Telefonos' and la_prod_name = 'M-ADM.Ref'

delete from an_referenced_components where rc_parent_co_id = @w_co_id and rc_child_co_id = @w_sco_id -- REFERENCE_COMPONENT     
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)

--=====================================================
-- MANTENIMIENTO (OFICINAS) -----> OFICINA -----> MEDIOS OFICINA
--=====================================================

if not exists (select 1 from an_component where co_name = 'ADM.Ref.FMediosOficina')
begin
   select @w_sco_id = isnull(max(co_id), 0) + 1 from an_component
   insert into an_component values (@w_sco_id, @w_co_mo_id, 'ADM.Ref.FMediosOficina', 'FMediosOficinaClass', @w_co_namespace, 'SV', null, @w_co_prod_name)
end
else
   select @w_sco_id = co_id from an_component where co_name = 'ADM.Ref.FMediosOficina'
   
if not exists (select 1 from an_label where la_label = 'MediosOficina' and la_prod_name = 'M-ADM.Ref') 
begin
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label
   insert into an_label values (@w_la_id, @w_la_cod, 'MediosOficina', 'M-ADM.Ref')
end
else
   select @w_la_id = la_id from an_label where la_label = 'MediosOficina' and la_prod_name = 'M-ADM.Ref'

delete from an_referenced_components where rc_parent_co_id = @w_co_id and rc_child_co_id = @w_sco_id -- REFERENCE_COMPONENT     
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)

print '******** Telefonos [Ftelfofi] ************'
select @w_co_id = co_id, @w_co_mo_id = co_mo_id, @w_co_namespace = co_namespace, @w_co_prod_name = co_prod_name 
from an_component
where co_name = 'ADM.Ref.Ftelfofi'

delete from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (1569, 15104, 15061, 15060) and tc_oc_nemonic  is null -- BASE_COMPONENT
insert into an_transaction_component values (@w_co_id, 1569, null)
insert into an_transaction_component values (@w_co_id, 15104, null)
insert into an_transaction_component values (@w_co_id, 15061, null)
insert into an_transaction_component values (@w_co_id, 15060, null)

print '******** Medios Oficina [FMediosOficina] ************'
select @w_co_id = co_id, @w_co_mo_id = co_mo_id, @w_co_namespace = co_namespace, @w_co_prod_name = co_prod_name 
from an_component
where co_name = 'ADM.Ref.FMediosOficina'

delete from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15186, 15187, 15184, 15183, 15185) and tc_oc_nemonic  is null -- BASE_COMPONENT
insert into an_transaction_component values (@w_co_id, 15186, null)
insert into an_transaction_component values (@w_co_id, 15187, null)
insert into an_transaction_component values (@w_co_id, 15184, null)
insert into an_transaction_component values (@w_co_id, 15183, null)
insert into an_transaction_component values (@w_co_id, 15185, null) */

--Autorizacion de Funcionalidades =====> Habilita SubComponentes - Fin */

--=====================================================
-- MANTENIMIENTO (OFICINAS) -----> COPIAR JERARQUIA DEPARTAMENTAL
--=====================================================

print '******** Oficinas - Copiar Jerarquia Departamental [FCopiajerarquia] ************'
select @w_co_id = co_id, @w_co_mo_id = co_mo_id, @w_co_namespace = co_namespace, @w_co_prod_name = co_prod_name 
from an_component
where co_name = 'ADM.Ref.FCopiajerarquia'

delete from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 15105 -- BASE_COMPONENT
insert into an_transaction_component values (@w_co_id, 15105, null)

delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1574 and tc_oc_nemonic = 'M-ADM.Ref' -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1574, 'M-ADM.Ref')

--=====================================================
-- DEPARTAMENTOS
--=====================================================

print '******** Departamentos [FGDepart] ************'
delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code in (1591, 592) and tc_oc_nemonic = 'M-ADM.Ref' -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1591, 'M-ADM.Ref')
insert into an_transaction_component values (0, 592, 'M-ADM.Ref')

select @w_co_id = co_id, @w_co_mo_id = co_mo_id, @w_co_namespace = co_namespace, @w_co_prod_name = co_prod_name 
from an_component
where co_name = 'ADM.Ref.FGDepartamentos'

delete from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 1592 and tc_oc_nemonic  is null -- BASE_COMPONENT
insert into an_transaction_component values (@w_co_id, 1592, null)

if not exists (select 1 from an_component where co_name = 'ADM.Ref.FDepartamentos')
begin
   select @w_sco_id = isnull(max(co_id), 0) + 1 from an_component
   insert into an_component values (@w_sco_id, @w_co_mo_id, 'ADM.Ref.FDepartamentos', 'FDepartamentosClass', @w_co_namespace, 'SV', null, 
   @w_co_prod_name)
end
else
   select @w_sco_id = co_id from an_component where co_name = 'ADM.Ref.FDepartamentos'
   
print '******** Medios [FMediosDepar] ************'
delete from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15176) and tc_oc_nemonic  is null -- BASE_COMPONENT
insert into an_transaction_component values (@w_co_id, 15176, null)
   
--Autorizacion de Funcionalidades =====> Habilita SubComponentes - Inicio
/*
--=====================================================
-- DEPARTAMENTOS -----> DEPARTAMENTO
--=====================================================

if not exists (select 1 from an_label where la_label = 'Departamento' and la_prod_name = 'M-ADM.Ref') 
begin
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label
   insert into an_label values (@w_la_id, @w_la_cod, 'Departamento', 'M-ADM.Ref')
end
else
   select @w_la_id = la_id from an_label where la_label = 'Departamento' and la_prod_name = 'M-ADM.Ref'

   
delete from an_referenced_components where rc_parent_co_id = @w_co_id and rc_child_co_id = @w_sco_id -- REFERENCE_COMPONENT        
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)

print '******** Departamento [FDepartamentos] ************'
delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code in (590, 591, 1571, 1593) and tc_oc_nemonic = 'M-ADM.Ref' -- 
BASE_PROD_NAME
insert into an_transaction_component values (0, 590, 'M-ADM.Ref')
insert into an_transaction_component values (0, 591, 'M-ADM.Ref')
insert into an_transaction_component values (0, 1571, 'M-ADM.Ref')
insert into an_transaction_component values (0, 1593, 'M-ADM.Ref')

--================================================================
-- DEPARTAMENTOS -----> DEPARTAMENTO -----> MEDIOS DEPARTAMENTALES
--================================================================

if not exists (select 1 from an_component where co_name = 'ADM.Ref.FMediosDepar')
begin
   select @w_sco_id = isnull(max(co_id), 0) + 1 from an_component
  insert into an_component values (@w_sco_id, @w_co_mo_id, 'ADM.Ref.FMediosDepar', 'FMediosDeparClass', @w_co_namespace, 'SV', null, 
  @w_co_prod_name)
end
else
   select @w_sco_id = co_id from an_component where co_name = 'ADM.Ref.FMediosDepar'
   
if not exists (select 1 from an_label where la_label = 'Medios' and la_prod_name = 'M-ADM.Ref') 
begin
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label
   insert into an_label values (@w_la_id, @w_la_cod, 'Medios', 'M-ADM.Ref')
end
else
   select @w_la_id = la_id from an_label where la_label = 'Medios' and la_prod_name = 'M-ADM.Ref'

delete from an_referenced_components where rc_parent_co_id = @w_co_id and rc_child_co_id = @w_sco_id -- REFERENCE_COMPONENT           
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)

print '******** Medios [FMediosDepar] ************'
select @w_co_id = co_id, @w_co_mo_id = co_mo_id, @w_co_namespace = co_namespace, @w_co_prod_name = co_prod_name 
from an_component
where co_name = 'ADM.Ref.FMediosDepar'

delete from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15176, 15177, 15174, 15173, 15175) and tc_oc_nemonic  is null -- BASE_COMPONENT

insert into an_transaction_component values (@w_co_id, 15176, null)
insert into an_transaction_component values (@w_co_id, 15177, null)
insert into an_transaction_component values (@w_co_id, 15174, null)
insert into an_transaction_component values (@w_co_id, 15173, null)
insert into an_transaction_component values (@w_co_id, 15175, null)
--Autorizacion de Funcionalidades =====> Habilita SubComponentes - Fin */

--================================================================
-- PARAMETROS GENERALES
--================================================================

print '******** Parámetros Generales [FParGenerales] ************'
select @w_co_id = co_id, @w_co_mo_id = co_mo_id, @w_co_namespace = co_namespace, @w_co_prod_name = co_prod_name 
from an_component
where co_name = 'ADM.Ref.FParGenerales'

delete from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (1580, 1579) and tc_oc_nemonic  is null -- BASE_COMPONENT
insert into an_transaction_component values (@w_co_id, 1580, null)
insert into an_transaction_component values (@w_co_id, 1579, null)

if not exists (select 1 from an_component where co_name = 'ADM.Ref.FParametros')
begin
   select @w_sco_id = isnull(max(co_id), 0) + 1 from an_component
   insert into an_component values (@w_sco_id, @w_co_mo_id, 'ADM.Ref.FParametros', 'FParametrosClass', @w_co_namespace, 'SV', null, @w_co_prod_name)
end
else
   select @w_sco_id = co_id from an_component where co_name = 'ADM.Ref.FParametros'
   
--Autorizacion de Funcionalidades =====> Habilita SubComponentes - Inicio
/*
--================================================================
-- PARAMETROS GENERALES -----> PARAMETRO GENERAL
--================================================================

if not exists (select 1 from an_label where la_label = 'Parámetro General' and la_prod_name = 'M-ADM.Ref') 
begin
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label
   insert into an_label values (@w_la_id, @w_la_cod, 'Parámetro General', 'M-ADM.Ref')
end
else
   select @w_la_id = la_id from an_label where la_label = 'Parámetro General' and la_prod_name = 'M-ADM.Ref'

delete from an_referenced_components where rc_parent_co_id = @w_co_id and rc_child_co_id = @w_sco_id -- REFERENCE_COMPONENT   
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)

print '******** Parámetros Generales [FParametros] ************'
delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code in (576, 577, 15031) and tc_oc_nemonic = 'M-ADM.Ref' -- BASE_PROD_NAME   
insert into an_transaction_component values (0, 576, 'M-ADM.Ref')
insert into an_transaction_component values (0, 577, 'M-ADM.Ref')
insert into an_transaction_component values (0, 15031, 'M-ADM.Ref')
--Autorizacion de Funcionalidades =====> Habilita SubComponentes - Fin */
go

--================================================================
-- AUTORIZACION DE USUARIOS
--================================================================

print '******** Autorización de Usuarios [FSeguridad] ************'
declare @w_co_id     int,
   @w_sco_id         int,
   @w_co_mo_id       int,
   @w_co_namespace   varchar(255),
   @w_co_prod_name   varchar(10),
   @w_la_cod         varchar(10),
   @w_la_id          int,
   @w_nemonic        varchar(10),
   @w_la_label       varchar(100),
   @w_mo_id          int
select @w_co_id = co_id, @w_co_mo_id = co_mo_id, @w_co_namespace = co_namespace, @w_co_prod_name = co_prod_name 
from an_component
where co_name = 'ADM.Ref.FSeguridad'

delete from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15986) and tc_oc_nemonic  is null -- BASE_COMPONENT
insert into an_transaction_component values (@w_co_id, 15986, null)

delete from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15982) and tc_oc_nemonic  is null -- BASE_COMPONENT
insert into an_transaction_component values (@w_co_id, 15982, null)

delete from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (8068) and tc_oc_nemonic  is null -- BASE_COMPONENT
insert into an_transaction_component values (@w_co_id, 8068, null)

delete from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15984) and tc_oc_nemonic  is null -- BASE_COMPONENT
insert into an_transaction_component values (@w_co_id, 15984, null)

delete from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15983) and tc_oc_nemonic  is null -- BASE_COMPONENT
insert into an_transaction_component values (@w_co_id, 15983, null)

if not exists (select 1 from an_component where co_name = 'ADM.Ref.FSeguridad')
begin
   select @w_sco_id = isnull(max(co_id), 0) + 1 from an_component
   insert into an_component values (@w_sco_id, @w_co_mo_id, 'ADM.Ref.FSeguridad', 'ADM.Ref.FSeguridadClass', @w_co_namespace, 'SV', null, @w_co_prod_name)
end
else
   select @w_sco_id = co_id from an_component where co_name = 'ADM.Ref.FSeguridad'

--================================================================
-- TASAS REFERENCIALES
--================================================================

print '******** Tasa Referenciales [FGtasasClass] ************'
use cobis
--ID del componente actual
select @w_co_id = co_id,@w_nemonic = co_prod_name
from an_component where co_name = 'ADM.Ref.FGTasas'

--Transacciones Base del ProdName
delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15190  and tc_oc_nemonic = @w_nemonic
insert into an_transaction_component values (0, 15190, @w_nemonic)    
go

--Autorizacion de Funcionalidades =====> Habilita SubComponentes - Inicio
/*
--================================================================
-- TASAS REFERENCIALES -----> TASA REFERENCIAL
--================================================================

print '******** Tasa Referencial [FGtasasClass] ************'
declare @w_co_id  int,
   @w_sco_id int,
	@w_la_id  int ,
	@w_nemonic varchar(10)
use cobis
--ID del componente actual
select @w_co_id = co_id,@w_nemonic = co_prod_name
from an_component where co_name = 'ADM.Ref.FGTasas'

--Transacciones Base del ProdName
delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15193  and tc_oc_nemonic = @w_nemonic
insert into an_transaction_component values (0, 15193, @w_nemonic)    
--Autorizacion de Funcionalidades =====> Habilita SubComponentes - Fin */
go

--================================================================
-- CARACTERISTICAS DE TASAS
--================================================================

print '******** Caracteristicas de Tasas [FMCaracTasasClass] ************'
declare @w_co_id  int ,
   @w_sco_id int ,
	@w_la_id  int ,
	@w_nemonic varchar(10)
use cobis
--ID del componente actual
select @w_co_id = co_id,@w_nemonic = co_prod_name
from an_component where co_name = 'ADM.Ref.FMCaracTasas'


delete from an_transaction_component where  tc_co_id = 0 and tc_tn_trn_code in (15193, 15190) and tc_oc_nemonic = @w_nemonic
delete from an_transaction_component where  tc_co_id = @w_co_id and  tc_tn_trn_code in (15191,15192) and tc_oc_nemonic  is null --base component
--Transacciones Base del ProdName
insert into an_transaction_component values (0, 15193, @w_nemonic)  --base prodname
insert into an_transaction_component values (0, 15190, @w_nemonic)  --base prodname

--Transacciones Base Component
insert into an_transaction_component values (@w_co_id, 15191, null) --base component
insert into an_transaction_component values (@w_co_id, 15192, null) --base component

go

--================================================================
-- PIZARRA
--================================================================

print '******** Pizarra [FFManPzClass] ************'
declare @w_co_id  int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)
use cobis
--ID del componente actual
select @w_co_id = co_id,@w_nemonic = co_prod_name
from an_component where co_name = 'ADM.Ref.FFManPz'

--Transacciones Base component

delete from an_transaction_component where  tc_co_id = @w_co_id and  tc_tn_trn_code in (15203, 15208, 15213, 12051, 12052, 15198, 15194, 15202, 15207, 15212, 12337, 15197, 15205, 15210, 15195, 12091, 15200, 15206, 15211, 12110, 15196, 15201, 12181) and tc_oc_nemonic  is null --base component

insert into an_transaction_component values (@w_co_id, 15203, null) --base component
insert into an_transaction_component values (@w_co_id, 15208, null) --base component
insert into an_transaction_component values (@w_co_id, 15213, null) --base component
insert into an_transaction_component values (@w_co_id, 12051, null) --base component
insert into an_transaction_component values (@w_co_id, 12052, null) --base component
insert into an_transaction_component values (@w_co_id, 15198, null) --base component
insert into an_transaction_component values (@w_co_id, 15194, null) --base component
insert into an_transaction_component values (@w_co_id, 15202, null) --base component
insert into an_transaction_component values (@w_co_id, 15207, null) --base component
insert into an_transaction_component values (@w_co_id, 15212, null) --base component
insert into an_transaction_component values (@w_co_id, 12337, null) --base component
insert into an_transaction_component values (@w_co_id, 15197, null) --base component
insert into an_transaction_component values (@w_co_id, 15205, null) --base component
insert into an_transaction_component values (@w_co_id, 15210, null) --base component
insert into an_transaction_component values (@w_co_id, 15195, null) --base component
insert into an_transaction_component values (@w_co_id, 12091, null) --base component
insert into an_transaction_component values (@w_co_id, 15200, null) --base component
insert into an_transaction_component values (@w_co_id, 15206, null) --base component
insert into an_transaction_component values (@w_co_id, 15211, null) --base component
insert into an_transaction_component values (@w_co_id, 12110, null) --base component
insert into an_transaction_component values (@w_co_id, 15196, null) --base component
insert into an_transaction_component values (@w_co_id, 15201, null) --base component
insert into an_transaction_component values (@w_co_id, 12181, null) --base component
go


--================================================================
-- FILIALES (CONSULTA)
--================================================================

print '******** Consulta: Filiales [FConsFiliales] ************'
declare @w_co_id  int ,
        @w_sco_id int ,
		@w_la_id  int ,
		@w_nemonic varchar(10)
use cobis

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name
from an_component where co_name = 'ADM.Ref.FConsFiliales'

--Transacciones Base del Componente 
delete from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 1570 and tc_oc_nemonic  is null
insert into an_transaction_component values (@w_co_id, 1570, null)
go

--================================================================
-- OFICINA POR FILIAL (CONSULTA)
--================================================================

print '******** Consulta: Oficinas por Filial [FConsOficinas] ************'
declare @w_co_id  int ,
        @w_sco_id int ,
		@w_la_id  int ,
		@w_nemonic varchar(10)
use cobis
--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name
from an_component where co_name = 'ADM.Ref.FConsOficinas'

--Transacciones Base del ProdName
delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1571  and tc_oc_nemonic = @w_nemonic
insert into an_transaction_component values (0, 1571, @w_nemonic)    --FILIAL
delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1574  and tc_oc_nemonic =@w_nemonic
insert into an_transaction_component values (0, 1574, @w_nemonic)    --OFICINA
go

--================================================================
-- DEPARTAMENTOS POR OFICINA (CONSULTAS)
--================================================================

print '******** Consulta: Departamentos por Oficina [FConsDepartamentos] ************'
declare @w_co_id  int ,
        @w_sco_id int ,
		@w_la_id  int ,
		@w_nemonic varchar(10)
use cobis
--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name
from an_component where co_name = 'ADM.Ref.FConsDepartamentos'

--Transacciones Base del ProdName
delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1571  and tc_oc_nemonic = @w_nemonic
insert into an_transaction_component values (0, 1571, @w_nemonic)    --FILIAL
delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1574  and tc_oc_nemonic = @w_nemonic
insert into an_transaction_component values (0, 1574, @w_nemonic)    --OFICINA
delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1591  and tc_oc_nemonic = @w_nemonic
insert into an_transaction_component values (0, 1591, @w_nemonic)    --DEPARTAMENTO

go

--================================================================
-- JERARQUICOS POR DEPARTAMENTOS (CONSULTAS)
--================================================================

print '******** Consulta: Jerárquico de Departamentos [FConsJerDep] ************'
declare @w_co_id  int ,
        @w_sco_id int ,
		@w_la_id  int ,
		@w_nemonic varchar(10)
use cobis
--ID del componente actual
select @w_co_id = co_id,@w_nemonic = co_prod_name
from an_component where co_name = 'ADM.Ref.FConsJerDep'

--Transacciones Base del ProdName
delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1571  and tc_oc_nemonic = @w_nemonic
insert into an_transaction_component values (0, 1571, @w_nemonic)    --FILIAL
delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1574  and tc_oc_nemonic = @w_nemonic
insert into an_transaction_component values (0, 1574, @w_nemonic)    --OFICINA
delete from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15046  and tc_oc_nemonic = @w_nemonic
insert into an_transaction_component values (0, 15046, @w_nemonic)   --DEPARTAMENTO

go

/*
--================================================================
-- ConsultaConsulta Detallada de Oficinas (CONSULTAS)
--================================================================

print '******** Consulta: Consulta Detallada de Oficinas [FCondetofi] ************'
declare @w_co_id  int ,
        @w_sco_id int ,
		@w_la_id  int ,
		@w_nemonic varchar(10)
use cobis
--ID del componente actual
select @w_co_id = co_id from an_component where co_class = 'FcondetofiClass'
--Transacciones Base del Componente   
delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15405)  
insert into an_transaction_component values (@w_co_id,15405,null)


go
*/
----------------------------------------------------------------------------------------------------------------
--print '******** Relacion Monedas/Dolar [FFMonedaClass] ************'
------------------------------------------------------------------------------------------------
-- JHI: SE COMENTA USO DE ESTA PANTALLA, YA QUE LA MISMA EXISTE EN EL MODULO DE TESORERIA COBIS
------------------------------------------------------------------------------------------------
declare @w_co_id  int ,
        @w_sco_id int ,
	@w_la_id  int ,
	@w_nemonic varchar(10)
use cobis
----ID del componente actual
select @w_co_id = co_id,@w_nemonic = co_prod_name
from an_component where co_name = 'ADM.Ref.FFMoneda'

delete from an_transaction_component where  tc_co_id = @w_co_id and  tc_tn_trn_code in (15219, 15218, 15216, 15217) and tc_oc_nemonic  is null --base component

--Transacciones Base Component
insert into an_transaction_component values (@w_co_id, 15219, null) --base component
insert into an_transaction_component values (@w_co_id, 15218, null) --base component
insert into an_transaction_component values (@w_co_id, 15216, null) --base component
insert into an_transaction_component values (@w_co_id, 15217, null) --base component
go

use cobis
go

--================================================================
-- MANTENIMIENTO DE DATOS (CATALOGO)
--================================================================

print '******* Mantenimiento de Datos [FMantCatalogoClass] ***********'
--COBISCorp.tCOBIS.ADMREF.Catalog - FMANTCAT.vb
declare @w_co_id int, @w_sco_id	int, @w_la_cod varchar(10), @w_la_label varchar(100), @w_co_prod_name varchar(10), @w_la_id int, @w_mo_id int
select @w_co_prod_name = 'M-ADM.Ref', @w_la_cod = 'ES_EC'
select @w_co_id = co_id from an_component where co_class like 'FMantCatalogoClass' and co_prod_name like @w_co_prod_name

delete from an_transaction_component where tc_co_id = @w_co_id and  tc_tn_trn_code in (1222,1550,1553) and tc_oc_nemonic  is null --base component
delete from an_transaction_component where tc_co_id = 0 and  tc_tn_trn_code in (1209,1549,1552,1555,1558,1561,1567,1564,1571,1578,15029,15396,15399) and tc_oc_nemonic = @w_co_prod_name -- BASE_PROD_NAME

insert into an_transaction_component values (@w_co_id, 1222, null) --i_operacion "S"   --base component
insert into an_transaction_component values (@w_co_id, 1550, null) --i_operacion "H" --base component
insert into an_transaction_component values (@w_co_id, 1553, null) --i_operacion "H"     --base component

insert into an_transaction_component values (0, 1209, @w_co_prod_name) --i_operacion "S" -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1549, @w_co_prod_name) --i_operacion "S"   -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1552, @w_co_prod_name) --i_operacion "S"   -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1555, @w_co_prod_name) --i_operacion "S"   -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1558, @w_co_prod_name) --i_operacion "S"   -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1561, @w_co_prod_name) --i_operacion "S"   -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1567, @w_co_prod_name) --i_operacion "S"   -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1564, @w_co_prod_name) --i_operacion "S"   -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1571, @w_co_prod_name) --i_operacion "H"   -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1578, @w_co_prod_name) --i_operacion "S"   -- BASE_PROD_NAME
insert into an_transaction_component values (0, 15029, @w_co_prod_name) --i_operacion "S"   -- BASE_PROD_NAME
insert into an_transaction_component values (0, 15396, @w_co_prod_name)
insert into an_transaction_component values (0, 15399, @w_co_prod_name)
go

--================================================================
-- DEFAULTS POR OFICINA (CATALOGO)
--================================================================

print '******* Defaults por Oficina [FDefaultsClass] ***********'
--COBISCorp.tCOBIS.ADMREF.Config - FDEFAULT.vb
declare @w_co_id int, @w_sco_id	int, @w_la_cod varchar(10), @w_la_label varchar(100), @w_co_prod_name varchar(10), @w_la_id int, @w_mo_id int
select	@w_co_prod_name = 'M-ADM.Ref', @w_la_cod = 'ES_EC'
select @w_co_id = co_id from an_component where co_class like 'FDefaultsClass' and co_prod_name like @w_co_prod_name

delete from an_transaction_component where tc_co_id = @w_co_id and  tc_tn_trn_code in (1587,1588,1590,1576) and tc_oc_nemonic  is null --base component
delete from an_transaction_component where tc_co_id = 0 and  tc_tn_trn_code in (1209,1549,1552, 1555,1558,1561, 1564,1567,1570, 1571,1574,1573, 1578,15029 ) and tc_oc_nemonic = @w_co_prod_name -- BASE_PROD_NAME

insert into an_transaction_component values (@w_co_id, 1587, null) --i_operacion "S"   --base component
insert into an_transaction_component values (@w_co_id, 1588, null) --i_operacion "Q"   --base component
insert into an_transaction_component values (@w_co_id, 1590, null) --i_operacion "S"   --base component
insert into an_transaction_component values (@w_co_id, 1576, null) --i_operacion "S" --base component

insert into an_transaction_component values (0, 1209, @w_co_prod_name) --i_operacion "S" -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1549, @w_co_prod_name) --i_operacion "S" -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1552, @w_co_prod_name) --i_operacion "S" -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1555, @w_co_prod_name) --i_operacion "S" -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1558, @w_co_prod_name) --i_operacion "S" -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1561, @w_co_prod_name) --i_operacion "S" -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1564, @w_co_prod_name) --i_operacion "S" -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1567, @w_co_prod_name) --i_operacion "S" -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1570, @w_co_prod_name) --i_operacion "S" -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1571, @w_co_prod_name) --i_operacion "H" -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1574, @w_co_prod_name) --i_operacion "H" -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1573, @w_co_prod_name) --i_operacion "S" -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1578, @w_co_prod_name) --i_operacion "S" -- BASE_PROD_NAME
insert into an_transaction_component values (0, 15029, @w_co_prod_name) --i_operacion "S" -- BASE_PROD_NAME
go

--================================================================
-- MANTENIMIENTO DE TABLAS (CATALOGO)
--================================================================

print '******* Mantenimiento de Tablas [FGTablasClass] ***********'
--COBISCorp.tCOBIS.ADMREF.Catalog - FGTABLAS.vb
declare @w_co_id int, @w_sco_id	int, @w_la_cod varchar(10), @w_la_label varchar(100), @w_co_prod_name varchar(10), @w_la_id int, @w_mo_id int
select @w_co_prod_name = 'M-ADM.Ref', @w_la_cod = 'ES_EC'
select @w_co_id = co_id from an_component where co_class like 'FGTablasClass' and co_prod_name like @w_co_prod_name

delete from an_transaction_component where tc_co_id = @w_co_id and  tc_tn_trn_code in (1533) and tc_oc_nemonic  is null --base component
delete from an_transaction_component where tc_co_id = @w_co_id and  tc_tn_trn_code in (15056) and tc_oc_nemonic  is null --base component
delete from an_transaction_component where tc_co_id = 0 and  tc_tn_trn_code in (15055) and tc_oc_nemonic = @w_co_prod_name -- BASE_PROD_NAME

insert into an_transaction_component values (@w_co_id, 1533, null) --actualizar tabla   --base component
insert into an_transaction_component values (@w_co_id, 15056, null) --i_operacion "S"   --base component
insert into an_transaction_component values (0, 15055, @w_co_prod_name) --i_operacion "S" -- BASE_PROD_NAME
go

--================================================================
-- ASIGNACION DE TABLAS A PRODUCTOS (CATALOGO)
--================================================================
print '******* Asignacion de Tablas a Productos [FTabProductoClass] ***********'
--COBISCorp.tCOBIS.ADMREF.Catalog - FTABPROD.vb
declare @w_co_id int, @w_sco_id	int, @w_la_cod varchar(10), @w_la_label varchar(100), @w_co_prod_name varchar(10), @w_la_id int, @w_mo_id int
select	@w_co_prod_name = 'M-ADM.Ref', @w_la_cod = 'ES_EC'
select @w_co_id = co_id from an_component where co_class like 'FTabProductoClass' and co_prod_name like @w_co_prod_name

delete from an_transaction_component where tc_co_id = @w_co_id and  tc_tn_trn_code in (586) and tc_oc_nemonic  is null --base component
delete from an_transaction_component where tc_co_id = 0 and  tc_tn_trn_code in (587,1578,15031,15055) and tc_oc_nemonic = @w_co_prod_name -- BASE_PROD_NAME

insert into an_transaction_component values (@w_co_id, 586, null) --i_operacion "I"   --base component

insert into an_transaction_component values (0, 587, @w_co_prod_name) --i_operacion "D" -- BASE_PROD_NAME
insert into an_transaction_component values (0, 1578, @w_co_prod_name) --i_operacion "S" -- BASE_PROD_NAME
insert into an_transaction_component values (0, 15031, @w_co_prod_name) --i_operacion "H" -- BASE_PROD_NAME
insert into an_transaction_component values (0, 15055, @w_co_prod_name) --i_operacion "S" -- BASE_PROD_NAME
go

--================================================================
-- VIGENCIAS DE TABLAS
--================================================================

--print '******* Vigencias de Tablas [FVigenciaTablasClass] ***********'
--COBISCorp.tCOBIS.ADMREF.Config - FVIGETAB.vb

--declare @w_co_id int, @w_sco_id	int, @w_la_cod varchar(10), @w_la_label varchar(100), @w_co_prod_name varchar(10), @w_la_id int, @w_mo_id int
--select	@w_co_prod_name = 'M-ADM.Ref', @w_la_cod = 'ES_EC'
--select @w_co_id = co_id from an_component where co_class like 'FVigenciaTablasClass' and co_prod_name like @w_co_prod_name

--delete from an_transaction_component where tc_co_id = @w_co_id and  tc_tn_trn_code in (581,582) and tc_oc_nemonic  is null --base component

--insert into an_transaction_component values (@w_co_id, 581, null) --i_operacion "I"   --base component
--insert into an_transaction_component values (@w_co_id, 582, null) --i_operacion "U"   --base component
--go


--================================================================
-- MENSAJES DE ERROR (CATALOGO)
--================================================================
print '******* Mensajes de Error [FGMenErrorClass] ***********'
--COBISCorp.tCOBIS.ADMREF.Config - FGMENERR.vb
declare @w_co_id int, @w_sco_id	int, @w_la_cod varchar(10), @w_la_label varchar(100), @w_co_prod_name varchar(10), @w_la_id int, @w_mo_id int
select @w_co_prod_name = 'M-ADM.Ref', @w_la_cod = 'ES_EC'
select @w_co_id = co_id from an_component where co_class like 'FGMenErrorClass' and co_prod_name like @w_co_prod_name

delete from an_transaction_component where tc_co_id = @w_co_id and  tc_tn_trn_code in (1534,1535,1536,1598,1599) and tc_oc_nemonic  is null --base component

insert into an_transaction_component values (@w_co_id, 1534, null) --i_operacion "I"   --base component
insert into an_transaction_component values (@w_co_id, 1535, null) --i_operacion "U"   --base component
insert into an_transaction_component values (@w_co_id, 1536, null) --i_operacion "D"   --base component
insert into an_transaction_component values (@w_co_id, 1598, null) --i_operacion "S"   --base component
insert into an_transaction_component values (@w_co_id, 1599, null) --i_operacion "Q"   --base component
go

-- BASE COMPONENT
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15020 and tc_oc_nemonic  = 'M-ADM.Ref' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15020 and tc_oc_nemonic  = 'M-ADM.Ref'
insert into an_transaction_component values (0,15020,'M-ADM.Ref')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1570 and tc_oc_nemonic  = 'M-ADM.Ref' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1570 and tc_oc_nemonic  = 'M-ADM.Ref'
insert into an_transaction_component values (0,1570,'M-ADM.Ref')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1577 and tc_oc_nemonic  = 'M-ADM.Ref' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1577 and tc_oc_nemonic  = 'M-ADM.Ref'
insert into an_transaction_component values (0,1577,'M-ADM.Ref')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15037 and tc_oc_nemonic  = 'M-ADM.Ref' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15037 and tc_oc_nemonic  = 'M-ADM.Ref'
insert into an_transaction_component values (0,15037,'M-ADM.Ref')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15168 and tc_oc_nemonic  = 'M-ADM.Ref' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15168 and tc_oc_nemonic  = 'M-ADM.Ref'
insert into an_transaction_component values (0,15168,'M-ADM.Ref')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15315 and tc_oc_nemonic  = 'M-ADM.Ref' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15315 and tc_oc_nemonic  = 'M-ADM.Ref'
insert into an_transaction_component values (0,15315,'M-ADM.Ref')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15316 and tc_oc_nemonic  = 'M-ADM.Ref' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15316 and tc_oc_nemonic  = 'M-ADM.Ref'
insert into an_transaction_component values (0,15316,'M-ADM.Ref')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15317 and tc_oc_nemonic  = 'M-ADM.Ref')
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15317 and tc_oc_nemonic  = 'M-ADM.Ref'
insert into an_transaction_component values (0,15317,'M-ADM.Ref')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15318 and tc_oc_nemonic  = 'M-ADM.Ref' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15318 and tc_oc_nemonic  = 'M-ADM.Ref'
insert into an_transaction_component values (0,15318,'M-ADM.Ref')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15319 and tc_oc_nemonic  = 'M-ADM.Ref')
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15319 and tc_oc_nemonic  = 'M-ADM.Ref'
insert into an_transaction_component values (0,15319,'M-ADM.Ref')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15320 and tc_oc_nemonic  = 'M-ADM.Ref' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15320 and tc_oc_nemonic  = 'M-ADM.Ref'
insert into an_transaction_component values (0,15320,'M-ADM.Ref')


go
