--BUEN DIA DEL CLIENTE EN MENCION EL SISTEMA COBIS VALIDO UNA CUENTA QUE ES INCORRECTA , 
--LA CUENTA NO ES DEL CLIENTE SIN EMBARGO EL SISTEMA LO VINCULO ANEXO ESTADO DE CUENTA 
--QUE DEBE DE IR CON LOS DATOS CORRECTOS DEL CLIENTE (BUC Y CUENTA).
--CLIENTE: 37379 ANA PATRICA ROSALES RAMIREZ
--Número de cuenta: 060604882519
--Cliente santander: 45898303

use cobis
go

declare @w_cliente int
select @w_cliente = 37379

select 'BUC' = en_banco, * from cobis..cl_ente where en_ente = @w_cliente
select 'CUENTA' = ea_cta_banco, * from cobis..cl_ente_aux where ea_ente = @w_cliente

update cobis..cl_ente
set    en_banco = '43615694' -- BUC ANTES 43615694
where  en_ente = @w_cliente

update cobis..cl_ente_aux
set    ea_cta_banco = '056724298938'-- CUENTA - ANTES 056724298938
where ea_ente = @w_cliente

select 'BUC' = en_banco, * from cobis..cl_ente where en_ente = @w_cliente
select 'CUENTA' = ea_cta_banco, * from cobis..cl_ente_aux where ea_ente = @w_cliente
go
