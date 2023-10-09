use cobis
go

delete from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='cl_sit_version')
delete from cl_catalogo_pro where cp_tabla = (select codigo from cl_tabla where tabla ='cl_sit_version')
delete from cl_tabla where tabla ='cl_sit_version'

declare @w_id_catalogo int

select @w_id_catalogo = isnull(max(codigo),0)+1 from cobis..cl_tabla 
insert into cobis..cl_tabla values(@w_id_catalogo,'cl_sit_version','Situacion de la version')
		
insert into cl_catalogo_pro (cp_producto, cp_tabla)
values ('CLI', @w_id_catalogo)

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalogo,'P','PRODUCTIVO','V',null,null,null)

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalogo,'D','DESARROLLO','V',null,null,null)

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalogo,'H','HISTORICO','V',null,null,null)

go
--===============================
declare 		@w_id_catalog int

delete from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='cl_tipo_respuesta_form')
delete from cl_catalogo_pro where cp_tabla = (select codigo from cl_tabla where tabla ='cl_tipo_respuesta_form')
delete from cl_tabla where tabla ='cl_tipo_respuesta_form'

select @w_id_catalog = isnull(max(codigo),0)+1 from cobis..cl_tabla 
insert into cobis..cl_tabla values(@w_id_catalog,'cl_tipo_respuesta_form','Tipos de respuesta')

insert into cl_catalogo_pro (cp_producto, cp_tabla)
values ('CLI', @w_id_catalog)

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalog,'C','CATALOGO','V',null,null,null)

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalog,'D','FECHA','V',null,null,null)

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalog,'I','ENTERO','V',null,null,null)

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalog,'M','DINERO','V',null,null,null)

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalog,'T','TABLA','V',null,null,null)

go

---
declare 		@w_id_catalog int
delete from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='cl_estado_tu_negocio')
delete from cl_catalogo_pro where cp_tabla = (select codigo from cl_tabla where tabla ='cl_estado_tu_negocio')
delete from cl_tabla where tabla ='cl_estado_tu_negocio'

select @w_id_catalog = isnull(max(codigo),0)+1 from cobis..cl_tabla 
insert into cobis..cl_tabla values(@w_id_catalog,'cl_estado_tu_negocio','Tipos de respuesta')

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalog,'AN','ACEPTADO NO VALIDADO','V',null,null,null)

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalog,'A','ACEPTADO','V',null,null,null)

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalog,'R','RECHAZADO','V',null,null,null)

go

----------   PARAMETROS DE LIMITE INFERIOR Y LIMITE SUPERIOR

delete from cobis..cl_parametro where pa_nemonico = 'LIMINF'
delete from cobis..cl_parametro where pa_nemonico = 'LIMSUP'

insert into cobis..cl_parametro values('Limite Inferior','LIMINF','M',null,null,null,null,1000,null,null,'CLI')
insert into cobis..cl_parametro values('Limite Superior','LIMSUP','M',null,null,null,null,300000,null,null,'CLI')

go

----------   PARAMETROS DE PORCENTAJE

delete from cobis..cl_parametro where pa_nemonico = 'PGM'
delete from cobis..cl_parametro where pa_nemonico = 'PUM'

insert into cobis..cl_parametro values('Porcentaje de Gastos Mensuales','PGM','M',null,null,null,20,null,null,null,'CLI')
insert into cobis..cl_parametro values('Porcentaje de Utilidad Mensual','PUM','M',null,null,null,35,null,null,null,'CLI')

go

----------   PARAMETROS DE MULTIPLO DE 100

delete from cobis..cl_parametro where pa_nemonico = 'MCIEN'

insert into cobis..cl_parametro values('Multiplo de 100','MCIEN','M',null,null,null,100,null,null,null,'CLI')

go

declare @w_id int

delete from cob_workflow..wf_tipo_documento 
where td_nombre_tipo_doc in ('COMPROBANTE LIBRO DE INGRESOS',
								'COMPROBANTE FACTURAS',
								'COMPROBANTE NOTAS DE REMISION',
								'COMPROBANTE DE GASTOS 1',
								'COMPROBANTE DE GASTOS 2',
								'COMPROBANTE DE GASTOS 3')

select @w_id = max(td_codigo_tipo_doc)+1 from cob_workflow..wf_tipo_documento

insert into cob_workflow..wf_tipo_documento values(@w_id ,'CERTIFICADO DE ARRAIGO DEL NEGOCIO','D','V','P')
select @w_id = @w_id + 1
insert into cob_workflow..wf_tipo_documento values(@w_id ,'FOTOGRAFIA DEL NEGOCIO','D','V','P')
select @w_id = @w_id + 1
insert into cob_workflow..wf_tipo_documento values(@w_id ,'COMPROBANTE LIBRO DE INGRESOS','D','V','P')
select @w_id = @w_id + 1
insert into cob_workflow..wf_tipo_documento values(@w_id,'COMPROBANTE FACTURAS','D','V','P')
select @w_id = @w_id + 1
insert into cob_workflow..wf_tipo_documento values(@w_id,'COMPROBANTE NOTAS DE REMISION','D','V','P')
select @w_id = @w_id + 1
insert into cob_workflow..wf_tipo_documento values(@w_id,'COMPROBANTE DE GASTOS 1','D','V','P')
select @w_id = @w_id + 1
insert into cob_workflow..wf_tipo_documento values(@w_id,'COMPROBANTE DE GASTOS 2','D','V','P')
select @w_id = @w_id + 1
insert into cob_workflow..wf_tipo_documento values(@w_id,'COMPROBANTE DE GASTOS 3','D','V','P')
go
