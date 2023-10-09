use cobis
go

declare @w_tabla int,
        @w_co_id int

select @w_tabla = codigo
from cl_tabla
where tabla = 'an_product'

---------------------------------------- WORKFLOW ------------------------------------
--Eliminación de datos
print 'Iniciando Eliminación de datos existentes WORKFLOW'
delete from cl_catalogo
where tabla  = @w_tabla
  and codigo  = 'M-WKF'

  
--Transacciones del Editor Workflow COBIS 5
SELECT @w_co_id = co_id FROM an_component WHERE co_name = 'WKF.Editor' and co_prod_name = 'M-WKF'

delete from an_transaction_component
where tc_co_id = @w_co_id
  and tc_oc_nemonic in ('M-WKF', null)
  
print 'Terminando Eliminación de datos existentes WORKFLOW'

--Inserción de datos
print 'Iniciando Inserción de datos para el control de las Funcionalidades por Rol WORKFLOW'
insert into cl_catalogo (tabla,codigo ,valor,estado) values (@w_tabla,'M-WKF','WORKFLOW','V')

--Componente Mantenimiento de Actividades
select @w_co_id = co_id 
from an_page_zone, an_label, an_component
where pz_la_id = la_id 
  and pz_co_id = co_id
  and la_prod_name = 'M-WKF'
  and la_label = 'Mantenimiento de Actividades'
  and la_cod = 'ES_EC'

update an_component
   set co_prod_name = 'M-WKF'
 where co_id = @w_co_id

--Transacciones de Mantenimiento de Actividades
insert into an_transaction_component values (@w_co_id,21812,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31750,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31751,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31752,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31753,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31754,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31755,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31756,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31757,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31758,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31759,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31760,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31761,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31762,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31763,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31764,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31765,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31766,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31767,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31768,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31769,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31770,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31771,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31772,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31773,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31774,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31775,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31776,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31777,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31778,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31779,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31780,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31781,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31782,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31783,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31784,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31785,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31786,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31787,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31788,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31789,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31790,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31791,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31792,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31793,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31794,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31795,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31796,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31797,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31798,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31799,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31800,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31801,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31802,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31803,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31804,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31805,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31806,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31807,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31808,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31809,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31810,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31811,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31812,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31813,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31814,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31815,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31816,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31817,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31818,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31819,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31820,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31821,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31822,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31823,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31824,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31825,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31826,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,31827,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32001,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32002,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32003,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32004,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32005,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32006,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32007,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32008,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32009,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32010,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32011,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32012,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32013,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32014,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32015,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32016,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32017,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32018,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32251,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32252,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32253,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32254,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32255,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32256,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32257,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32258,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32259,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32280,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32281,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32282,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32283,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32284,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,32285,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73504,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73507,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73508,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73511,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73512,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73513,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73514,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73515,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73509,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73510,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73501,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73542,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73529,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73540,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73506,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73503,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73517,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73518,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73537,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73539,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73541,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73516,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73538,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73505,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73552,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73553,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73554,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73800,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73801,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73802,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73803,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73804,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73805,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73914,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73915,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73920,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73921,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73519,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73520,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73521,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73522,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73523,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73524,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73525,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73526,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73527,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73528,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73530,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73531,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73532,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73533,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73534,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73535,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73536,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73547,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73548,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73549,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73543,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73544,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73545,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73546,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73550,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,73551,'M-WKF')
 
insert into an_transaction_component values (@w_co_id, 1875051,'M-WKF')
 
insert into an_transaction_component values (@w_co_id, 1875052,'M-WKF')
 
insert into an_transaction_component values (@w_co_id, 1875053,'M-WKF')
 
insert into an_transaction_component values (@w_co_id, 1875054,'M-WKF')
 
insert into an_transaction_component values (@w_co_id, 1875055,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,87000,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,87001,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,87002,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,87003,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,87004,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,87006,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,87007,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,87008,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,87009,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,87010,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,87021,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,87014,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,87015,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,87019,'M-WKF')
 
insert into an_transaction_component values (@w_co_id,87020,'M-WKF')




delete from an_service_component where sc_co_id = @w_co_id
print 'Terminando Eliminación de registros para los servicios relacionados con el EDITOR DEL WORKFLOW'

--Inserción de datos
--Autorización para los servicios relacionados con el EDITOR DEL WORKFLOW
print 'Iniciando Eliminación de registros para los servicios relacionados con el EDITOR DEL WORKFLOW'
select @w_co_id = co_id 
from an_page_zone, an_label, an_component
where pz_la_id = la_id 
  and pz_co_id = co_id
  and la_prod_name = 'M-WKF'
  and la_label = 'Mantenimiento de Procesos de Negocio'
  and la_cod = 'ES_EC'

