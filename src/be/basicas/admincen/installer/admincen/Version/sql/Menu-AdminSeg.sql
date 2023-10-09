/************************************************************************/   
/*   Archivo:       Menu-AdminSeg.sql                                 */
/*   Base de datos:     cobis                                       */
/*   Producto:       ADMIN-Seg                                      */
/*   Disenado por:        Isaac Torres                                     */
/*   Fecha de documentacion:   04/Ago/2012                             */
/************************************************************************/
/*         IMPORTANTE                                        */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA", representantes exclusivos para el Ecuador de              */
/*   "NCR".                                                 */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la          */
/*   Presidencia Ejecutiva de MACOSA o su representante.               */
/*         PROPOSITO                                        */
/*      Este script permite crear las opciones de menu para la          */
/*      administracion de seguridades                                   */
/*   FECHA      AUTOR          RAZON                           */
/* 18\May\13   Nolberto V.      Se tomo este menú de Nucleo y se lo    */
/*                              modifico y adaptó a Capital Bank      */
/* 21-04-2016  BBO              Migracion Sybase-SQL FAL                */
/************************************************************************/



/*********************************************************************/
/*                ADMINISTRACION DE SEGURIDAD (ADMSEG)                */
/*********************************************************************/
/* ******************** << Admin - Seguridades >> ********************  */
print '/* ******************** << Admin - Seguridades >> ********************  */'
print''

--====================================================
-- PANTALA DE INGRESO - FFuncionariosClass 
--====================================================
print '/* ******************** << PANTALA DE INGRESO - FFuncionariosClass >> ********************  */'
use cobis
go

declare @w_codigo int 
select @w_codigo=codigo from cl_tabla where tabla='an_product'
if not exists( select 1 from  cl_catalogo  where tabla=@w_codigo and codigo ='M-ADM.Seg')
   insert into  cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'M-ADM.Seg','ADMINISTRADOR DE SEGURIDADES','V')  
go

declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'

select @w_co_id = co_id  from an_component where co_class = 'FFuncionariosClass' and co_prod_name = @w_prod_name

--<< Componentes Hijos >>--
--Roles de Funcinario  
  if not exists(select 1 from an_component where co_class = 'FRolesUsuarioClass' and co_prod_name = @w_prod_name)
  begin
    select @w_sco_id = isnull(max(co_id), 0) + 1 from   an_component      
    select @w_co_mo_id = mo_id from an_module where mo_filename = 'COBISCorp.tCOBIS.ADMSEG.Functional.dll'    
    insert into an_component values (@w_sco_id, @w_co_mo_id, 'ADMSEG.FRolesUsuario', 'FRolesUsuarioClass', 'COBISCorp.tCOBIS.ADMSEG.Functional.dll', 'SV', null, @w_prod_name)
  end
  else
    select @w_sco_id = co_id from an_component where co_class = 'FRolesUsuarioClass' and co_prod_name = @w_prod_name      
  
  delete  an_transaction_component where tc_co_id = 0 and tc_tn_trn_code in (15093,15043,15222) and tc_oc_nemonic = @w_prod_name
  insert into an_transaction_component values (0,15093,@w_prod_name)
  insert into an_transaction_component values (0,15043,@w_prod_name)
  insert into an_transaction_component values (0,15222,@w_prod_name)
    
  delete an_transaction_component where tc_co_id = @w_sco_id and tc_tn_trn_code in (15075,15076,572,571,570,1585,15065)
  insert into an_transaction_component values (@w_sco_id,15075,null)
  insert into an_transaction_component values (@w_sco_id,15076,null)
  insert into an_transaction_component values (@w_sco_id,572,null) 
  insert into an_transaction_component values (@w_sco_id,571,null) 
  insert into an_transaction_component values (@w_sco_id,570,null) 
  insert into an_transaction_component values (@w_sco_id,1585,null) 
  insert into an_transaction_component values (@w_sco_id,15065,null)
  
--Login Funcinario  
  if not exists(select 1 from an_component where co_class = 'FUsuarioLoginClass' and co_prod_name = @w_prod_name)
  begin
    select @w_sco_id = isnull(max(co_id), 0) + 1 from   an_component      
    select @w_co_mo_id = mo_id from an_module where mo_filename = 'COBISCorp.tCOBIS.ADMSEG.Functional.dll'    
    insert into an_component values (@w_sco_id, @w_co_mo_id, 'ADMSEG.FUsuarioLogin', 'FUsuarioLoginClass', 'COBISCorp.tCOBIS.ADMSEG.Functional.dll', 'SV', null, @w_prod_name)
  end
  else
    select @w_sco_id = co_id from an_component where co_class = 'FUsuarioLoginClass' and co_prod_name = @w_prod_name
  
  delete  an_transaction_component where tc_co_id = 0 and tc_tn_trn_code in (1571,1574,15015,15093) and tc_oc_nemonic = @w_prod_name
  insert into an_transaction_component values (0,1571,@w_prod_name)
  insert into an_transaction_component values (0,1574,@w_prod_name)
  insert into an_transaction_component values (0,15015,@w_prod_name)
  insert into an_transaction_component values (0,15093,@w_prod_name)
  
  delete an_transaction_component where tc_co_id = @w_sco_id and tc_tn_trn_code in (15078,15079,567,568,569)
  insert into an_transaction_component values (@w_sco_id,15078,null)
  insert into an_transaction_component values (@w_sco_id,15079,null)
  insert into an_transaction_component values (@w_sco_id,567,null)
  insert into an_transaction_component values (@w_sco_id,568,null)
  insert into an_transaction_component values (@w_sco_id,569,null)

--Medios Funcionarios
  if not exists(select 1 from an_component where co_class = 'FMediosFuncioClass' and co_prod_name = @w_prod_name)
  begin
    select @w_sco_id = isnull(max(co_id), 0) + 1 from   an_component      
    select @w_co_mo_id = mo_id from an_module where mo_filename = 'COBISCorp.tCOBIS.ADMSEG.Functional.dll'    
    insert into an_component values (@w_sco_id, @w_co_mo_id, 'ADMSEG.FMediosFuncio', 'FMediosFuncioClass', 'COBISCorp.tCOBIS.ADMSEG.Functional.dll', 'SV', null, @w_prod_name)
  end
  else
    select @w_sco_id = co_id from an_component where co_class = 'FMediosFuncioClass' and co_prod_name = @w_prod_name   
  
  delete an_transaction_component where tc_co_id = @w_sco_id and tc_tn_trn_code in (15182,15179,15178,15180)
  insert into an_transaction_component values (@w_sco_id,15182,null)
  insert into an_transaction_component values (@w_sco_id,15179,null)
  insert into an_transaction_component values (@w_sco_id,15178,null)
  insert into an_transaction_component values (@w_sco_id,15180,null)  
  
--<< Componente Padre FFuncionariosClass >>--
  select @w_co_id = co_id, @w_prod_name = co_prod_name from an_component where co_class = 'FFuncionariosClass' 
  
  delete  an_transaction_component where tc_co_id = 0 and tc_tn_trn_code in (1574,1593, 1597) and tc_oc_nemonic = @w_prod_name
  insert into an_transaction_component values (0,1574,@w_prod_name)
  insert into an_transaction_component values (0,1593,@w_prod_name)
  insert into an_transaction_component values (0,1597,@w_prod_name)
 
  delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (1577,598,15047)
  insert into an_transaction_component values (@w_co_id,1577,null)
  insert into an_transaction_component values (@w_co_id,598,null)
  insert into an_transaction_component values (@w_co_id,15047,null)  
  
   select @w_sco_id = co_id from an_component where co_class = 'FRolesUsuarioClass' and co_prod_name = @w_prod_name   
   if not exists (select 1 from an_label where la_label = 'Roles Funcionario') 
   begin
      select @w_la_id = isnull(max(la_id), 0) + 1 from   an_label                                                                                                                                                                                                  
      insert into an_label values (@w_la_id, @w_la_cod, 'Roles Funcionario', @w_prod_name )                                                                                                                                                                         
   end                                                                                                                                                                                                                                                                 
   else 
      select @w_la_id = la_id from an_label where la_label = 'Roles Funcionario'
   delete an_referenced_components where rc_parent_co_id = @w_co_id  and rc_child_co_id = @w_sco_id
   insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)
   
   
   select @w_sco_id = co_id from an_component where co_class = 'FUsuarioLoginClass' and co_prod_name = @w_prod_name   
   if not exists (select 1 from an_label where la_label = 'Login Funcionario') 
   begin
      select @w_la_id = isnull(max(la_id), 0) + 1 from   an_label                                                                                                                                                                                                  
      insert into an_label values (@w_la_id, @w_la_cod, 'Login Funcionario', @w_prod_name )                                                                                                                                                                         
   end
   else 
      select @w_la_id = la_id from an_label where la_label = 'Login Funcionario'
   delete an_referenced_components where rc_parent_co_id = @w_co_id  and rc_child_co_id = @w_sco_id
   insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)
   
   
   select @w_sco_id = co_id from an_component where co_class = 'FMediosFuncioClass' and co_prod_name = @w_prod_name   
   if not exists (select 1 from an_label where la_label = 'Medios Funcionario') 
   begin
      select @w_la_id = isnull(max(la_id), 0) + 1 from   an_label                                                                                                                                                                                                  
      insert into an_label values (@w_la_id, @w_la_cod, 'Medios Funcionario', @w_prod_name )                                                                                                                                                                         
   end                                                                                                                                                                                                                                                                 
   else 
      select @w_la_id = la_id from an_label where la_label = 'Medios Funcionario'
   delete an_referenced_components where rc_parent_co_id = @w_co_id  and rc_child_co_id = @w_sco_id
   insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)
