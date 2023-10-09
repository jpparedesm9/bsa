use cobis
go

declare @menuId int
declare @rsId1 int,@rsId2 int,@rsId3 int,@rsId4 int,@rsId5 int,@rsId6 int,@rsId7 int,@rsId8 int,@rsId9 int,
@rsId10 int,@rsId11 int,@rsId12 int,@rsId13 int,@rsId14 int,@rsId15 int,@rsId16 int,@rsId17 int,@rsId18 int,@rsId19 int

print '------Resources-----'
select @rsId1 = re_id from cobis..cew_resource
where re_pattern='/cobis/web/views/ADMCEW/.*'
select @rsId2 = re_id from cobis..cew_resource
where re_pattern='/cobis/web/views/businessrules/.*'
select @rsId3 = re_id from cobis..cew_resource
where re_pattern='/cobis/web/views/fpm/.*'
select @rsId4 = re_id from cobis..cew_resource
where re_pattern='/cobis/web/views/workflow/.*'
select @rsId5 = re_id from cobis..cew_resource
where re_pattern='/cobis/web/views/FINPM/.*'
select @rsId6 = re_id from cobis..cew_resource
where re_pattern='/cobis/web/views/LATFO/.*'
select @rsId7 = re_id from cobis..cew_resource
where re_pattern='/cobis/web/views/ADMIN/.*'
select @rsId8 = re_id from cobis..cew_resource
where re_pattern='/cobis/web/views/inbox/.*'
select @rsId9 = re_id from cobis..cew_resource
where re_pattern='/cobis/web/views//inbox/.*'
select @rsId10 = re_id from cobis..cew_resource
where re_pattern='/cobis/web/views//customer/.*'
select @rsId11 = re_id from cobis..cew_resource
where re_pattern='/cobis/web/views/customer/.*'
select @rsId12 = re_id from cobis..cew_resource
where re_pattern='/cobis/web/views//LATFO/.*'
select @rsId13 = re_id from cobis..cew_resource
where re_pattern='/cobis/web/views/BUSIN/.*'
select @rsId14 = re_id from cobis..cew_resource
where re_pattern='/cobis/web/views/clientviewer/.*'
select @rsId15 = re_id from cobis..cew_resource
where re_pattern='/cobis/web/views/CANES/.*'
select @rsId16 = re_id from cobis..cew_resource
where re_pattern='/cobis/web/views/admin-clientviewer/.*'
select @rsId17 = re_id from cobis..cew_resource
where re_pattern='/cobis/web/views//workflow/.*'
select @rsId18 = re_id from cobis..cew_resource
where re_pattern='/cobis/web/views/MKCHK/.*'
select @rsId19 = re_id from cobis..cew_resource
where re_pattern='/cobis/web/views/businessprocess/.*'
print '------fin carga Resources-----'
/*******************************insert into cew_menu_resources**********************************/
--Administrador de Menú
select @menuId=(select me_id from cobis..cew_menu
					where me_name='ADMCEW.MENU_MANAGER')
print 'recursos de Administrador de Menu -> %1!'  + cast(@menuId as varchar)
if(@rsId1 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId1)  --/cobis/web/views/ADMCEW/.*>--<views/ADMCEW/ADMCEW.html 
else 
 print 'Recurso /cobis/web/views/ADMCEW/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                                                    

--Administrador Productos Financieros
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_APF')
print'recursos de Administrador Productos Financieros -> %1!' + cast(@menuId as varchar)
if(@rsId3 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId3)  --/cobis/web/views/fpm/.*>--<views/fpm/fpm-tree-process-page.html 
else 
 print 'Recurso /cobis/web/views/fpm/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId5 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId5)  --/cobis/web/views/FINPM/.*>--<views/fpm/fpm-tree-process-page.html 
else 
 print 'Recurso /cobis/web/views/FINPM/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId7 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId7)  --/cobis/web/views/ADMIN/.*>--<views/fpm/fpm-tree-process-page.html 
else 
 print 'Recurso /cobis/web/views/ADMIN/.* no encontrado para el menu %1' + cast(@menuId as varchar)

--Administrador Vista Consolidada					
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_ADMIN_VCC')
print'recursos de Administrador Vista Consolidada -> %1!' + cast(@menuId as varchar)
if(@rsId7 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId7)  --/cobis/web/views/ADMIN/.*>--<views/admin-clientviewer/admin-client-viewer.html 
else 
 print 'Recurso /cobis/web/views/ADMIN/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId14 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId14)  --/cobis/web/views/clientviewer/.*>--<views/admin-clientviewer/admin-client-viewer.html 
else 
 print 'Recurso /cobis/web/views/clientviewer/.* no encontrado para el menu %1' + cast(@menuId as varchar)   
if(@rsId16 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId16)  --/cobis/web/views/admin-clientviewer/.*>--<views/admin-clientviewer/admin-client-viewer.html 
else 
 print 'Recurso /cobis/web/views/admin-clientviewer/.* no encontrado para el menu %1' + cast(@menuId as varchar)

