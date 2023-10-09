
print 'Ingreso de componente para eliminar integrantes'

use cobis
go

DECLARE @w_co_id INT, 
        @w_prod_name varchar(10), 
        @w_mo_id int

select @w_prod_name = 'WF' 
select @w_mo_id = mo_id  
  from cobis..an_module 
 where mo_name = 'IBX.InboxOficial'
 
SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component 

SELECT @w_co_id =  isnull(@w_co_id,1)
select @w_mo_id = isnull(@w_mo_id ,1)

IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_class = 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=ELIMINAR')
begin
	INSERT INTO cobis..an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, @w_mo_id, 'Grupos Eliminar Participantes', 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=ELIMINAR', 'views/LOANS/GROUP/T_GROUPCOMPOIET_974/1.0.0/', 'I', NULL, @w_prod_name) 
end
go

print 'Ingreso de componente para Aprobar Prestamo'

use cobis
go

DECLARE @w_co_id INT, 
        @w_prod_name varchar(10), 
        @w_mo_id int

select @w_prod_name = 'WF' 
select @w_mo_id = mo_id  
  from cobis..an_module 
 where mo_name = 'IBX.InboxOficial'
 
SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component 

SELECT @w_co_id =  isnull(@w_co_id,1)
select @w_mo_id = isnull(@w_mo_id ,1)

IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_class = 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=APROBAR')
begin
	INSERT INTO cobis..an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, @w_mo_id, 'Grupos Aprobar Préstamo', 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=APROBAR', 'views/LOANS/GROUP/T_GROUPCOMPOIET_974/1.0.0/', 'I', NULL, @w_prod_name) 
end
go

print 'Ingreso de registro para error'
use cobis
go

if not exists (select 1 from cobis..cl_errores where numero = 208936)
    insert into cobis..cl_errores values (208936, 0, 'En esta etapa no se puede agregar integrantes')
go

print '-- REGISTRO DE PARAMETROS - Eliminar Participantes'
if not exists (select 1 from cobis..cl_parametro where pa_nemonico = 'ETELIM' and pa_producto = 'CRE')
    insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
    values ('NOMBRE DE LA ETAPA DE ELIMINAR', 'ETELIM', 'C', 'ELIMINAR PARTICIPANTES', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
go
