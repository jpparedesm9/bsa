use cobis
go

declare @w_tabla int,
        @w_co_id int

select @w_tabla = codigo
from cobis..cl_tabla
where tabla = 'an_product'

---------------------------------- WORKFLOW MONITOR ---------------------------------------------------
--Eliminación de datos
print 'Iniciando Eliminación de datos existentes WORKFLOR MONITOR'
delete from cobis..cl_catalogo
where tabla  = @w_tabla
  and codigo = 'M-WKF'

select @w_co_id = co_id 
from cobis..an_page_zone, cobis..an_label, cobis..an_component
where pz_la_id = la_id 
  and pz_co_id = co_id
  and la_prod_name = 'M-WKF'
  and la_label like '%Estad%sticas'
  and la_cod = 'ES_EC'
  
--Transacciones de Tareas pendientes
delete from cobis..an_transaction_component
where tc_co_id = @w_co_id
  and tc_oc_nemonic = null
print 'Terminando Eliminación de datos existentes WORKFLOR MONITOR'

--Inserción de datos
print 'Iniciando Inserción de datos para el control de las Funcionalidades por Rol WORKFLOR MONITOR'
insert into cobis..cl_catalogo(tabla,codigo,valor,estado) values (@w_tabla,'M-WKF','WORKFLOR MONITOR','V')
   
--Componentes de las Tareas pendientes
select @w_co_id = co_id 
from cobis..an_page_zone, cobis..an_label, cobis..an_component
where pz_la_id = la_id 
  and pz_co_id = co_id
  and la_prod_name = 'M-WKF'
  and la_label like '%Estad%sticas'
  and la_cod = 'ES_EC'
		
--Transacciones de las Tareas pendientes
insert into cobis..an_transaction_component
select @w_co_id, tn_trn_code, null
  from cobis..cl_ttransaccion
  where tn_trn_code between 73800 and 73805
print 'Terminando Inserción de datos para el control de las Funcionalidades por Rol WORKFLOR MONITOR'

go
