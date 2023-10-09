/* ******************************PERSONALIZACIÓN*******************************/
use cobis 
go
print 'Eliminacion de Catalogacion de seguridades para el menu de Cuentas(Personaliozacion)'
go

delete cobis..an_referenced_components from cobis..an_referenced_components,cobis..an_component where co_prod_name = 'M-PER' and co_id = rc_parent_co_id  
delete cobis..an_operation_component from cobis..an_operation_component,cobis..an_component where co_prod_name = 'M-PER' and co_id = oc_co_id                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
delete cobis..an_transaction_component from cobis..an_transaction_component,cobis..an_component where co_prod_name  = 'M-PER' and co_id = tc_co_id
delete cobis..an_transaction_component  where tc_oc_nemonic ='M-PER' and tc_co_id = 0
go

declare @w_codigo int 
select @w_codigo=codigo from cobis..cl_tabla where tabla='an_product'
if not exists( select 1 from  cobis..cl_catalogo  where tabla=@w_codigo and codigo ='M-PER')
begin
   insert into  cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'M-PER','CUENTAS PERSONALIZACION','V')  
end
go

/*Declaracion de variables*/
declare @w_co_id int,
        @w_la_id int,
        @w_la_cod varchar(6)
        
select @w_la_cod = 'ES_EC'

/* ************************COMPONENTES DEL PRONAME****************************/
/* ***************************************************************************/
/* ***************Búsqueda Productos Finales [FAyudaProdFinal]****************/
print 'Búsqueda Productos Finales [FAyudaProdFinal]'
insert into cobis..an_transaction_component values (0, 4077, 'M-PER')                                                                                                                                                                         
insert into cobis..an_transaction_component values (0, 4011, 'M-PER')                                                                                                                                                                         
insert into cobis..an_transaction_component values (0, 4085, 'M-PER')                                                                                                                                                                         
/* ***************Búsqueda Rubros de Servicios [FAyudaSubserv]****************/
print 'Búsqueda Rubros de Servicios'
insert into cobis..an_transaction_component values (0, 4039, 'M-PER')
/* ***************Búsqueda de Clientes y Prospectos [FBuscarCliente]**********/
print 'Búsqueda de Clientes y Prospectos'
insert into cobis..an_transaction_component values (0, 1318, 'M-PER')
insert into cobis..an_transaction_component values (0, 1182, 'M-PER')
insert into cobis..an_transaction_component values (0, 1241, 'M-PER')
/* ****************Busqueda de grupos economicos************************/
insert into cobis..an_transaction_component values (0, 150, 'M-PER')
/* **Búsquedas para Personalizacion de Costos de Servicios [FBuscarLabor] ***/
print 'Búsquedas para Personalizacion de Costos de Servicios'
insert into cobis..an_transaction_component values (0, 1253, 'M-PER')
insert into cobis..an_transaction_component values (0, 1254, 'M-PER')
insert into cobis..an_transaction_component values (0, 1255, 'M-PER')
insert into cobis..an_transaction_component values (0, 1184, 'M-PER')
insert into cobis..an_transaction_component values (0, 1190, 'M-PER')
/* *******Registros Seleccionados [FCatalogo] ************/
insert into cobis..an_transaction_component values (0, 35, 'M-PER')
/* *******Registros Seleccionados [FCatalogoServ] ************/
insert into cobis..an_transaction_component values (0, 4069, 'M-PER')
/* **********                                                   ****************************** */
insert into cobis..an_transaction_component values (0, 15301, 'M-PER')
insert into cobis..an_transaction_component values (0, 15302, 'M-PER')
insert into cobis..an_transaction_component values (0, 15315, 'M-PER')
insert into cobis..an_transaction_component values (0, 15316, 'M-PER')
insert into cobis..an_transaction_component values (0, 15317, 'M-PER')
insert into cobis..an_transaction_component values (0, 15318, 'M-PER')
insert into cobis..an_transaction_component values (0, 15319, 'M-PER')
insert into cobis..an_transaction_component values (0, 15320, 'M-PER')
insert into cobis..an_transaction_component values (0, 15168, 'M-PER')

