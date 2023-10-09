use cobis
go

print 'ELIMINANDO ENTRADAS EN cl_seqnos PARA VISTA CONSOLIDADA DE CLIENTES'
delete from cl_seqnos  where bdatos = 'cob_pac'

print 'INSERTANDO ENTRADAS EN cl_seqnos PARA VISTA CONSOLIDADA DE CLIENTES'
insert into cl_seqnos values ('cob_pac', '', 0, '')

-------------------------------------------------------------------------
-- Secuenciales para adminitración de menus contextuales (VCC) ----
-------------------------------------------------------------------------
insert into cl_seqnos values ('cob_pac', 'bpl_an_page_view', 0, 'pvi_id')

insert into cl_seqnos values ('cob_pac', 'bpl_rule', 0, 'rl_id')

insert into cl_seqnos values ('cob_pac', 'bpl_rule_version', 0, 'rv_id')

insert into cl_seqnos values ('cob_pac', 'bpl_view', 0, 'vi_id')

insert into cl_seqnos values ('cob_pac', 'bpl_view_parameter', 0, 'par_id')


if not exists (select 1 from cobis..cl_seqnos where tabla ='vcc_section_management_content')
begin
	insert into cobis..cl_seqnos (bdatos,tabla,siguiente,pkey) values('cob_pac','vcc_section_management_content',1,'sm_id')
end

if not exists (select 1 from cobis..cl_seqnos where tabla ='vcc_rol_content_management')
begin
	insert into cobis..cl_seqnos (bdatos,tabla,siguiente,pkey) values('cob_pac','vcc_rol_content_management',1,'rc_sm_id')
end

if not exists (select 1 from cobis..cl_seqnos where tabla ='bpl_rule_dependence')
begin
	insert into cobis..cl_seqnos (bdatos,tabla,siguiente,pkey) values('cob_pac','bpl_rule_dependence',1,'bp_ru_de')
end

if not exists (select 1 from cobis..cl_seqnos where tabla ='bpl_rule_exceptions')
begin
	insert into cobis..cl_seqnos (bdatos,tabla,siguiente,pkey) values('cob_pac','bpl_rule_exceptions',1,'bp_ru_ex')
end

if not exists (select 1 from cobis..cl_seqnos where tabla ='vcc_dtos')
begin
	insert into cobis..cl_seqnos (bdatos,tabla,siguiente,pkey) values('cob_pac','vcc_dtos',1,'dto_id')
end

if not exists (select 1 from cobis..cl_seqnos where tabla ='vcc_pro_admin_default')
begin
	insert into cobis..cl_seqnos (bdatos,tabla,siguiente,pkey) values('cob_pac','vcc_pro_admin_default',1,'prd_id')
end

if not exists (select 1 from cobis..cl_seqnos where tabla ='vcc_properties')
begin
	insert into cobis..cl_seqnos (bdatos,tabla,siguiente,pkey) values('cob_pac','vcc_properties',1,'pr_id')
end

if not exists(select 1 from cobis..cl_seqnos where bdatos = 'cob_pac' and tabla = 'bpi_task_view')
begin
	insert into cobis..cl_seqnos (bdatos,tabla,siguiente,pkey) values ('cob_pac','bpi_task_view',0,'tv_id')  
end

go
