use cobis
go

--Parametro Ind
select * from cobis..cl_parametro where pa_nemonico = 'PGAIND'  and pa_producto = 'CCA'
delete cobis..cl_parametro where pa_nemonico = 'PGAIND'  and pa_producto = 'CCA'

insert into cl_parametro (
        pa_parametro                         , pa_nemonico, pa_tipo, pa_float, pa_producto)
values ('PORCENTAJE GARANTIA CREDITO INDIVIDUAL', 'PGAIND', 'F'    , 0       , 'CCA')

select * from cobis..cl_parametro where pa_nemonico = 'PGAIND'  and pa_producto = 'CCA'



--Parametro Animate
select * from cobis..cl_parametro where pa_nemonico = 'PGARAN'  and pa_producto = 'CCA'
delete cobis..cl_parametro where pa_nemonico = 'PGARAN'  and pa_producto = 'CCA'

insert into cl_parametro (
        pa_parametro                         , pa_nemonico, pa_tipo, pa_float, pa_producto)
values ('PORCENTAJE GARANTIA CREDITO ANIMATE', 'PGARAN'   , 'F'    , 0      , 'CCA')

select * from cobis..cl_parametro where pa_nemonico = 'PGARAN'  and pa_producto = 'CCA'


--Parametro Grupal
select * from cobis..cl_parametro where pa_nemonico = 'PGARGR'  and pa_producto = 'CCA'

update cobis..cl_parametro set
pa_float = 10 
where pa_nemonico = 'PGARGR' 
and pa_producto = 'CCA'

select * from cobis..cl_parametro where pa_nemonico = 'PGARGR'  and pa_producto = 'CCA'