--Seguridades de Reglas y Políticas
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_BUSSINESS_RULES_ADMIN')
print'recursos de Seguridades de Reglas y Políticas -> %1!' + cast(@menuId as varchar)
if(@rsId2 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId2)  --/cobis/web/views/businessrules/.*>--<views/businessrules/container-admin-businessrules.html 
else 
 print 'Recurso /cobis/web/views/businessrules/.* no encontrado para el menu %1' + cast(@menuId as varchar)

--Categorias y SubCategorias
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_CAT_SUBCAT')
print'recursos de Categorias y SubCategorias -> %1!' + cast(@menuId as varchar)
if(@rsId6 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId6)  --/cobis/web/views/LATFO/.*>--<views/LATFO/CLAIM/T_CLAIM_44_AGORY85/1.0.0/VC_AGORY85_CEGOR_783_TASK.html 
else 
 print 'Recurso /cobis/web/views/LATFO/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId5 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId5)  --/cobis/web/views/FINPM/.*>--<views/LATFO/CLAIM/T_CLAIM_44_AGORY85/1.0.0/VC_AGORY85_CEGOR_783_TASK.html 
else 
 print 'Recurso /cobis/web/views/FINPM/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId7 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId7)  --/cobis/web/views/ADMIN/.*>--<views/LATFO/CLAIM/T_CLAIM_44_AGORY85/1.0.0/VC_AGORY85_CEGOR_783_TASK.html 
else 
 print 'Recurso /cobis/web/views/ADMIN/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId12 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId12)  --/cobis/web/views//LATFO/.*>--<views/LATFO/CLAIM/T_CLAIM_44_AGORY85/1.0.0/VC_AGORY85_CEGOR_783_TASK.html 
else 
 print 'Recurso /cobis/web/views//LATFO/.* no encontrado para el menu %1' + cast(@menuId as varchar)

--Official Inbox 
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_CONTAINER_INBOX_FF')
print'recursos de Official Inbox -> %1!' + cast(@menuId as varchar)
if(@rsId2 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId2)  --/cobis/web/views/businessrules/.*>--<views/LATFO/INBOX/T_INBOX_72_NXNNR78/1.0.0/VC_NXNNR78_TSOGE_560_TASK.html?role=F 
else 
 print 'Recurso /cobis/web/views/businessrules/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId5 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId5)  --/cobis/web/views/FINPM/.*>--<views/LATFO/INBOX/T_INBOX_72_NXNNR78/1.0.0/VC_NXNNR78_TSOGE_560_TASK.html?role=F 
else 
 print 'Recurso /cobis/web/views/FINPM/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId6 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId6)  --/cobis/web/views/LATFO/.*>--<views/LATFO/INBOX/T_INBOX_72_NXNNR78/1.0.0/VC_NXNNR78_TSOGE_560_TASK.html?role=F
else 
 print 'Recurso /cobis/web/views/LATFO/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId7 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId7)  --/cobis/web/views/ADMIN/.*>--<views/LATFO/INBOX/T_INBOX_72_NXNNR78/1.0.0/VC_NXNNR78_TSOGE_560_TASK.html?role=F
else 
 print 'Recurso /cobis/web/views/ADMIN/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId8 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId8)  --/cobis/web/views/inbox/.*>--<views/LATFO/INBOX/T_INBOX_72_NXNNR78/1.0.0/VC_NXNNR78_TSOGE_560_TASK.html?role=F
else 
 print 'Recurso /cobis/web/views/inbox/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId9 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId9)  --/cobis/web/views//inbox/.*>--<views/LATFO/INBOX/T_INBOX_72_NXNNR78/1.0.0/VC_NXNNR78_TSOGE_560_TASK.html?role=F
else 
 print 'Recurso /cobis/web/views//inbox/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId12 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId12)  --/cobis/web/views//LATFO/.*>--<views/LATFO/INBOX/T_INBOX_72_NXNNR78/1.0.0/VC_NXNNR78_TSOGE_560_TASK.html?role=F
else 
 print 'Recurso /cobis/web/views//LATFO/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId13 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId13)  --/cobis/web/views/BUSIN/.*>--<views/LATFO/INBOX/T_INBOX_72_NXNNR78/1.0.0/VC_NXNNR78_TSOGE_560_TASK.html?role=F
else 
 print 'Recurso /cobis/web/views/BUSIN/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId19 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId19)  --/cobis/web/views/businessprocess/.*>--<views/LATFO/INBOX/T_INBOX_72_NXNNR78/1.0.0/VC_NXNNR78_TSOGE_560_TASK.html?role=F
else 
 print 'Recurso /cobis/web/views/businessprocess/.* no encontrado para el menu %1' + cast(@menuId as varchar)

