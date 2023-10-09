

use cobis
go

DECLARE @w_menu_parent_id INT,
        @w_menu_id INT,
        @w_producto int,
        @w_rol int,
        @w_menu_order int 

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
    select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
    insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
    values (@w_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'


SELECT @w_menu_parent_id = me_id FROM cew_menu WHERE me_name = 'MNU_FRONTOFFICE'
SELECT @w_menu_order = isnull(max(me_id),0) FROM cew_menu WHERE me_id_parent = @w_menu_parent_id

select @w_producto = pd_producto from cl_producto where pd_descripcion = 'ADMINISTRACION'

if @w_menu_parent_id is not null
begin
    --MENU CREACION DE GRUPOS
    if not exists (select 1 from cew_menu where me_name = 'MNU_LOANGROUP')
    begin
        SELECT @w_menu_id = isnull( max(me_id), 0 ) + 1 FROM cew_menu
        SELECT @w_menu_order = isnull(max(me_id),0) FROM cew_menu WHERE me_id_parent = @w_menu_parent_id
        INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option)
        VALUES (@w_menu_id, @w_menu_parent_id, 'MNU_LOANGROUP', 1, 'views/LOANS/GROUP/T_GROUPCOMPOIET_974/1.0.0/VC_GROUPCOMOS_387974_TASK.html?mode=1', 5, 
        @w_producto, 0)
    end    
    SELECT @w_menu_id = me_id from cew_menu where me_name = 'MNU_LOANGROUP'    
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
        insert into cew_menu_role values (@w_menu_id, @w_rol)
    end
    
	--MENU MANTENIMIENTO DE GRUPOS
    if not exists (select 1 from cew_menu where me_name = 'MNU_LOANGROUPUP')
    begin
        SELECT @w_menu_id = isnull( max(me_id), 0 ) + 1 FROM cew_menu
        SELECT @w_menu_order = isnull(max(me_id),0) FROM cew_menu WHERE me_id_parent = @w_menu_parent_id
        INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option)
        VALUES (@w_menu_id, @w_menu_parent_id, 'MNU_LOANGROUPUP', 1, 'views/LOANS/GROUP/T_GROUPCOMPOIET_974/1.0.0/VC_GROUPCOMOS_387974_TASK.html?mode=2', 6, 
        @w_producto, 0)
    end    
    SELECT @w_menu_id = me_id from cew_menu where me_name = 'MNU_LOANGROUPUP'    
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
        insert into cew_menu_role values (@w_menu_id, @w_rol)
    end
	
	
	--SELECT @w_menu_parent_id = me_id FROM cew_menu WHERE me_name = 'MNU_CUSTOMER_ADM'
	--MENU NEGOCIOS DEL CLIENTE
   /* if not exists (select 1 from cew_menu where me_name = 'MNU_BUSINESS')
    begin
        SELECT @w_menu_id = isnull( max(me_id), 0 ) + 1 FROM cew_menu
        SELECT @w_menu_order = isnull(max(me_id),0) FROM cew_menu WHERE me_id_parent = @w_menu_parent_id
		INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option)
		VALUES (@w_menu_id, @w_menu_parent_id, 'MNU_BUSINESS', 1, 'views/CSTMR/CSTMR/T_BUSINESSFMWNQ_114/1.0.0/VC_BUSINESSPR_115114_TASK.html', 7,
		@w_producto, 0)
    end    
    SELECT @w_menu_id = me_id from cew_menu where me_name = 'MNU_BUSINESS'    
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
        insert into cew_menu_role values (@w_menu_id, @w_rol)
    end
	
	--MENU REFERENCIAS DEL CLIENTE
    if not exists (select 1 from cew_menu where me_name = 'MNU_REFERENCES')
    begin
        SELECT @w_menu_id = isnull( max(me_id), 0 ) + 1 FROM cew_menu
        SELECT @w_menu_order = isnull(max(me_id),0) FROM cew_menu WHERE me_id_parent = @w_menu_parent_id
		INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option)
		VALUES (@w_menu_id, @w_menu_parent_id, 'MNU_REFERENCES', 1, 'views/CSTMR/CSTMR/T_REFERENCESOWS_647/1.0.0/VC_REFERENCSS_358647_TASK.html', 8, @w_producto, 0)
    end    
    SELECT @w_menu_id = me_id from cew_menu where me_name = 'MNU_REFERENCES'    
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
        insert into cew_menu_role values (@w_menu_id, @w_rol)
    end
	
	--MENU DIRECCIONES DEL CLIENTE
    if not exists (select 1 from cew_menu where me_name = 'MNU_ADDRESS')
    begin
        SELECT @w_menu_id = isnull( max(me_id), 0 ) + 1 FROM cew_menu
        SELECT @w_menu_order = isnull(max(me_id),0) FROM cew_menu WHERE me_id_parent = @w_menu_parent_id
		INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option)
		VALUES (@w_menu_id, @w_menu_parent_id, 'MNU_ADDRESS', 1, 'views/CSTMR/CSTMR/T_ADDRESSKSQYAJ_769/1.0.0/VC_ADDRESSYWA_591769_TASK.html', 9, @w_producto, 0)
    end    
    SELECT @w_menu_id = me_id from cew_menu where me_name = 'MNU_ADDRESS'    
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
        insert into cew_menu_role values (@w_menu_id, @w_rol)
    end
	*/
