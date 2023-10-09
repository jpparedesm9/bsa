--->>>>>>>>>>>>>>>>>>>REQ#180604 Tabla de documentos excluidos - etapa VERIFICAR Y DIGITALIZAR
use cob_credito
go

print 'ROLLBACK TABLA: cr_documentos_excluidos'
if object_id ('dbo.cr_documentos_excluidos') is not null
	drop table dbo.cr_documentos_excluidos
go
