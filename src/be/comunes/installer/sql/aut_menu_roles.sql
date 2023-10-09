use cobis
go

IF OBJECT_ID ('aut_menu_tmp') IS NOT NULL
	DROP TABLE aut_menu_tmp
GO

create table aut_menu_tmp(
menu   varchar(50),
id_rol tinyint
)

declare @w_id_rol int, @w_menu varchar(100),@w_rol tinyint
--Administrador
select @w_id_rol = ro_rol from cobis..ad_rol
where ro_descripcion ='ADMINISTRADOR'

insert into aut_menu_tmp values ('MNU_APF', @w_id_rol)
insert into aut_menu_tmp values ('MNU_WORKFLOW_EDITOR', @w_id_rol)
insert into aut_menu_tmp values ('MNU_WORKFLOW_STATISTICS', @w_id_rol)
insert into aut_menu_tmp values ('MNU_GROUP_ADMINISTRATION', @w_id_rol)
insert into aut_menu_tmp values ('MNU_VARIABLES_PROGRAMS', @w_id_rol)
insert into aut_menu_tmp values ('MNU_EDITOR_POLITICAS', @w_id_rol)
insert into aut_menu_tmp values ('MNU_BUSSINESS_RULES_ADMIN', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ADMIN_VCC', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_MANTENIMIENTO_PAG', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_VALUES_RATES', @w_id_rol)
insert into aut_menu_tmp values ('MNU_RLATION_CUSTOMER', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ADDRESS', @w_id_rol)
insert into aut_menu_tmp values ('MNU_REFERENCES', @w_id_rol)
insert into aut_menu_tmp values ('MNU_BUSINESS', @w_id_rol)
insert into aut_menu_tmp values ('MNU_LOANGROUP', @w_id_rol)
insert into aut_menu_tmp values ('MNU_LOANGROUPUP', @w_id_rol)
insert into aut_menu_tmp values ('MNU_CONTAINER_INBOX_SS', @w_id_rol)
insert into aut_menu_tmp values ('MNU_CONTENT_SECTION', @w_id_rol)
insert into aut_menu_tmp values ('MNU_CONTENT_SECTION_SECURITY', @w_id_rol)
insert into aut_menu_tmp values ('MNU_SECTION_ADMINISTRATOR', @w_id_rol)
insert into aut_menu_tmp values ('MNU_DTOS_AND_PROPERTIES', @w_id_rol)
insert into aut_menu_tmp values ('ADMCEW.MENU_MANAGER', @w_id_rol)
insert into aut_menu_tmp values ('MNU_CAT_SUBCAT', @w_id_rol)
insert into aut_menu_tmp values ('MNU_SEARCH_CLAIMS', @w_id_rol)
insert into aut_menu_tmp values ('MNU_SEARCH_TRAN_MKCHK', @w_id_rol)
--insert into aut_menu_tmp values ('MNU_ASSETS_DETAILSAHO', @w_id_rol)




--'FUNCIONARIO OFICINA'
SELECT @w_id_rol=''
SELECT @w_id_rol = ro_rol FROM cobis..ad_rol
WHERE ro_descripcion ='FUNCIONARIO OFICINA'
insert into aut_menu_tmp values ('MNU_VCC', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_DETAILSAHO', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_IMPDISBURS', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_IMPDOC', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_PROYCUOTA', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_QUERYSGENERALINFORMATION', @w_id_rol)
insert into aut_menu_tmp values ('MNU_WARRANTIESQUERY_GENERAL', @w_id_rol)
insert into aut_menu_tmp values ('MNU_INBOX_QUERY', @w_id_rol)
insert into aut_menu_tmp values ('MNU_REPRINT_DOCUMENT', @w_id_rol)
insert into aut_menu_tmp values ('MNU_CONTAINER_INBOX_SS', @w_id_rol)
insert into aut_menu_tmp values ('MNU_CONTAINER_INBOX_FF', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_CAMBIOEST', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_CLAUSE', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_EXTENDSQUONTA', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_INGREOTROCARGO', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_READJUSTMENT', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_REVERSE', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_SLDRT_PYMNT', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_VALDATE', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_DESEMBOLSO', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_PAYMENTS', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_RENOVACIONES', @w_id_rol)
insert into aut_menu_tmp values ('MNU_WARR_MANT_MODIFICATION', @w_id_rol)
insert into aut_menu_tmp values ('MNU_WARR_MANT_CREATION', @w_id_rol)
insert into aut_menu_tmp values ('MNU_PROSPECTS', @w_id_rol)
insert into aut_menu_tmp values ('MNU_CSTMR_SEACHCUSTOMER', @w_id_rol)
insert into aut_menu_tmp values ('MNU_LEGAL_PERSON', @w_id_rol)
insert into aut_menu_tmp values ('MNU_QUERY_DOCUMENTS', @w_id_rol)
insert into aut_menu_tmp values ('MNU_QUERY_DOCUMENTS_GRP', @w_id_rol)
insert into aut_menu_tmp values ('MNU_QUERY_DOCUMENTS_FILTER', @w_id_rol)
insert into aut_menu_tmp values ('MNU_LCR_BLOCK', @w_id_rol)


--'CONSULTA'
SELECT @w_id_rol=''
SELECT @w_id_rol = ro_rol FROM cobis..ad_rol
WHERE ro_descripcion ='CONSULTA'
insert into aut_menu_tmp values ('MNU_ASSETS_DETAILSAHO', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_IMPDISBURS', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_IMPDOC', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_PROYCUOTA', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_QUERYSGENERALINFORMATION', @w_id_rol)
insert into aut_menu_tmp values ('MNU_WARRANTIESQUERY_GENERAL', @w_id_rol)
insert into aut_menu_tmp values ('MNU_INBOX_QUERY', @w_id_rol)
insert into aut_menu_tmp values ('MNU_REPRINT_DOCUMENT', @w_id_rol)
insert into aut_menu_tmp values ('MNU_CONTAINER_INBOX_SS', @w_id_rol)

--'ASESOR'
SELECT @w_id_rol=''
SELECT @w_id_rol = ro_rol FROM cobis..ad_rol
WHERE ro_descripcion ='ASESOR'
insert into aut_menu_tmp values ('MNU_ASSETS_DETAILSAHO', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_IMPDISBURS', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_IMPDOC', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_PROYCUOTA', @w_id_rol)
insert into aut_menu_tmp values ('MNU_ASSETS_QUERYSGENERALINFORMATION', @w_id_rol)
insert into aut_menu_tmp values ('MNU_WARRANTIESQUERY_GENERAL', @w_id_rol)
insert into aut_menu_tmp values ('MNU_INBOX_QUERY', @w_id_rol)
insert into aut_menu_tmp values ('MNU_REPRINT_DOCUMENT', @w_id_rol)
insert into aut_menu_tmp values ('MNU_CONTAINER_INBOX_SS', @w_id_rol)
insert into aut_menu_tmp values ('MNU_QUERY_DOCUMENTS', @w_id_rol)
insert into aut_menu_tmp values ('MNU_QUERY_DOCUMENTS_GRP', @w_id_rol)
insert into aut_menu_tmp values ('MNU_QUERY_DOCUMENTS_FILTER', @w_id_rol)

--Programa que autoriza
exec sp_add_menu_role


--BORRADO DE TABLA TEMPORAL
IF OBJECT_ID ('aut_menu_tmp') IS NOT NULL
	DROP TABLE aut_menu_tmp

go