go


/* ******************** <<  >> ********************  */
print''
--====================================================
-- PANTALA DE MODIFICACION - FGFuncionariosClass 
--====================================================
print '/* ******************** << PANTALA DE MODIFICACION - FGFuncionariosClass >> ********************  */'
use cobis
go

declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'   

select @w_co_id = co_id from an_component where co_class = 'FGFuncionariosClass' and co_prod_name = @w_prod_name
  
  delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (1510,1575,15001) 
  insert into an_transaction_component values (@w_co_id,15001,null)  
  insert into an_transaction_component values (@w_co_id,1510,null)  
  insert into an_transaction_component values (@w_co_id,1575,null)  
  

--Funcionario Superior --FFuncionarios         
if not exists(select 1 from an_component where co_class = 'FFuncionariosClass' and co_prod_name = @w_prod_name)
begin
    select @w_sco_id = isnull(max(co_id), 0) + 1 from   an_component      
    select @w_co_mo_id = mo_id from an_module where mo_filename = 'COBISCorp.tCOBIS.ADMSEG.Functional.dll'    
    insert into an_component values (@w_sco_id, @w_co_mo_id, 'ADMSEG.FFuncionarios', 'FFuncionariosClass', 'COBISCorp.tCOBIS.ADMSEG.Functional.dll', 'SV', null, @w_prod_name)
end
else
   select @w_sco_id = co_id from an_component where co_class = 'FFuncionariosClass' and co_prod_name = @w_prod_name      
   
if not exists (select 1 from an_label where la_label = 'Actualizar Funcionario' and la_prod_name = @w_prod_name) begin                                                                                                                                                                            
select @w_la_id = isnull(max(la_id), 0) + 1 from   an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, @w_la_cod, 'Actualizar Funcionario', @w_prod_name )                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else select @w_la_id = la_id from an_label where la_label = 'Actualizar Funcionario'      
delete an_referenced_components where rc_parent_co_id = @w_co_id  and rc_child_co_id = @w_sco_id
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)   

go


/* ******************** <<  >> ********************  */
print''
--====================================================
-- PANTALA DE ELIMINACION - FGFuncionariosClass 
--====================================================
print '/* ******************** << PANTALA DE ELIMINACION - FGFuncionariosClass >> ********************  */'
use cobis
go

declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'

select @w_co_id = co_id from an_component where co_class = 'FGFuncionariosClass' and co_prod_name = @w_prod_name
  
delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (1510,15001)
insert into an_transaction_component values (@w_co_id,15001,null)  
insert into an_transaction_component values (@w_co_id,1510,null)      
go



/* ******************** <<  >> ********************  */
print''
--====================================================
-- PANTALA DE MANTENIMIENTO OFICIALES - FTran2514Class
--====================================================
print '/* ******************** << PANTALA DE MANTENIMIENTO OFICIALES - FTran2514Class >> ********************  */'
use cobis
go

declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'

select @w_co_id = co_id from an_component where co_class = 'FTran2514Class' and co_prod_name = @w_prod_name
   
delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (1577,1579,15001,15150,15151,15153,15154,15155)   
insert into an_transaction_component values (@w_co_id,1577,null) 
insert into an_transaction_component values (@w_co_id,1579,null)
insert into an_transaction_component values (@w_co_id,15001,null)  
insert into an_transaction_component values (@w_co_id,15150,null)
insert into an_transaction_component values (@w_co_id,15151,null)
insert into an_transaction_component values (@w_co_id,15153,null)
insert into an_transaction_component values (@w_co_id,15154,null)
insert into an_transaction_component values (@w_co_id,15155,null)
   

if not exists(select 1 from an_component where co_class = 'FGFuncionariosClass' and co_prod_name = @w_prod_name)
begin
    select @w_sco_id = isnull(max(co_id), 0) + 1 from   an_component 
    select @w_co_mo_id = mo_id from an_module where mo_filename = 'COBISCorp.tCOBIS.ADMSEG.Functional.dll'    
    insert into an_component values (@w_sco_id, @w_co_mo_id, 'ADMSEG.grid_valores', 'FGFuncionariosClass', 'COBISCorp.tCOBIS.ADMSEG.Functional.dll', 'SV', null, @w_prod_name)
end
else
   select @w_sco_id = co_id from an_component where co_class = 'FGFuncionariosClass' and co_prod_name = @w_prod_name
      
if not exists (select 1 from an_label where la_label = 'Busqueda de Funcionario') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from   an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, @w_la_cod, 'Busqueda de Funcionario', @w_prod_name )                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else
   select @w_la_id = la_id from an_label where la_label = 'Busqueda de Funcionario'      
delete an_referenced_components where rc_parent_co_id = @w_co_id  and rc_child_co_id = @w_sco_id
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)
go


/* ******************** <<  >> ********************  */
print''
--====================================================
-- PANTALA DE OFICIAL SUSTITUTO - FTran2517Class
--====================================================
print '/* ******************** << PANTALA DE OFICIAL SUSTITUTO - FTran2517Class >> ********************  */'
use cobis
go

declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'

select @w_co_id = co_id from an_component where co_class = 'FTran2517Class' and co_prod_name = @w_prod_name

delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15153,15152,15156)   
insert into an_transaction_component values (@w_co_id,15153,null)
insert into an_transaction_component values (@w_co_id,15152,null)
insert into an_transaction_component values (@w_co_id,15156,null)
go



/* ******************** <<  >> ********************  */
print''
--====================================================
-- PANTALA DE LOGIN EN NODOS - FUsuarioLoginClass
--====================================================
print '/* ******************** << PANTALA DE OFICIAL SUSTITUTO - FUsuarioLoginClass >> ********************  */'
use cobis
go

declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'
      
select @w_co_id = co_id from an_component where co_class = 'FUsuarioLoginClass' and co_prod_name = @w_prod_name

delete  an_transaction_component where tc_co_id = 0 and tc_tn_trn_code in (1571,1574,15015,15093) and tc_oc_nemonic = @w_prod_name 
insert into an_transaction_component values (0,1571,@w_prod_name)
insert into an_transaction_component values (0,1574,@w_prod_name)
insert into an_transaction_component values (0,15015,@w_prod_name)
insert into an_transaction_component values (0,15093,@w_prod_name)

delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15078,15079,567,568,569)   
insert into an_transaction_component values (@w_co_id,15078,null)
insert into an_transaction_component values (@w_co_id,15079,null)
insert into an_transaction_component values (@w_co_id,567,null)
insert into an_transaction_component values (@w_co_id,568,null)
insert into an_transaction_component values (@w_co_id,569,null)
go


/* ******************** <<  >> ********************  */
print''
--=======================================================
-- PANTALA DE ROLES DE FUNCIONARIOS - FRolesUsuarioClass
--=======================================================
print '/* ******************** << PANTALA DE ROLES DE FUNCIONARIOS - FRolesUsuarioClass >> ********************  */'
use cobis
go

declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'
      
select @w_co_id = co_id from an_component where co_class = 'FRolesUsuarioClass' and co_prod_name = @w_prod_name

delete  an_transaction_component where tc_co_id = 0 and tc_tn_trn_code in (15093,15043) and tc_oc_nemonic = @w_prod_name 
insert into an_transaction_component values (0,15093,@w_prod_name)
insert into an_transaction_component values (0,15043,@w_prod_name)
    
delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15075,15076,572,571,570,1585,15065)    
insert into an_transaction_component values (@w_co_id,15075,null)
insert into an_transaction_component values (@w_co_id,15076,null)
insert into an_transaction_component values (@w_co_id,572,null) 
insert into an_transaction_component values (@w_co_id,571,null) 
insert into an_transaction_component values (@w_co_id,570,null) 
insert into an_transaction_component values (@w_co_id,1585,null) 
insert into an_transaction_component values (@w_co_id,15065,null)
go


/* ******************** <<  >> ********************  */
print''
--=======================================================
-- PANTALA DE OPERADORES DE BATCH - FOperadorClass
--=======================================================
print '/* ******************** << PANTALA DE OPERADORES DE BATCH - FOperadorClass >> ********************  */'
use cobis
go

declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'
      
select @w_co_id = co_id from an_component where co_class = 'FOperadorClass' and co_prod_name = @w_prod_name
  
delete  an_transaction_component where tc_co_id = 0 and tc_tn_trn_code in (15093) and tc_oc_nemonic = @w_prod_name   
insert into an_transaction_component values (0,15093,@w_prod_name)
    
delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15289,15290,15291,15292,15293)     
insert into an_transaction_component values (@w_co_id,15289,null)
insert into an_transaction_component values (@w_co_id,15290,null)
insert into an_transaction_component values (@w_co_id,15291,null)
insert into an_transaction_component values (@w_co_id,15292,null)
insert into an_transaction_component values (@w_co_id,15293,null)
go



