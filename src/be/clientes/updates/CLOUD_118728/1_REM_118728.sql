use cobis
go

if not exists(select 1 from cobis..cl_parametro
              where pa_nemonico= 'EICRVI'
              and   pa_producto= 'CRE')
begin
	insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
	values ('ELIMINAR INTEGRANTES CREDITO VIGENTE', 'EICRVI', 'I', NULL, NULL, NULL, 30, NULL, NULL, NULL, 'CRE')
end
go
use cobis
go
if not exists(select 1 from cobis..cl_errores
              where numero=103197
              )
insert into cobis..cl_errores (numero, severidad, mensaje)
values (103197, 0, 'No se puede modificar el Grupo si la solicitud no se encuentra en la etapa de Ingreso')
go

use cobis
go
Update cobis..cl_errores
set mensaje='TIENE OPERACIÓNES PENDIENTES'
where numero =149053

go