--Supervisor Inbox
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_CONTAINER_INBOX_SS')
print'recursos de Supervisor Inbox -> %1!' + cast(@menuId as varchar)
if(@rsId5 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId5)  --/cobis/web/views/FINPM/.*>--<views/LATFO/INBOX/T_INBOX_72_NXNNR78/1.0.0/VC_NXNNR78_TSOGE_560_TASK.html?role=S
else 
 print 'Recurso /cobis/web/views/ADMCEW/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId6 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId6)  --/cobis/web/views/LATFO/.*>--<views/LATFO/INBOX/T_INBOX_72_NXNNR78/1.0.0/VC_NXNNR78_TSOGE_560_TASK.html?role=S
else 
 print 'Recurso /cobis/web/views/ADMCEW/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId7 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId7)  --/cobis/web/views/ADMIN/.*>--<views/LATFO/INBOX/T_INBOX_72_NXNNR78/1.0.0/VC_NXNNR78_TSOGE_560_TASK.html?role=S
else 
 print 'Recurso /cobis/web/views/ADMCEW/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId8 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId8)  --/cobis/web/views/inbox/.*>--<views/LATFO/INBOX/T_INBOX_72_NXNNR78/1.0.0/VC_NXNNR78_TSOGE_560_TASK.html?role=S
else 
 print 'Recurso /cobis/web/views/ADMCEW/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId9 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId9)  --/cobis/web/views//inbox/.*>--<views/LATFO/INBOX/T_INBOX_72_NXNNR78/1.0.0/VC_NXNNR78_TSOGE_560_TASK.html?role=S
else 
 print 'Recurso /cobis/web/views/ADMCEW/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId12 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId12)  --/cobis/web/views//LATFO/.*>--<views/LATFO/INBOX/T_INBOX_72_NXNNR78/1.0.0/VC_NXNNR78_TSOGE_560_TASK.html?role=S
else 
 print 'Recurso /cobis/web/views/ADMCEW/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId13 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId13)  --/cobis/web/views/BUSIN/.*>--<views/LATFO/INBOX/T_INBOX_72_NXNNR78/1.0.0/VC_NXNNR78_TSOGE_560_TASK.html?role=S
else 
 print 'Recurso /cobis/web/views/ADMCEW/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId19 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId19)  --/cobis/web/views/businessprocess/.*>--<views/LATFO/INBOX/T_INBOX_72_NXNNR78/1.0.0/VC_NXNNR78_TSOGE_560_TASK.html?role=S
else 
 print 'Recurso /cobis/web/views/ADMCEW/.* no encontrado para el menu %1' + cast(@menuId as varchar)

--Administrador de contenidos
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_CONTENT_SECTION')
print'recursos de Administrador de contenidos -> %1!' + cast(@menuId as varchar)
if(@rsId6 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId6)  --/cobis/web/views/LATFO/.*>--<views/LATFO/PLATF/T_PLATF_99_NSOSK11/1.0.0/VC_NSOSK11_NNTOO_561_TASK.html 
else 
 print 'Recurso /cobis/web/views/LATFO/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                    
if(@rsId12 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId12)  --/cobis/web/views//LATFO/.*>--<views/LATFO/PLATF/T_PLATF_99_NSOSK11/1.0.0/VC_NSOSK11_NNTOO_561_TASK.html 
else 
 print 'Recurso /cobis/web/views//LATFO/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                  

--Seguridad Sección de Contenidos 
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_CONTENT_SECTION_SECURITY')
print'recursos de Seguridad Sección de Contenidos -> %1!' + cast(@menuId as varchar)
if(@rsId6 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId6)  --/cobis/web/views/LATFO/.*>--<views/LATFO/PLATF/T_PLATF_90_LTNTI84/1.0.0/VC_LTNTI84_REONA_308_TASK.html 
else 
 print 'Recurso /cobis/web/views/LATFO/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                    
if(@rsId12 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId12)  --/cobis/web/views//LATFO/.*>--<views/LATFO/PLATF/T_PLATF_90_LTNTI84/1.0.0/VC_LTNTI84_REONA_308_TASK.html 
else 
 print 'Recurso /cobis/web/views//LATFO/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                  

--Dtos y Propiedades
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_DTOS_AND_PROPERTIES')
print'recursos de Dtos y Propiedades -> %1!' + cast(@menuId as varchar)
if(@rsId6 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId6)  --/cobis/web/views/LATFO/.*>--<views/LATFO/UCSPM/T_UCSPM_16_KTOIT54/1.0.0/VC_KTOIT54_DOLST_848_TASK.html 
else 
 print 'Recurso /cobis/web/views/LATFO/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                    
if(@rsId10 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId10)  --/cobis/web/views//customer/.*>--<views/LATFO/UCSPM/T_UCSPM_16_KTOIT54/1.0.0/VC_KTOIT54_DOLST_848_TASK.html 
else 
 print 'Recurso /cobis/web/views//customer/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                               
