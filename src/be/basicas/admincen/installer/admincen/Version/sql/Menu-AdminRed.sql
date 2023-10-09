/********************************************************************/	
/*    Archivo:       Menu-AdminRed.sql	                            */
/*    Base de datos: cobis         		 	            */
/*    Producto:      ADMIN-RED  			 	    */
/*    Disenado por:  Roger Orejuela                                 */
/*    Fecha:	     04/Ago/2012		 	 	    */
/********************************************************************/
/*		     IMPORTANTE	                                    */
/*    Este programa es parte de los paquetes bancarios propiedad de */
/*    "MACOSA", representantes exclusivos para el Ecuador de "NCR". */
/*    Su uso no autorizado queda expresamente prohibido asi como    */
/*    cualquier alteracion o agregado hecho por alguno de sus	    */
/*    usuarios sin el debido consentimiento por escrito de la 	    */
/*    Presidencia Ejecutiva de MACOSA o su representante.	    */
/********************************************************************/
/*		     PROPOSITO		                            */
/*    Este script permite crear las opciones de menu para la        */
/*    administracion de seguridades                                 */
/********************************************************************/
/*	             MODIFICACIONES		                    */
/*    FECHA          AUTOR          RAZON	                    */
/*    01/Nov/2012    J. Mite        Autorizacion de Funcionalidades */
/*    21-04-2016     BBO            Migracion Sybase-SQL FAL        */
/********************************************************************/



/********************************************************************/
/*                ADMINISTRACION DE RED (ADMRED)	            */
/********************************************************************/

--====================================================
-- PRODNAME 
--====================================================
use cobis
go	

declare @w_codigo int 
select @w_codigo=codigo from cl_tabla where tabla='an_product'
if not exists( select 1 from  cl_catalogo  where tabla=@w_codigo and codigo ='M-ADM.RED')
   insert into  cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'M-ADM.RED','ADMINISTRADOR DE RED','V')  
go

declare @w_nemonic varchar(10)
	
--ID del componente actual
select @w_nemonic = 'M-ADM.RED'

-- BASE PROD-NAME
if exists(select 1 from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =1571 and tc_oc_nemonic = @w_nemonic)
   delete from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =1571 and tc_oc_nemonic = @w_nemonic
insert into an_transaction_component values (0, 1571,@w_nemonic)    --FILIAL

if exists(select 1 from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =1574 and tc_oc_nemonic = @w_nemonic)
   delete from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =1574 and tc_oc_nemonic = @w_nemonic
insert into an_transaction_component values (0, 1574,@w_nemonic)    --OFICINA

if exists(select 1 from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =15015 and tc_oc_nemonic = @w_nemonic)
   delete from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =15015 and tc_oc_nemonic = @w_nemonic
insert into an_transaction_component values (0, 15015,@w_nemonic)   --NODO

if exists(select 1 from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =15062  and tc_oc_nemonic = @w_nemonic)
   delete from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =15062  and tc_oc_nemonic = @w_nemonic
insert into an_transaction_component values (0, 15062,@w_nemonic)   --BUSCA TERMINALES

if exists(select 1 from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =1581  and tc_oc_nemonic =@w_nemonic)
   delete from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =1581  and tc_oc_nemonic =@w_nemonic
insert into an_transaction_component values (0, 1581,@w_nemonic)    --BASE DATOS

if exists(select 1 from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =568  and tc_oc_nemonic =@w_nemonic)
   delete from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =568  and tc_oc_nemonic =@w_nemonic
insert into an_transaction_component values (0, 568,@w_nemonic)

print 'SE APLICO CON EXITO LA SEGURIDAD PARA: PRODUNAME DE RED'
go


--====================================================
-- TERMINALES
--====================================================

use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)
	
--ID del componente actual
select @w_co_id = co_id,@w_nemonic = co_prod_name
from an_component where co_name = 'ADM.RED.FTerminales'

-- BASE COMPONENT
if exists(select 1 from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =1571 and tc_oc_nemonic = @w_nemonic)
   delete from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =1571 and tc_oc_nemonic = @w_nemonic
insert into an_transaction_component values (0, 1571,@w_nemonic)    --FILIAL

if exists(select 1 from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =1574 and tc_oc_nemonic = @w_nemonic)
   delete from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =1574 and tc_oc_nemonic = @w_nemonic
insert into an_transaction_component values (0, 1574,@w_nemonic)    --OFICINA

if exists(select 1 from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =15015 and tc_oc_nemonic = @w_nemonic)
   delete from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =15015 and tc_oc_nemonic = @w_nemonic