/* ******************** <<  >> ********************  */
print''
--===================================================================
-- PANTALA DE ASIGNACION DE CARGO POR DEPARTAMENTO - FAsiCargosClass
--===================================================================
print '/* ******************** << PANTALA DE ASIGNACION DE CARGO POR DEPARTAMENTO - FAsiCargosClass >> ********************  */'
use cobis
go

declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'
      
select @w_co_id = co_id from an_component where co_class = 'FAsiCargosClass' and co_prod_name = @w_prod_name
  
delete  an_transaction_component where tc_co_id = 0 and tc_tn_trn_code in (1571,1574,1593) and tc_oc_nemonic = @w_prod_name 
insert into an_transaction_component values (0,1571,@w_prod_name)
insert into an_transaction_component values (0,1574,@w_prod_name)
insert into an_transaction_component values (0,1593,@w_prod_name)
    
delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (593,1564,1596)  
insert into an_transaction_component values (@w_co_id,593,null)
insert into an_transaction_component values (@w_co_id,1564,null)
insert into an_transaction_component values (@w_co_id,1596,null)
go



/* ******************** <<  >> ********************  */
print''
--=============================================================
-- PANTALA DE DESBLOQUEO DE USUARIOS - FDesbloqueoUsuarioClass
--=============================================================
print '/* ******************** << PANTALA DE DESBLOQUEO DE USUARIOS - FDesbloqueoUsuarioClass >> ********************  */'
use cobis
go

declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'

select @w_co_id = co_id from an_component where co_class = 'FDesbloqueoUsuarioClass' and co_prod_name = @w_prod_name
  
delete  an_transaction_component where tc_co_id = 0 and tc_tn_trn_code in (15093) and tc_oc_nemonic = @w_prod_name  
insert into an_transaction_component values (0,15093,@w_prod_name)    
    
delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15914)  
insert into an_transaction_component values (@w_co_id,15914,null)
go


/* ******************** <<  >> ********************  */
print''
--=============================================================
-- PANTALA DE COMPLEJIDAD DE PASSWORD - FComplejidadClass
--=============================================================
print '/* ******************** << PANTALA DE COMPLEJIDAD DE PASSWORD - FComplejidadClass >> ********************  */'
use cobis
go

declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'

select @w_co_id = co_id from an_component where co_class = 'FComplejidadClass' and co_prod_name = @w_prod_name
  
delete  an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (1579) and tc_oc_nemonic = @w_prod_name  
insert into an_transaction_component values (@w_co_id,1579,@w_prod_name)    
    
delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (576)  
insert into an_transaction_component values (@w_co_id,576,null)
go


/* ******************** <<  >> ********************  */
print''
--=============================================================
-- PANTALA DE INGRESAR ROLES - FRolesClass 
--=============================================================
print '/* ******************** << PANTALA DE INGRESAR ROLES - FRolesClass >> ********************  */'
use cobis
go

-- Pantalla Hija FProductosRolClass
declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'

 
select @w_co_id = co_id from an_component where co_class = 'FProductosRolClass' and co_prod_name = @w_prod_name

delete  an_transaction_component where tc_co_id = 0 and tc_tn_trn_code in (15043,15037) and tc_oc_nemonic = @w_prod_name 
insert into an_transaction_component values (0,15043,@w_prod_name)    
insert into an_transaction_component values (0,15037,@w_prod_name)
 
delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15047,15020,15069,15073,15022,566,525,564,15017,15036,527)   
insert into an_transaction_component values (@w_co_id,15047,null) 
insert into an_transaction_component values (@w_co_id,15020,null) 
insert into an_transaction_component values (@w_co_id,15069,null) 
insert into an_transaction_component values (@w_co_id,15073,null) 
insert into an_transaction_component values (@w_co_id,15022,null) 
insert into an_transaction_component values (@w_co_id,566,null) 
insert into an_transaction_component values (@w_co_id,525,null) 
insert into an_transaction_component values (@w_co_id,564,null) 
insert into an_transaction_component values (@w_co_id,15017,null) 
insert into an_transaction_component values (@w_co_id,15036,null) 
insert into an_transaction_component values (@w_co_id,527,null) 
go

--Pantalla Padre FRolesClass
declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'

select @w_co_id = co_id from an_component where co_class = 'FRolesClass' and co_prod_name = @w_prod_name 

delete  an_transaction_component where tc_co_id = 0 and tc_tn_trn_code in (1571,1593) and tc_oc_nemonic = @w_prod_name 
insert into an_transaction_component values (0,1571,@w_prod_name)    
insert into an_transaction_component values (0,1593,@w_prod_name)
 
delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (540)   
insert into an_transaction_component values (@w_co_id,540,null) 

select @w_sco_id = co_id from an_component where co_class = 'FProductosRolClass' and co_prod_name = @w_prod_name
if not exists (select 1 from an_label where la_label = 'Producto por Rol') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from   an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, @w_la_cod, 'Producto por Rol', @w_prod_name )                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else
   select @w_la_id = la_id from an_label where la_label = 'Producto por Rol'      
delete an_referenced_components where rc_parent_co_id = @w_co_id  and rc_child_co_id = @w_sco_id
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)
go



/* ******************** <<  >> ********************  */
print''
--=============================================================
-- PANTALA DE ACTUALIZAR ROLES - FGRolesClass 
--=============================================================
print '/* ******************** << PANTALA DE ACTUALIZAR ROLES - FGRolesClass >> ********************  */'
use cobis
go

-- Pantalla Hija Secundaria FProductosRolClass
declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'

 
select @w_co_id = co_id from an_component where co_class = 'FProductosRolClass' and co_prod_name = @w_prod_name

delete  an_transaction_component where tc_co_id = 0 and tc_tn_trn_code in (15043,15037) and tc_oc_nemonic = @w_prod_name 
insert into an_transaction_component values (0,15043,@w_prod_name)    
insert into an_transaction_component values (0,15037,@w_prod_name)
 
delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15047,15020,15069,15073,15022,566,525,564,15017,15036,527)   
insert into an_transaction_component values (@w_co_id,15047,null) 
insert into an_transaction_component values (@w_co_id,15020,null) 
insert into an_transaction_component values (@w_co_id,15069,null) 
insert into an_transaction_component values (@w_co_id,15073,null) 
insert into an_transaction_component values (@w_co_id,15022,null) 
insert into an_transaction_component values (@w_co_id,566,null) 
insert into an_transaction_component values (@w_co_id,525,null) 
insert into an_transaction_component values (@w_co_id,564,null) 
insert into an_transaction_component values (@w_co_id,15017,null) 
insert into an_transaction_component values (@w_co_id,15036,null) 
insert into an_transaction_component values (@w_co_id,527,null) 
go

--Pantalla Hija Principal FRolesClass
declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'

select @w_co_id = co_id from an_component where co_class = 'FRolesClass' and co_prod_name = @w_prod_name 

delete  an_transaction_component where tc_co_id = 0 and tc_tn_trn_code in (1571,1593) and tc_oc_nemonic = @w_prod_name 
insert into an_transaction_component values (0,1571,@w_prod_name)    
insert into an_transaction_component values (0,1593,@w_prod_name)
 
delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (541)   
insert into an_transaction_component values (@w_co_id,541,null) 

select @w_sco_id = co_id from an_component where co_class = 'FProductosRolClass' and co_prod_name = @w_prod_name
if not exists (select 1 from an_label where la_label = 'Producto por Rol') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from   an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, @w_la_cod, 'Producto por Rol', @w_prod_name )                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else
   select @w_la_id = la_id from an_label where la_label = 'Producto por Rol'      
delete an_referenced_components where rc_parent_co_id = @w_co_id  and rc_child_co_id = @w_sco_id
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)
go

--Pantalla Principal FGRolesClass
declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'

select @w_co_id = co_id from an_component where co_class = 'FGRolesClass' and co_prod_name = @w_prod_name 
 
delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15042, 15044)   
insert into an_transaction_component values (@w_co_id,15042,null) 
insert into an_transaction_component values (@w_co_id,15044,null)

select @w_sco_id = co_id from an_component where co_class = 'FRolesClass' and co_prod_name = @w_prod_name
if not exists (select 1 from an_label where la_label = 'Actualizar Datos Rol') 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from   an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, @w_la_cod, 'Actualizar Datos Rol', @w_prod_name )                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else
   select @w_la_id = la_id from an_label where la_label = 'Actualizar Datos Rol'      
delete an_referenced_components where rc_parent_co_id = @w_co_id  and rc_child_co_id = @w_sco_id
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)
go



/* ******************** <<  >> ********************  */
print''
--=============================================================
-- PANTALA DE ElIMINACION DE ROLES - FGRolesClass 
--=============================================================
print '/* ******************** << PANTALA DE ElIMINACION DE ROLES - FGRolesClass >> ********************  */'
use cobis
go

-- Pantalla Hija Secundaria FProductosRolClass
declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'
      
select @w_co_id = co_id from an_component where co_class = 'FGRolesClass' and co_prod_name = @w_prod_name 
 
delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (542, 15044)   
insert into an_transaction_component values (@w_co_id,542,null) 
insert into an_transaction_component values (@w_co_id,15044,null)      
go

      
      
