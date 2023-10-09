/* INSERCIONES EN REGLAS */
use cobis
go

declare @id int

--Eliminacion de catalogos
if exists(select 1 from cobis..cl_tabla where tabla = 'bpl_status')
begin
	delete from cl_catalogo where tabla in (select codigo from cobis..cl_tabla where tabla = 'bpl_status')
	delete from cl_tabla where tabla = 'bpl_status'
end

if exists(select 1 from cobis..cl_tabla where tabla = 'bpl_type_dependence')
begin
	delete from cl_catalogo where tabla in (select codigo from cobis..cl_tabla where tabla = 'bpl_type_dependence')
	delete from cl_tabla where tabla = 'bpl_type_dependence'
end

if exists(select 1 from cobis..cl_tabla where tabla = 'bpl_marital_status')
begin
	delete from cl_catalogo where tabla in (select codigo from cobis..cl_tabla where tabla = 'bpl_marital_status')
	delete from cl_tabla where tabla = 'bpl_marital_status'
end 

--Creacion de catalogo bpl_status
select @id = siguiente   from cobis..cl_seqnos where bdatos = 'cobis' and tabla = 'cl_tabla' and pkey = 'codigo'
insert into cobis..cl_tabla (codigo, tabla, descripcion) values (@id, 'bpl_status','Tabla de estado de Reglas')

insert into cl_catalogo (tabla, codigo, valor, estado) values(@id,'C','Cancelado','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values(@id,'V','Vigente','V')
update cobis..cl_seqnos set siguiente = @id +1  where bdatos = 'cobis'   and tabla  = 'cl_tabla'   and pkey   = 'codigo'


--Creacion de catalogo bpl_type_dependence
select @id = siguiente   from cobis..cl_seqnos where bdatos = 'cobis' and tabla = 'cl_tabla' and pkey = 'codigo'
insert into cobis..cl_tabla values (@id,'bpl_type_dependence','Dependencias de Reglas')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@id,'01','Proceso','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@id,'02','Producto','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@id,'03','Orquestación','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@id,'04','Funcionalidad','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@id,'05','Otra','V')

update cobis..cl_seqnos set siguiente = @id +1 where bdatos = 'cobis'   and tabla  = 'cl_tabla'   and pkey   = 'codigo'

--Creacion de catalogo bpl_marital_status
select @id = siguiente   from cobis..cl_seqnos where bdatos = 'cobis' and tabla = 'cl_tabla' and pkey = 'codigo'

insert into cobis..cl_tabla (codigo, tabla, descripcion) values(@id, 'bpl_marital_status','Tabla de estado de Reglas')

insert into cl_catalogo (tabla, codigo, valor, estado) values(@id,'S','Soltero','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values(@id,'C','Casado','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values(@id,'V','Viudo','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values(@id,'D','Divorciado','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values(@id,'UL','Unión Libre','V')

update cobis..cl_seqnos set siguiente = @id +1 where bdatos = 'cobis'   and tabla  = 'cl_tabla'   and pkey   = 'codigo'

--Creacion de registros de la tabla bpl_result_policies
if not exists(select 1 from cob_pac..bpl_result_policies where rp_id=0)
	insert into cob_pac..bpl_result_policies values(0,'CUMPLE','T')

if not exists(select 1 from cob_pac..bpl_result_policies where rp_id=1)
	insert into cob_pac..bpl_result_policies values(1,'NO CUMPLE','F')
	
if not exists(select 1 from cob_pac..bpl_result_policies where rp_id=2)
	insert into cob_pac..bpl_result_policies values(2,'EXCEPCION','T')
go