if(@rsId11 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId11)  --/cobis/web/views/customer/.*>--<views/LATFO/UCSPM/T_UCSPM_16_KTOIT54/1.0.0/VC_KTOIT54_DOLST_848_TASK.html 
else 
 print 'Recurso /cobis/web/views/customer/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                
if(@rsId12 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId12)  --/cobis/web/views//LATFO/.*>--<views/LATFO/UCSPM/T_UCSPM_16_KTOIT54/1.0.0/VC_KTOIT54_DOLST_848_TASK.html 
else 
 print 'Recurso /cobis/web/views//LATFO/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                  
if(@rsId15 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId15)  --/cobis/web/views/CANES/.*>--<views/LATFO/UCSPM/T_UCSPM_16_KTOIT54/1.0.0/VC_KTOIT54_DOLST_848_TASK.html 
else 
 print 'Recurso /cobis/web/views/CANES/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                   

--Editor de Políticas
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_EDITOR_POLITICAS')
print'recursos de Editor de Políticas -> %1!' + cast(@menuId as varchar)
if(@rsId2 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId2)  --/cobis/web/views/businessrules/.*>--<views/businessrules/container-rules-editor.html 
else 
 print 'Recurso /cobis/web/views/businessrules/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                      
if(@rsId13 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId13)  --/cobis/web/views/BUSIN/.*>--<views/businessrules/container-rules-editor.html 
else 
 print 'Recurso /cobis/web/views/BUSIN/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                             

--Sistemas y Subtipos
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_GROUP_ADMINISTRATION')
print'recursos de Sistemas y Subtipos -> %1!' + cast(@menuId as varchar)
if(@rsId2 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId2)  --/cobis/web/views/businessrules/.*>--<views/businessrules/container-group-businessrules.html 
else 
 print 'Recurso /cobis/web/views/businessrules/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                               
if(@rsId13 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId13)  --/cobis/web/views/BUSIN/.*>--<views/businessrules/container-group-businessrules.html 
else 
 print 'Recurso /cobis/web/views/BUSIN/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                      
if(@rsId19 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId19)  --/cobis/web/views/businessprocess/.*>--<views/businessrules/container-group-businessrules.html 
else 
 print 'Recurso /cobis/web/views/businessprocess/.* no encontrado para el menu %1' + cast(@menuId as varchar)

--Consultas de Inbox
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_INBOX_QUERY')
print'recursos de Consultas de Inbox -> %1!' + cast(@menuId as varchar)
if(@rsId8 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId8)  --/cobis/web/views/inbox/.*>--<views/inbox/inbox-query.html 
else 
 print 'Recurso /cobis/web/views/inbox/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                                                 
if(@rsId9 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId9)  --/cobis/web/views//inbox/.*>--<views/inbox/inbox-query.html 
else 
 print 'Recurso /cobis/web/views//inbox/.* no encontrado para el menu %1' + cast(@menuId as varchar)

--Consolidación de Solicitudes de Castigo
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_GRP_PENALIZATION')
print'recursos de Consolidación de Solicitudes de Castigo -> %1!' + cast(@menuId as varchar)
if(@rsId13 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId13)  --/cobis/web/views/BUSIN/.*>--<views/BUSIN/FLCRE/T_FLCRE_45_OTENA94/1.0.0/VC_OTENA94_SELZT_306_TASK.html 
else 
 print 'Recurso /cobis/web/views/BUSIN/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId19 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId19)  --/cobis/web/views/businessprocess/.*>--<views/BUSIN/FLCRE/T_FLCRE_45_OTENA94/1.0.0/VC_OTENA94_SELZT_306_TASK.html 
else 
 print 'Recurso /cobis/web/views/businessprocess/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                         

--Listado de Operaciones Candidatas
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_QUER_PUNISHMENT')
print'recursos de Listado de Operaciones Candidatas -> %1!' + cast(@menuId as varchar)
if(@rsId13 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId13)  --/cobis/web/views/BUSIN/.*>--<views/BUSIN/FLCRE/T_FLCRE_98_TUIHT20/1.0.0/VC_TUIHT20_TIHNT_960_TASK.html 
else 
 print 'Recurso /cobis/web/views/BUSIN/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                   
if(@rsId19 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId19)  --/cobis/web/views/businessprocess/.*>--<views/BUSIN/FLCRE/T_FLCRE_98_TUIHT20/1.0.0/VC_TUIHT20_TIHNT_960_TASK.html 
else 
 print 'Recurso /cobis/web/views/businessprocess/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                         

--MNU_REASIGNACION
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_REASIGNACION')
print'recursos de MNU_REASIGNACION -> %1!' + cast(@menuId as varchar)
if(@rsId2 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId2)  --/cobis/web/views/businessrules/.*>--<views/BUSIN/FLCRE/T_FLCRE_83_OCIPA21/1.0.0/VC_OCIPA21_AOLAO_722_TASK.html 
else 
 print 'Recurso /cobis/web/views/businessrules/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                