insert into an_transaction_component values (0, 15015,@w_nemonic)   --NODO

if exists(select 1 from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =15062  and tc_oc_nemonic = @w_nemonic)
   delete from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =15062  and tc_oc_nemonic = @w_nemonic
insert into an_transaction_component values (0, 15062,@w_nemonic)   --BUSCA TERMINALES

if exists(select 1 from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =1581  and tc_oc_nemonic =@w_nemonic)
   delete from an_transaction_component where tc_co_id= 0 and tc_tn_trn_code =1581  and tc_oc_nemonic =@w_nemonic
insert into an_transaction_component values (0, 1581,@w_nemonic)    --BASE DATOS


-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =555 and tc_oc_nemonic is null)
  delete from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =555 and tc_oc_nemonic is null
insert into an_transaction_component values (@w_co_id, 555, null)

if exists(select 1 from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =556 and tc_oc_nemonic is null)
  delete from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =556 and tc_oc_nemonic is null
insert into an_transaction_component values (@w_co_id, 556, null)

if exists(select 1 from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =557 and tc_oc_nemonic is null)
  delete from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =557 and tc_oc_nemonic is null
insert into an_transaction_component values (@w_co_id, 557, null)

if exists(select 1 from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =15063 and tc_oc_nemonic is null)
  delete from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =15063 and tc_oc_nemonic is null
insert into an_transaction_component values (@w_co_id, 15063, null)

print 'SE APLICO CON EXITO LA SEGURIDAD PARA: TERMINALES'
go


--====================================================
-- BASE DE DATOS
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'ADM.RED.FBaseDatos'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =1581 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =1581 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,1581,null)									

if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =1582 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =1582 and tc_oc_nemonic  is null								
insert into  an_transaction_component  values(@w_co_id,1582,null)									

if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =506 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =506 and tc_oc_nemonic  is null									
insert into  an_transaction_component  values(@w_co_id,506,null)									

if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =504 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =504 and tc_oc_nemonic  is null									
insert into  an_transaction_component  values(@w_co_id,504,null)									

if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =505 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =505 and tc_oc_nemonic  is null									
insert into  an_transaction_component  values(@w_co_id,505,null)									

print 'SE APLICO CON EXITO LA SEGURIDAD PARA: BASE DE DATOS'
go

--====================================================
-- NODO
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10),
	@w_la_cod varchar(10)	

--ID del componente actual
select @w_co_id = co_id,@w_nemonic = co_prod_name
from an_component where co_name = 'ADM.RED.FNodos'

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =522 and tc_oc_nemonic is null)
   delete from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =522 and tc_oc_nemonic is null
insert into an_transaction_component values (@w_co_id, 522, null)

if exists(select 1 from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =523 and tc_oc_nemonic is null)
   delete from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =523 and tc_oc_nemonic is null
insert into an_transaction_component values (@w_co_id, 523, null)

if exists(select 1 from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =15012 and tc_oc_nemonic is null)
   delete from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =15012 and tc_oc_nemonic is null
insert into an_transaction_component values (@w_co_id, 15012, null)

if exists(select 1 from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =15054 and tc_oc_nemonic is null)
   delete from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =15054 and tc_oc_nemonic is null
insert into an_transaction_component values (@w_co_id, 15054, null)

--Autorizacion de Funcionalidades =====> Habilita SubComponentes - Inicio
/*
--Llamando a Subcomponente
select @w_la_cod= 'ES_EC' 

-- Relaciona al subcomponente FTerminales
if not exists (select 1 from an_label where la_label = 'Terminales' and la_prod_name = @w_nemonic) 
begin 
   select @w_la_id = isnull(max(la_id), 0) + 1 from   an_label    
   insert into an_label values (@w_la_id, @w_la_cod, 'Terminales', @w_nemonic)
end                         
else 
   select @w_la_id = la_id from an_label where la_label = 'Terminales'

select @w_sco_id = co_id from an_component where co_name = 'ADM.RED.FTerminales'

if exists(select 1 from an_referenced_components where rc_parent_co_id = @w_co_id and rc_child_co_id = @w_sco_id and rc_la_id= @w_la_id)
   delete from an_referenced_components where rc_parent_co_id = @w_co_id and rc_child_co_id = @w_sco_id and rc_la_id= @w_la_id
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)

-- Relaciona al subcomponente FBaseDatos
if not exists (select 1 from an_label where la_label = 'Bases de Datos' and la_prod_name = @w_nemonic) 
begin                
   select @w_la_id = isnull(max(la_id), 0) + 1 from   an_label    
   insert into an_label values (@w_la_id, @w_la_cod, 'Bases de Datos', @w_nemonic)                         
end                                                                                                                                  
else 
   select @w_la_id = la_id from an_label where la_label = 'Bases de Datos'
select @w_sco_id = co_id from an_component where co_name = 'ADM.RED.FBaseDatos'
if exists(select 1 from an_referenced_components where rc_parent_co_id = @w_co_id and rc_child_co_id = @w_sco_id and rc_la_id= @w_la_id)
   delete from an_referenced_components where rc_parent_co_id = @w_co_id and rc_child_co_id = @w_sco_id and rc_la_id= @w_la_id
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)
--Autorizacion de Funcionalidades =====> Habilita SubComponentes - Fin */

