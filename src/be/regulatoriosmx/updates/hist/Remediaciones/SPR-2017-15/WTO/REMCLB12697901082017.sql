/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : CGS-B126979 Imprimió en blanco pagaré (Grupal)
--Descripción del Problema   : Creacion de TRamite para generar Reporte de Pagare Grupales
--Responsable                : Walther Toledo
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : N/A
/*----------------------------------------------------------------------------------------------------------------*/
use cobis
go

update cl_ente_aux
set ea_cta_banco = 9877
where ea_ente in (5799)

update cl_ente_aux
set ea_estado_std = 'ACT'
where ea_ente in (5799)

update cl_ente_aux
set ea_cta_banco = 9878
where ea_ente in (5800)

update cl_ente_aux
set ea_estado_std = 'ACT'
where ea_ente in (5800)

update cl_ente_aux
set ea_cta_banco = 9879
where ea_ente in (5801)

update cl_ente_aux
set ea_estado_std = 'ACT'
where ea_ente in (5801)

update cl_ente_aux
set ea_cta_banco = 9880
where ea_ente in (5802)

update cl_ente_aux
set ea_estado_std = 'ACT'
where ea_ente in (5802)

update cl_ente_aux
set ea_cta_banco = 9881
where ea_ente in (5803)

update cl_ente_aux
set ea_estado_std = 'ACT'
where ea_ente in (5803)

update cl_ente_aux
set ea_cta_banco = 9882
where ea_ente in (5804)

update cl_ente_aux
set ea_estado_std = 'ACT'
where ea_ente in (5804)

update cl_ente
set en_banco = 'CODSTD5798'
where en_ente in (5798)

update cl_ente
set en_banco = 'CODSTD5799'
where en_ente in (5799)

update cl_ente
set en_banco = 'CODSTD5800'
where en_ente in (5800)

update cl_ente
set en_banco = 'CODSTD5801'
where en_ente in (5801)

update cl_ente
set en_banco = 'CODSTD5802'
where en_ente in (5802)

update cl_ente
set en_banco = 'CODSTD5803'
where en_ente in (5803)

update cl_ente
set en_banco = 'CODSTD5804'
where en_ente in (5804)

go