insert into cobis..an_transaction_component values (0, 4106, 'M-PER')
insert into cobis..an_transaction_component values (0, 679 , 'M-PER')

/* *******Registros Seleccionados [FCatalogoServ] ************/
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'FCatalogoServ'
and co_prod_name = 'M-PER'

--insert into cobis..an_transaction_component values (@w_co_id, 4069, null)

/* *******Registros Seleccionados [FConsultaCta] ************/
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'FConsultaCta'
and co_prod_name = 'M-PER'

--insert into cobis..an_transaction_component values (@w_co_id, 4069, null)


/* ********************** Productos Bancarios  [FTrproban] **************************/
print 'Productos Bancarios'
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FTrproban'
and co_prod_name = 'M-PER'

if not exists (select 1 from cobis..an_label where la_label = 'Actualizar Producto bancario')
begin                                                                                                                                                                            
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                  
   insert into cobis..an_label values (@w_la_id, @w_la_cod, 'Actualizar Producto bancario', 'M-PER')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else 
begin
select @w_la_id = la_id from cobis..an_label where la_label = 'Actualizar Producto bancario'
end

insert into cobis..an_operation_component values (@w_co_id,'ACTUALIZAR',@w_la_id, 'Actualizar Producto bancario','BUTTON')
insert into cobis..an_transaction_component values (@w_co_id, 4001, 'ACTUALIZAR')--Actualizar


if not exists (select 1 from cobis..an_label where la_label = 'Crear Producto bancario')
begin                                                                                                                                                                            
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                  
   insert into cobis..an_label values (@w_la_id, @w_la_cod, 'Crear Producto bancario', 'M-PER')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else 
begin
select @w_la_id = la_id from cobis..an_label where la_label = 'Crear Producto bancario'
end
insert into cobis..an_operation_component values (@w_co_id,'CREAR',@w_la_id, 'Crear Producto bancario','BUTTON')
insert into cobis..an_transaction_component values (@w_co_id, 4000, 'CREAR')--Crear


insert into cobis..an_transaction_component values (@w_co_id, 4002, null)--Buscar
insert into cobis..an_transaction_component values (@w_co_id, 4158, null)--Subtipo
/*
FTrprobanClass		
 @t_trn	4000	Crear
 @t_trn	4002	Buscar
 @t_trn	4001	Actualizar
	    4158	Subtipos
*/

/* ********************** Mercado [FTrprobaen] *******************************/
print 'Mercado'

select @w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FTrprobaen'
and co_prod_name = 'M-PER'

--línea siguiente al insert del componente
if not exists (select 1 from cobis..an_label where la_label = 'Crear Mercado')
begin                                                                                                                                                                            
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                  
   insert into cobis..an_label values (@w_la_id, @w_la_cod, 'Crear Mercado', 'M-PER')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else
begin
 select @w_la_id = la_id from cobis..an_label where la_label = 'Crear Mercado'
end
insert into cobis..an_operation_component values (@w_co_id,'CREAR',@w_la_id, 'Crear Mercado','BUTTON')
insert into cobis..an_transaction_component values (@w_co_id, 4004, 'CREAR')

if not exists (select 1 from cobis..an_label where la_label = 'Actualizacíon de Mercado') begin                                                                                                                                                                            
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                  
   insert into cobis..an_label values (@w_la_id, @w_la_cod, 'Actualizacíon de Mercado', 'M-PER')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else
begin
select @w_la_id = la_id from cobis..an_label where la_label = 'Actualizacíon de Mercado'
end
insert into cobis..an_operation_component values (@w_co_id,'ACTUALIZAR',@w_la_id, 'Actualizacíon de Mercado','BUTTON')
insert into cobis..an_transaction_component values (@w_co_id, 4005, 'ACTUALIZAR')

insert into cobis..an_transaction_component values (@w_co_id, 4006, null)
insert into cobis..an_transaction_component values (@w_co_id, 4002, null)


/* ************Productos Finales [FProFin] *******************/
print 'Productos Finales'
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FProFin'
and co_prod_name = 'M-PER'