if(@rsId8 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId8)  --/cobis/web/views/inbox/.*>--<views/BUSIN/FLCRE/T_FLCRE_83_OCIPA21/1.0.0/VC_OCIPA21_AOLAO_722_TASK.html 
else 
 print 'Recurso /cobis/web/views/inbox/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                        
if(@rsId9 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId9)  --/cobis/web/views//inbox/.*>--<views/BUSIN/FLCRE/T_FLCRE_83_OCIPA21/1.0.0/VC_OCIPA21_AOLAO_722_TASK.html 
else 
 print 'Recurso /cobis/web/views//inbox/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                       
if(@rsId10 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId10)  --/cobis/web/views//customer/.*>--<views/BUSIN/FLCRE/T_FLCRE_83_OCIPA21/1.0.0/VC_OCIPA21_AOLAO_722_TASK.html 
else 
 print 'Recurso /cobis/web/views//customer/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                   
if(@rsId11 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId11)  --/cobis/web/views/customer/.*>--<views/BUSIN/FLCRE/T_FLCRE_83_OCIPA21/1.0.0/VC_OCIPA21_AOLAO_722_TASK.html 
else 
 print 'Recurso /cobis/web/views/customer/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                    
if(@rsId13 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId13)  --/cobis/web/views/BUSIN/.*>--<views/BUSIN/FLCRE/T_FLCRE_83_OCIPA21/1.0.0/VC_OCIPA21_AOLAO_722_TASK.html 
else 
 print 'Recurso /cobis/web/views/BUSIN/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                   
if(@rsId15 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId15)  --/cobis/web/views/CANES/.*>--<views/BUSIN/FLCRE/T_FLCRE_83_OCIPA21/1.0.0/VC_OCIPA21_AOLAO_722_TASK.html 
else 
 print 'Recurso /cobis/web/views/CANES/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                       
if(@rsId19 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId19)  --/cobis/web/views/businessprocess/.*>--<views/BUSIN/FLCRE/T_FLCRE_83_OCIPA21/1.0.0/VC_OCIPA21_AOLAO_722_TASK.html 
else 
 print 'Recurso /cobis/web/views/businessprocess/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                         

--Reimpresión De Documentos
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_REPRINT_DOCUMENT')
print'recursos de Reimpresión De Documentos -> %1!' + cast(@menuId as varchar)
if(@rsId2 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId2)  --/cobis/web/views/businessrules/.*>--<views/BUSIN/FLCRE/T_FLCRE_13_RPUME79/1.0.0/VC_RPUME79_RERNO_643_TASK.html 
else 
 print 'Recurso /cobis/web/views/businessrules/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                
if(@rsId5 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId5)  --/cobis/web/views/FINPM/.*>--<views/BUSIN/FLCRE/T_FLCRE_13_RPUME79/1.0.0/VC_RPUME79_RERNO_643_TASK.html 
else 
 print 'Recurso /cobis/web/views/FINPM/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId6 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId6)  --/cobis/web/views/LATFO/.*>--<views/BUSIN/FLCRE/T_FLCRE_13_RPUME79/1.0.0/VC_RPUME79_RERNO_643_TASK.html 
else 
 print 'Recurso /cobis/web/views/LATFO/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId7 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId7)  --/cobis/web/views/ADMIN/.*>--<views/BUSIN/FLCRE/T_FLCRE_13_RPUME79/1.0.0/VC_RPUME79_RERNO_643_TASK.html 
else 
 print 'Recurso /cobis/web/views/ADMIN/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId8 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId8)  --/cobis/web/views/inbox/.*>--<views/BUSIN/FLCRE/T_FLCRE_13_RPUME79/1.0.0/VC_RPUME79_RERNO_643_TASK.html 
else 
 print 'Recurso /cobis/web/views/inbox/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                        
if(@rsId9 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId9)  --/cobis/web/views//inbox/.*>--<views/BUSIN/FLCRE/T_FLCRE_13_RPUME79/1.0.0/VC_RPUME79_RERNO_643_TASK.html 
else 
 print 'Recurso /cobis/web/views//inbox/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                       
if(@rsId10 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId10)  --/cobis/web/views//customer/.*>--<views/BUSIN/FLCRE/T_FLCRE_13_RPUME79/1.0.0/VC_RPUME79_RERNO_643_TASK.html 
else 
 print 'Recurso /cobis/web/views//customer/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                   
if(@rsId11 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId11)  --/cobis/web/views/customer/.*>--<views/BUSIN/FLCRE/T_FLCRE_13_RPUME79/1.0.0/VC_RPUME79_RERNO_643_TASK.html 
else 
 print 'Recurso /cobis/web/views/customer/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId12 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId12)  --/cobis/web/views//LATFO/.*>--<views/BUSIN/FLCRE/T_FLCRE_13_RPUME79/1.0.0/VC_RPUME79_RERNO_643_TASK.html 
else 
 print 'Recurso /cobis/web/views//LATFO/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId13 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId13)  --/cobis/web/views/BUSIN/.*>--<views/BUSIN/FLCRE/T_FLCRE_13_RPUME79/1.0.0/VC_RPUME79_RERNO_643_TASK.html 
