--*******************************  Respaldo de tablas de menu  *****************************
use cobis
go

--BORRAR MENUES
delete cew_menu_role
from cew_menu 
where mro_id_menu = me_id
and me_name in ('MNU_WARRANTIESQUERY','MNU_WARR_MANT','MNU_ASSETS_MANTN','MNU_ASSETS_TRNSC', 'MNU_PROSPECTSMNU', 'MNU_GROUPMNU','MNU_MAKER_CHECKER')
go

--*******************************  Actualización de menú para Administración y Consulta  *****************************

declare @w_menu_id int

--MENU PRINCIPAL
if not exists (select 1 from cobis..cew_menu where me_name = 'MNU_ADMIN')
begin
    select @w_menu_id = isnull(max(me_id),0)+1 from cobis..cew_menu
    insert into cobis..cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description) values (@w_menu_id, NULL, 'MNU_ADMIN', 1, null, 1, 0, 0, '')
end

if not exists (select 1 from cobis..cew_menu where me_name = 'MNU_OPER')
begin
    select @w_menu_id = @w_menu_id +1 
    insert into cobis..cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description) values (@w_menu_id, NULL, 'MNU_OPER', 1, null, 1, 0, 0, '')
end

if not exists (select 1 from cobis..cew_menu where me_name = 'MNU_QUERY')
begin
    select @w_menu_id = @w_menu_id +1
    insert into cobis..cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description) values (@w_menu_id, NULL, 'MNU_QUERY', 1, null, 1, 0, 0, '')
end
go

--MENU ADMINISTRADOR

declare @w_menu_id_parent int, @w_menu_id INT,@w_id_producto int

select @w_menu_id_parent = me_id from cobis..cew_menu where me_name = 'MNU_ADMIN'

--APF
update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 1
where me_name ='MNU_APF'

--WORKFLOW
update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 2
where me_name = 'MNU_WORKFLOW'

--REGLAS DE NEGOCIO
update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 3
where me_name = 'MNU_BUSINESS_RULES'

--ADMIN VCC
update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 4
where me_name = 'MNU_ADMIN_VCC'

--CARTERA
if not exists (select 1 from cobis..cew_menu where me_name = 'MNU_ASSETS_ADM')
begin
    select @w_id_producto	= isnull(pd_producto,0) from cobis..cl_producto where pd_abreviatura='CCA'
    select @w_menu_id = isnull(max(me_id),0)+1 from cobis..cew_menu
    insert into cobis..cew_menu ( me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description ) values (@w_menu_id, @w_menu_id_parent, 'MNU_ASSETS_ADM', 1, NULL, 5, @w_id_producto, 0, '' )
end

--PROSPECTOS
if not exists (select 1 from cobis..cew_menu where me_name = 'MNU_CUSTOMER_ADM')
begin
    select @w_id_producto	= isnull(pd_producto,0) from cobis..cl_producto where pd_abreviatura='MIS'
    select @w_menu_id = isnull(max(me_id),0)+1 from cobis..cew_menu
    insert into cobis..cew_menu ( me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description ) values (@w_menu_id, @w_menu_id_parent, 'MNU_CUSTOMER_ADM', 1, NULL, 6, @w_id_producto, 0, '' )
end

--GRUPOS
   
if not exists (select 1 from cobis..cew_menu where me_name ='MNU_GROUP_ADM')
begin
    select @w_id_producto	= isnull(pd_producto,0) from cobis..cl_producto where pd_abreviatura='MIS'
    select @w_menu_id = isnull(max(me_id),0)+1 from cobis..cew_menu
    insert into cobis..cew_menu ( me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description ) values (@w_menu_id, @w_menu_id_parent, 'MNU_GROUP_ADM', 1, NULL, 7, @w_id_producto, 0, '' )
end


--INBOX
   
if not exists (select 1 from cobis..cew_menu where me_name ='MNU_INBOX_ADM')
begin
    select @w_id_producto	= isnull(pd_producto,0) from cobis..cl_producto where pd_abreviatura='FPM'
    select @w_menu_id = isnull(max(me_id),0)+1 from cobis..cew_menu
    insert into cobis..cew_menu ( me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description ) values (@w_menu_id, @w_menu_id_parent, 'MNU_INBOX_ADM', 1, NULL, 8, @w_id_producto, 0, '' )
end


--CONTENIDOS
if not exists (select 1 from cobis..cew_menu where me_name ='MNU_CONTENT_ADM')
begin
    select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura='FPM'
    select @w_menu_id = isnull(max(me_id),0)+1 from cobis..cew_menu
    insert into cobis..cew_menu ( me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description ) values (@w_menu_id, @w_menu_id_parent, 'MNU_CONTENT_ADM', 1, NULL, 9, @w_id_producto, 0, '' )
end

--MENU MANAGER
update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 10
where me_name = 'ADMCEW.MENU_MANAGER'

--MAKER AND CHECKER
update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 11
where me_name = 'MNU_MAKER_CHECKER'

--GESTION DE RECLAMOS
update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 11
where me_name = 'MNU_MANAGEMENT_CLAIMS'

go
--******************************************************************************