--línea siguiente al insert del componente
if not exists (select 1 from cobis..an_label where la_label = 'Actualizar Productos Finales') 
begin                                                                                                                                                                            
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                  
   insert into cobis..an_label values (@w_la_id, @w_la_cod, 'Actualizar Productos Finales', 'M-PER')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else
begin
 select @w_la_id = la_id from cobis..an_label where la_label = 'Actualizar Productos Finales'
end

insert into cobis..an_operation_component values (@w_co_id,'ACTUALIZAR',@w_la_id, 'Actualizar Productos Finales','BUTTON') --Boton actualizar
insert into cobis..an_transaction_component values (@w_co_id, 4009, 'ACTUALIZAR') --actualizar

insert into cobis..an_transaction_component values (@w_co_id, 4012, null)
insert into cobis..an_transaction_component values (@w_co_id, 4045, null)
insert into cobis..an_transaction_component values (@w_co_id, 4010, null)
insert into cobis..an_transaction_component values (@w_co_id, 4008, null)
--insert into cobis..an_transaction_component values (@w_co_id, 4011, null)

/*
FProFinClass		
 @t_trn	4008 *	Crear
 @t_trn	4010 *	Eliminar
 @t_trn	4009 *	Actualizar
 @t_trn	4011 *	
 @t_trn	4079	
 @t_trn	4075	
 @t_trn	4012 *	
 @t_trn	4078	
 @t_trn	4076	
 @t_trn	4045 *	
     	4122	Buscar

*/


/* ****** Categorías por Producto Final**********************/
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FCatProFinal'
and co_prod_name = 'M-PER'

if not exists (select 1 from cobis..an_label where la_label = 'Actualizar Categoria por producto final') 
begin                                                                                                                                                                            
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                  
   insert into cobis..an_label values (@w_la_id, @w_la_cod, 'Actualizar Categoria por producto final', 'M-PER')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else
begin
 select @w_la_id = la_id from cobis..an_label where la_label = 'Actualizar Categoria por producto final'
end

insert into cobis..an_operation_component values (@w_co_id,'ACTUALIZAR',@w_la_id, 'Actualizar Categoria por producto final','BUTTON')
insert into cobis..an_transaction_component values (@w_co_id, 4114, 'ACTUALIZAR')
--
if not exists (select 1 from cobis..an_label where la_label = 'Eliminar Categoria por producto final')
begin                                                                                                                                                                            
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                  
   insert into cobis..an_label values (@w_la_id, @w_la_cod, 'Eliminar Categoria por producto final', 'M-PER')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else
begin
 select @w_la_id = la_id from cobis..an_label where la_label = 'Eliminar Categoria por producto final'
end

insert into cobis..an_operation_component values (@w_co_id,'ELIMINAR',@w_la_id, 'Eliminar Categoria por producto final','BUTTON')
insert into cobis..an_transaction_component values (@w_co_id, 4115, 'ELIMINAR')

--Propias del componente
insert into cobis..an_transaction_component values (@w_co_id, 4101, null) --Buscar
insert into cobis..an_transaction_component values (@w_co_id, 4113, null) --Crear



/*
FCatProFinalClass		
 @t_trn	4101  *	Buscar
 @t_trn	4113  *	Crear
 @t_trn	4114  *	Actualizar
 @t_trn	4115  *	Eliminar
 @t_trn	4079	catalogo
 @t_trn	4011	catalogo
 @t_trn	4078	catalogo
 @t_trn	4077	catalogo
*/



/* *******Tipo de Capitalización por Producto Final [FCapProFinal] ************/
print 'Tipo de Capitalización por Producto Final'
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FCapProFinal'
and co_prod_name = 'M-PER'

--sección inicial del script – genérico aplicable a todos los componentes del ProdName
insert into cobis..an_transaction_component values (0, 4078, 'M-PER')
insert into cobis..an_transaction_component values (0, 4079, 'M-PER')

--Propios del componente
if not exists (select 1 from cobis..an_label where la_label = 'Crear tipo de capitalización por producto final')
begin                                                                                                                                                                            
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                  
   insert into cobis..an_label values (@w_la_id, @w_la_cod, 'Crear tipo de capitalización por producto final', 'M-PER')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else