end
else
begin
    print 'No existe el menu padre: MNU_FRONTOFFICE'
end


---prospectos
SELECT @w_menu_parent_id = me_id FROM cew_menu WHERE me_name = 'MNU_CUSTOMER_OPER'

 if not exists (select 1 from cew_menu where me_name = 'MNU_PROSPECTS')
    begin
        SELECT @w_menu_id = isnull( max(me_id), 0 ) + 1 FROM cew_menu
        SELECT @w_menu_order = isnull(max(me_id),0) FROM cew_menu WHERE me_id_parent = @w_menu_parent_id
		INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option)
		VALUES (@w_menu_id, @w_menu_parent_id, 'MNU_PROSPECTS', 1, 'views/CSTMR/CSTMR/T_PROSPECTCOOSS_684/1.0.0/VC_PROSPECTMI_213684_TASK.html', 9, @w_producto, 0)
    end    
    SELECT @w_menu_id = me_id from cew_menu where me_name = 'MNU_PROSPECTS'    
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
        insert into cew_menu_role values (@w_menu_id, @w_rol)
    end
--------	

 if not exists (select 1 from cew_menu where me_name = 'MNU_CSTMR_SEACHCUSTOMER')
 select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'
    begin
        SELECT @w_menu_id = isnull( max(me_id), 0 ) + 1 FROM cew_menu
        SELECT @w_menu_order = isnull(max(me_id),0) FROM cew_menu WHERE me_id_parent = @w_menu_parent_id
		INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option)
		VALUES (@w_menu_id, @w_menu_parent_id, 'MNU_CSTMR_SEACHCUSTOMER', 1, 'views/CSTMR/CSTMR/T_CUSTOMERCOETP_680/1.0.0/VC_CUSTOMEROI_208680_TASK.html', 9, @w_producto, 0)
    end    
    SELECT @w_menu_id = me_id from cew_menu where me_name = 'MNU_CSTMR_SEACHCUSTOMER'    
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
        insert into cew_menu_role values (@w_menu_id, @w_rol)
    end	
	
-----
 if not exists (select 1 from cew_menu where me_name = 'MNU_CUSTOMER_UP_RFC_CURP')
 select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'
    begin
        SELECT @w_menu_id = isnull( max(me_id), 0 ) + 1 FROM cew_menu
        SELECT @w_menu_order = isnull(max(me_id),0) FROM cew_menu WHERE me_id_parent = @w_menu_parent_id
		INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
		VALUES (@w_menu_id, @w_menu_parent_id, 'MNU_CUSTOMER_UP_RFC_CURP', 1, 'views/CSTMR/CSTMR/T_CSTMRKOYOOADV_774/1.0.0/VC_MODIFICAIC_908774_TASK.html', 9, @w_producto, 0,'Actualización CURP y RFC')
    end    
    SELECT @w_menu_id = me_id from cew_menu where me_name = 'MNU_CUSTOMER_UP_RFC_CURP'    
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
        insert into cew_menu_role values (@w_menu_id, @w_rol)
    end	
	
