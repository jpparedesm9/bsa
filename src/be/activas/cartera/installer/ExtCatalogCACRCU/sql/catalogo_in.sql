use cobis
go

declare @w_return      int,
        @w_s_app       varchar(50),
        @w_path        varchar(50),
        @w_error       int,
        @w_errores     varchar(1500),
        @w_comando     varchar(2500),
        @w_usuario     login,
        @w_mensaje     varchar(255),
		@w_destino     varchar(2500),
		@w_max         int,
		@w_codigo      int,
		@w_tabla       varchar(200),
		@w_descripcion varchar(2000),
		@w_cp_producto varchar(20)
        
if (OBJECT_ID('cobis..catalogos_activa')) IS NOT NULL
    drop table cobis..catalogos_activa
   
if (OBJECT_ID('cobis..catalogos_activa_det')) IS NOT NULL
    drop table cobis..catalogos_activa_det
    
select @w_s_app = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'ADM'
and pa_nemonico = 'S_APP'


select @w_path = ba_path_destino
   from cobis..ba_batch
   where ba_batch = 21060

create table cobis..catalogos_activa(
    codigo      smallint    not null,
    tabla       char(30)    not null,
    descripcion descripcion not null,
	cp_producto varchar(10)
)

create table cobis..catalogos_activa_det(
     tabla      smallint    not null,
     codigo     char(10)    not null,
     valor      varchar(2000) not null,
     estado     char(3)     not null
)

select @w_comando = @w_s_app + 's_app' + ' bcp -auto -login cobis..catalogos_activa in '
                   + @w_path + 'tabla.txt' +  ' -c -t"|" ' + '-config ' + @w_s_app + 's_app.ini'

print @w_comando
exec @w_error = xp_cmdshell @w_comando

select @w_comando = ''
select @w_comando = @w_s_app + 's_app' + ' bcp -auto -login cobis..catalogos_activa_det in '
                   + @w_path + 'catalogo.txt' +  ' -c -t"|" ' + '-config ' + @w_s_app + 's_app.ini'

print @w_comando
exec @w_error = xp_cmdshell @w_comando


select * 
into #tmpTabla
from cobis..catalogos_activa
where tabla not in (select tabla from cobis..cl_tabla)

select * 
into #tmpCatalogo
from cobis..catalogos_activa_det
where tabla in (select codigo from #tmpTabla)

select @w_max = max(codigo) from #tmpTabla

declare cur_tabla cursor 
for select codigo, tabla, descripcion, cp_producto 
from #tmpTabla 
for read only
open cur_tabla
fetch next from cur_tabla
into @w_codigo, @w_tabla, @w_descripcion, @w_cp_producto
WHILE @@FETCH_STATUS = 0  
BEGIN
	select @w_max = @w_max + 1  

	insert into cl_catalogo_pro
	values (@w_cp_producto, @w_max)

	insert into cl_tabla (codigo, tabla, descripcion)
	values (@w_max, @w_tabla, @w_descripcion)

	insert into cl_catalogo (tabla, codigo, valor, estado)
	select @w_max, codigo, valor, estado
	from #tmpCatalogo
	where tabla = @w_codigo
	
	fetch next from cur_tabla
	into @w_codigo, @w_tabla, @w_descripcion, @w_cp_producto
END

drop table #tmpTabla 
drop table #tmpCatalogo

go

