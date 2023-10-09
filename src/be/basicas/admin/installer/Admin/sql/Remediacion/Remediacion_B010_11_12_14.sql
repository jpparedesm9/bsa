/************************************************************************/
/*          MODIFICACIONES                                              */
/* 25/ABR/2016       ELO     Migracion SYBASE-SQLServer FAL             */
use cobis
go

-------------------------------------
-- Transaccion de Servicio - B011
-- para Autorización de Funcionalidades
-------------------------------------
print 'Registros de ts_adm_seguridades'
if exists (select 1 from ad_vistas_trnser 
           where vt_producto = 1
             and vt_tabla = 'ts_adm_seguridades' )
   delete ad_vistas_trnser 
           where vt_producto = 1
             and vt_tabla = 'ts_adm_seguridades'
go
insert into ad_vistas_trnser values (1 ,'cobis', 'ts_adm_seguridades', 'MANTENIMIENTO DE AUTORIZACION DE FUNCIONALIDADES', 'V', 'fecha', 'secuencia', 'clase',  'N', 'P', 'A',  null, 'usuario', 'terminal_s',  null,  NULL,null)--elo se aumenta null 
go

-------------------------------------
-- Parametro TDT - B012
-------------------------------------
print 'Parametro TDT'
-- Parametro TDT para controlar el tiempo de inactividad de CEN en comparacion 
-- con el valor campo ro_time_out de cada rol en la tabla cobis..ad_rol (en segundos).
-- Si el parametro es D, cierra la sesion, y si el valor es B, bloquea la estacion de trabajo Windows
if exists(select 1 from cl_parametro where pa_nemonico = 'TDT')
	delete from cl_parametro where pa_nemonico = 'TDT'
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_char, pa_producto )
values ('TDT', 'TIPO DE DESCONEXION TIMEOUT FRONT END', 'C', 'D', 'ADM' )
go

-------------------------------------
-- Parametro PCP - B014
-------------------------------------
print 'Parametro PCP'
if exists(select 1 from cl_parametro where pa_nemonico = 'PCP')
	delete from cl_parametro where pa_nemonico = 'PCP'
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_char, pa_producto )
values ('PCP', 'COMPLEJIDAD DE PASSWORD', 'C', '100', 'ADM' )




-------------------------------------
-- Pantalla Transacciones por Funcionalidad
-------------------------------------
-- Registros para: PI.CCA.FOperacion    

declare @w_la_label varchar(255),@w_prod_name varchar(20),@w_rol_des varchar(255),@w_pa_parent varchar(255),@w_pa_name varchar(255),@w_orden int,@w_mo_name varchar(255),@w_co_name varchar(255),@w_co_class varchar(255),@w_co_namespace varchar(255)
select  @w_la_label 	= 'Transacciones por Funcionalidad',
		@w_prod_name 	= 'M-ADM.Seg',
		@w_rol_des 		= 'MENU POR PROCESOS',
		@w_pa_parent 	= 'AS.Roles',
		@w_pa_name 		= 'AS.ADMSEG.FTransacxFuncionalidadClass',
		@w_orden 		= 6,
		@w_mo_name		= 'ADMSEG.Role',
		@w_co_name 		= 'ADMSEG.FTransacFun',
		@w_co_class 	= 'FTransacxFuncionalidadClass',
		@w_co_namespace = 'COBISCorp.tCOBIS.ADMSEG.Role'

print 'Registros de Opción de MENU: %1!'+ @w_la_label
if not exists (select 1 from cobis..an_page where pa_name = @w_pa_name)
begin
	declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int, @wd_parent_module int
	select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = @w_rol_des
	select @w_la_cod = 'ES_EC'
	select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
	insert into cobis..an_label values (@w_la_id, @w_la_cod, @w_la_label, @w_prod_name)
	select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
	select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = @w_pa_parent
	insert into cobis..an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id)
	values (@w_pa_id, @w_la_id, @w_pa_name, 'icono pagina', @w_pa_id_parent, @w_orden, 'horizontal', 'Nemonic', @w_prod_name, '', null)
	insert into cobis..an_role_page values (@w_pa_id, @w_rol)
	if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone values (1, 'Zona 1', 1, 1, 1, 1)  end
	select @w_mo_id = mo_id from cobis..an_module where mo_name = @w_mo_name

	if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module values (@w_mo_id, @w_rol)
	select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
	insert into cobis..an_component values (@w_co_id, @w_mo_id, @w_co_name, @w_co_class, @w_co_namespace, 'SV', '', @w_prod_name)
	insert into cobis..an_role_component values (@w_co_id, @w_rol)

	select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
	if @w_pz_id is null select @w_pz_id = 1

	if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
		insert into cobis..an_page_zone values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
	end
end
go

-------------------------------------
-- Esquema de Autorización para Transacciones por Funcionalidad
-------------------------------------
print 'Autorización para Transaccion x Funcionalidades'
declare @w_co_id        int,
          @w_prod_name  varchar(10)		 	  

select @w_prod_name = 'M-ADM.Seg'
select @w_co_id = co_id from an_component where co_class = 'FTransacxFuncionalidadClass' and co_prod_name = @w_prod_name
   
if exists(select 1 from cobis..an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15390))
	delete cobis..an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15390)
insert into cobis..an_transaction_component values (@w_co_id,15390,null)
go

-------------------------------------
-- Transacciones para Transacciones por Funcionalidad
-------------------------------------
print 'BE - Transaccion x Funcionalidades'
if not exists(select 1 from cobis..ad_procedure where pd_stored_procedure = 'sp_transacfun')
	insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
	values (5208,'sp_transacfun','cobis','V',getdate(),'sp_transacfun.sp')
go

if not exists(select 1 from cobis..ad_pro_transaccion where pt_transaccion = 15390)
	insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
	values (1, 'R', 0, 15390, 'V', getdate(), 5208, null) 
go


if not exists(select 1 from cobis..cl_ttransaccion where tn_trn_code = 15390)
	insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
	values (15390, 'TRANSACCIONES POR FUNCIONALIDAD', 'TRANFUN', 'TRANSACCIONES POR FUNCIONALIDAD')
go

declare @codigo int
select @codigo = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'
if not exists(select 1 from cobis..ad_tr_autorizada where ta_transaccion = 15390)
	insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda, ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante, ta_estado,ta_fecha_ult_mod) 
	values (1,'R',0,15390,@codigo,getdate(),1,'V',getdate())
go


-------------------------------------
-- Orden de Paginas Autorización de Funcionalidades y Transacciones por Funcionalidad
-------------------------------------
print 'Orden de Páginas ADMIN'
if exists (select 1 from cobis..an_page where pa_name = 'AS.ADMSEG.FTransacxFuncionalidadClass')
	update cobis..an_page set pa_order = 6 where pa_name = 'AS.ADMSEG.FTransacxFuncionalidadClass'

if exists (select 1 from cobis..an_page where pa_name = 'AS.ADMSEG.SecurityManagementView')
	update cobis..an_page set pa_order = 7 where pa_name = 'AS.ADMSEG.SecurityManagementView'

go



