
	use cobis
	go
	
	declare @w_tabla smallint
	
	select @w_tabla = codigo 
	from cl_tabla
	where  tabla = 'ca_param_notif'

if not exists(select 1 from cobis..cl_catalogo where tabla=@w_tabla and codigo='GRPCO_NJAS')
	insert into cobis..cl_catalogo(tabla,codigo,valor,estado)
	values(@w_tabla,'GRPCO_NJAS','PagoCorresponsal.jasper','V')


if not exists(select 1 from cobis..cl_catalogo where tabla=@w_tabla and codigo='GRPCO_NPDF')
	insert into cobis..cl_catalogo(tabla,codigo,valor,estado)
	values(@w_tabla,'GRPCO_NPDF','PagoCorresponsal_','V')


if not exists(select 1 from cobis..cl_catalogo where tabla=@w_tabla and codigo='GRPCO_NXML')
	insert into cobis..cl_catalogo(tabla,codigo,valor,estado)
	values(@w_tabla,'GRPCO_NXML','PagoCorresponsal.xml','V')