print 'Iniciando inserción de registros para los servicios relacionados con el EDITOR DEL WORKFLOW'
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.ActivityInfo','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.AssociateUserToRol','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.CloneTemplate','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteActivity','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteActivityLaunch','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteActivityObservation','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteDocumentType','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteHerarchyLevelTpl','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteHerarchyTypeTpl','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteHierachyRol','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteHierarchy','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteHierarchyItem','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteHierarchyItemTpl','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteHierarchyUserTpl','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteLauncherAditionalInformation','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteLink','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteLinkCondition','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteLinkRol','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteLoadBalance','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteMappingVarProcess','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteObservation','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteOptAct','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteProcess','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteProcessVariable','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteProcessVersion','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteReceptor','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteReqAct','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteResult','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteResults','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteRol','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteSchedulerTask','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteStep','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteStepPolicy','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DeleteUser','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.DisassociateUserToRol','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.GetTaskFlow','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertActivity','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertActivityInfo','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertActivityObservation','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertAllHierarchyItem','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertDocumentType','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertHerarchyLevelTpl','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertHierachy','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertHierachyRol','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertHierarchy','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertHierarchyItem','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertHierarchyItemTpl','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertHierarchyTypeTpl','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertHierarchyUserTpl','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertLauncherAditionalInformation','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertLink','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertLinkCondition','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertLinkRol','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertLoadBalance','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertMappingVarProcess','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertObservation','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertOptAct','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertProcess','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertProcessVariable','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertProcessVersion','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertReqAct','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertResult','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertResults','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertRol','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertSchedulerTask','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertStep','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertStepPolicy','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.InsertUser','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryActivity','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryActivityDetails','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryActivityExisting','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryAllHierarchyItem','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryAllHierarchyTypeTpl','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryAllStepPolicy','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryAvailableObservation','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryCatalogProcess','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryCatalogProcessByDescription','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryChildHierarchyItemTpl','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryConditionDesc','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryDescriptionSched','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryDestinationVersionActivity','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryDetailDocumentTypes','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryDetailProcess','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryDinamicCatalog','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryDocumentTypes','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryDocumentsTypeActivity','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryException','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryExceptionId','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryExceptionName','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryHerarchyLevelTpl','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryHerarchyTypeTpl','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryHierarchyItem','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryHierarchyItemTpl','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryHierarchyItemTplByHierarchy','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryHierarchyLevelProcessInstance','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryHierarchyMembers','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryHierarchyName','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryHierarchyProcess','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryHierarchyUserTpl','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryInformativeAditionalInformation','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryInstruction','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryInstructionId','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryInstructionName','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryLauncherAditionalInformation','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryLink','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryLinkDetail','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryLinkRole','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryLinkRoleDetail','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryLoadBalance','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryLoadBalanceDetail','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryLoadBalanceName','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryMaintenanceRol','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryNameProgram','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryNotificationTemplate','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryObservationsTree','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryPaletteActivities','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryParameterDesc','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryProccessVersion','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryProcessErrors','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryProcessLink','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryProcessName','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryProcessTemplates','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryProcessTemplatesByType','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryProcessVariable','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryReesults','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryReesultsDetails','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryRequirementsActivity','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryResultDetail','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryResultId','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryResultName','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryResultTree','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryResultsAvailable','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryResultsStep','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryRol','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryRolDetail','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryRuleHistory','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryRuleInstanceProcess','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryRuleName','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryRuleNameByTypeSubtype','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryRuleProcessHistory','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QuerySchedulerTask','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryStep','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryStepActRequirement','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryStepDesc','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryStepN','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryStepObservation','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryStepPolicy','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryStepProcess','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryStepTarget','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryTreeProcesses','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryUserName','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryUsers','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryUsersCatalog','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryUsersDetail','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryUsersPseudoCatalog','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryUsersRol','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryUsersRolA','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryVariableAvailable','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryVariableHierarchy','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryVariableId','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryVariableName','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryVariableProcessMap','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryVariablePseudoCatalog','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryVariablepPseudoCatalog','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryVariables','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryVersion','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryVersionGrid','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.RecoverUser','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateActivity','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateActivityInfo','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateDocumentType','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateHerarchyLevelTpl','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateHierachyRol','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateHierarchy','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateHierarchyItem','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateHierarchyItemTpl','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateHierarchyTypeTpl','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateHierarchyUserTpl','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateInstanceProcess','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateLauncherAditionalInformation','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateLink','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateLinkCondition','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateLinkRole','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateLoadBalance','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateMappingVarProcess','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateObservation','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateOrInsertReceptor','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateProcess','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateProcessVariable','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateProcessVersion','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateReqAct','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateResult','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateResults','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateRol','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateSchedulerTask','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateStep','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateStepActRequeriment','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateStepPolicy','M-WKF')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateUser','M-WKF')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateUserToRol','M-WKF')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindAllSubTypeRule','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSubTypeRule','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.FindSystemRule','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.QueryAllSubtypesRules','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Adm.Groupingrules.Services.QueryAllSystems','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.ProgramaAdmManager.FindById','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.ConditionRuleQueryManager.QueryById','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.ConditionRuleQueryManager.QueryByRuleVersion','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.FindByProductAndActive','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.FindRuleActiveByAcronym','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryActiveRules','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryActiveRulesByType','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryById','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryByType','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryByTypeAndSubtype','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryByTypeAndSubtypeBySystem','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QueryRulesByTypeAndSubType','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypeBySystem','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypesInRule','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.QuerySubTypesInRuleBySystem','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RuleManager.List<Rule> queryByType','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RuleManager.QueryAllRules','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.CancelClaimTask','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.CancelTask','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.CheckRequiment','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.ClaimTask','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.CompleteTask','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.CreateProcessInstance','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetActivitiesByProcess','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetCredencials','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetCurrentTask','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetHumanTasksByProcess','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetProcInstancesListByUserProduct','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetProcessById','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetProcessByUser','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetProcessListByName','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetProcessesList','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetReassignUsers','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetSupervisorActivityList','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetSupervisorActivityStatusList','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetSupervisorProcessList','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetSupervisorTaskList','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetTaskList','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetTaskListCriteria','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetTaskListGroup','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetVersionListByProcess','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.ModifiedRequirementByProcess','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.QueryUsersWorkflow','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.ReassignTask','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.ResumeTask','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.SuspendTask','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.UpdateRequirementByProcess','M-WKF')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.UpdateRequirementByProcessWithObservation','M-WKF')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetScalarUsers','M-WKF')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetTakeUsers','M-WKF')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.TablaQueryManager.QueryBynombreTabla','M-WKF')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Preferences.getUserPreferences','M-WKF')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Official.GetOfficialInfo','M-WKF')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Favorites.getUserFavorites','M-WKF')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Cobis.Commons.Services.QueryCatalogByCode','M-WKF')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryExceptionApprovedByStep','M-WKF')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Cobis.Commons.Services.QueryCatalog','M-WKF')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Designer.MiddlewareManager.QueryExecByEntities','M-WKF')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Designer.MiddlewareManager.Persist','M-WKF')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryExceptedReqApproved','M-WKF')

