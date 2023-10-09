/*************************************************************************/
/*   Archivo:              REM_107888_ca_transaccion.sql      		     */
/*   Stored procedure:     REM_107888_ca_transaccion.sql      			 */
/*   Base de datos:        cobis		                               	 */
/*   Producto:             cartera                                  	 */
/*   Disenado por:         jlsdv                                         */
/*   Fecha de escritura:   Marzo 2019                                  	 */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/*   				Script para la creación de la transacción 			 */
/*   				  y la autorizacion para el caso 107888 			 */
/*                              CAMBIOS                                  */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    20/Marzo/2019       	Jose Sánchez          Emision inicial        */
/*                                                                       */
/*************************************************************************/
USE cobis
GO

DECLARE 
@w_tn_trn_code    int, 
@w_pd_procedure   int, 
@w_pd_producto    tinyint, 
@w_ro_rol		  tinyint, 
@w_ta_autorizante smallint

-- Se inicializa el codigo de la transacción
SELECT @w_tn_trn_code = 7316

-- Obtiene el id de maximo de la tabla cobis..ad_procedure
SELECT @w_pd_procedure = ISNULL(MAX(pd_procedure), 0) +1 FROM ad_procedure

-- Obtiene el codigo del producto de cartera
SELECT @w_pd_producto = pd_producto FROM cobis..cl_producto WHERE pd_descripcion = 'CARTERA' AND pd_abreviatura = 'CCA'

-- Obtiene el codigo del rol de OPERACIONES 
SELECT @w_ro_rol = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'OPERACIONES'

-- Obtiene el codigo del rol autorizante
SELECT @w_ta_autorizante = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'OPERACIONES'

DELETE FROM cl_ttransaccion
	WHERE tn_descripcion = 'CONSULTA DE DATOS DE CONCILIACION MANUAL'

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
	VALUES (@w_tn_trn_code, 'CONSULTA DE DATOS DE CONCILIACION MANUAL', @w_tn_trn_code, 'CONSULTA DE DATOS DE CONCILIACION MANUAL')

DELETE FROM ad_procedure
  WHERE pd_stored_procedure = 'sp_conciliar_corresponsal_qry'

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
	VALUES (@w_pd_procedure, 'sp_conciliar_corresponsal_qry', 'cob_conta_super' ,'V', GETDATE(), 'conciliar_qry')

DELETE FROM ad_pro_transaccion
	WHERE pt_transaccion = @w_tn_trn_code AND pt_producto = @w_pd_producto

INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
	VALUES (@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', GETDATE(), @w_pd_procedure, NULL)

DELETE FROM ad_tr_autorizada
	WHERE ta_transaccion = @w_tn_trn_code AND ta_producto = @w_pd_producto

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
	VALUES (@w_pd_producto, 'R', 0, @w_tn_trn_code, @w_ro_rol, GETDATE(), @w_ta_autorizante, 'V', GETDATE())

-------------------------------------------------------------------------------------------
-- Se inicializa el codigo de la transacción
SELECT @w_tn_trn_code = 7317

-- Obtiene el id de maximo de la tabla cobis..ad_procedure
SELECT @w_pd_procedure = ISNULL(MAX(pd_procedure), 0) +1 FROM ad_procedure

DELETE FROM cl_ttransaccion
	WHERE tn_descripcion = 'APLICAR ACCIONES DE CONCILIACION MANUAL'

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
	VALUES (@w_tn_trn_code, 'APLICAR ACCIONES DE CONCILIACION MANUAL', @w_tn_trn_code, 'APLICAR ACCIONES DE CONCILIACION MANUAL')

DELETE FROM ad_procedure
  WHERE pd_stored_procedure = 'sp_conciliar_corresponsal_acc'

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
	VALUES (@w_pd_procedure, 'sp_conciliar_corresponsal_acc', 'cob_conta_super' ,'V', GETDATE(), 'conciliar_acc')

DELETE FROM ad_pro_transaccion
	WHERE pt_transaccion = @w_tn_trn_code AND pt_producto = @w_pd_producto

INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
	VALUES (@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', GETDATE(), @w_pd_procedure, NULL)

DELETE FROM ad_tr_autorizada
	WHERE ta_transaccion = @w_tn_trn_code AND ta_producto = @w_pd_producto

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
	VALUES (@w_pd_producto, 'R', 0, @w_tn_trn_code, @w_ro_rol, GETDATE(), @w_ta_autorizante, 'V', GETDATE())

-------------------------------------------------------------------------------------------
-- Se inicializa el codigo de la transacción
SELECT @w_tn_trn_code = 7318

-- Obtiene el id de maximo de la tabla cobis..ad_procedure
SELECT @w_pd_procedure = ISNULL(MAX(pd_procedure), 0) +1 FROM ad_procedure

DELETE FROM cl_ttransaccion
	WHERE tn_descripcion = 'CONCILIAR CORRESPOSALES AUTOMATICAMENTE'

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
	VALUES (@w_tn_trn_code, 'CONCILIAR CORRESPOSALES AUTOMATICAMENTE', @w_tn_trn_code, 'CONCILIAR CORRESPOSALES AUTOMATICAMENTE')

DELETE FROM ad_procedure
  WHERE pd_stored_procedure = 'sp_conciliar_corresponsal'

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
	VALUES (@w_pd_procedure, 'sp_conciliar_corresponsal', 'cob_conta_super' ,'V', GETDATE(), 'conciliar_co')

DELETE FROM ad_pro_transaccion
	WHERE pt_transaccion = @w_tn_trn_code AND pt_producto = @w_pd_producto

INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
	VALUES (@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', GETDATE(), @w_pd_procedure, NULL)

DELETE FROM ad_tr_autorizada
	WHERE ta_transaccion = @w_tn_trn_code AND ta_producto = @w_pd_producto

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
	VALUES (@w_pd_producto, 'R', 0, @w_tn_trn_code, @w_ro_rol, GETDATE(), @w_ta_autorizante, 'V', GETDATE())
GO

