use cobis
go


/******************************************************/
--Fecha Creación del Script: 2016/06/23               */
--Historial  Dependencias:                            */
--Insertar Transacciones autorizadas 398,703,706,1051 */
--Modulo :MIS CTA_AHO                                 */
/******************************************************/


/* *****************************************************/
--cl_ttransaccion
/*******************************************************/


DELETE FROM cobis..cl_ttransaccion
WHERE (tn_trn_code = 1051 AND tn_descripcion = 'BUSQ. OFICINAS' AND tn_nemonico = 'BOCNB' AND tn_desc_larga = 'LISTA LAS OFICINAS QUE NO HAN SIDO ASOCIADAS AUN A UNA RELACION CLIENTE - CB')
go


INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (1051, 'BUSQ. OFICINAS', 'BOCNB', 'LISTA LAS OFICINAS QUE NO HAN SIDO ASOCIADAS AUN A UNA RELACION CLIENTE - CB')
go

/* *****************************************************/
--ad_pro_transaccion
/*******************************************************/

DELETE FROM cobis..ad_pro_transaccion
WHERE (pt_producto = 2 AND pt_tipo = 'R' AND pt_moneda = 0 AND pt_transaccion = 1051 AND pt_estado = 'V' AND pt_procedure = 1126)
go

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (2, 'R', 0, 1051, 'V', getdate(), 1126, NULL)
go

/* *****************************************************/
--ad_tr_autorizada
/*******************************************************/

delete cobis..ad_tr_autorizada
where ta_transaccion in(1051)
and ta_rol = 3

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (2, 'R', 0, 1051, 3, getdate(), 1, 'V', getdate())


/* *****************************************************/
--ad_procedure
/*******************************************************/

DELETE FROM cobis..ad_procedure
WHERE (pd_procedure = 1126 AND pd_stored_procedure = 'sp_clasoser' AND pd_base_datos = 'cobis' AND pd_estado = 'V' AND pd_archivo = 'clasoser.sp')
go


INSERT INTO cobis..ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (1126, 'sp_clasoser', 'cobis', 'V', getdate(), 'clasoser.sp')

go

/* *************************************/
--Parametros
/* *************************************/
       
         
DELETE FROM cobis..cl_parametro
WHERE pa_parametro = 'CODIGO RELACION DE CB' AND pa_nemonico = 'CRCNB' AND pa_producto = 'MIS'


DELETE FROM cobis..cl_parametro
WHERE pa_parametro = 'TIPO DE CLIENTE CB' AND pa_nemonico = 'TCCNB' AND pa_producto = 'MIS'

     
DELETE FROM cobis..cl_parametro
WHERE pa_parametro = 'TIPO CLIENTE CORRESPONSAL BANCARIO POSICIONADO' AND pa_producto = 'MIS'


DELETE FROM cobis..cl_parametro
WHERE pa_parametro = 'CODIGO CCNB' AND pa_nemonico = 'CCCNB' AND pa_producto = 'ADM'
go

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO RELACION DE CB', 'CRCNB', 'I', NULL, NULL, NULL, 207, NULL, NULL, NULL, 'MIS')


INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO DE CLIENTE CB', 'TCCNB', 'C', '005', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')


INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO CLIENTE CORRESPONSAL BANCARIO POSICIONADO', 'TCCBP', 'C', '006', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')


INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO CCNB', 'CCCNB', 'I', NULL, NULL, NULL, 9007, NULL, NULL, NULL, 'ADM')
go

/******************************************************/
--Fecha Creación del Script: 2016/06/23               */
--Historial  Dependencias:                            */
--Insertar Transacciones autorizadas 402,403,404,405  */
--Modulo :REMESAS Y CAMARA                            */
/******************************************************/

use cobis
go

declare 
     @w_rol      int,
     @w_moneda   tinyint,
     @w_producto tinyint

select @w_producto = 10
select @w_rol      = ro_rol from ad_rol where ro_descripcion like 'MENU POR PROCESOS'
select @w_moneda   = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'

/*transacciones*/
delete cl_ttransaccion where tn_trn_code in (402, 403, 404, 405)

insert into cl_ttransaccion values (402, 'CHEQUES DEVUELTOS DE REMESAS', 'CDEV', 'CHEQUE DEVUELTO DE REMESAS')
insert into cl_ttransaccion values (403, 'CONFIRMA CARTA DE REMESAS MANUAL', 'CCMA', 'CONFIRMA CARTA DE REMESAS MANUAL')
insert into cl_ttransaccion values (404, 'CONFIRMA CHEQUE DE UNA CARTA DE REMESAS', 'CNCQ', 'CONFIRMA CHEQUE DE UNA CARTA DE REMESAS')
insert into cl_ttransaccion values (405, 'POSTERGACION DE FECHA DE EFECTIVIZACION DE UNA CARTA', 'POFH', 'POSTERGACION DE FECHA DE EFECTIVIZACION DE UNA CARTA')

/*procedure*/
delete ad_procedure where pd_procedure in (400, 401, 402, 408)

insert into ad_procedure values (400, 'sp_rem_chequedev', 'cob_remesas', 'V', getdate(), 'rechqdev.sp')
insert into ad_procedure values (401, 'sp_rem_confcheque','cob_remesas', 'V', getdate(), 'reconchq.sp')
insert into ad_procedure values (402, 'sp_rem_confcarman','cob_remesas', 'V', getdate(), 'recocarm.sp')
insert into ad_procedure values (408, 'sp_rem_postfecha', 'cob_remesas', 'V', getdate(), 'reposfch.sp')