/* ******************** <<  >> ********************  */
print''
--=============================================================
-- PANTALA DE  COPIAR ROLRES - FCopiarolesClass 
--=============================================================
print '/* ******************** << PANTALA DE  COPIAR ROLRES - FCopiarolesClass >> ********************  */'
use cobis
go

declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'
      
select @w_co_id = co_id from an_component where co_class = 'FCopiarolesClass' and co_prod_name = @w_prod_name 
 
delete  an_transaction_component where tc_co_id = 0 and tc_tn_trn_code in (15043) and tc_oc_nemonic = @w_prod_name 
insert into an_transaction_component values (0,15043,@w_prod_name)
 
delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15106)   
insert into an_transaction_component values (@w_co_id,15106,null)      
go


/* ******************** <<  >> ********************  */
print''
--====================================================
-- PANTALA DE Transacciones por Funcionalidad - FTransacxFuncionalidadClass
--====================================================
print '/* ******************** << PANTALA DE Transacciones por Funcionalidad - FTransacxFuncionalidadClass >> ********************  */'
use cobis
go

declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'
      
select @w_co_id = co_id from an_component where co_class = 'FTransacxFuncionalidadClass' and co_prod_name = @w_prod_name
   
delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15390)  
insert into an_transaction_component values (@w_co_id,15390,null)


print''
--====================================================
-- PANTALA DE Consulta de Conexiones - FConexClass
--====================================================
print '/* ******************** << PANTALA DE Consulta de Conexiones - FConexClass >> ********************  */'
select @w_co_id = co_id from an_component where co_class = 'FConexClass' and co_prod_name = @w_prod_name   
delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15404)  
insert into an_transaction_component values (@w_co_id,15404,null)


--====================================================
-- PANTALA DE Consulta de Conexiones Fallidas - FConexFallidaClass
--====================================================
print '/* ******************** << PANTALA DE Consulta de Conexiones Fallidas - FConexFallidaClass >> ********************  */'
select @w_co_id = co_id from an_component where co_class = 'FConexFallidaClass' and co_prod_name = @w_prod_name 
delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15417)  
insert into an_transaction_component values (@w_co_id,15417,null)
            
go

/* ******************** <<  >> ********************  */
print''
--=============================================================
-- PANTALA DE PRODUCTOS POR ROL  - FProductosRolClass
--=============================================================
print '/* ******************** << PANTALA DE PRODUCTOS POR ROL - FProductosRolClass >> ********************  */'
use cobis
go

declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'
      
select @w_co_id = co_id from an_component where co_class = 'FProductosRolClass' and co_prod_name = @w_prod_name

delete  an_transaction_component where tc_co_id = 0 and tc_tn_trn_code in (15043,15037) and tc_oc_nemonic = @w_prod_name 
insert into an_transaction_component values (0,15043,@w_prod_name)    
insert into an_transaction_component values (0,15037,@w_prod_name)
 
delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15047,15020,15069,15073,15022,566,525,564,15017,15036,527)   
insert into an_transaction_component values (@w_co_id,15047,null) 
insert into an_transaction_component values (@w_co_id,15020,null) 
insert into an_transaction_component values (@w_co_id,15069,null) 
insert into an_transaction_component values (@w_co_id,15073,null) 
insert into an_transaction_component values (@w_co_id,15022,null) 
insert into an_transaction_component values (@w_co_id,566,null) 
insert into an_transaction_component values (@w_co_id,525,null) 
insert into an_transaction_component values (@w_co_id,564,null) 
insert into an_transaction_component values (@w_co_id,15017,null) 
insert into an_transaction_component values (@w_co_id,15036,null) 
insert into an_transaction_component values (@w_co_id,527,null) 
go


      
/* ******************** <<  >> ********************  */
print''
--=============================================================
-- PANTALA DE COMPONENTES POR ROL - FProductosRolClass
--=============================================================
print '/* ******************** << PANTALA DE COMPONENTES POR ROL - FProductosRolClass >> ********************  */'
use cobis
go

declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'
      
select @w_co_id = co_id from an_component where co_class = 'FProductosRolClass' and co_prod_name = @w_prod_name

delete  an_transaction_component where tc_co_id = 0 and tc_tn_trn_code in (15043,15037) and tc_oc_nemonic = @w_prod_name 
insert into an_transaction_component values (0,15043,@w_prod_name)    
insert into an_transaction_component values (0,15037,@w_prod_name)
 
delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15047,15020,15069,15073,15022,566,525,564,15017,15036,527)   
insert into an_transaction_component values (@w_co_id,15047,null) 
insert into an_transaction_component values (@w_co_id,15020,null) 
insert into an_transaction_component values (@w_co_id,15069,null) 
insert into an_transaction_component values (@w_co_id,15073,null) 
insert into an_transaction_component values (@w_co_id,15022,null) 
insert into an_transaction_component values (@w_co_id,566,null) 
insert into an_transaction_component values (@w_co_id,525,null) 
insert into an_transaction_component values (@w_co_id,564,null) 
insert into an_transaction_component values (@w_co_id,15017,null) 
insert into an_transaction_component values (@w_co_id,15036,null) 
insert into an_transaction_component values (@w_co_id,527,null) 
go



/* ******************** <<  >> ********************  */
print''
--=============================================================
-- PANTALA DE MODULOS POR ROL - FProductosRolClass
--=============================================================
print '/* ******************** << PANTALA DE MODULOS POR ROL - FProductosRolClass >> ********************  */'
use cobis
go

declare @w_co_id        int,
          @w_prod_name  varchar(10),
        @w_co_mo_id   int,
        @w_la_id      int,
        @w_sco_id     int,
        @w_la_cod     varchar(10)
        

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Seg'
      
select @w_co_id = co_id from an_component where co_class = 'FProductosRolClass' and co_prod_name = @w_prod_name

delete  an_transaction_component where tc_co_id = 0 and tc_tn_trn_code in (15043,15037) and tc_oc_nemonic = @w_prod_name 
insert into an_transaction_component values (0,15043,@w_prod_name)    
insert into an_transaction_component values (0,15037,@w_prod_name)
 
delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15047,15020,15069,15073,15022,566,525,564,15017,15036,527)   
insert into an_transaction_component values (@w_co_id,15047,null) 
insert into an_transaction_component values (@w_co_id,15020,null) 
insert into an_transaction_component values (@w_co_id,15069,null) 
insert into an_transaction_component values (@w_co_id,15073,null) 
insert into an_transaction_component values (@w_co_id,15022,null) 
insert into an_transaction_component values (@w_co_id,566,null) 
insert into an_transaction_component values (@w_co_id,525,null) 
insert into an_transaction_component values (@w_co_id,564,null) 
insert into an_transaction_component values (@w_co_id,15017,null) 
insert into an_transaction_component values (@w_co_id,15036,null) 
insert into an_transaction_component values (@w_co_id,527,null) 
go