print 'SE APLICO CON EXITO LA SEGURIDAD PARA: NODO'
go


--====================================================
-- GRUPO NODO (ACTUALIZAR, HABILITAR, ELIMINAR)
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10),
	@w_la_cod varchar(10)	

--ID del componente actual
select @w_co_id = co_id,@w_nemonic = co_prod_name
from an_component where co_name = 'ADM.RED.FGNodos'

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =524 and tc_oc_nemonic is null)
   delete from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =524 and tc_oc_nemonic is null
insert into an_transaction_component values (@w_co_id, 524, null)

if exists(select 1 from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =1583 and tc_oc_nemonic is null)
   delete from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =1583 and tc_oc_nemonic is null
insert into an_transaction_component values (@w_co_id, 1583, null)

if exists(select 1 from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =15014 and tc_oc_nemonic is null)
   delete from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =15014 and tc_oc_nemonic is null
insert into an_transaction_component values (@w_co_id, 15014, null)

--Autorizacion de Funcionalidades =====> Habilita SubComponentes - Inicio 
/*
--Llamando a Subcomponente
--Relaciona al subcomponente FNODOS
select @w_la_cod= 'ES_EC' 
if not exists (select 1 from an_label where la_label = 'Nodos' and la_prod_name = @w_nemonic) 
begin                         
   select @w_la_id = isnull(max(la_id), 0) + 1 from   an_label    
   insert into an_label values (@w_la_id, @w_la_cod, 'Nodos', @w_nemonic) 
end                                                                                                                                               else 
   select @w_la_id = la_id from an_label where la_label = 'Nodos'

select @w_sco_id = co_id from an_component where co_name = 'ADM.RED.FNodos'
if exists(select 1 from an_referenced_components where rc_parent_co_id = @w_co_id and rc_child_co_id = @w_sco_id and rc_la_id= @w_la_id)
   delete from an_referenced_components where rc_parent_co_id = @w_co_id and rc_child_co_id = @w_sco_id and rc_la_id= @w_la_id
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)
--Autorizacion de Funcionalidades =====> Habilita SubComponentes - Fin */

print 'SE APLICO CON EXITO LA SEGURIDAD PARA: GRUPO NODO (ACTUALIZAR, HABILITAR, ELIMINAR)'
go


--====================================================
-- EQUIPOS
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10)

--ID del componente actual
select @w_co_id = co_id,@w_nemonic = co_prod_name
from an_component where co_name = 'ADM.RED.FEquipos'

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =519 and tc_oc_nemonic is null)
   delete from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =519 and tc_oc_nemonic is null
insert into an_transaction_component values (@w_co_id, 519, null)

if exists(select 1 from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =520 and tc_oc_nemonic is null)
   delete from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =520 and tc_oc_nemonic is null
insert into an_transaction_component values (@w_co_id, 520, null)

if exists(select 1 from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =521 and tc_oc_nemonic is null)
   delete from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =521 and tc_oc_nemonic is null
insert into an_transaction_component values (@w_co_id, 521, null)

if exists(select 1 from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =15010 and tc_oc_nemonic is null)
   delete from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =15010 and tc_oc_nemonic is null
insert into an_transaction_component values (@w_co_id, 15010, null)

if exists(select 1 from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =15011 and tc_oc_nemonic is null)
   delete from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =15011 and tc_oc_nemonic is null
insert into an_transaction_component values (@w_co_id, 15011, null)

print 'SE APLICO CON EXITO LA SEGURIDAD PARA: EQUIPOS'
go

--====================================================
-- CONFIGURACION NODO
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id  int,
	@w_nemonic varchar(10),
	@w_la_cod varchar(10)	

