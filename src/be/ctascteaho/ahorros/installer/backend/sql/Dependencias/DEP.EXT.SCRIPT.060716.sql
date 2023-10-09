/******************************************************/
--Fecha Creación del Script: 2016/07/06               */
--Historial  Dependencias:                            */
--Insertar Transaccion autorizada 2700                */
--Modulo      CTA_AHO                                 */
/******************************************************/

------------------------------------------------------------------------
use cobis
go
------------------------------------------------------------------------
declare 
     @w_rol         int,
     @w_moneda      tinyint,
     @w_producto    tinyint,
	 @w_transaccion int,
	 @w_procedure   int,
	 @w_base	    varchar(30),
	 @w_nombresp    varchar(50),
	 @w_filesp      varchar(50)

select @w_producto    = 4,
	   @w_transaccion = 2700,
	   @w_base        = 'cob_ahorros',
	   @w_nombresp    = 'sp_autndc_aho',
	   @w_filesp      = 'autndc_aho.sp'

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

------------------CL_TTRANSACCION----------------------------
if exists(select 1 from cl_ttransaccion where tn_trn_code = @w_transaccion)
begin
	if not exists(select 1 from ad_procedure where pd_stored_procedure = @w_nombresp)
	begin
		----------------------AD_PROCEDURE------------------------------
		select top 1 @w_procedure = pd_procedure +1 from cobis..ad_procedure order by pd_procedure desc
		INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
		VALUES (@w_procedure, @w_nombresp, @w_base, 'V',  getdate(), @w_filesp)
	end
	if not exists(select 1 from ad_pro_transaccion where pt_transaccion = @w_transaccion and pt_procedure = @w_procedure)
	begin	
		-------------------AD_PRO_TRANSACCION----------------------------
		delete from ad_pro_transaccion where pt_transaccion = @w_transaccion
		select @w_procedure = pd_procedure from cobis..ad_procedure where pd_stored_procedure = @w_nombresp
		INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
		VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_procedure, NULL)
	end
	if not exists(select 1 from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_producto = @w_producto)
	begin	
		------------------AD_TR_AUTORIZADA----------------------------
		select @w_procedure = pd_procedure from cobis..ad_procedure where pd_stored_procedure = @w_nombresp
		INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
		VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
	end
end 
go
