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

DELETE FROM ad_procedure
  WHERE pd_stored_procedure = 'sp_conse_seguro_zurich'

DELETE FROM ad_pro_transaccion
	WHERE pt_transaccion = @w_tn_trn_code AND pt_producto = @w_pd_producto

DELETE FROM ad_tr_autorizada
	WHERE ta_transaccion = @w_tn_trn_code AND ta_producto = @w_pd_producto