--ID del componente actual
select @w_co_id = co_id,@w_nemonic = co_prod_name
from an_component where co_name = 'ADM.RED.FConsConfigNodos'

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =15007 and tc_oc_nemonic is null)
   delete from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =15007 and tc_oc_nemonic is null
insert into an_transaction_component values (@w_co_id, 15007, null)

print 'SE APLICO CON EXITO LA SEGURIDAD PARA: CONFIGURACION NODO'
go


--====================================================
-- SISTEMAS OPERATIVOS
--====================================================
use cobis
go	

declare @w_co_id int,
   @w_sco_id int,
	@w_la_id int,
	@w_nemonic varchar(10),
	@w_la_cod varchar(10)	
	
--ID del componente actual
select @w_co_id = co_id, @w_nemonic = co_prod_name 
from an_component where co_name = 'ADM.RED.FSistOperativos'									

-- BASE COMPONENT 
if exists(select 1 from an_transaction_component where tc_co_id= @w_co_id and tc_tn_trn_code =1502 and tc_oc_nemonic is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =1502 and tc_oc_nemonic  is null				
insert into  an_transaction_component  values(@w_co_id,1502,null)									

if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =1503 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =1503 and tc_oc_nemonic  is null									
insert into  an_transaction_component  values(@w_co_id,1503,null)									

if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =554 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =554 and tc_oc_nemonic  is null									
insert into  an_transaction_component  values(@w_co_id,554,null)									

if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =552 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =552 and tc_oc_nemonic  is null									
insert into  an_transaction_component  values(@w_co_id,552,null)									

if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =553 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =553 and tc_oc_nemonic  is null									
insert into  an_transaction_component  values(@w_co_id,553,null)	

--caso 24696
if exists(select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =15052 and tc_oc_nemonic  is null)
   delete from  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code =15052 and tc_oc_nemonic  is null									
insert into  an_transaction_component  values(@w_co_id,15052,null)	


-- BASE COMPONENT
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15020 and tc_oc_nemonic  = 'M-ADM.RED' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15020 and tc_oc_nemonic  = 'M-ADM.RED'
insert into an_transaction_component values (0,15020,'M-ADM.RED')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1570 and tc_oc_nemonic  = 'M-ADM.RED' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1570 and tc_oc_nemonic  = 'M-ADM.RED'
insert into an_transaction_component values (0,1570,'M-ADM.RED')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1577 and tc_oc_nemonic  = 'M-ADM.RED' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1577 and tc_oc_nemonic  = 'M-ADM.RED'
insert into an_transaction_component values (0,1577,'M-ADM.RED')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15037 and tc_oc_nemonic  = 'M-ADM.RED' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15037 and tc_oc_nemonic  = 'M-ADM.RED'
insert into an_transaction_component values (0,15037,'M-ADM.RED')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15168 and tc_oc_nemonic  = 'M-ADM.RED' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15168 and tc_oc_nemonic  = 'M-ADM.RED'
insert into an_transaction_component values (0,15168,'M-ADM.RED')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15315 and tc_oc_nemonic  = 'M-ADM.RED' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15315 and tc_oc_nemonic  = 'M-ADM.RED'
insert into an_transaction_component values (0,15315,'M-ADM.RED')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15316 and tc_oc_nemonic  = 'M-ADM.RED' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15316 and tc_oc_nemonic  = 'M-ADM.RED'
insert into an_transaction_component values (0,15316,'M-ADM.RED')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15317 and tc_oc_nemonic  = 'M-ADM.RED' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15317 and tc_oc_nemonic  = 'M-ADM.RED'
insert into an_transaction_component values (0,15317,'M-ADM.RED')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15318 and tc_oc_nemonic  = 'M-ADM.RED' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15318 and tc_oc_nemonic  = 'M-ADM.RED'
insert into an_transaction_component values (0,15318,'M-ADM.RED')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15319 and tc_oc_nemonic  = 'M-ADM.RED' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15319 and tc_oc_nemonic  = 'M-ADM.RED'
insert into an_transaction_component values (0,15319,'M-ADM.RED')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15320 and tc_oc_nemonic  = 'M-ADM.RED' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15320 and tc_oc_nemonic  = 'M-ADM.RED'
insert into an_transaction_component values (0,15320,'M-ADM.RED')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15222 and tc_oc_nemonic  = 'M-ADM.RED' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15222 and tc_oc_nemonic  = 'M-ADM.RED'
insert into an_transaction_component values (0,15222,'M-ADM.RED')

print 'SE APLICO CON EXITO LA SEGURIDAD PARA: SISTEMAS OPERATIVOS'
go


