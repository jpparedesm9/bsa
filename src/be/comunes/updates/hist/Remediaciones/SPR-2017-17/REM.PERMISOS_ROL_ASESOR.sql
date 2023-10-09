
use cobis
go
      

declare @w_id_producto			int,
		@w_role				    int,
		@w_tipo					char(1),
		@w_moneda			    SMALLINT,
		@w_estado				CHAR(1)
		

 
select @w_role = ro_rol
  from cobis..ad_rol
 where ro_descripcion = 'ASESOR'

select @w_tipo		= 'R'
select @w_moneda   	= 0
SELECT @w_estado	= 'V'

 
if @@rowcount = 1 and @w_role is not null
begin
			 
	insert into cew_menu_role (mro_id_menu, mro_id_role)
    select me_id, @w_role
	  from cew_menu 
	 where me_name in ('MNU_OPER', 'MNU_INBOX', 'MNU_CONTAINER_INBOX_FF', 'MNU_VCC')
	   AND me_id NOT IN (SELECT mro_id_menu FROM cew_menu_role WHERE mro_id_role = @w_role)
	 
	insert into cew_resource_rol (rro_id_resource, rro_id_rol)
	select re_id, @w_role
	  from cew_resource
	  where re_pattern in ('/cobis/web/views//customer/.*',
	  '/cobis/web/views/customer/.*',
	  '/cobis/web/views/clientviewer/.*',
	  '/cobis/web/views/inbox/.*',
	  '/cobis/web/views//inbox/.*',
	  '/cobis/web/views/businessrules/.*',
	  '/cobis/web/views/LATFO/.*',
	  '/cobis/web/views//LATFO/.*',
	  '/cobis/web/views/BUSIN/.*',
	  '/cobis/web/views/businessprocess/.*')
	    AND re_id NOT IN (SELECT rro_id_resource FROM cew_resource_rol WHERE rro_id_rol = @w_role)
	  
	select @w_id_producto = pd_producto
      from cl_producto 
     where pd_descripcion = 'WORKFLOW'
 
	if @w_id_producto is not null
	begin
		insert into ad_servicio_autorizado
		select ms_servicio, @w_role, @w_id_producto, 'R', 0, getdate(),'V',getdate()
		from cew_menu_service
		where ms_id_menu in (select me_id 
							   from cew_menu 
							  where me_name in ('MNU_INBOX', 'MNU_CONTAINER_INBOX_FF'))
		  AND ms_servicio NOT IN (SELECT ts_servicio from ad_servicio_autorizado WHERE ts_rol = @w_role) 
							  
		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
		select @w_id_producto, @w_tipo, @w_moneda, mt_transaccion, @w_role, getdate(), 1, @w_estado, getdate()
		  from cew_menu_transaccion
		 where mt_id_menu in (select me_id 
							   from cew_menu 
							  where me_name in ('MNU_INBOX', 'MNU_CONTAINER_INBOX_FF'))
			AND mt_transaccion NOT IN (SELECT ta_transaccion FROM ad_tr_autorizada WHERE ta_rol = @w_role)
			 
	end
	
	select @w_id_producto = pd_producto
      from cl_producto 
     where pd_descripcion = 'VISTA CONSOLIDADA DE CLIENTES'
 
	if @w_id_producto is not null
	begin
		insert into ad_servicio_autorizado
		select ms_servicio, @w_role, @w_id_producto, 'R', 0, getdate(),'V',getdate()
		  from cew_menu_service
		 where ms_id_menu in (select me_id 
								from cew_menu 
							    where me_name in ('MNU_VCC'))
		  AND ms_servicio NOT IN (SELECT ts_servicio from ad_servicio_autorizado WHERE ts_rol = @w_role) 

		insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
		select @w_id_producto, @w_tipo, @w_moneda, mt_transaccion, @w_role, getdate(), 1, @w_estado, getdate()
		  from cew_menu_transaccion
		 where mt_id_menu in (select me_id 
							   from cew_menu 
							  where me_name in ('MNU_VCC'))
		   AND mt_transaccion NOT IN (SELECT ta_transaccion FROM ad_tr_autorizada WHERE ta_rol = @w_role)
	end  
		 
end
	 
	 