begin
 select @w_la_id = la_id from cobis..an_label where la_label = 'Crear tipo de capitalización por producto final'
end

insert into cobis..an_operation_component values (@w_co_id,'CREAR',@w_la_id, 'Crear tipo de capitalización por producto final','BUTTON')
insert into cobis..an_transaction_component values (@w_co_id, 4094, 'CREAR')

--Componentes propios
insert into cobis..an_transaction_component values (@w_co_id, 4093, null) --Buscar
insert into cobis..an_transaction_component values (@w_co_id, 4095, null) --Actualizar
insert into cobis..an_transaction_component values (@w_co_id, 4096, null) --Eliminar

/*
FCapProFinalClass		
 @t_trn	4093  *	Buscar
 @t_trn	4094  *	Crear
 @t_trn	4096  *	Eliminar
 @t_trn	4095  *	Actualizar
 @t_trn	4079  *	catalogo
 @t_trn	4011	catalogo
 @t_trn	4078  *	catalogo
 @t_trn	4077	catalogo
*/



/* *******Ciclos por Producto Final [FCicProFinal] ************/
print 'Ciclos o Corte por Producto Final'
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FCicProFinal'
and co_prod_name = 'M-PER'

if not exists (select 1 from cobis..an_label where la_label = 'Crear Corte por Producto Final') begin                                                                                                                                                                            
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                  
   insert into cobis..an_label values (@w_la_id, @w_la_cod, 'Crear Corte por Producto Final', 'M-PER')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else
begin
 select @w_la_id = la_id from cobis..an_label where la_label = 'Crear Corte por Producto Final'
end
insert into cobis..an_operation_component values (@w_co_id,'CREAR',@w_la_id, 'Crear Corte por Producto Final','BUTTON')
insert into cobis..an_transaction_component values (@w_co_id, 4098, 'CREAR')

--Componentes propios
insert into cobis..an_transaction_component values (@w_co_id, 4011, null) --Buscar
insert into cobis..an_transaction_component values (@w_co_id, 4097, null) --Buscar
insert into cobis..an_transaction_component values (@w_co_id, 4099, null) --Actualizar
insert into cobis..an_transaction_component values (@w_co_id, 4100, null) --Eliminar

/*
FCicProFinalClass		
 @t_trn	4097  *	Buscar
 @t_trn	4098  *	Crear
 @t_trn	4100  *	Eliminar
 @t_trn	4099  *	Actualizar
 @t_trn	4079	catalogo proname
 @t_trn	4011  *	catalogo
 @t_trn	4078	catalogo proname
 @t_trn	4077	catalogo
*/


/*********************************************************************************/

/* *******Caracteristicas Especiales [FProCont] ************/
print 'Características Especiales'
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FProCont'
and co_prod_name = 'M-PER'



if not exists (select 1 from cobis..an_label where la_label = 'Características Especiales')
begin                                                                                                                                                                            
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                  
   insert into cobis..an_label values (@w_la_id, @w_la_cod, 'Crear Características Especiales', 'M-PER')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else
begin
 select @w_la_id = la_id from cobis..an_label where la_label = 'Crear Caracteristicas Especiales'
end
insert into cobis..an_operation_component values (@w_co_id,'CREAR',@w_la_id, 'Crear Características Especiales','BUTTON')
insert into cobis..an_transaction_component values (@w_co_id, 4125, 'CREAR')

--Componentes propios
insert into cobis..an_transaction_component values (@w_co_id, 4123, null) --Buscar
insert into cobis..an_transaction_component values (@w_co_id, 4097, null) --Buscar
insert into cobis..an_transaction_component values (@w_co_id, 4126, null) --Actualizar
insert into cobis..an_transaction_component values (@w_co_id, 4124, null) --Actualizar2



/*
FProContClass		
 @t_trn	4123  *	Buscar
 @t_trn	4125  *	Crear
 @t_trn	4126  *	Actualizar
 @t_trn	4124  *	Actualizar2
 @t_trn	4079	
 @t_trn	4011	
 @t_trn	4101	
 @t_trn	4078	
 @t_trn	4077	
*/
/*********************************************************************************/