-- dump tran cobis with no_log

SELECT @w_co_id = co_id FROM an_component WHERE co_name = 'WKF.Estadisticas' and co_prod_name = 'M-WKF'

delete from an_transaction_component
where tc_co_id = @w_co_id
  and tc_oc_nemonic = 'M-WKF'
 
insert into an_transaction_component values (@w_co_id,73800,'M-WKF')
insert into an_transaction_component values (@w_co_id,73801,'M-WKF')
insert into an_transaction_component values (@w_co_id,73802,'M-WKF')
insert into an_transaction_component values (@w_co_id,73803,'M-WKF')
insert into an_transaction_component values (@w_co_id,73804,'M-WKF')


delete from an_service_component where sc_co_id = @w_co_id

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'WFMonitor.Proceso.GetActivitySummary','M-WKF')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'WFMonitor.Proceso.GetSummaryByProcessId','M-WKF')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'WFMonitor.Proceso.ObtenerResumen','M-WKF')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'WFMonitor.Proceso.QueryActivities','M-WKF')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'WFMonitor.Proceso.GetProcessVersions','M-WKF')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'WFMonitor.Proceso.GetOfficeByUser','M-WKF')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Preferences.getUserPreferences','M-WKF')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Official.GetOfficialInfo','M-WKF')
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Favorites.getUserFavorites','M-WKF')

-- dump tran cobis with no_log
print 'Finalizando inserción de registros para los servicios relacionados con el EDITOR DEL WORKFLOW'

 
go
