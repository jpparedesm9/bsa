/************************************************************************/
/*          MODIFICACIONES                                              */
/* 25/ABR/2016       ELO     Migracion SYBASE-SQLServer FAL             */

use cobis
go


-----------------------------------------------------------------------------------------------
-- Eliminación de pagina a partir de pa_name
-----------------------------------------------------------------------------------------------
declare @w_pa_name varchar(100),
	@w_pa_id_label integer,
	@w_cod_label integer,
	@w_label varchar(100),
	@w_cod_page integer,
	@w_cod_component integer

	
	
select @w_pa_name = 'AS.ADM.Ref.FcondetofiClass'
--borra label
select @w_pa_id_label = pa_la_id from an_page where pa_name = @w_pa_name
delete from an_label where la_id = @w_pa_id_label and la_prod_name = 'M-ADM.Ref'
--borra page
select @w_cod_page = pa_id from an_page where pa_name = @w_pa_name
delete from an_page where pa_id = @w_cod_page
delete from an_role_page where rp_pa_id = @w_cod_page
--borra page_zone
select @w_cod_component = pz_co_id from an_page_zone  where pz_pa_id = @w_cod_page
delete from an_page_zone where pz_pa_id = @w_cod_page
--borra component
delete from an_component where co_id = @w_cod_component
delete from an_role_component where rc_co_id = @w_cod_component

go


-- Registros para: PI.CCA.FOperacion    


declare @w_la_label varchar(255),@w_prod_name varchar(20),@w_rol_des varchar(255),@w_pa_parent varchar(255),@w_pa_name varchar(255),@w_orden int,@w_mo_name varchar(255),@w_co_name varchar(255),@w_co_class varchar(255),@w_co_namespace varchar(255)
select  @w_la_label 	= 'Consulta detallada de Oficinas',
		@w_prod_name 	= 'M-ADM.Ref',
		@w_rol_des 		= 'MENU POR PROCESOS',
		@w_pa_parent 	= 'AS.Consultas-1',
		@w_pa_name 		= 'AS.ADM.Ref.FcondetofiClass',
		@w_orden 		= 5,
		@w_mo_name		= 'ADM.Ref.Query',
		@w_co_name 		= 'ADM.Ref.Fcondetofi',
		@w_co_class 	= 'FcondetofiClass',
		@w_co_namespace = 'COBISCorp.tCOBIS.ADMREF.Query'
		
print 'Registros de Opción de MENU: %1!' + @w_la_label
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


/* Recursos Generados en FronEnd

str2041   &Generar Datos
str2040   &Exportar a Excel
str501014	Reporte detallado de oficinas

str501015	Desea generar los datos detallados para las oficinas?
str501016	El Detalle de las Oficinas se generó con éxito!
str501017	No se realizó generación de registros para detalle de Oficinas.

str501018	Regional	
str501019	FIE-ASFI	
str501020	Oficina		
str501021	Departamento
str501022	Provincia	
str501023	Municipio	
str501024	Cantón		
str501025	Localidad	
str501026	Dirección
str501027	Dependencia
str501028	Tipo Of.
str501029	Clasificación
str501030	Nombre Of.
str501031	Jefe Agencia
str501032	Encargado Pto. Reclamo
str501033	Telefono1
str501034	Telefono2
str501035	Telefono3
str501036	Celular
str501037	Cordenadas
str501038	Tipo Horario
str501039	Horario L-V
str501040	Horario Sabado
str501041	Horario Domingo
str501042	Obs. Horario
str501043	Servicios Ofertados
str501044	Circular ASFI
str501045	Fecha ASFI
*/



-----------------------------------------------------------------------------------------------------------------------------------------------

declare @w_co_id        int,
          @w_prod_name  varchar(10),
		  @w_co_mo_id   int,
		  @w_la_id      int,
		  @w_sco_id     int,
		  @w_la_cod     varchar(10)
		  

select @w_la_cod = 'ES_EC',
       @w_prod_name = 'M-ADM.Ref'
	   
select @w_co_id = co_id from an_component where co_class = 'FcondetofiClass' and co_prod_name = @w_prod_name
   
delete cobis..an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code in (15405)  
insert into cobis..an_transaction_component values (@w_co_id,15405,null)
go


-----------------------------------------------------------------------------------------------------------------------------------------------
if exists (select 1 from ad_procedure where  pd_procedure = 5216)
   delete from ad_procedure where  pd_procedure = 5216
go

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (5216,'sp_condetofi','cobis','V',getdate(),'condetofi.sp')
go

if exists (select 1 from ad_pro_transaccion where  pt_producto = 1 and pt_transaccion = 15405 )
   delete  from ad_pro_transaccion where  pt_producto = 1 and pt_transaccion = 15405 
go
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
values (1, 'R', 0, 15405, 'V', getdate(), 5216, null) 
go
if exists (select 1 from cl_ttransaccion where tn_trn_code = 15405 and tn_nemonico = 'CDETOF' )
   delete cl_ttransaccion where tn_trn_code = 15405 and tn_nemonico = 'CDETOF'
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15405, 'CONSULTA DETALLADA DE OFICINAS', 'CDETOF', 'CONSULTA DETALLADA DE OFICINAS')
go

declare @codigo int
select @codigo = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'

if exists (select 1 from ad_tr_autorizada where ta_transaccion = 15405 and  ta_producto = 1 )
   delete  ad_tr_autorizada where ta_transaccion = 15405 and  ta_producto = 1
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda, ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante, ta_estado,ta_fecha_ult_mod) 
values (1,'R',0,15405,@codigo,getdate(),1,'V',getdate())
go



-----------------------------------------------------------------------------------------------------------------------------------------------
/* cl_det_oficina */
print '=====> cl_det_oficina'
go

if exists (select 1 from sysobjects where name='cl_det_oficina')
drop table cl_det_oficina 
go

CREATE TABLE cl_det_oficina(
		do_regional        varchar(100) NULL,
		do_cod_fie_asfi      varchar(10) NULL,
		do_cod_oficina      smallint NULL,
		do_dpto_pais        varchar(64) NULL,
		do_provincia       varchar(64) NULL,
		do_municipio       varchar(64) NULL,
		do_ciudad          varchar(64) NULL,
		do_localidad       varchar(64) NULL,
		do_direccion       varchar(255) NULL,
		do_dependencia     varchar(64) NULL,
		do_tipo_oficina     varchar(10) NULL,
		do_clasificacion   varchar(64) NULL,
		do_nombre_of        varchar(64) NULL,
		do_jefe_agencia     varchar(64) NULL,
		do_enc_pto_reclamo   varchar(64) NULL,
		do_tel_1           varchar(12) NULL,
		do_tel_2           varchar(12) NULL,
		do_tel_3           varchar(12) NULL,
		do_celular         varchar(12) NULL,
		do_cordenadas      varchar(255) NULL,
		do_tipo_horario     varchar(64) NULL,
		do_obs_horario      varchar(120) NULL,
		do_horario_lunes    varchar(63) NULL,
		do_horario_sabado   varchar(63) NULL,
		do_horario_domingo  varchar(63) NULL,
		do_servicios       varchar(200) NULL,
		do_circular_com_asfi varchar(20) NULL,
		do_fecha_asfi       datetime NULL
)
go