--MENU ADMINISTRACION CARTERA
declare @w_menu_id_parent int

select @w_menu_id_parent = me_id from cobis..cew_menu
where me_name = 'MNU_ASSETS_ADM'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 1
where me_name = 'MNU_ASSETS_MANTENIMIENTO_PAG'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 2
where me_name = 'MNU_ASSETS_VALUES_RATES'

go

--MENU ADMINISTRACION PROSPECTO
declare @w_menu_id_parent int

select @w_menu_id_parent = me_id from cobis..cew_menu
where me_name = 'MNU_CUSTOMER_ADM'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 1
where me_name = 'MNU_RLATION_CUSTOMER'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 2
where me_name = 'MNU_ADDRESS'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 3
where me_name = 'MNU_REFERENCES'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 4
where me_name = 'MNU_BUSINESS'

GO

--MENU ADMINISTRACION GRUPO
declare @w_menu_id_parent int

select @w_menu_id_parent = me_id from cobis..cew_menu
where me_name = 'MNU_GROUP_ADM'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 1
where me_name = 'MNU_LOANGROUP'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 2
where me_name = 'MNU_LOANGROUPUP'
GO

--CONTENIDOS
declare @w_menu_id_parent int

select @w_menu_id_parent = me_id from cobis..cew_menu
where me_name = 'MNU_CONTENT_ADM'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 1
where me_name = 'MNU_CONTENT_SECTION'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 2
where me_name = 'MNU_CONTENT_SECTION_SECURITY'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 3
where me_name = 'MNU_SECTION_ADMINISTRATOR'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 4
where me_name = 'MNU_DTOS_AND_PROPERTIES'
GO

--INBOX
declare @w_menu_id_parent int

select @w_menu_id_parent = me_id from cobis..cew_menu
where me_name = 'MNU_INBOX_ADM'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 1
where me_name = 'MNU_CONTAINER_INBOX_SS'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 2
where me_name = 'MNU_REPRINT_DOCUMENT'

go
--************************************************MENU CONSULTA****************************
declare @w_menu_id_parent int, @w_menu_id INT,@w_id_producto tinyint

select @w_menu_id_parent = me_id from cobis..cew_menu where me_name = 'MNU_QUERY'

if not exists (select 1 from cobis..cew_menu where me_name = 'MNU_ASSETS_QUERY')
begin
    select @w_id_producto	= isnull(pd_producto,0) from cobis..cl_producto where pd_abreviatura='CCA'
    select @w_menu_id = isnull(max(me_id),0)+1 from cobis..cew_menu
    insert into cobis..cew_menu ( me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description ) values (@w_menu_id, @w_menu_id_parent, 'MNU_ASSETS_QUERY', 1, NULL, 1, @w_id_producto, 0, '' )
end

if not exists (select 1 from cobis..cew_menu where me_name = 'MNU_WRRNT_QUERY')
begin
    select @w_id_producto	= isnull(pd_producto,0) from cobis..cl_producto where pd_abreviatura='GAR'
    select @w_menu_id = @w_menu_id + 1
    insert into cobis..cew_menu ( me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description ) values (@w_menu_id, @w_menu_id_parent, 'MNU_WRRNT_QUERY', 1, NULL, 2, @w_id_producto, 0, '' )
end


if not exists (select 1 from cobis..cew_menu where me_name = 'MNU_INBOX_QUERY_MAIN')
begin
    select @w_id_producto	= isnull(pd_producto,0)  from cobis..cl_producto where pd_abreviatura='CWF'
    select @w_menu_id = @w_menu_id + 1
    insert into cobis..cew_menu ( me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description ) values (@w_menu_id, @w_menu_id_parent, 'MNU_INBOX_QUERY_MAIN', 1, NULL, 3, @w_id_producto, 0, '' )
end
go

--MENU CONSULTA - CARTERA
declare @w_menu_id_parent int

select @w_menu_id_parent = me_id from cobis..cew_menu
where me_name = 'MNU_ASSETS_QUERY'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 1
where me_name = 'MNU_ASSETS_QUERYSGENERALINFORMATION'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 2
where me_name = 'MNU_ASSETS_PROYCUOTA'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 3
where me_name = 'MNU_ASSETS_IMPDOC'


update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 4
where me_name = 'MNU_ASSETS_DETAILSAHO'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 5
where me_name = 'MNU_ASSETS_IMPDISBURS'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 6
where me_name = 'MNU_ASSETS_LOG_PROC_ORD_DEBITOS'
go

--MENU CONSULTA - GARANTÍAS
declare @w_menu_id_parent int

select @w_menu_id_parent = me_id from cobis..cew_menu
where me_name = 'MNU_WRRNT_QUERY'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 1
where me_name = 'MNU_WARRANTIESQUERY_GENERAL'
go

--MENU CONSULTA - INBOX

declare @w_menu_id_parent int

select @w_menu_id_parent = me_id from cobis..cew_menu
where me_name = 'MNU_INBOX_QUERY_MAIN'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 1
where me_name = 'MNU_INBOX_QUERY'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 2
where me_name = 'MNU_REPRINT_DOCUMENT'
go

