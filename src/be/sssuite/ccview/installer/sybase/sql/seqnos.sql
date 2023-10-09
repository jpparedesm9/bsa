use cobis
go 

if not exists (select 1 from cobis..cl_seqnos where tabla ='vcc_section_management_content')
insert into cobis..cl_seqnos (bdatos,tabla,siguiente,pkey) values('cob_pac','vcc_section_management_content',1,'sm_id')
go

if not exists (select 1 from cobis..cl_seqnos where tabla ='vcc_rol_content_management')
insert into cobis..cl_seqnos (bdatos,tabla,siguiente,pkey)
values('cob_pac','vcc_rol_content_management',1,'rc_sm_id')
go
