/*************************************************************************/
/*   Archivo:              autoriza_transaccion.sql          		     */
/*   Stored procedure:     autoriza_transaccion.sql      		    	 */
/*   Base de datos:        cobis		                                 */
/*   Producto:             cartera                                  	 */
/*   Disenado por:         jcastro                                       */
/*   Fecha de escritura:   Octubre 2020                              	 */
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
/*    10/Octubre/2020       Johan Castro          Emision inicial        */
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
SELECT @w_tn_trn_code = 775100

-- Obtiene el id de maximo de la tabla cobis..ad_procedure
SELECT @w_pd_procedure = ISNULL(MAX(pd_procedure), 0) +1 FROM ad_procedure
select @w_pd_procedure 

-- Obtiene el codigo del producto de cartera
SELECT @w_pd_producto = pd_producto FROM cobis..cl_producto WHERE pd_descripcion = 'CARTERA' AND pd_abreviatura = 'CCA'

-- Obtiene el codigo del rol de OPERACIONES 
SELECT @w_ro_rol = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'OPERACIONES'

-- Obtiene el codigo del rol autorizante
SELECT @w_ta_autorizante = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'OPERACIONES'

DELETE FROM cl_ttransaccion
	WHERE tn_descripcion = 'CONSULTA CONSENTIMIENTO ZURICH'

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
	VALUES (@w_tn_trn_code, 'CONSULTA CONSENTIMIENTO ZURICH', @w_tn_trn_code, 'CONSENTIMIENTO ZURICH')

DELETE FROM ad_procedure
  WHERE pd_stored_procedure = 'sp_conse_seguro_zurich'

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
	VALUES (@w_pd_procedure, 'sp_conse_seguro_zurich', 'cob_cartera' ,'V', GETDATE(), 'segzurich')

DELETE FROM ad_pro_transaccion
	WHERE pt_transaccion = @w_tn_trn_code AND pt_producto = @w_pd_producto

INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
	VALUES (@w_pd_producto, 'R', 0, @w_tn_trn_code, 'V', GETDATE(), @w_pd_procedure, NULL)

DELETE FROM ad_tr_autorizada
	WHERE ta_transaccion = @w_tn_trn_code AND ta_producto = @w_pd_producto

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
	VALUES (@w_pd_producto, 'R', 0, @w_tn_trn_code, 10, GETDATE(), @w_ta_autorizante, 'V', GETDATE())
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
	VALUES (@w_pd_producto, 'R', 0, @w_tn_trn_code, 12, GETDATE(), @w_ta_autorizante, 'V', GETDATE())
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
	VALUES (@w_pd_producto, 'R', 0, @w_tn_trn_code, 16, GETDATE(), @w_ta_autorizante, 'V', GETDATE())
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
	VALUES (@w_pd_producto, 'R', 0, @w_tn_trn_code, 26, GETDATE(), @w_ta_autorizante, 'V', GETDATE())
	