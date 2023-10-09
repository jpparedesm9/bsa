use cobis
go

declare @w_codigo_act int

select @w_codigo_act = ac_codigo_actividad
from cob_workflow..wf_actividad
where ac_nombre_actividad like '%APROBAR PR%'


select *
from cobis..cl_parametro
where pa_nemonico = 'CAAPSO'

if not exists (select 1 from cobis..cl_parametro where pa_nemonico = 'CAAPSO')
begin
     insert into cobis..cl_parametro (pa_parametro                           , pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int       , pa_money, pa_datetime, pa_float, pa_producto)
                              values ('CODIGO ACTIVIDAD APROBACION SOLICITUD', 'CAAPSO'   , 'I'    , NULL   , NULL      , NULL       , @w_codigo_act, NULL    , NULL       , NULL    , 'CCA'      )
end


select *
from cobis..cl_parametro
where pa_nemonico = 'CAAPSO'

declare @w_codigo_tabla int

select @w_codigo_tabla = codigo
from cobis..cl_tabla
where tabla = 'cl_tipo_medio'

select  * from cobis..cl_catalogo where tabla = @w_codigo_tabla


if not exists(select  1 from cobis..cl_catalogo where tabla = @w_codigo_tabla and   codigo = 3)
begin 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
                        values (@w_codigo_tabla, '3', 'TELEFONO', 'V', NULL, NULL, NULL)
end    

select  * from cobis..cl_catalogo where tabla = @w_codigo_tabla

