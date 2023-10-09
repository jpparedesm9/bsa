---------------
--CASO 109999
---------------
use cobis
go

--CLIENTE 61050
update cobis..cl_ente 
set en_rfc = 'MAYH7006295P4',
    en_nit = 'MAYH7006295P4'
where en_ente = 61050


update cobis..cl_ente_aux
set ea_nit = 'MAYH7006295P4'
where ea_ente = 61050
go



use cob_conta_super
go

select * from sb_ods_ult_ejec 
where ou_archivo = 'MOV_CONT'
and ou_fecha = '11/30/2018'

delete sb_ods_ult_ejec 
where ou_archivo = 'MOV_CONT'
and ou_fecha = '11/30/2018'

select * from sb_ods_ult_ejec 
where ou_archivo = 'MOV_CONT'
and ou_fecha = '11/30/2018'

exec sp_mov_contable_mes 
@i_param1 = '12/04/2018'
go

delete sb_ods_ult_ejec 
where ou_archivo = 'MOV_CONT'
and ou_fecha = '11/30/2018'
go

