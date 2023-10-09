use cobis
go

declare @w_id_tabla int

delete from cobis..cl_catalogo where tabla in (select codigo from cobis..cl_tabla where tabla ='ca_rubro_grupo')
delete from cobis..cl_tabla where tabla ='ca_rubro_grupo'

select  @w_id_tabla = isnull(max(codigo),0) + 1 from cobis..cl_tabla

insert into cobis..cl_tabla values(@w_id_tabla,'ca_rubro_grupo','Grupos de Rubros ') 

insert into cobis..cl_catalogo values (@w_id_tabla,'1','CAPITAL','V',null,null,null)
insert into cobis..cl_catalogo values (@w_id_tabla,'2','INTERES','V',null,null,null)
insert into cobis..cl_catalogo values (@w_id_tabla,'3','COMISION','V',null,null,null)
insert into cobis..cl_catalogo values (@w_id_tabla,'4','SEGUROS','V',null,null,null)
insert into cobis..cl_catalogo values (@w_id_tabla,'5','GASTOS','V',null,null,null)

go
