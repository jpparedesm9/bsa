/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : CGS-B126979 Imprimió en blanco pagaré (Grupal)
--Descripción del Problema   : Creacion de TRamite para generar Reporte de Pagare Grupales
--Responsable                : Walther Toledo
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_errores.sql
/*----------------------------------------------------------------------------------------------------------------*/

update cobis..cl_ente_aux 
set ea_estado_std = 'ACT' 
where ea_ente in (5413) 

update cobis..cl_ente_aux 
set ea_estado_std = 'ACT' 
where ea_ente in (5403) 

update cobis..cl_ente_aux 
set ea_cta_banco = 5433 
where ea_ente in (5404) 


update cobis..cl_ente_aux 
set ea_estado_std = 'ACT' 
where ea_ente in (5404)

update cobis..cl_ente_aux 
set ea_estado_std = 'ACT' 
where ea_ente in (5406) 


update cobis..cl_ente_aux 
set ea_estado_std = 'ACT' 
where ea_ente in (5412) 


update cobis..cl_ente_aux 
set ea_estado_std = 'ACT' 
where ea_ente in (5415)

update cobis..cl_ente 
set en_banco = 'CODSTD5413'
where en_ente in (5413) 


update cobis..cl_ente 
set en_banco = 'CODSTD5403' 
where en_ente in (5403) 



update cobis..cl_ente 
set en_banco = 'CODSTD5404' 
where en_ente in (5404) 


update cobis..cl_ente 
set en_banco = 'CODSTD5406' 
where en_ente in (5406) 
 

update cobis..cl_ente 
set en_banco = 'CODSTD5412' 
where en_ente in (5412) 



update cobis..cl_ente 
set en_banco = 'CODSTD5415' 
where en_ente in (5415) 


update cobis..cl_ente 
set en_banco = 'CODSTD5310' 
where en_ente in (5310) 