else 
 print 'Recurso /cobis/web/views/BUSIN/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                   
if(@rsId15 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId15)  --/cobis/web/views/CANES/.*>--<views/BUSIN/FLCRE/T_FLCRE_13_RPUME79/1.0.0/VC_RPUME79_RERNO_643_TASK.html 
else 
 print 'Recurso /cobis/web/views/CANES/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId19 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId19)  --/cobis/web/views/businessprocess/.*>--<views/BUSIN/FLCRE/T_FLCRE_13_RPUME79/1.0.0/VC_RPUME79_RERNO_643_TASK.html 
else 
 print 'Recurso /cobis/web/views/businessprocess/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                         

--Consulta de Reclamos 
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_SEARCH_CLAIMS')
print'recursos de Consulta de Reclamos -> %1!' + cast(@menuId as varchar)
if(@rsId5 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId5)  --/cobis/web/views/FINPM/.*>--<views/LATFO/CLAIM/T_CLAIM_41_AHMES22/1.0.0/VC_AHMES22_FSCHE_616_TASK.html 
else 
 print 'Recurso /cobis/web/views/FINPM/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId6 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId6)  --/cobis/web/views/LATFO/.*>--<views/LATFO/CLAIM/T_CLAIM_41_AHMES22/1.0.0/VC_AHMES22_FSCHE_616_TASK.html 
else 
 print 'Recurso /cobis/web/views/LATFO/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                    
if(@rsId7 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId7)  --/cobis/web/views/ADMIN/.*>--<views/LATFO/CLAIM/T_CLAIM_41_AHMES22/1.0.0/VC_AHMES22_FSCHE_616_TASK.html 
else 
 print 'Recurso /cobis/web/views/ADMIN/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId12 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId12)  --/cobis/web/views//LATFO/.*>--<views/LATFO/CLAIM/T_CLAIM_41_AHMES22/1.0.0/VC_AHMES22_FSCHE_616_TASK.html 
else 
 print 'Recurso /cobis/web/views//LATFO/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                  
if(@rsId19 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId19)  --/cobis/web/views/businessprocess/.*>--<views/LATFO/CLAIM/T_CLAIM_41_AHMES22/1.0.0/VC_AHMES22_FSCHE_616_TASK.html 
else 
 print 'Recurso /cobis/web/views/businessprocess/.* no encontrado para el menu %1' + cast(@menuId as varchar)

--Transacciones de Negocio
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_SEARCH_TRAN_MKCHK')
print'recursos de Transacciones de Negocio -> %1!' + cast(@menuId as varchar)
if(@rsId2 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId2)  --/cobis/web/views/businessrules/.*>--<views/MKCHK/ADMWS/T_ADMWS_85_NSACG04/1.0.0/VC_NSACG04_EASAD_863_TASK.html 
else 
 print 'Recurso /cobis/web/views/businessrules/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                            
if(@rsId6 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId6)  --/cobis/web/views/LATFO/.*>--<views/MKCHK/ADMWS/T_ADMWS_85_NSACG04/1.0.0/VC_NSACG04_EASAD_863_TASK.html 
else 
 print 'Recurso /cobis/web/views/LATFO/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId12 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId12)  --/cobis/web/views//LATFO/.*>--<views/MKCHK/ADMWS/T_ADMWS_85_NSACG04/1.0.0/VC_NSACG04_EASAD_863_TASK.html 
else 
 print 'Recurso /cobis/web/views//LATFO/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId18 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId18)  --/cobis/web/views/MKCHK/.*>--<views/MKCHK/ADMWS/T_ADMWS_85_NSACG04/1.0.0/VC_NSACG04_EASAD_863_TASK.html 
else 
 print 'Recurso /cobis/web/views/MKCHK/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                   

--Administrador de Secciones 
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_SECTION_ADMINISTRATOR')
print'recursos de Administrador de Secciones -> %1!' + cast(@menuId as varchar)
if(@rsId2 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId2)  --/cobis/web/views/businessrules/.*>--<views/admin-clientviewer/admin-clientviewer-tree-page.html 
else 
 print 'Recurso /cobis/web/views/businessrules/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId6 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId6)  --/cobis/web/views/LATFO/.*>--<views/admin-clientviewer/admin-clientviewer-tree-page.html 
else 
 print 'Recurso /cobis/web/views/LATFO/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId12 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId12)  --/cobis/web/views//LATFO/.*>--<views/admin-clientviewer/admin-clientviewer-tree-page.html 
else 
 print 'Recurso /cobis/web/views//LATFO/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId14 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId14)  --/cobis/web/views/clientviewer/.*>--<views/admin-clientviewer/admin-clientviewer-tree-page.html 
else 
 print 'Recurso /cobis/web/views/clientviewer/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                           