/* ********************** Rango [FRango] ***********************/
print 'Rango'
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FRango'
and co_prod_name = 'M-PER'

insert into cobis..an_transaction_component values (@w_co_id, 4037, null)
insert into cobis..an_transaction_component values (@w_co_id, 4051, null)
insert into cobis..an_transaction_component values (@w_co_id, 4035, null)
insert into cobis..an_transaction_component values (@w_co_id, 4036, null)

/* ********************* Tipos de Rango [FTipRango] ******************************/
print 'Tipos de Rango'
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FTipRango'
and co_prod_name = 'M-PER'

--línea siguiente al insert del componente
if not exists (select 1 from cobis..an_label where la_label = 'Crear Tipo Rango') begin                                                                                                                                                                            
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                  
   insert into cobis..an_label values (@w_la_id, @w_la_cod, 'Crear Tipo Rango', 'M-PER')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else
begin
 select @w_la_id = la_id from cobis..an_label where la_label = 'Crear Tipo Rango'
end
insert into cobis..an_operation_component values (@w_co_id,'CREAR',@w_la_id, 'Crear Tipo Rango','BUTTON')
insert into cobis..an_transaction_component values (@w_co_id, 4032, 'CREAR')

if not exists (select 1 from cobis..an_label where la_label = 'Actualizar Tipo Rango') begin                                                                                                                                                                            
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                  
   insert into cobis..an_label values (@w_la_id, @w_la_cod, 'Actualizar Tipo Rango', 'M-PER')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else
begin
 select @w_la_id = la_id from cobis..an_label where la_label = 'Actualizar Tipo Rango'
end
insert into cobis..an_operation_component values (@w_co_id,'ACTUALIZAR',@w_la_id, 'Actualizar Tipo Rango','BUTTON')
insert into cobis..an_transaction_component values (@w_co_id, 4033, 'ACTUALIZAR')

insert into cobis..an_transaction_component values (@w_co_id, 4034, null)

/* *************************Servicios Disponibles*****************************/
print 'Servicios Disponibles'
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FCreaServ'
and co_prod_name = 'M-PER'

--Componentes Propias
insert into cobis..an_transaction_component values (@w_co_id, 4027, null)--Crear
insert into cobis..an_transaction_component values (@w_co_id, 4028, null)--Actualizar
insert into cobis..an_transaction_component values (@w_co_id, 4029, null)

/* ************************ Rubros del Servicio [FVarServ] *******************************/
print 'Rubros del Servicio'
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FVarServ'
and co_prod_name = 'M-PER'

--línea siguiente al insert del componente
if not exists (select 1 from cobis..an_label where la_label = 'Crear Rubros de Servicio') begin                                                                                                                                                                            
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                  
   insert into cobis..an_label values (@w_la_id, @w_la_cod, 'Crear Rubros de Servicio', 'M-PER')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else
begin
 select @w_la_id = la_id from cobis..an_label where la_label = 'Crear Rubros de Servicio'
end
insert into cobis..an_operation_component values (@w_co_id,'CREAR',@w_la_id, 'Crear Rubros de Servicio','BUTTON')
insert into cobis..an_transaction_component values (@w_co_id, 4025, 'CREAR')

if not exists (select 1 from cobis..an_label where la_label = 'Actualizacion Rubros de Servicio')
begin                                                                                                                                                                            
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                  
   insert into cobis..an_label values (@w_la_id, @w_la_cod, 'Actualizacion Rubros de Servicio', 'M-PER')                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else
begin
 select @w_la_id = la_id from cobis..an_label where la_label = 'Actualizacion Rubros de Servicio'
end
insert into cobis..an_operation_component values (@w_co_id,'ACTUALIZAR',@w_la_id, 'Actualizacion Rubros de Servicio','BUTTON')
insert into cobis..an_transaction_component values (@w_co_id, 4026, 'ACTUALIZAR')

insert into cobis..an_transaction_component values (@w_co_id, 4017, null)

/* ***************** Servicios Personalizables [FRubros] ***********************/
print 'Servicios Personalizables'
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FRubros'
and co_prod_name = 'M-PER'

