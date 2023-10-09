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

IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_class = 'VC_TPYEP21_FAETL_814_TASK.html')
begin
    print 'Insertar nuevo componente'
	insert into an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
    values (@w_co_id, @w_mo_id, 'Tabla de Amortización - Individual', 'VC_TPYEP21_FAETL_814_TASK.html', 'views/BUSIN/FLCRE/T_FLCRE_12_TPYEP21/1.0.0/', 'I', NULL, @w_prod_name)
end else
    print 'ya existe el an_component'

select 'desp', * from an_component WHERE co_name like '%Tabla de Amortizaci%'

go

---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>
---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>
use cobis
go

declare @w_tabla smallint

if not exists (select 1 from cobis..cl_tabla where tabla = 'eli_reg_dia_pago') begin
    print 'Va a insertar tabla eli_reg_dia_pago'
    select @w_tabla = max(codigo)+ 1 from cl_tabla
    
    insert into cobis..cl_tabla (codigo, tabla,descripcion) values (@w_tabla, 'eli_reg_dia_pago', 'Pantallas donde se elimina registro día de Pago' )
    
    insert into cl_catalogo_pro (cp_producto, cp_tabla)
    values ('ADM', @w_tabla)
    
    insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) 
    values (@w_tabla, 'PANING', 'INGRESAR SOLICITUD', 'V', NULL, NULL, NULL)

    select @w_tabla = codigo from cobis..cl_tabla where tabla = 'eli_reg_dia_pago'
    select 'ingreso', * from cl_catalogo where tabla = @w_tabla
    select * from cl_catalogo_pro where cp_tabla = @w_tabla
        
    update cobis..cl_seqnos
       set siguiente = @w_tabla
     where tabla = 'cl_tabla'
     
end else begin
    print 'Ya existe la tabla eli_reg_dia_pago'
    select @w_tabla = codigo from cobis..cl_tabla where tabla = 'eli_reg_dia_pago'
    select 'existe', * from cl_catalogo where tabla = @w_tabla
    select * from cl_catalogo_pro where cp_tabla = @w_tabla
end
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

update an_component set co_name = 'Tabla de Amortización - Grupal'
WHERE co_class = 'VC_TPYEP21_FAETL_814_TASK.html?ETAPA=PLANPAGO&SOLICITUD=GRUPAL'

IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_class = 'VC_TPYEP21_FAETL_814_TASK.html?ETAPA=PLANPAGO&SOLICITUD=GRUPAL&MODE=Q')
begin
    print 'Insertar nuevo componente'
    insert into an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name) 
	values (@w_co_id, @w_mo_id, 'Tabla de Amortización - Grupal Consulta', 'VC_TPYEP21_FAETL_814_TASK.html?ETAPA=PLANPAGO&SOLICITUD=GRUPAL&MODE=Q', 'views/BUSIN/FLCRE/T_FLCRE_12_TPYEP21/1.0.0/', 'I', NULL, 'WF')
end else
    print 'ya existe el an_component'

select 'todo_dESP', * from an_component where co_name like '%abla de Amortizaci%'

go

---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>
---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>---->>>>

use cobis
go

select 'todo_ANTES', * from an_component where co_name like '%abla de Amortizaci%'

update an_component set co_class = 'VC_TPYEP21_FAETL_814_TASK.html?SOLICITUD=INDIVIDUAL' WHERE co_class = 'VC_TPYEP21_FAETL_814_TASK.html'
update an_component set co_class = 'VC_TPYEP21_FAETL_814_TASK.html?SOLICITUD=INDIVIDUAL&MODE=Q' WHERE co_class = 'VC_TPYEP21_FAETL_814_TASK.html?MODE=Q'

select 'todo_DESP', * from an_component where co_name like '%abla de Amortizaci%'
go
