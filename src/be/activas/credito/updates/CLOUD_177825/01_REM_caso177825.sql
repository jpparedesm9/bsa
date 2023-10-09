use cobis
go

--ACTIVAR VALIDACION SIGUIENTE ETAPA BIO
select * from cl_parametro where pa_producto = 'CRE' and pa_nemonico = 'AVUSEB'

delete cl_parametro where pa_producto = 'CRE' and pa_nemonico = 'AVUSEB'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('ACTIVAR VALIDACION SIGUIENTE ETAPA BIO', 'AVUSEB', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
go

select * from cl_parametro where pa_producto = 'CRE' and pa_nemonico = 'AVUSEB'
go

--CATALOGOS ACTIVIDADES DEPUES DE ESPERA DE GARANTIAS
use cobis
go

declare @w_id_tabla int, @w_tabla char(30)
select  @w_tabla = 'cr_activ_desp_gar_liq'

select @w_id_tabla = codigo from cl_tabla where tabla = @w_tabla

if ( @w_id_tabla is null) begin
    select @w_id_tabla = max(codigo) + 1 from cl_tabla
	insert into cl_tabla (codigo, tabla, descripcion) values (@w_id_tabla, @w_tabla, 'Act Despues de Garantia Liquida Por Flujos')
	
	update cobis..cl_seqnos
	set siguiente = @w_id_tabla
	where tabla = 'cl_tabla'
	and bdatos = 'cobis'
end

select * from cl_tabla where codigo = @w_id_tabla
select * from cl_catalogo_pro where cp_tabla = @w_id_tabla
select * from cl_catalogo where tabla = @w_id_tabla

delete cl_catalogo_pro where cp_producto = 'ADM' and cp_tabla = @w_id_tabla
insert into cl_catalogo_pro (cp_producto, cp_tabla) values ('ADM', @w_id_tabla)

delete cl_catalogo where tabla = @w_id_tabla
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_id_tabla, 'GRUPAL', '9', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_id_tabla, 'REVOLVENTE', '9', 'V', NULL, NULL, NULL)

go
