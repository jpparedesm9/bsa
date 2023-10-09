use cobis
go


delete from cobis..cl_parametro where pa_nemonico in ( 'NDEDAD', 'MONSEG')


if not exists (select 1 from cobis..cl_parametro where pa_nemonico = 'NDEDAD') begin
   insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo,  pa_tinyint,   pa_producto)
   values ('NUMERO DIAS CALCULO EDAD', 'NDEDAD'   , 'T'    ,  10        ,   'ADM')
end

if not exists (select 1 from cobis..cl_parametro where pa_nemonico = 'MONSEG') begin
   insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo,  pa_money,   pa_producto)
   values ('MONTO SEGURO', 'MONSEG'   , 'M'    ,  48        ,   'ADM')
end



select * from cobis..cl_parametro where pa_nemonico in ( 'NDEDAD', 'MONSEG')

go