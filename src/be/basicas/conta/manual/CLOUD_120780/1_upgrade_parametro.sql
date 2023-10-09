use cobis
go

delete cobis..cl_parametro
where pa_producto = 'CON'
  and pa_nemonico = 'OTRUS'
go

insert into cobis..cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_char, pa_producto)
values ('OTRUS', 'CONSULTA COMPROBANTE SOLO OTRO USUARIO', 'C', 'S', 'CON')
go