----
if not exists (select 1 from cew_menu where me_name = 'MNU_CUSTOMER_ALERT')
	    begin
	        select @w_menu_id = isnull( max(me_id), 0 ) + 1 from cew_menu
	        select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
	        insert into dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	        values (@w_menu_id, @w_menu_parent_id, 'MNU_CUSTOMER_ALERT', 1,null, @w_menu_order, 
	        @w_producto, 0, 'Alertas de Riesgo')
	    end    
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_CUSTOMER_ALERT'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end

---
SELECT @w_menu_parent_id = me_id FROM cew_menu WHERE me_name = 'MNU_CUSTOMER_ALERT'

if not exists (select 1 from cew_menu where me_name = 'MNU_ALERT_PLDFT')
	    begin
	        select @w_menu_id = isnull( max(me_id), 0 ) + 1 from cew_menu
	        select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
	        insert into dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	        values (@w_menu_id, @w_menu_parent_id, 'MNU_ALERT_PLDFT', 1,'views/CSTMR/CSTMR/T_CSTMRZIMDHJYH_829/1.0.0/VC_ADDALERTSS_984829_TASK.html', @w_menu_order, 
	        @w_producto, 0, 'Alerta de PLD - FT')
	    end    
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_ALERT_PLDFT'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end
---
if not exists (select 1 from cew_menu where me_name = 'MNU_ALERT_VLZ')
	    begin
	        select @w_menu_id = isnull( max(me_id), 0 ) + 1 from cew_menu
	        select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
	        insert into dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	        values (@w_menu_id, @w_menu_parent_id, 'MNU_ALERT_VLZ', 1,'views/CSTMR/CSTMR/T_CSTMREXCVZKUD_480/1.0.0/VC_VIEWALERTT_687480_TASK.html?mode=2', @w_menu_order, 
	        @w_producto, 0, 'Alertas de Riesgo View')
	    end    
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_ALERT_VLZ'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end


go

if not exists (select 1 from cew_menu where me_name = 'MNU_EXCLUSION_LIST')
	    begin
		    SELECT @w_menu_parent_id =me_id_parent from cew_menu where me_name = 'MNU_PROSPECTS'
	        select @w_menu_id = isnull( max(me_id), 0 ) + 1 from cew_menu
	        select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
	        insert into dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	        values (@w_menu_id, @w_menu_parent_id, 'MNU_EXCLUSION_LIST', 1,'views\LOANS\GROUP\T_LOANSUAYYOAVM_556\1.0.0\VC_EXCLUSIOSL_682556_TASK.html', @w_menu_order, 
	        @w_producto, 0, 'Lista de Exclusion de Clientes')
	    end    
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_EXCLUSION_LIST'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end

-----------------------------------------------------------
----------------------  COLECTIVOS ------------------------
-----------------------------------------------------------

--- Alta Masiva Colectivos
select @w_menu_parent_id = me_id from cew_menu where me_name = 'MNU_CUSTOMER_OPER'

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'

