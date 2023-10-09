/*************************************************/
---No Bug: bug Relacionado a historia AHO-H80489
---Título de la Historia: Reg. Detalle cheque
---Fecha: 06/Sep/2016
--Descripción del bug: no se encuentra autorizada la transaccion  
--Descripción de la Solución:   Se registra autorizacion
--Autor: Tania Baidal
/*************************************************/


use cobis
go


declare @w_rol int, @w_moneda tinyint, @w_producto tinyint, @w_transaccion int, @w_descripcion varchar(64), @w_nemonico varchar(10), @w_desc_larga varchar(100), @w_procedure int, @w_base varchar(30), @w_nombresp varchar(50), @w_filesp varchar(50)
select @w_rol = ro_rol from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
select @w_producto    = 3,
	   @w_transaccion = 639,
	   @w_descripcion = 'REGISTRO DE CHEQUE',
	   @w_nemonico    = 'RECH',
	   @w_desc_larga  = 'REGISTRO DE CHEQUE EN LA TABLA DEFINITIVA',
	   @w_procedure   = 482,
	   @w_base        = 'cob_remesas',
	   @w_nombresp    = 'sp_detallecheque',
	   @w_filesp      = 'detcheq.sp'

--Dependencias/sql/cc_proc.sql
if exists (SELECT * FROM cobis..ad_procedure WHERE pd_procedure = @w_procedure)
begin
       DELETE FROM ad_procedure WHERE pd_procedure = @w_procedure
end

insert into cobis..ad_procedure values(@w_procedure,@w_nombresp,@w_base,'V',getdate(),@w_filesp)

--Dependencias/sql/cc_tran.sql
if exists (SELECT * FROM cobis..cl_ttransaccion WHERE tn_trn_code = @w_transaccion)
begin
       delete FROM cobis..cl_ttransaccion WHERE tn_trn_code = @w_transaccion
end


INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (@w_transaccion, @w_descripcion, @w_nemonico, @w_desc_larga)


--Dependencias/sql/cc_protran.sql
if exists (SELECT * FROM cobis..ad_pro_transaccion WHERE pt_producto = @w_producto and pt_transaccion = @w_transaccion  and pt_moneda = @w_moneda)
begin
delete from cobis..ad_pro_transaccion WHERE pt_producto = @w_producto and pt_transaccion = @w_transaccion and pt_moneda = @w_moneda
end

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, 'V', getdate(), @w_procedure, NULL)

--Dependencias/sql/cc_traut.sql
if exists (SELECT * FROM cobis..ad_tr_autorizada WHERE ta_transaccion = @w_transaccion and ta_producto = @w_producto and ta_moneda = @w_moneda)
begin
    DELETE FROM cobis..ad_tr_autorizada WHERE ta_transaccion = @w_transaccion and ta_producto = @w_producto and ta_moneda = @w_moneda
end

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
GO
