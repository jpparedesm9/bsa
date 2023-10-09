--->>>>>>>>>>>>>>>>>>>REQ#180604 Tabla de documentos excluidos - etapa VERIFICAR Y DIGITALIZAR
use cob_credito
go

print 'CREACION TABLA: cr_documentos_excluidos'
if object_id ('dbo.cr_documentos_excluidos') is not null
	drop table dbo.cr_documentos_excluidos
go

create table dbo.cr_documentos_excluidos (
    de_toperacion   varchar(10),
    de_tabla        char(30),   
	de_codigo       char(10)
)
go

insert into cr_documentos_excluidos values('INDIVIDUAL','cr_doc_digitalizado_flujo_ind','003')--AVISO DE PRIVACIDAD INDIVIDUAL / AVAL
insert into cr_documentos_excluidos values('INDIVIDUAL','cr_doc_digitalizado_flujo_ind','004')--AUTORIZACION BURO INDIVIDUAL / AVAL
insert into cr_documentos_excluidos values('INDIVIDUAL','cr_doc_digitalizado_flujo_ind','001')--AVISO DE PRIVACIDAD
insert into cr_documentos_excluidos values('INDIVIDUAL','cr_doc_digitalizado_flujo_ind','005')--FORMATO DE DOMICILIACION
insert into cr_documentos_excluidos values('INDIVIDUAL','cr_doc_digitalizado_ind','001')--IDENTIFICACION ANVERSO / AVAL
insert into cr_documentos_excluidos values('INDIVIDUAL','cr_doc_digitalizado_ind','002')--IDENTIFICACION REVERSO / AVAL
insert into cr_documentos_excluidos values('INDIVIDUAL','cr_doc_digitalizado_ind','003')--COMPROBANTE DOMICILIO / AVAL
insert into cr_documentos_excluidos values('INDIVIDUAL','cr_doc_digitalizado_ind','008')--SOLICITUD DE CREDITO CORTA / AVAL
insert into cr_documentos_excluidos values('INDIVIDUAL','cr_doc_digitalizado_ind','009')--ACTA DE NACIMIENTO / AVAL

go