/* ******************** <<  >> ********************  */
print''
--=============================================================
-- PANTALA DE PARAMETRIZACION DE AMBITOS - FAmbitoClass
--=============================================================
print '/* ******************** << PANTALA DE PARAMETRIZACION DE AMBITOS - FAmbitoClass >> ********************  */'
use cobis
go
-----------------------------------------------------------------------------------------------
-- Eliminación de pagina a partir de pa_name
-----------------------------------------------------------------------------------------------
/*declare @w_pa_name varchar(255),
   @w_pa_id_label integer,
   @w_cod_label integer,
   @w_label varchar(100),
   @w_cod_page integer,
   @w_cod_component integer

select @w_pa_name = 'AS.ADMSEG.FAmbitoClass'
select @w_pa_id_label = pa_la_id from an_page where pa_name = @w_pa_name

--BORRA LABEL
print 'Borrando en an_label'
delete from an_label where la_id = @w_pa_id_label and la_prod_name = 'M-ADM.Seg'

--BORRA PAGE
select @w_cod_page = pa_id from an_page where pa_name = @w_pa_name

print 'Borrando en an_page'
delete from an_page where pa_id = @w_cod_page

print 'Borrando en an_page_rol'
delete from an_role_page where rp_pa_id = @w_cod_page

--BORRA PAGE_ZONE
select @w_cod_component = pz_co_id from an_page_zone  where pz_pa_id = @w_cod_page

print 'Borrando en an_page_zone'
delete from an_page_zone where pz_pa_id = @w_cod_page

--BORRA COMPONENT
print 'Borrando en an_component'
delete from an_component where co_id = @w_cod_component

print 'Borrando en an_role_component'
delete from an_role_component where rc_co_id = @w_cod_component

declare  @w_la_label varchar(255),
   @w_prod_name varchar(20),
   @w_rol_des varchar(255),
   @w_pa_parent varchar(255),
   @w_orden int,
   @w_mo_name varchar(255),
   @w_co_name varchar(255),
   @w_co_class varchar(255),
   @w_co_namespace varchar(255)

select  @w_la_label    = 'Control de ámbito',
   @w_prod_name    = 'M-ADM.Seg',
   @w_rol_des       = 'MENU POR PROCESOS',
   @w_pa_parent    = 'AS.Definición de Seguridades',
   @w_pa_name       = 'AS.ADMSEG.FAmbitoClass',
   @w_orden       = 5,
   @w_mo_name      = 'ADMSEG.Query',
   @w_co_name       = 'ADMSEG.FAmbitoClass',
   @w_co_class    = 'FAmbitoClass',
   @w_co_namespace = 'COBISCorp.tCOBIS.ADMSEG.Query'
   
print 'Registros de Opción de MENU: ' + @w_la_label
if not exists (select 1 from an_page where pa_name = @w_pa_name)
   begin
      declare @w_rol int, 
         @w_la_cod varchar(10), 
         @w_la_id int,
         @w_pa_id  int,
         @w_pa_id_parent int,
         @w_mg_id int,
         @w_mo_id int,
         @w_co_id int,
         @w_pz_id int,
         @wd_parent_module int

      --OBTENIENDO EL ROL
      select @w_rol = ro_rol from   ad_rol where  ro_descripcion = @w_rol_des
      select @w_la_cod = 'ES_EC'
      
      --OBTENIENDO EL MAXIMO SECUENCIAL DE LABEL
      select @w_la_id = isnull(max(la_id), 0) + 1 from   an_label
      
      --INSERTANDO EL LABEL
      print 'Insertando en an_label: '  + @w_la_label
      insert into an_label values (@w_la_id, @w_la_cod, @w_la_label, @w_prod_name)
      
      --SELECCIONANDO EL MAXIMO SECUENCIAL DE AN_PAGE
      select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   an_page
      select @w_pa_id_parent = pa_id from an_page where pa_name = @w_pa_parent
      
      --INSERTANDO EN LA AN_PAGE
      print 'Insertando en an_page'
      insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id)
         values (@w_pa_id, @w_la_id, @w_pa_name, 'icono pagina', @w_pa_id_parent, @w_orden, 'horizontal', 'Nemonic', @w_prod_name, '', null)
      
      --INSERTANDO EN LA AN_ROLE_PAGE
      print 'Insertando en an_role_page'
      insert into an_role_page values (@w_pa_id, @w_rol)
      
      --INSERTANDO EN LA AN_ZONE
      if not exists (select 1 from an_zone where zo_id = 1) 
         begin
            print 'Insertando en an_zone'
            insert into an_zone values (1, 'Zona 1', 1, 1, 1, 1)  
         end
         
      select @w_mo_id = mo_id from an_module where mo_name = @w_mo_name
      
      if not exists (select 1 from an_module_group where mg_name = 'ADMSEG.Query') 
         begin
            select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   an_module_group
            
            --INSERTANDO EN LA AN_MODULE_GROUP
            insert into an_module_group 
               values (@w_mg_id, 'ADMSEG.Query', '4.0.0.80', 'http://192.168.64.157:81/ADMSEG/ADMSEG.application', 'COBISExplorer')
               
         end 
      else 
         select @w_mg_id = mg_id from an_module_group where mg_name = 'ADMSEG.Query'
         
      if not exists (select 1 from an_module where mo_name = 'ADMSEG.Query') 
         begin
            select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   an_module
            
            --INSERTANDO EN LA AN_MODULE
            insert into an_module values (@w_mo_id, @w_mg_id, @w_la_id, 'ADMSEG.Query', 'COBISCorp.tCOBIS.ADMSEG.Query.dll', 0, null)
         end 
      else 
         select @w_mo_id = mo_id from an_module where mo_name = 'ADMSEG.Query'
      
      --INSERTANDO EN LA AN_ROLE_MODULE
      print 'Insertando en an_role_module'
      if not exists (select 1 from an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
         insert into an_role_module values (@w_mo_id, @w_rol)

      --OBTENIENDO EL MAXIMO SECUENCIAL DE AN_COMPONENT
      select @w_co_id  = isnull(max(co_id), 0) + 1 from   an_component

      --INSERTANDO EN LA AN_COMPONENT
      print 'Insertando en an_component'
      insert into an_component 
         values (@w_co_id, @w_mo_id, @w_co_name, @w_co_class, @w_co_namespace, 'SV', '', @w_prod_name)

      --INSERTANDO EN LA AN_ROLE_COMPONENT
      print 'Insertando en an_role_component'
      insert into an_role_component values (@w_co_id, @w_rol)

      --OBTENIENDO EL MAXIMO SECUENCIAL DE AN_PAGE_ZONE
      select @w_pz_id = isnull(max(pz_id), 0) + 1 from   an_page_zone
      
      if @w_pz_id is null 
         select @w_pz_id = 1

      --INSERTANDO EN LA AN_PAGE_ZONE
      if not exists (select 1 from an_page_zone 
                  where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) 
         begin
            print 'Insertando en an_page_zone'
            insert into an_page_zone 
               values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
         end
   end
go
*/
/* ******************** <<  >> ********************  */
print''
--=============================================================
-- PANTALA DE REPORTE DE AMBITOS - FConAmbitoClass
--=============================================================
print '/* ******************** << PANTALA DE REPORTE DE AMBITOS - FConAmbitoClass >> ********************  */'
use cobis
go
-----------------------------------------------------------------------------------------------
-- Eliminación de pagina a partir de pa_name
-----------------------------------------------------------------------------------------------
declare @w_pa_name varchar(255),
   @w_pa_id_label integer,
   @w_cod_label integer,
   @w_label varchar(100),
   @w_cod_page integer,
   @w_cod_component integer

select @w_pa_name = 'AS.ADMSEG.FConAmbitoClass'
select @w_pa_id_label = pa_la_id from an_page where pa_name = @w_pa_name

--BORRA LABEL
print 'Borrando en an_label'
delete from an_label where la_id = @w_pa_id_label and la_prod_name = 'M-ADM.Seg'

--BORRA PAGE
select @w_cod_page = pa_id from an_page where pa_name = @w_pa_name

print 'Borrando en an_page'
delete from an_page where pa_id = @w_cod_page

print 'Borrando en an_page_rol'
delete from an_role_page where rp_pa_id = @w_cod_page

--BORRA PAGE_ZONE
select @w_cod_component = pz_co_id from an_page_zone  where pz_pa_id = @w_cod_page

print 'Borrando en an_page_zone'
delete from an_page_zone where pz_pa_id = @w_cod_page

--BORRA COMPONENT
print 'Borrando en an_component'
delete from an_component where co_id = @w_cod_component

print 'Borrando en an_role_component'
delete from an_role_component where rc_co_id = @w_cod_component

declare  @w_la_label varchar(255),
   @w_prod_name varchar(20),
   @w_rol_des varchar(255),
   @w_pa_parent varchar(255),
   --@w_pa_name varchar(255),
   @w_orden int,
   @w_mo_name varchar(255),
   @w_co_name varchar(255),
   @w_co_class varchar(255),
   @w_co_namespace varchar(255)

select  @w_la_label    = 'Consulta de Rol por Usuario',
   @w_prod_name    = 'M-ADM.Seg',
   @w_rol_des       = 'MENU POR PROCESOS',
   @w_pa_parent    = 'AS.Consultas3',
   @w_pa_name       = 'AS.ADMSEG.FConAmbitoClass',
   @w_orden       = 5,
   @w_mo_name      = 'ADMSEG.Query',
   @w_co_name       = 'ADMSEG.FConAmbitoClass',
   @w_co_class    = 'FConAmbitoClass',
   @w_co_namespace = 'COBISCorp.tCOBIS.ADMSEG.Query'
   