if(@rsId16 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId16)  --/cobis/web/views/admin-clientviewer/.*>--<views/admin-clientviewer/admin-clientviewer-tree-page.html 
else 
 print 'Recurso /cobis/web/views/admin-clientviewer/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                     

--Variables y Programas  
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_VARIABLES_PROGRAMS')
print'recursos de Variables y Programas -> %1!' + cast(@menuId as varchar)
if(@rsId2 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId2)  --/cobis/web/views/businessrules/.*>--<views/businessrules/container-businessrules.html 
else 
 print 'Recurso /cobis/web/views/businessrules/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                     
if(@rsId14 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId14)  --/cobis/web/views/clientviewer/.*>--<views/businessrules/container-businessrules.html 
else 
 print 'Recurso /cobis/web/views/clientviewer/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                     
if(@rsId16 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId16)  --/cobis/web/views/admin-clientviewer/.*>--<views/businessrules/container-businessrules.html 
else 
 print 'Recurso /cobis/web/views/admin-clientviewer/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                               

--Vista Consolidada
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_VCC')
print'recursos de Vista Consolidada -> %1!' + cast(@menuId as varchar)
if(@rsId2 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId2)  --/cobis/web/views/businessrules/.*>--<views/clientviewer/container-clientviewer.html 
else 
 print 'Recurso /cobis/web/views/businessrules/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                       
if(@rsId5 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId5)  --/cobis/web/views/FINPM/.*>--<views/clientviewer/container-clientviewer.html 
else 
 print 'Recurso /cobis/web/views/FINPM/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId7 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId7)  --/cobis/web/views/ADMIN/.*>--<views/clientviewer/container-clientviewer.html 
else 
 print 'Recurso /cobis/web/views/ADMIN/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId10 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId10)  --/cobis/web/views//customer/.*>--<views/clientviewer/container-clientviewer.html 
else 
 print 'Recurso /cobis/web/views//customer/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                          
if(@rsId11 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId11)  --/cobis/web/views/customer/.*>--<views/clientviewer/container-clientviewer.html 
else 
 print 'Recurso /cobis/web/views/customer/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                           
if(@rsId13 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId13)  --/cobis/web/views/BUSIN/.*>--<views/clientviewer/container-clientviewer.html 
else 
 print 'Recurso /cobis/web/views/BUSIN/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId14 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId14)  --/cobis/web/views/clientviewer/.*>--<views/clientviewer/container-clientviewer.html 
else 
 print 'Recurso /cobis/web/views/clientviewer/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                       
if(@rsId15 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId15)  --/cobis/web/views/CANES/.*>--<views/clientviewer/container-clientviewer.html 
else 
 print 'Recurso /cobis/web/views/CANES/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                  
if(@rsId16 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId16)  --/cobis/web/views/admin-clientviewer/.*>--<views/clientviewer/container-clientviewer.html 
else 
 print 'Recurso /cobis/web/views/admin-clientviewer/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                 
if(@rsId19 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId19)  --/cobis/web/views/businessprocess/.*>--<views/clientviewer/container-clientviewer.html 
else 
 print 'Recurso /cobis/web/views/businessprocess/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                        

--Editor de Workflow
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_WORKFLOW_EDITOR')
print'recursos de Editor de Workflow -> %1!' + cast(@menuId as varchar)
if(@rsId2 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId2)  --/cobis/web/views/businessrules/.*>--<views/workflow/workflow-tree-process-page.html 
else 
 print 'Recurso /cobis/web/views/businessrules/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                       
if(@rsId4 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId4)  --/cobis/web/views/workflow/.*>--<views/workflow/workflow-tree-process-page.html 
else 
 print 'Recurso /cobis/web/views/workflow/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                            
if(@rsId6 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId6)  --/cobis/web/views/LATFO/.*>--<views/workflow/workflow-tree-process-page.html 
else 
 print 'Recurso /cobis/web/views/LATFO/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId10 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId10)  --/cobis/web/views//customer/.*>--<views/workflow/workflow-tree-process-page.html 
else 
 print 'Recurso /cobis/web/views//customer/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                          
if(@rsId11 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId11)  --/cobis/web/views/customer/.*>--<views/workflow/workflow-tree-process-page.html 
else 
 print 'Recurso /cobis/web/views/customer/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                           
if(@rsId12 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId12)  --/cobis/web/views//LATFO/.*>--<views/workflow/workflow-tree-process-page.html 
else 
 print 'Recurso /cobis/web/views//LATFO/.* no encontrado para el menu %1' + cast(@menuId as varchar)
if(@rsId17 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId17)  --/cobis/web/views//workflow/.*>--<views/workflow/workflow-tree-process-page.html 
else 
 print 'Recurso /cobis/web/views//workflow/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                          

--Estadísticas
select @menuId=(select me_id from cobis..cew_menu
					where me_name='MNU_WORKFLOW_STATISTICS')