--********************************** MENU OPERACIONES **********************************************************************************
declare @w_menu_id_parent int, @w_menu_id INT,@w_id_producto tinyint

select @w_menu_id_parent = me_id from cobis..cew_menu where me_name = 'MNU_OPER'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 1
where me_name = 'MNU_VCC'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 2
where me_name = 'MNU_INBOX'

if not exists (select 1 from cobis..cew_menu where me_name = 'MNU_CUSTOMER_OPER')
begin
    select @w_id_producto	= isnull(pd_producto,0) from cobis..cl_producto where pd_abreviatura='CCA'
    select @w_menu_id = isnull(max(me_id),0)+1 from cobis..cew_menu
    insert into cobis..cew_menu ( me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description ) values (@w_menu_id, @w_menu_id_parent, 'MNU_CUSTOMER_OPER', 1, NULL, 3, @w_id_producto, 0, '' )
end
else
begin
    update cobis..cew_menu
    set me_id_parent = @w_menu_id_parent,
    me_order     = 3
    where me_name = 'MNU_CUSTOMER_OPER'
end


update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 4
where me_name = 'MNU_ASSETS'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 5
where me_name = 'MNU_WARRANTIES'

go


--MENU OPERACIONES PROSPECTOS
declare @w_menu_id_parent int

select @w_menu_id_parent = me_id from cobis..cew_menu
where me_name = 'MNU_CUSTOMER_OPER'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 1
where me_name = 'MNU_PROSPECTS'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 2
where me_name = 'MNU_CSTMR_SEACHCUSTOMER'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 3
where me_name = 'MNU_LEGAL_PERSON'




go
--MENU INBOX
declare @w_menu_id_parent int

select @w_menu_id_parent = me_id from cobis..cew_menu
where me_name = 'MNU_INBOX'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 1
where me_name = 'MNU_CONTAINER_INBOX_FF'
go

--MENU OPERACIONES CARTERA
declare @w_menu_id_parent int

select @w_menu_id_parent = me_id from cobis..cew_menu
where me_name = 'MNU_ASSETS'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 1
where me_name = 'MNU_ASSETS_CAMBIOEST'


update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 2
where me_name = 'MNU_ASSETS_CLAUSE'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 3
where me_name = 'MNU_ASSETS_EXTENDSQUONTA'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 4
where me_name = 'MNU_ASSETS_INGREOTROCARGO'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 5
where me_name = 'MNU_ASSETS_READJUSTMENT'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 6
where me_name = 'MNU_ASSETS_REVERSE'

--update cobis..cew_menu
--set me_id_parent = @w_menu_id_parent,
--    me_order     = 7
--where me_name = 'MNU_ASSETS_SLDRT_PYMNT'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 8
where me_name = 'MNU_ASSETS_VALDATE'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 9
where me_name = 'MNU_ASSETS_DESEMBOLSO'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 10
where me_name = 'MNU_ASSETS_PAYMENTS'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 11
where me_name = 'MNU_ASSETS_RENOVACIONES'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 12
where me_name = 'MNU_FUND'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 13
where me_name = 'MNU_ASSETS_PAGO_GRUPALES_GRANTIA'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 14
where me_name = 'MNU_ASSETS_VOUCHER_MAIL'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 15
where me_name = 'MNU_ASSETS_CONCILIATION'

go

--MENU OPERACIONES CARTERA
declare @w_menu_id_parent int

select @w_menu_id_parent = me_id from cobis..cew_menu
where me_name = 'MNU_WARRANTIES'

update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 1
where me_name = 'MNU_WARR_MANT_CREATION'


update cobis..cew_menu
set me_id_parent = @w_menu_id_parent,
    me_order     = 2
where me_name = 'MNU_WARR_MANT_MODIFICATION'
go

--FIN ACTUALIZACION DE MENUS

--------------------------------------------------------------------------------------------------------------------------------------------------
--Borrar permisos de roles a Menús Front Office y Back Office 
delete from cobis..cew_menu_role
where mro_id_menu in (select me_id 
                        from cobis..cew_menu 
					   where me_name in ('MNU_FRONTOFFICE', 'MNU_BACK_OFFICE'))
go

--Autorización de los nuevos menus a Menú por Procesos
declare @w_rol int

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS'
 
if @w_rol is not null
begin	
	
	INSERT INTO cew_menu_role
	SELECT me_id, @w_rol
      FROM cew_menu
	 WHERE me_id not IN (SELECT mro_id_menu FROM cew_menu_role WHERE mro_id_role = @w_rol)
	 AND me_name NOT IN ('MNU_FRONTOFFICE', 'MNU_BACK_OFFICE','MNU_WARRANTIESQUERY','MNU_WARR_MANT','MNU_ASSETS_MANTN','MNU_ASSETS_TRNSC', 'MNU_PROSPECTSMNU', 'MNU_GROUPMNU')
	 --AND me_name NOT IN ('MNU_FRONTOFFICE', 'MNU_BACK_OFFICE','MNU_WARRANTIESQUERY','MNU_WARR_MANT','MNU_PROSPECTSMNU', 'MNU_GROUPMNU')
	   
end

go