print 'Registros de Opción de MENU: ' + @w_la_label
if not exists (select 1 from an_page where pa_name = @w_pa_name)
   begin
      declare @w_rol int, 
         @w_la_cod varchar(10), 
         @w_la_id int,
         @w_pa_id  int,
         @w_pa_id_parent int,
         @w_mg_id int,
         @w_mo_id int,
         @w_co_id int,
         @w_pz_id int,
         @wd_parent_module int

      --OBTENIENDO EL ROL
      select @w_rol = ro_rol from   ad_rol where  ro_descripcion = @w_rol_des
      select @w_la_cod = 'ES_EC'
      
      --OBTENIENDO EL MAXIMO SECUENCIAL DE LABEL
      select @w_la_id = isnull(max(la_id), 0) + 1 from   an_label
      
      --INSERTANDO EL LABEL
      print 'Insertando en an_label: ' + @w_la_label
      insert into an_label values (@w_la_id, @w_la_cod, @w_la_label, @w_prod_name)
      
      --SELECCIONANDO EL MAXIMO SECUENCIAL DE AN_PAGE
      select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   an_page
      select @w_pa_id_parent = pa_id from an_page where pa_name = @w_pa_parent
      
      --INSERTANDO EN LA AN_PAGE
      print 'Insertando en an_page'
      insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id)
         values (@w_pa_id, @w_la_id, @w_pa_name, 'icono pagina', @w_pa_id_parent, @w_orden, 'horizontal', 'Nemonic', @w_prod_name, '', null)
      
      --INSERTANDO EN LA AN_ROLE_PAGE
      print 'Insertando en an_role_page'
      insert into an_role_page values (@w_pa_id, @w_rol)
      
      --INSERTANDO EN LA AN_ZONE
      if not exists (select 1 from an_zone where zo_id = 1) 
         begin
            print 'Insertando en an_zone'
            insert into an_zone values (1, 'Zona 1', 1, 1, 1, 1)  
         end
         
      select @w_mo_id = mo_id from an_module where mo_name = @w_mo_name
      
      if not exists (select 1 from an_module_group where mg_name = 'ADMSEG.Query') 
         begin
            select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   an_module_group
            
            --INSERTANDO EN LA AN_MODULE_GROUP
            insert into an_module_group 
               values (@w_mg_id, 'ADMSEG.Query', '4.0.0.80', 'http://192.168.64.157:81/ADMSEG/ADMSEG.application', 'COBISExplorer')
               
         end 
      else 
         select @w_mg_id = mg_id from an_module_group where mg_name = 'ADMSEG.Query'
         
      if not exists (select 1 from an_module where mo_name = 'ADMSEG.Query') 
         begin
            select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   an_module
            
            --INSERTANDO EN LA AN_MODULE
            insert into an_module values (@w_mo_id, @w_mg_id, @w_la_id, 'ADMSEG.Query', 'COBISCorp.tCOBIS.ADMSEG.Query.dll', 0, null)
         end 
      else 
         select @w_mo_id = mo_id from an_module where mo_name = 'ADMSEG.Query'
      
      --INSERTANDO EN LA AN_ROLE_MODULE
      print 'Insertando en an_role_module'
      if not exists (select 1 from an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
         insert into an_role_module values (@w_mo_id, @w_rol)

      --OBTENIENDO EL MAXIMO SECUENCIAL DE AN_COMPONENT
      select @w_co_id  = isnull(max(co_id), 0) + 1 from   an_component

      --INSERTANDO EN LA AN_COMPONENT
      print 'Insertando en an_component'
      insert into an_component 
         values (@w_co_id, @w_mo_id, @w_co_name, @w_co_class, @w_co_namespace, 'SV', '', @w_prod_name)

      --INSERTANDO EN LA AN_ROLE_COMPONENT
      print 'Insertando en an_role_component'
      insert into an_role_component values (@w_co_id, @w_rol)

      --OBTENIENDO EL MAXIMO SECUENCIAL DE AN_PAGE_ZONE
      select @w_pz_id = isnull(max(pz_id), 0) + 1 from   an_page_zone
      
      if @w_pz_id is null 
         select @w_pz_id = 1

      --INSERTANDO EN LA AN_PAGE_ZONE
      if not exists (select 1 from an_page_zone 
                  where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) 
         begin
            print 'Insertando en an_page_zone'
            insert into an_page_zone 
               values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
         end
   end
go

--Pedro
use cobis
go



declare @w_componente int
declare @w_nemonico1 varchar(20)
declare @w_nemonico2 varchar(20)
declare @w_nemonico varchar(20)
declare @w_id_label int
declare @w_id int
declare @w_mo_id int
declare @w_comp_pop int
declare @w_contador int
--------------------------------------------------------------------------------------
-- Usuarios por Tran. Autorizada
--------------------------------------------------------------------------------------
--BASE PROD-NAME
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FContranClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15069 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15069, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FContranClass'
     end
end

--BASE COMPONENT
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FContranClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = @w_componente and tc_tn_trn_code = 15074 and tc_oc_nemonic is null

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (@w_componente, 15074, null)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FContranClass'
     end
end


go


--declare @w_componente int
--declare @w_nemonico1 varchar(20)
--declare @w_nemonico2 varchar(20)
--declare @w_nemonico varchar(20)
--declare @w_id_label int
--declare @w_id int
--declare @w_mo_id int
--declare @w_comp_pop int
--declare @w_contador int
--------------------------------------------------------------------------------------
-- Consulta de Transacciones de Servicio
--------------------------------------------------------------------------------------
--BASE PROD-NAME
--select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FTranServicioClass'
--select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15031 and tc_oc_nemonic = @w_nemonico

--if (@w_contador = 0)
--begin
--     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15031, @w_nemonico)
--     if (@@error != 0)
--     begin
--         print 'Ha ocurrido un error en la pantalla FTranServicioClass'
--     end
--end

--select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FTranServicioClass'
--select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15093 and tc_oc_nemonic = @w_nemonico

--if (@w_contador = 0)
--begin
--     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15093, @w_nemonico)
--     if (@@error != 0)
--     begin
--         print 'Ha ocurrido un error en la pantalla FTranServicioClass'
--     end
--end

--BASE COMPONENT
--select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FTranServicioClass'
--select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = @w_componente and tc_tn_trn_code = 15917 and tc_oc_nemonic is null

--if (@w_contador = 0)
--begin
--     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (@w_componente, 15917, null)
--     if (@@error != 0)
--     begin
--         print 'Ha ocurrido un error en la pantalla FTranServicioClass'
--     end
--end

--select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FTranServicioClass'
--select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = @w_componente and tc_tn_trn_code = 15916 and tc_oc_nemonic is null

--if (@w_contador = 0)
--begin
--     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (@w_componente, 15916, null)
--     if (@@error != 0)
--     begin
--         print 'Ha ocurrido un error en la pantalla FTranServicioClass'
--     end
--end

--select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FTranServicioClass'
--select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = @w_componente and tc_tn_trn_code = 1556 and tc_oc_nemonic is null

--if (@w_contador = 0)
--begin
--     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (@w_componente, 1556, null)
--     if (@@error != 0)
--     begin
--         print 'Ha ocurrido un error en la pantalla FTranServicioClass'
--     end
--end

--select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FTranServicioClass'
--select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = @w_componente and tc_tn_trn_code = 15915 and tc_oc_nemonic is null

--if (@w_contador = 0)
--begin
--     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (@w_componente, 15915, null)
--     if (@@error != 0)
--     begin
--         print 'Ha ocurrido un error en la pantalla FTranServicioClass'
--     end
--end


--go

 
declare @w_componente int
declare @w_nemonico1 varchar(20)
declare @w_nemonico2 varchar(20)
declare @w_nemonico varchar(20)
declare @w_id_label int
declare @w_id int
declare @w_mo_id int
declare @w_comp_pop int
declare @w_contador int
--------------------------------------------------------------------------------------
-- Horarios Existentes
--------------------------------------------------------------------------------------
--BASE PROD-NAME
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FConsHorarioClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15064 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15064, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FConsHorarioClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FConsHorarioClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1585 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 1585, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FConsHorarioClass'
     end
end


go


declare @w_componente int
declare @w_nemonico1 varchar(20)
declare @w_nemonico2 varchar(20)
declare @w_nemonico varchar(20)
declare @w_id_label int
declare @w_id int
declare @w_mo_id int
declare @w_comp_pop int
declare @w_contador int
--------------------------------------------------------------------------------------
-- Roles Existentes
--------------------------------------------------------------------------------------
--BASE COMPONENT
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FConsRolesClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = @w_componente and tc_tn_trn_code = 15041 and tc_oc_nemonic is null

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (@w_componente, 15041, null)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FConsRolesClass'
     end
end


go


declare @w_componente int
declare @w_nemonico1 varchar(20)
declare @w_nemonico2 varchar(20)
declare @w_nemonico varchar(20)
declare @w_id_label int
declare @w_id int
declare @w_mo_id int
declare @w_comp_pop int
declare @w_contador int
--------------------------------------------------------------------------------------
-- Usuario por Nodo
--------------------------------------------------------------------------------------
--BASE PROD-NAME
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FConsUsuNodosClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1571 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 1571, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FConsUsuNodosClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FConsUsuNodosClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1574 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 1574, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FConsUsuNodosClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FConsUsuNodosClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15015 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15015, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FConsUsuNodosClass'
     end
end

--BASE COMPONENT
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FConsUsuNodosClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = @w_componente and tc_tn_trn_code = 15094 and tc_oc_nemonic is null

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (@w_componente, 15094, null)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FConsUsuNodosClass'
     end
end


go


declare @w_componente int
declare @w_nemonico1 varchar(20)
declare @w_nemonico2 varchar(20)
declare @w_nemonico varchar(20)
declare @w_id_label int
declare @w_id int
declare @w_mo_id int
declare @w_comp_pop int
declare @w_contador int
--------------------------------------------------------------------------------------
-- Transacciones Autorizadas
--------------------------------------------------------------------------------------
--BASE PROD-NAME
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FConsTranAutClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15069 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15069, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FConsTranAutClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FConsTranAutClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15043 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15043, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FConsTranAutClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FConsTranAutClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15037 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15037, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FConsTranAutClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FConsTranAutClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15017 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15017, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FConsTranAutClass'
     end
end


go


declare @w_componente int
declare @w_nemonico1 varchar(20)
declare @w_nemonico2 varchar(20)
declare @w_nemonico varchar(20)
declare @w_id_label int
declare @w_id int
declare @w_mo_id int
declare @w_comp_pop int
declare @w_contador int
--------------------------------------------------------------------------------------
-- Productos por Rol
--------------------------------------------------------------------------------------
--BASE PROD-NAME
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FConsProductosRolClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15017 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15017, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FConsProductosRolClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FConsProductosRolClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15043 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15043, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FConsProductosRolClass'
     end
end


go