insert into cobis..an_transaction_component values (@w_co_id, 4013, null)
insert into cobis..an_transaction_component values (@w_co_id, 4015, null)
insert into cobis..an_transaction_component values (@w_co_id, 4035, null) --Crear
insert into cobis..an_transaction_component values (@w_co_id, 4016, null) --Eliminar

/* *******Mantenimiento de costos de servicios [FMantenimiento] ************/
print 'Mantenimiento de costos de servicios'
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FMantenimiento'
and co_prod_name = 'M-PER'

if not exists (select 1 from cobis..an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 4049 and tc_oc_nemonic = 'M-PER') 
begin
   insert into cobis..an_transaction_component values (0, 4049,'M-PER')
end
insert into cobis..an_transaction_component values (@w_co_id, 4046, null)

/* *******Mantenimiento en línea de costos de servicios [FMantenLinea] ************/
print 'Mantenimiento en línea de costos de servicios'
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FMantenLinea'
and co_prod_name = 'M-PER'

insert into cobis..an_transaction_component values (@w_co_id, 4060, null)
insert into cobis..an_transaction_component values (@w_co_id, 4046, null)

/* *******Mantenimiento masivos de costos de servicios [FMantenLinea2] ************/
print 'Mantenimiento masivos de costos de servicios'
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FMantenLinea2'
and co_prod_name = 'M-PER'

insert into cobis..an_transaction_component values (@w_co_id, 4080, null)
insert into cobis..an_transaction_component values (@w_co_id, 4081, null)
insert into cobis..an_transaction_component values (@w_co_id, 4082, null)


/* **************Consulta de Costos Vigentes [FConCostos] *******************/
print 'Consulta de Costos Vigentes'
/*select w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FConCostos'
and co_prod_name = 'M-PER'

insert into cobis..an_transaction_component values (@w_co_id, 4052, null)

---
if not exists (select 1 from cobis..an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 4058 and tc_oc_nemonic = 'M-PER') 
   insert into cobis..an_transaction_component values (0, 4058, 'M-PER')

if not exists (select 1 from cobis..an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 4038 and tc_oc_nemonic = 'M-PER') 
   insert into cobis..an_transaction_component values (0, 4038, 'M-PER')

if not exists (select 1 from cobis..an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 4047 and tc_oc_nemonic = 'M-PER') 
   insert into cobis..an_transaction_component values (0, 4047, 'M-PER')

if not exists (select 1 from cobis..an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 4048 and tc_oc_nemonic = 'M-PER') 
   insert into cobis..an_transaction_component values (0, 4048, 'M-PER')*/
   
/* ********Consulta de Proximos Costos Vigentes [FConsVal] ************/
print 'Consulta de Proximos Costos Vigentes'
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FConVal'
and co_prod_name = 'M-PER'

if not exists (select 1 from cobis..an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 4059 and tc_oc_nemonic = 'M-PER') 
begin
   insert into cobis..an_transaction_component values (0, 4059,'M-PER')
end

insert into cobis..an_transaction_component values (@w_co_id, 4059, null)

/* ************Consulta de Costos en Linea [FConsulMas] ************/
print 'Consulta de Costos en Linea'
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FConsulMas'
and co_prod_name = 'M-PER'

insert into cobis..an_transaction_component values (@w_co_id, 4083, null)

--
if not exists (select 1 from cobis..an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 4003 and tc_oc_nemonic = 'M-PER')
begin 
   insert into cobis..an_transaction_component values (0, 4003, 'M-PER')
end
if not exists (select 1 from cobis..an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 4076 and tc_oc_nemonic = 'M-PER')
begin 
   insert into cobis..an_transaction_component values (0, 4076, 'M-PER')
end

/* **********Consulta de Proximos Costos [FConsulMas2] ************/
print 'Consulta de Proximos Costos'
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FConsulMas2'
and co_prod_name = 'M-PER'

insert into cobis..an_transaction_component values (@w_co_id, 4084, null)

--
if not exists (select 1 from cobis..an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 4002 and tc_oc_nemonic = 'M-PER')
begin 
   insert into cobis..an_transaction_component values (0, 4002,'M-PER')
