----------------------------------------------------------
----  ROLLBACK OBTENER ESTADOS MODIFICACION PANTALLA -----
----------------------------------------------------------
use cobis
go

declare 
@w_tn_trn_code        int,
@w_pd_procedure       int

select 
@w_tn_trn_code = 21745, -- Se inicializa el codigo de la transaccion
@w_pd_procedure  = 21745

-- SE INSERTA EN LA TABLA DE TRANSACCIONES CON EL SECUENCIAL DE TRANSACCIONES
delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code

-- SE INSERTA EN LA TABLA AD_PROCEDURE EL SP CON EL SECUENCUAL DE PROCEDURE
delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure

-- ASOCIACION DE LA TRANSACCION CON EL SP POR LA TRANSACCION SECUENCIAL
delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure

-- AUTORIZACION DE LA TRANSACCION EN EL ROL CON EL SECUENCIAL DEL DE LA TRANSACCION
delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code


----------------------------------------------------------
----  ROLLBACK ACTUALIZAR ESTADOS MODIFICACION PANTALLA -----
----------------------------------------------------------
use cobis
go

declare 
@w_tn_trn_code        int,
@w_pd_procedure       int

select 
@w_tn_trn_code = 21745, -- Se inicializa el codigo de la transaccion
@w_pd_procedure  = 21745

-- SE INSERTA EN LA TABLA DE TRANSACCIONES CON EL SECUENCIAL DE TRANSACCIONES
delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code

-- SE INSERTA EN LA TABLA AD_PROCEDURE EL SP CON EL SECUENCUAL DE PROCEDURE
delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure

-- ASOCIACION DE LA TRANSACCION CON EL SP POR LA TRANSACCION SECUENCIAL
delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure

-- AUTORIZACION DE LA TRANSACCION EN EL ROL CON EL SECUENCIAL DEL DE LA TRANSACCION
delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code

go