declare @w_componente int
declare @w_nemonico1 varchar(20)
declare @w_nemonico2 varchar(20)
declare @w_nemonico varchar(20)
declare @w_id_label int
declare @w_id int
declare @w_mo_id int
declare @w_comp_pop int
declare @w_contador int
--------------------------------------------------------------------------------------
-- Usuarios por Rol
--------------------------------------------------------------------------------------
--BASE PROD-NAME
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FConsUsuRolClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15075 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15075, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FConsUsuRolClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FConsUsuRolClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15043 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15043, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FConsUsuRolClass'
     end
end


go


declare @w_componente int
declare @w_nemonico1 varchar(20)
declare @w_nemonico2 varchar(20)
declare @w_nemonico varchar(20)
declare @w_id_label int
declare @w_id int
declare @w_mo_id int
declare @w_comp_pop int
declare @w_contador int
--------------------------------------------------------------------------------------
-- Horarios por Funcionario
--------------------------------------------------------------------------------------
--BASE PROD-NAME
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FConsHorUsuClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15075 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15075, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FConsHorUsuClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FConsHorUsuClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1585 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 1585, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FConsHorUsuClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FConsHorUsuClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15093 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15093, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FConsHorUsuClass'
     end
end


go


declare @w_componente int
declare @w_nemonico1 varchar(20)
declare @w_nemonico2 varchar(20)
declare @w_nemonico varchar(20)
declare @w_id_label int
declare @w_id int
declare @w_mo_id int
declare @w_comp_pop int
declare @w_contador int
--------------------------------------------------------------------------------------
-- Roles por Usuario
--------------------------------------------------------------------------------------
--BASE PROD-NAME
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FConsRolUsuClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15075 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15075, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FConsRolUsuClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FConsRolUsuClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15093 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15093, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FConsRolUsuClass'
     end
end


go


--declare @w_componente int
--declare @w_nemonico1 varchar(20)
--declare @w_nemonico2 varchar(20)
--declare @w_nemonico varchar(20)
--declare @w_id_label int
--declare @w_id int
--declare @w_mo_id int
--declare @w_comp_pop int
--declare @w_contador int
--------------------------------------------------------------------------------------
-- Calendario (BANCO CENTRAL)
--------------------------------------------------------------------------------------
--BASE COMPONENT
--select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FDIASNALBCOCENTRALClass'
--select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = @w_componente and tc_tn_trn_code = 15402 and tc_oc_nemonic is null

--if (@w_contador = 0)
--begin
--     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (@w_componente, 15402, null)
--     if (@@error != 0)
--     begin
--         print 'Ha ocurrido un error en la pantalla FDIASNALBCOCENTRALClass'
--     end
--end

--select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FDIASNALBCOCENTRALClass'
--select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = @w_componente and tc_tn_trn_code = 15400 and tc_oc_nemonic is null

--if (@w_contador = 0)
--begin
--     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (@w_componente, 15400, null)
--     if (@@error != 0)
--     begin
--         print 'Ha ocurrido un error en la pantalla FDIASNALBCOCENTRALClass'
--     end
--end

--select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FDIASNALBCOCENTRALClass'
--select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = @w_componente and tc_tn_trn_code = 15401 and tc_oc_nemonic is null

--if (@w_contador = 0)
--begin
--     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (@w_componente, 15401, null)
--     if (@@error != 0)
--     begin
--         print 'Ha ocurrido un error en la pantalla FDIASNALBCOCENTRALClass'
--     end
--end


--go


declare @w_componente int
declare @w_nemonico1 varchar(20)
declare @w_nemonico2 varchar(20)
declare @w_nemonico varchar(20)
declare @w_id_label int
declare @w_id int
declare @w_mo_id int
declare @w_comp_pop int
declare @w_contador int
--------------------------------------------------------------------------------------
-- Calendario (Feriados x Distrito)
--------------------------------------------------------------------------------------
--BASE PROD-NAME
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FCalendarioClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15000 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15000, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FCalendarioClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FCalendarioClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 594 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 594, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FCalendarioClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FCalendarioClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 595 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 595, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FCalendarioClass'
     end
end

--BASE COMPONENT
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FCalendarioClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = @w_componente and tc_tn_trn_code = 1562 and tc_oc_nemonic is null

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (@w_componente, 1562, null)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FCalendarioClass'
     end
end


go


declare @w_componente int
declare @w_nemonico1 varchar(20)
declare @w_nemonico2 varchar(20)
declare @w_nemonico varchar(20)
declare @w_id_label int
declare @w_id int
declare @w_mo_id int
declare @w_comp_pop int
declare @w_contador int
--------------------------------------------------------------------------------------
-- Calendario (Feriados Nacionales)
--------------------------------------------------------------------------------------
--BASE PROD-NAME
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FDiasNacionalesClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15000 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15000, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FDiasNacionalesClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FDiasNacionalesClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 594 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 594, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FDiasNacionalesClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FDiasNacionalesClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 595 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 595, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FDiasNacionalesClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FDiasNacionalesClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1579 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 1579, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FDiasNacionalesClass'
     end
end


go


declare @w_componente int
declare @w_nemonico1 varchar(20)
declare @w_nemonico2 varchar(20)
declare @w_nemonico varchar(20)
declare @w_id_label int
declare @w_id int
declare @w_mo_id int
declare @w_comp_pop int
declare @w_contador int
--------------------------------------------------------------------------------------
-- Ingresar
--------------------------------------------------------------------------------------
--BASE PROD-NAME
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FDefHorariosClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 578 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 578, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FDefHorariosClass'
     end
end

--BASE PROD-NAME
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FDefHorariosClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 579 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 579, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FDefHorariosClass'
     end
end

--BASE PROD-NAME
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FDefHorariosClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 509 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 509, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FDefHorariosClass'
     end
end

--BASE PROD-NAME
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FDefHorariosClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 507 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 507, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FDefHorariosClass'
     end
end

--BASE PROD-NAME
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FDefHorariosClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 508 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 508, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FDefHorariosClass'
     end
end
--BASE COMPONENT
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FDefHorariosClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = @w_componente and tc_tn_trn_code = 15095 and tc_oc_nemonic is null

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (@w_componente, 15095, null)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FDefHorariosClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FDefHorariosClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = @w_componente and tc_tn_trn_code = 15097 and tc_oc_nemonic is null

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (@w_componente, 15097, null)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FDefHorariosClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FDefHorariosClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = @w_componente and tc_tn_trn_code = 15096 and tc_oc_nemonic is null

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (@w_componente, 15096, null)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FDefHorariosClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FDefHorariosClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = @w_componente and tc_tn_trn_code = 15097 and tc_oc_nemonic is null

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (@w_componente, 15097, null)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FDefHorariosClass'
     end
end


go


declare @w_componente int
declare @w_nemonico1 varchar(20)
declare @w_nemonico2 varchar(20)
declare @w_nemonico varchar(20)
declare @w_id_label int
declare @w_id int
declare @w_mo_id int
declare @w_comp_pop int
declare @w_contador int
--------------------------------------------------------------------------------------
-- Actualizar
--------------------------------------------------------------------------------------
--BASE PROD-NAME
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FGTiposHorarioClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15064 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15064, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FGTiposHorarioClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FGTiposHorarioClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15064 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15064, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FGTiposHorarioClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FGTiposHorarioClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15064 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15064, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FGTiposHorarioClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FGTiposHorarioClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 580 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 580, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FGTiposHorarioClass'
     end
end

----------------insertar Tablas Referenciadas
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FGTiposHorarioClass'

select @w_comp_pop = co_id from an_component where co_class = 'FDefHorariosClass'
----------------insertar Label
select  @w_contador = isnull(count(*), 0) from an_label where la_cod = 'ES_EC' and la_label = 'Actualizar Horario' and la_prod_name = 'M-ADM.Seg'

if (@w_contador = 0)
begin
     select @w_id= isnull(max(la_id ), 0) + 1 from an_label
     insert into an_label (la_id , la_cod, la_label, la_prod_name) values (@w_id, 'ES_EC', 'Actualizar Horario', 'M-ADM.Seg')
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en el label Actualizar Horario'
     end
end

select @w_id_label = la_id from an_label where la_label = 'Actualizar Horario'
select @w_contador = isnull(count(*), 0) from an_referenced_components where rc_parent_co_id = @w_componente and rc_child_co_id = @w_comp_pop and rc_la_id = @w_id_label

if (@w_contador = 0)
begin
     insert into an_referenced_components (rc_parent_co_id, rc_child_co_id, rc_la_id) values (@w_componente, @w_comp_pop, @w_id_label)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en el pantalla FGTiposHorarioClass'
     end
end


go


declare @w_componente int
declare @w_nemonico1 varchar(20)
declare @w_nemonico2 varchar(20)
declare @w_nemonico varchar(20)
declare @w_id_label int
declare @w_id int
declare @w_mo_id int
declare @w_comp_pop int
declare @w_contador int
--------------------------------------------------------------------------------------
-- Eliminar
--------------------------------------------------------------------------------------
--BASE PROD-NAME
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FGTiposHorarioClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15064 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15064, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FGTiposHorarioClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FGTiposHorarioClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15064 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15064, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FGTiposHorarioClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FGTiposHorarioClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15064 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15064, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FGTiposHorarioClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FGTiposHorarioClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 580 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 580, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FGTiposHorarioClass'
     end
