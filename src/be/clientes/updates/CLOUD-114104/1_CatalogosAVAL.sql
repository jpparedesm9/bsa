use cobis
go

delete cl_catalogo_pro
from cl_tabla
where tabla in ('cr_doc_digitalizado_flujo_ind')
  and codigo = cp_tabla
go

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cr_doc_digitalizado_flujo_ind')
  and cl_tabla.codigo = cl_catalogo.tabla

delete cl_tabla
where cl_tabla.tabla in ('cr_doc_digitalizado_flujo_ind')


--cr_doc_digitalizado_flujo_ind
print 'cr_doc_digitalizado_flujo_ind'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cobis..cl_tabla values (@w_tabla,'cr_doc_digitalizado_flujo_ind','Documentos digitalizados para flujo individual')
insert into cl_catalogo_pro values ('CRE', @w_tabla)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) 
values (@w_tabla,'001','AVISO DE PRIVACIDAD','V')  
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) 
values (@w_tabla,'002','AUTORIZACION BURO','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) 
values (@w_tabla,'003','AVISO DE PRIVACIDAD INDIVIDUAL / AVAL','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) 
values (@w_tabla,'004','AUTORIZACION BURO INDIVIDUAL / AVAL','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) 
values (@w_tabla,'005','FORMATO DE DOMICILIACION', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) 
values (@w_tabla,'006', 'SOLICITUD DE CREDITO COMPLEMENTARIA', 'V')
go