if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES')
begin 
   if not exists (select 1 from cew_menu where me_name = 'MNU_ALTA_COLEC')
   begin
       select @w_menu_id    = isnull( max(me_id), 0 ) + 1 from cew_menu
       select @w_menu_order = isnull( max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
       insert into cobis..cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
       values (@w_menu_id, @w_menu_parent_id, 'MNU_ALTA_COLEC', 1,'views/CLCOL/CLTVO/T_CLCOLIQAJNDTG_333/1.0.0/VC_LOADCOLLEV_719333_TASK.html?mode=1', @w_menu_order, 
       @w_producto, 0, 'Alta masivo colectivos')
   end    
   select @w_menu_id = me_id from cew_menu where me_name = 'MNU_ALTA_COLEC'    
   if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
   begin
       insert into cew_menu_role values (@w_menu_id, @w_rol)
   end
end
else
begin
	
	select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
	
	if not exists (select 1 from cew_menu where me_name = 'MNU_ALTA_COLEC')
    begin
        select @w_menu_id = isnull( max(me_id), 0 ) + 1 from cew_menu
        select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
        insert into dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
        values (@w_menu_id, @w_menu_parent_id, 'MNU_ALTA_COLEC', 1,'views/CLCOL/CLTVO/T_CLCOLIQAJNDTG_333/1.0.0/VC_LOADCOLLEV_719333_TASK.html?mode=1', @w_menu_order, 
        @w_producto, 0, 'Alta masivo colectivos')
    end    
    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_ALTA_COLEC'    
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
        insert into cew_menu_role values (@w_menu_id, @w_rol)
    end
end

--- Alta Masiva Asesor

select @w_menu_parent_id = me_id from cew_menu where me_name = 'MNU_ASSETS'

if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES')
begin 
	if not exists (select 1 from cew_menu where me_name = 'MNU_ALTA_ADVISOR')
    begin
        select @w_menu_id    = isnull( max(me_id), 0 ) + 1 from cew_menu
        select @w_menu_order = isnull( max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
        insert into cobis..cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
        values (@w_menu_id, @w_menu_parent_id, 'MNU_ALTA_ADVISOR', 1,'views/CLCOL/CLTVO/T_CLCOLETZFPPIC_497/1.0.0/VC_LOADEXTERA_441497_TASK.html?mode=2', @w_menu_order, 
        @w_producto, 0, 'Alta masivo Asesor')
    end    
    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_ALTA_ADVISOR'    
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
        insert into cew_menu_role values (@w_menu_id, @w_rol)
    end
end
else
begin
	
	select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
	
	if not exists (select 1 from cew_menu where me_name = 'MNU_ALTA_ADVISOR')
    begin
        select @w_menu_id = isnull( max(me_id), 0 ) + 1 from cew_menu
        select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
        insert into cobis..cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
        values (@w_menu_id, @w_menu_parent_id, 'MNU_ALTA_ADVISOR', 1,'views/CLCOL/CLTVO/T_CLCOLETZFPPIC_497/1.0.0/VC_LOADEXTERA_441497_TASK.html?mode=2', @w_menu_order, 
        @w_producto, 0, 'Alta masivo Asesor')
    end    
    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_ALTA_ADVISOR'    
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
        insert into cew_menu_role values (@w_menu_id, @w_rol)
    end
end

--- Rol Asesor Colectivo
--Seleccion de Administracion como menu Padre
select @w_menu_parent_id = me_id from cew_menu where me_name = 'MNU_ADMIN'

if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES')
begin 
	if not exists (select 1 from cew_menu where me_name = 'MNU_ADVISOR_ROLE')
    begin
        select @w_menu_id    = isnull( max(me_id), 0 ) + 1 from cew_menu
        select @w_menu_order = isnull( max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
        insert into cobis..cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
        values (@w_menu_id, @w_menu_parent_id, 'MNU_ADVISOR_ROLE', 1,'views/CLCOL/CLTVO/T_CLCOLWGNHFDMI_872/1.0.0/VC_COLLECTIAV_943872_TASK.html', @w_menu_order, 
        @w_producto, 0, 'Rol Asesor Colectivo')
    end    
    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_ADVISOR_ROLE'    
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
        insert into cew_menu_role values (@w_menu_id, @w_rol)
    end
end
else
begin
	
	select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
	
	if not exists (select 1 from cew_menu where me_name = 'MNU_ADVISOR_ROLE')
    begin
        select @w_menu_id = isnull( max(me_id), 0 ) + 1 from cew_menu
        select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
        insert into cobis..cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
        values (@w_menu_id, @w_menu_parent_id, 'MNU_ADVISOR_ROLE', 1,'views/CLCOL/CLTVO/T_CLCOLWGNHFDMI_872/1.0.0/VC_COLLECTIAV_943872_TASK.html', @w_menu_order, 
        @w_producto, 0, 'Rol Asesor Colectivo')
    end    
    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_ADVISOR_ROLE'    
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
        insert into cew_menu_role values (@w_menu_id, @w_rol)
    end
end

-- ==================================================
-- Menu 'Validar Referencia'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'
SELECT @w_rol = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'SOCIO COMERCIAL'
select @w_menu_parent_id = null

IF EXISTS (SELECT 1 FROM cobis..ad_rol WHERE ro_descripcion = 'SOCIO COMERCIAL')
BEGIN
	IF NOT EXISTS (SELECT 1 FROM cew_menu WHERE me_name = 'MNU_VALIDAR_REFERENCIA')
	BEGIN
		PRINT 'Ingresa a crear el menu para la pantalla Validar Referencia'

		SELECT @w_menu_id = ISNULL(MAX(me_id), 0) + 1
		FROM cew_menu

		SELECT @w_menu_order = 1

		INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
		VALUES (@w_menu_id, @w_menu_parent_id, 'MNU_VALIDAR_REFERENCIA', 1, 'views/CSTMR/CSTMR/T_CSTMRKRGHIVHP_582/1.0.0/VC_VALIDATERE_626582_TASK.html', @w_menu_order, @w_producto, 0, 'Validar Referencia')
	END

	SELECT @w_menu_id = me_id
	FROM cew_menu
	WHERE me_name = 'MNU_VALIDAR_REFERENCIA'

	IF NOT EXISTS (
			SELECT 1
			FROM cew_menu_role
			WHERE mro_id_menu = @w_menu_id
				AND mro_id_role = @w_rol
			)
	BEGIN
		INSERT INTO cew_menu_role
		VALUES (@w_menu_id, @w_rol)
	END
END
go
-- ==================================================

/*Asigancion de rol a las vistas*/
USE cobis

declare @w_id_resource int, @w_rol INT,@w_cod int
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'
select 'Id_Role' = @w_rol

SELECT @w_cod=isnull(max(re_id),0)  FROM cobis..cew_resource

 
IF NOT EXISTS(SELECT 1  FROM cobis..cew_resource WHERE re_pattern= '/cobis/web/views/CLCOL/.*')
BEGIN
 PRINT 'a'
  INSERT INTO dbo.cew_resource (re_id, re_pattern)
  VALUES (@w_cod+1, '/cobis/web/views/CLCOL/.*')

END

select @w_id_resource = re_id from cobis..cew_resource where re_pattern = '/cobis/web/views/CLCOL/.*'
select 'Id_Resource' = @w_id_resource

IF NOT EXISTS(select 1 from cobis..cew_resource_rol where rro_id_resource = @w_id_resource and rro_id_rol = @w_rol)
BEGIN
 PRINT 'b'
insert into cobis..cew_resource_rol (rro_id_resource, rro_id_rol)
values (@w_id_resource, @w_rol)
END

--Rol Administrador
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'

IF NOT EXISTS(select 1 from cobis..cew_resource_rol where rro_id_resource = @w_id_resource and rro_id_rol = @w_rol)
BEGIN
   insert into cobis..cew_resource_rol (rro_id_resource, rro_id_rol)
   values (@w_id_resource, @w_rol)
END


--Pantallas Auditoria
use cobis
go

declare 
@w_me_id            int,
@w_me_parent        int,
@w_me_parent_1      int,
@w_rol              int,
@w_producto         int,
@w_moneda           int

declare @w_roles table(
   role         int,
   menu         int
)

declare @w_services table(
   servicio     varchar(500)
)

declare @w_servicio_autorizado table (
   servicio      varchar(500),
   rol           int,
   producto      int,
   tipo          char(1),
   moneda        int,
   fecha_aut     datetime,
   estado        char(1),
   fecha_ult_mod datetime
)

select @w_producto = pd_producto
from cl_producto
where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'


select @w_moneda = mo_moneda
from cl_moneda
where mo_descripcion = 'PESOS'

insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.GetCustomerCycleNumber')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.ReadTelephone')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchAddress')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchRelation')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchRelationPerson')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.FindPostalCode')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.ReadCustomerInfo')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.ReadDataCustomer')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchAddresBusiness')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchAddresProspectSan')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchAddressByHome')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchCustomerBusiness')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchCustomerReference')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchEconomicActivity')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchPepPerson')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchRelationClient')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchSpouseCustomer')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchTelephone')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchZipPostal')