/*Procedure transaccion*/
delete ad_pro_transaccion where pt_producto = @w_producto and pt_transaccion in (402, 403, 404, 405)

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) values(@w_producto,'R',0,402,'V',getdate(),400)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) values(@w_producto,'R',0,403,'V',getdate(),402)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) values(@w_producto,'R',0,404,'V',getdate(),401)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) values(@w_producto,'R',0,405,'V',getdate(),408)

/*Autorizaciones*/
delete ad_tr_autorizada  where ta_producto = @w_producto and ta_moneda = @w_moneda and ta_rol = @w_rol and ta_transaccion in (402,403,404,405)

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 402, @w_rol, getdate(), 1, 'V', getdate())

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 403, @w_rol, getdate(), 1, 'V', getdate())

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 404, @w_rol, getdate(), 1, 'V', getdate())

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 405, @w_rol, getdate(), 1, 'V', getdate())

go

/******************************************************/
--Fecha Creación del Script: 2016/06/23               */
--Historial  Dependencias:                            */
--Insertar Transacciones autorizadas 299, 208, 296, 202, 295  */
--Modulo : AHORROS                                    */
/******************************************************/
--TBA

use cobis
go

--********FTRAN202********

DECLARE @w_cod_procedure int, 
        @w_rol           int, 
        @w_moneda        tinyint,
        @w_producto      tinyint,
		@w_transaccion   int

select @w_rol = ro_rol
from ad_rol
-- where ro_descripcion like 'ADMINISTRADOR'
where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
from  cobis..cl_parametro
where pa_nemonico = 'CMNAC'
and   pa_producto = 'ADM'


--299
select @w_producto = 4

select @w_transaccion = 299


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol)
begin
    INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
    VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
end

select @w_transaccion = 208
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol)
begin
    INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
    VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
end


select @w_transaccion = 296
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol)
begin
    INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
    VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
end

select @w_transaccion = 202
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol)
begin
    INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
    VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
end

select @w_transaccion = 295
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = @w_transaccion and ta_rol = @w_rol)
begin
    INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
    VALUES (@w_producto, 'R', @w_moneda, @w_transaccion, @w_rol, getdate(), 1, 'V', getdate())
end

GO


/******************************************************/
--Fecha Creación del Script: 2016/06/23               */
--Historial  Dependencias:                            */
--Insertar Transacciones autorizadas 299, 208, 296, 202, 295  */
--Modulo : REMESAS Y CAMARA                           */
/******************************************************/
use cobis
go
-- ---------------------------------------------------------------------------------------------------------
declare @w_rol      int,
        @w_moneda   tinyint,
        @w_producto tinyint
        
select @w_rol = ro_rol
from ad_rol
-- where ro_descripcion like 'ADMINISTRADOR'
where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
from  cobis..cl_parametro
where pa_nemonico = 'CMNAC'
and   pa_producto = 'ADM'

select @w_producto = 10 --->PRODUCTO 10 - REMESAS Y CAMARA

if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 601 and ta_rol = @w_rol)
begin
    INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
    VALUES (@w_producto, 'R', @w_moneda, 601, @w_rol, getdate(), 1, 'V', getdate())
end

select @w_producto = 2

if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 1225 and ta_rol = @w_rol)
begin
    INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
    VALUES (@w_producto, 'R', @w_moneda, 1225, @w_rol, getdate(), 1, 'V', getdate())
end


/******************************************************/
--Fecha Creación del Script: 2016/06/23               */
--Historial  Dependencias:                            */
--Insertar Transacciones autorizadas 1574, 15029, 16, */
/*                                    2938, 408, 410  */
--Modulo : ADMIN, CLIENTES, REMESAS Y CAMARA          */
/******************************************************/

if not exists(select * from cobis..ad_tr_autorizada where ta_transaccion = 1574 and ta_rol = @w_rol)
	insert into cobis..ad_tr_autorizada values(1, 'R', @w_moneda, 1574, @w_rol , getdate(), 1, 'V', getdate())

if not exists(select * from cobis..ad_tr_autorizada where ta_transaccion = 15029 and ta_rol = @w_rol)
	insert into cobis..ad_tr_autorizada values(1, 'R', @w_moneda, 15029, @w_rol , getdate(), 1, 'V', getdate())

if not exists(select * from cobis..ad_tr_autorizada where ta_transaccion = 16 and ta_rol = @w_rol)
	insert into cobis..ad_tr_autorizada values(3, 'R', @w_moneda, 16, @w_rol , getdate(), 1, 'V', getdate())

if not exists(select * from cobis..ad_tr_autorizada where ta_transaccion = 2938 and ta_rol = @w_rol)
	insert into cobis..ad_tr_autorizada values(2, 'R', @w_moneda, 2938, @w_rol , getdate(), 1, 'V', getdate())

if not exists(select * from cobis..ad_tr_autorizada where ta_transaccion = 408 and ta_rol = @w_rol)
	insert into cobis..ad_tr_autorizada values(10, 'R', @w_moneda, 408, @w_rol , getdate(), 1, 'V', getdate())

if not exists(select * from cobis..ad_tr_autorizada where ta_transaccion = 410 and ta_rol = @w_rol)
	insert into cobis..ad_tr_autorizada values(10, 'R', @w_moneda, 410, @w_rol , getdate(), 1, 'V', getdate())



go