end
if not exists (select 1 from cobis..an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 4075 and tc_oc_nemonic = 'M-PER') 
begin
   insert into cobis..an_transaction_component values (0, 4075,'M-PER')
 end 
 
/* *******Consulta histórica de costos y tasas [FconVarCosto] ************/
print 'Consulta histórica de costos y tasas'
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FconVarCosto'
and co_prod_name = 'M-PER'

insert into cobis..an_transaction_component values (@w_co_id, 4086, null)
insert into cobis..an_transaction_component values (@w_co_id, 4013, null)
  
/* *******Personalización de Cuentas [FPersoCuenta] ************/
print 'Personalización de Cuentas'
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FPersoCuenta'
and co_prod_name = 'M-PER'

--línea siguiente al insert del componente
insert into cobis..an_transaction_component values (@w_co_id, 4071, null)
insert into cobis..an_transaction_component values (@w_co_id, 4072, null)
--insert into cobis..an_transaction_component values (@w_co_id, 4085, null)
--insert into cobis..an_transaction_component values (@w_co_id, 1190, null)
insert into cobis..an_transaction_component values (@w_co_id, 1256, null)
insert into cobis..an_transaction_component values (@w_co_id, 1257, null)
--insert into cobis..an_transaction_component values (@w_co_id, 1184, null)

if not exists (select 1 from cobis..an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 4068 and tc_oc_nemonic = 'M-PER')
begin 
   insert into cobis..an_transaction_component values (0, 4068,'M-PER')
end
if not exists (select 1 from cobis..an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 4070 and tc_oc_nemonic = 'M-PER') 
begin
   insert into cobis..an_transaction_component values (0, 4070,'M-PER')
end
if not exists (select 1 from cobis..an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 4044 and tc_oc_nemonic = 'M-PER') 
begin
   insert into cobis..an_transaction_component values (0, 4044,'M-PER')
end
/* *********Consulta de Cuenta Personalizada [FConsultaPer] ************/
print 'Consulta de Cuenta Personalizada'
select @w_co_id  = co_id
from cobis..an_component
where co_name = 'PER.FConsultaPer'
and co_prod_name = 'M-PER'

if not exists (select 1 from cobis..an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 4073 and tc_oc_nemonic = 'M-PER') 
begin
   insert into cobis..an_transaction_component values (0, 4073,'M-PER')
end

if not exists (select 1 from cobis..an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 4074 and tc_oc_nemonic = 'M-PER') 
begin
   insert into cobis..an_transaction_component values (0, 4074,'M-PER')
end

if not exists (select 1 from cobis..an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 4031 and tc_oc_nemonic = 'M-PER') 
begin
   insert into cobis..an_transaction_component values (0, 4031,'M-PER')
 end 

/***********************************************************************/




/* *******C.O.B.I.S - PERSONALIZACION [FPrincipal] ************/
print 'C.O.B.I.S - PERSONALIZACION'
insert into cobis..an_transaction_component values (0, 1502,'M-PER')
/* ********** Registros Seleccionados [FRegistros] *************************/
insert into cobis..an_transaction_component values (0, 4046, 'M-PER')
insert into cobis..an_transaction_component values (0, 4023, 'M-PER')
insert into cobis..an_transaction_component values (0, 4012, 'M-PER')
insert into cobis..an_transaction_component values (0, 4067, 'M-PER')
go



declare @w_la_cod varchar(6)
if exists(select 1 from cobis..cl_parametro
           where pa_producto = 'ADM'
	     and pa_nemonico = 'CULTDF')
begin			 
    select @w_la_cod = replace (pa_char, '-','_')
      from cobis..cl_parametro
     where pa_producto = 'ADM'
       and pa_nemonico = 'CULTDF'
       
       -- DUPLICA ETIQUETAS PERSONALIZACION
  INSERT INTO cobis..an_label (la_id, la_cod, la_label, la_prod_name)
  	SELECT la_id, @w_la_cod, la_label, la_prod_name FROM cobis..an_label
     Where la_cod = 'ES_EC'
  	and la_id not in (select la_id from cobis..an_label where la_cod = @w_la_cod)
  	and la_prod_name = 'M-PER'   

end 