select @w_me_id = isnull(max(me_id) ,0) +1 from cobis..cew_menu
select @w_me_parent   = me_id from cobis..cew_menu where me_name = 'MNU_CUSTOMER_OPER'
select @w_me_parent_1 = me_id from cobis..cew_menu where me_name = 'MNU_OPER'

insert into @w_roles
select ro_rol, 1
from ad_rol
where ro_descripcion not in 
( 'MESA DE OPERACIONES' , 
'ASESOR', 
'ASESOR MOVIL',
'ASESOR EXTERNO',
'CORRESPONSAL OXXO',
'PERFIL MOVIL',
'SCHEDULER CTS',
'CALL CENTER',
'CORRESPONSAL NO BANCARIO',
'OPERADOR SOFOME',
'COORDINADOR'
)

delete from cobis..ad_servicio_autorizado 
where ts_servicio in (select servicio from @w_services)
and ts_rol in (select role from @w_roles where menu = 1)


insert into @w_roles
select ro_rol, 2
from ad_rol
where ro_descripcion in ( 'MESA DE OPERACIONES' , 'ASESOR')

select * from @w_roles


delete cobis..cew_menu_role where mro_id_menu = 
(select me_id from cobis..cew_menu where me_name = 'MNU_CSTMR_SEACHCUSTOMER_QUERY')

