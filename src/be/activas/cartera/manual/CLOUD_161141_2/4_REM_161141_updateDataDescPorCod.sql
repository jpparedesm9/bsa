USE cobis
GO

select count(*)
from cobis..cl_ente_aux where ea_colectivo = 'CLIENTE CANDIDATO'

select count(*) 
from cobis..cl_ente_aux where ea_nivel_colectivo = 'ORO'

update cobis..cl_ente_aux set ea_colectivo = 'CC' where ea_colectivo = 'CLIENTE CANDIDATO'
update cobis..cl_ente_aux set ea_nivel_colectivo = 'O' where ea_nivel_colectivo = 'ORO'
go

--The module 'sp_lcr_generar_candidatos' depends on the missing object 'cob_conta_super..sp_operaciones_canceladas'. The module will still be created; however, it cannot run successfully until the object exists.
