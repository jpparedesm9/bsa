use cobis
go

DECLARE @w_co_id INT, 
        @w_prod_name varchar(10), 
        @w_mo_id int

select @w_prod_name = 'WF' 
select @w_mo_id = mo_id  
from   cobis..an_module 
where  mo_name = 'ADM.Ref.Office'
 
select @w_co_id = max(co_id) + 1 FROM cobis..an_component 

select @w_co_id =  isnull(@w_co_id, 1)
select @w_mo_id = isnull(@w_mo_id, 1)

select 'antes', * from an_component WHERE co_name like '%Tabla de Amortizaci%'

delete FROM an_component WHERE co_class = 'VC_TPYEP21_FAETL_814_TASK.html'

select 'desp', * from an_component WHERE co_name like '%Tabla de Amortizaci%'

go

---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>
---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>

use cobis
go

declare @w_tabla smallint

print 'Ya existe la tabla eli_reg_dia_pago'
select @w_tabla = codigo from cobis..cl_tabla where tabla = 'eli_reg_dia_pago'

select * from cobis..cl_tabla where tabla = 'eli_reg_dia_pago'	
select * from cl_catalogo where tabla = @w_tabla
select * from cl_catalogo_pro where cp_tabla = @w_tabla

delete cl_catalogo_pro where cp_tabla = @w_tabla
delete cl_catalogo where tabla = @w_tabla
delete cl_tabla where tabla = 'eli_reg_dia_pago'	

go

---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>
---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>
use cobis
go

DECLARE @w_co_id INT, 
        @w_prod_name varchar(10), 
        @w_mo_id int

select @w_prod_name = 'WF' 
select @w_mo_id = mo_id  
from   cobis..an_module 
where  mo_name = 'ADM.Ref.Office'
 
select @w_co_id = max(co_id) + 1 FROM cobis..an_component 

select @w_co_id =  isnull(@w_co_id, 1)
select @w_mo_id = isnull(@w_mo_id, 1)

select 'todo_ANTES', * from an_component where co_name like '%abla de Amortizaci%'

update an_component set co_name = 'Tabla de Amortización - Grupal Consulta'
WHERE co_class = 'VC_TPYEP21_FAETL_814_TASK.html?ETAPA=PLANPAGO&SOLICITUD=GRUPAL'

delete an_component WHERE co_class = 'VC_TPYEP21_FAETL_814_TASK.html?ETAPA=PLANPAGO&SOLICITUD=GRUPAL&MODE=Q'

select 'todo_desp', * from an_component where co_name like '%abla de Amortizaci%'
go