delete cobis..cew_menu_role where mro_id_menu = 
(select me_id from cobis..cew_menu where me_name = 'MNU_CUSTOMER_OPER') 
and mro_id_role in (select role from @w_roles)

delete cobis..cew_menu_role where mro_id_menu = 
(select me_id from cobis..cew_menu where me_name = 'MNU_OPER') 
and mro_id_role in (select role from @w_roles)


delete cobis..cew_menu where me_name = 'MNU_CSTMR_SEACHCUSTOMER_QUERY'

if @w_me_parent is not null begin

   insert into cobis..cew_menu values (@w_me_id, @w_me_parent, 'MNU_CSTMR_SEACHCUSTOMER_QUERY', 1, 'views/CSTMR/CSTMR/T_CUSTOMERCOETP_680/1.0.0/VC_CUSTOMEROI_208680_TASK.html?modo=Q', 169, 2,0, 'Consulta Mantenimiento de Personas Naturales', null, 'CWC')
   
   insert into cobis..cew_menu_role 
   select @w_me_parent, role
   from @w_roles
   where menu = 1
   
   insert into cobis..cew_menu_role 
   select @w_me_parent_1, role
   from @w_roles
   where menu = 1
   
   insert into cobis..cew_menu_role 
   select @w_me_id, role
   from @w_roles
   where menu = 1
end



delete from cobis..ad_servicio_autorizado 
where ts_servicio in (select servicio from @w_services)
and ts_rol in (select role from @w_roles where menu = 1)

insert into @w_servicio_autorizado 
select servicio, role, @w_producto, 'R', @w_moneda, getdate(),'V', getdate()
from @w_services, @w_roles
where menu = 1

insert into ad_servicio_autorizado 
select * from @w_servicio_autorizado


delete cobis..cew_resource_rol 
where rro_id_resource in ( select  re_id 
                           from cew_resource where re_pattern in (
                           '/cobis/web/views/CSTMR/.*',
                           '/resources/CSTMR/.*',
                           '/cobis/web/views//customer/.*',
                           '/cobis/web/views/customer/.*',
						   '/cobis/web/views/inbox/.*',
						   '/cobis/web/views//inbox/.*'))
and rro_id_rol in (select role from @w_roles where menu = 1)

insert into cobis..cew_resource_rol
select  re_id, role
from cew_resource, @w_roles
where re_pattern in (
'/cobis/web/views/CSTMR/.*',
'/resources/CSTMR/.*',
'/cobis/web/views//customer/.*',
'/cobis/web/views/customer/.*',
'/cobis/web/views/inbox/.*',
'/cobis/web/views//inbox/.*')
and menu = 1


select @w_me_id  = null 
select @w_me_id = me_id 
from cobis..cew_menu 
where me_name = 'MNU_CSTMR_SEACHCUSTOMER'

if @w_me_id is not null begin
   delete cobis..cew_menu_role where mro_id_menu = (select me_id from cobis..cew_menu where me_name = 'MNU_CSTMR_SEACHCUSTOMER')
   

   insert into cobis..cew_menu_role 
   select @w_me_id, role
   from @w_roles
   where menu = 2
end
go