end

----------------insertar Tablas Referenciadas
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FGTiposHorarioClass'

select @w_comp_pop = co_id from an_component where co_class = 'FDefHorariosClass'
----------------insertar Label
select  @w_contador = isnull(count(*), 0) from an_label where la_cod = 'ES_EC' and la_label = 'Actualizar Horario' and la_prod_name = 'M-ADM.Seg'

if (@w_contador = 0)
begin
     select @w_id= isnull(max(la_id ), 0) + 1 from an_label
     insert into an_label (la_id , la_cod, la_label, la_prod_name) values (@w_id, 'ES_EC', 'Actualizar Horario', 'M-ADM.Seg')
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en el label Actualizar Horario'
     end
end

select @w_id_label = la_id from an_label where la_label = 'Actualizar Horario'
select @w_contador = isnull(count(*), 0) from an_referenced_components where rc_parent_co_id = @w_componente and rc_child_co_id = @w_comp_pop and rc_la_id = @w_id_label

if (@w_contador = 0)
begin
     insert into an_referenced_components (rc_parent_co_id, rc_child_co_id, rc_la_id) values (@w_componente, @w_comp_pop, @w_id_label)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en el pantalla FGTiposHorarioClass'
     end
end


go


declare @w_componente int
declare @w_nemonico1 varchar(20)
declare @w_nemonico2 varchar(20)
declare @w_nemonico varchar(20)
declare @w_id_label int
declare @w_id int
declare @w_mo_id int
declare @w_comp_pop int
declare @w_contador int
--------------------------------------------------------------------------------------
-- Paginas por Rol
--------------------------------------------------------------------------------------
--BASE PROD-NAME
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FProductosRolClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15017 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15017, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FProductosRolClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FProductosRolClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 527 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 527, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FProductosRolClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FProductosRolClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 525 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 525, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FProductosRolClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FProductosRolClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15043 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15043, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FProductosRolClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FProductosRolClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15037 and tc_oc_nemonic = @w_nemonico

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (0, 15037, @w_nemonico)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FProductosRolClass'
     end
end

--BASE COMPONENT
select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FProductosRolClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = @w_componente and tc_tn_trn_code = 15036 and tc_oc_nemonic is null

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (@w_componente, 15036, null)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FProductosRolClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FProductosRolClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = @w_componente and tc_tn_trn_code = 15073 and tc_oc_nemonic is null

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (@w_componente, 15073, null)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FProductosRolClass'
     end
end

select @w_componente = co_id, @w_nemonico = co_prod_name from an_component where co_class = 'FProductosRolClass'
select @w_contador = isnull(count(*), 0) from an_transaction_component where tc_co_id = @w_componente and tc_tn_trn_code = 15022 and tc_oc_nemonic is null

if (@w_contador = 0)
begin
     insert into an_transaction_component (tc_co_id, tc_tn_trn_code, tc_oc_nemonic) values (@w_componente, 15022, null)
     if (@@error != 0)
     begin
         print 'Ha ocurrido un error en la pantalla FProductosRolClass'
     end
end

go


-- BASE COMPONENT
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15020 and tc_oc_nemonic  = 'M-ADM.Seg' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15020 and tc_oc_nemonic  = 'M-ADM.Seg'
insert into an_transaction_component values (0,15020,'M-ADM.Seg')


if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1570 and tc_oc_nemonic  = 'M-ADM.Seg' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1570 and tc_oc_nemonic  = 'M-ADM.Seg'
insert into an_transaction_component values (0,1570,'M-ADM.Seg')


if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1577 and tc_oc_nemonic  = 'M-ADM.Seg' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1577 and tc_oc_nemonic  = 'M-ADM.Seg'
insert into an_transaction_component values (0,1577,'M-ADM.Seg')


if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15037 and tc_oc_nemonic  = 'M-ADM.Seg' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15037 and tc_oc_nemonic  = 'M-ADM.Seg'
insert into an_transaction_component values (0,15037,'M-ADM.Seg')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15168 and tc_oc_nemonic  = 'M-ADM.Seg' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15168 and tc_oc_nemonic  = 'M-ADM.Seg'
insert into an_transaction_component values (0,15168,'M-ADM.Seg')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15315 and tc_oc_nemonic  = 'M-ADM.Seg' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15315 and tc_oc_nemonic  = 'M-ADM.Seg'
insert into an_transaction_component values (0,15315,'M-ADM.Seg')


if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15316 and tc_oc_nemonic  = 'M-ADM.Seg' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15316 and tc_oc_nemonic  = 'M-ADM.Seg'
insert into an_transaction_component values (0,15316,'M-ADM.Seg')


if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15317 and tc_oc_nemonic  = 'M-ADM.Seg')
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15317 and tc_oc_nemonic  = 'M-ADM.Seg'
insert into an_transaction_component values (0,15317,'M-ADM.Seg')


if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15318 and tc_oc_nemonic  = 'M-ADM.Seg' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15318 and tc_oc_nemonic  = 'M-ADM.Seg'
insert into an_transaction_component values (0,15318,'M-ADM.Seg')


if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15319 and tc_oc_nemonic  = 'M-ADM.Seg')
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15319 and tc_oc_nemonic  = 'M-ADM.Seg'
insert into an_transaction_component values (0,15319,'M-ADM.Seg')


if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15320 and tc_oc_nemonic  = 'M-ADM.Seg' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15320 and tc_oc_nemonic  = 'M-ADM.Seg'
insert into an_transaction_component values (0,15320,'M-ADM.Seg')
go

----------------
--Servicios MC para Admin
print '/* ******************** << Autorización Servicios MC para Admin >> ********************  */'
declare @w_co_id int

delete FROM an_service_component where sc_co_id in (select co_id from an_component 	where co_class in (	'FGFuncionariosClass',
																												'FRolesUsuarioClass',
																												'FFuncionariosClass',
																												'FTran2514Class',
																												'FRolesClass')
																							and co_prod_name = 'M-ADM.Seg')

--FGFuncionariosClass
select @w_co_id = co_id from an_component where co_class = 'FGFuncionariosClass' and co_prod_name = 'M-ADM.Seg'

insert into an_service_component values (@w_co_id, 'HTM.API.HumanTask.CreateProcessInstance',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiStartEnQueue ',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiApproveMCTransaction',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiDenyMCTransaction',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiFinishEnQueue',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiGetViews',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiHasMCAuthorization',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiSaveAuthorizationInfo',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiValidateAndPersistMCTransaction',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ClearMCTransaction',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.DeleteLockedTxByBusinessTransactionId',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.getSerializationConfigurations',null)

--FRolesUsuarioClass
select @w_co_id = co_id from an_component where co_class = 'FRolesUsuarioClass' and co_prod_name = 'M-ADM.Seg'

insert into an_service_component values (@w_co_id, 'HTM.API.HumanTask.CreateProcessInstance',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiStartEnQueue ',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiApproveMCTransaction',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiDenyMCTransaction',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiFinishEnQueue',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiGetViews',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiHasMCAuthorization',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiSaveAuthorizationInfo',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiValidateAndPersistMCTransaction',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ClearMCTransaction',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.DeleteLockedTxByBusinessTransactionId',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.getSerializationConfigurations',null)

--FFuncionariosClass
select @w_co_id = co_id from an_component where co_class = 'FFuncionariosClass' and co_prod_name = 'M-ADM.Seg'

insert into an_service_component values (@w_co_id, 'HTM.API.HumanTask.CreateProcessInstance',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiStartEnQueue ',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiApproveMCTransaction',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiDenyMCTransaction',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiFinishEnQueue',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiGetViews',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiHasMCAuthorization',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiSaveAuthorizationInfo',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiValidateAndPersistMCTransaction',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ClearMCTransaction',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.DeleteLockedTxByBusinessTransactionId',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.getSerializationConfigurations',null)
insert into an_service_component values (@w_co_id, 'ldapService',null)

--FTran2514Class
select @w_co_id = co_id from an_component where co_class = 'FTran2514Class' and co_prod_name = 'M-ADM.Seg'

insert into an_service_component values (@w_co_id, 'HTM.API.HumanTask.CreateProcessInstance',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiStartEnQueue ',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiApproveMCTransaction',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiDenyMCTransaction',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiFinishEnQueue',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiGetViews',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiHasMCAuthorization',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiSaveAuthorizationInfo',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiValidateAndPersistMCTransaction',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ClearMCTransaction',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.DeleteLockedTxByBusinessTransactionId',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.getSerializationConfigurations',null)


--FRolesClass
select @w_co_id = co_id from an_component where co_class = 'FRolesClass' and co_prod_name = 'M-ADM.Seg'

insert into an_service_component values (@w_co_id, 'HTM.API.HumanTask.CreateProcessInstance',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiStartEnQueue ',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiApproveMCTransaction',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiDenyMCTransaction',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiFinishEnQueue',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiGetViews',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiHasMCAuthorization',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiSaveAuthorizationInfo',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiValidateAndPersistMCTransaction',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ClearMCTransaction',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.DeleteLockedTxByBusinessTransactionId',null)
insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.getSerializationConfigurations',null)
go