print'recursos de Estadísticas -> %1!' + cast(@menuId as varchar)
if(@rsId2 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId2)  --/cobis/web/views/businessrules/.*>--<views/workflow/workflow-container-statistics.html 
else 
 print 'Recurso /cobis/web/views/businessrules/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                    
if(@rsId4 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId4)  --/cobis/web/views/workflow/.*>--<views/workflow/workflow-container-statistics.html 
else 
 print 'Recurso /cobis/web/views/workflow/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                         
if(@rsId10 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId10)  --/cobis/web/views//customer/.*>--<views/workflow/workflow-container-statistics.html 
else 
 print 'Recurso /cobis/web/views//customer/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                       
if(@rsId11 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId11)  --/cobis/web/views/customer/.*>--<views/workflow/workflow-container-statistics.html 
else 
 print 'Recurso /cobis/web/views/customer/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                        
if(@rsId14 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId14)  --/cobis/web/views/clientviewer/.*>--<views/workflow/workflow-container-statistics.html 
else 
 print 'Recurso /cobis/web/views/clientviewer/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                    
if(@rsId16 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId16)  --/cobis/web/views/admin-clientviewer/.*>--<views/workflow/workflow-container-statistics.html 
else 
 print 'Recurso /cobis/web/views/admin-clientviewer/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                              
if(@rsId17 is not null) 
 insert into cew_menu_resource(mr_id_menu, mr_id_resource) values(@menuId,@rsId17)  --/cobis/web/views//workflow/.*>--<views/workflow/workflow-container-statistics.html 
else 
 print 'Recurso /cobis/web/views//workflow/.* no encontrado para el menu %1' + cast(@menuId as varchar)                                                                                                       
	
go


--Descripciones de los menus
print'Actualiza descripciones de los menus'

update cew_menu set me_description='Vista Consolidada' where me_name='MNU_VCC'                                                                                                                                                                                  
update cew_menu set me_description='Administrador de Vista Consolidada' where me_name='MNU_ADMIN_VCC'                                                                                                                                                           
update cew_menu set me_description='Sección de Contenidos' where me_name='MNU_CONTENT_SECTION'                                                                                                                                                                  
update cew_menu set me_description='Seguridad Sección de Contenidos' where me_name='MNU_CONTENT_SECTION_SECURITY'                                                                                                                                               
update cew_menu set me_description='Administrador de Secciones' where me_name='MNU_SECTION_ADMINISTRATOR'                                                                                                                                                       
update cew_menu set me_description='Dtos y Propiedades' where me_name='MNU_DTOS_AND_PROPERTIES'
update cew_menu set me_description='Editor de Workflow' where me_name='MNU_WORKFLOW_EDITOR'                                                                                                                                                                     
update cew_menu set me_description='Estadísticas' where me_name='MNU_WORKFLOW_STATISTICS'                                                                                                                                                                       
update cew_menu set me_description='Sistemas y Subtipos' where me_name='MNU_GROUP_ADMINISTRATION'                                                                                                                                                               
update cew_menu set me_description='Variables y Programas' where me_name='MNU_VARIABLES_PROGRAMS'                                                                                                                                                               
update cew_menu set me_description='Editor de Políticas' where me_name='MNU_EDITOR_POLITICAS'                                                                                                                                                                   
update cew_menu set me_description='Seguridades de Reglas y Políticas' where me_name='MNU_BUSSINESS_RULES_ADMIN'                                                                                                                                                
update cew_menu set me_description='Consultas de Inbox' where me_name='MNU_INBOX_QUERY'                                                                                                                                                                         
update cew_menu set me_description='Supervisor Inbox' where me_name='MNU_CONTAINER_INBOX_SS'                                                                                                                                                                    
update cew_menu set me_description='Official Inbox' where me_name='MNU_CONTAINER_INBOX_FF'                                                                                                                                                                      
update cew_menu set me_description='MNU_REASIGNACION' where me_name='MNU_REASIGNACION'                                                                                                                                                                          
update cew_menu set me_description='Reimpresión De Documentos' where me_name='MNU_REPRINT_DOCUMENT'                                                                                                                                                             
update cew_menu set me_description='Categorias y SubCategorias' where me_name='MNU_CAT_SUBCAT'                                                                                                                                                                  
update cew_menu set me_description='Consulta de Reclamos' where me_name='MNU_SEARCH_CLAIMS'                                                                                                                                                                     
update cew_menu set me_description='Transacciones de Negocio' where me_name='MNU_SEARCH_TRAN_MKCHK'                                                                                                                                                             
update cew_menu set me_description='Administrador de Productos Financieros' where me_name='MNU_APF'
update cew_menu set me_description='Listado de Operaciones Candidatas' where me_name='MNU_QUER_PUNISHMENT'                                                                                                                                                      
update cew_menu set me_description='Consolidación de Solicitudes de Castigo' where me_name='MNU_GRP_PENALIZATION'                                                                                                                                               
update cew_menu set me_description='Administrador de men·' where me_name='ADMCEW.MENU_MANAGER'                                                                                                                                                                  

go