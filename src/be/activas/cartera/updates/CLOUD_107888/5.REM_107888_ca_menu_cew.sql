/*************************************************************************/
/*   Archivo:              REM_107888_ca_menu_cew.sql      				 */
/*   Stored procedure:     REM_107888_ca_menu_cew.sql					 */
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
/*   	Script para la creacion del menu en el cew para el caso #107888  */
/*                              CAMBIOS                                  */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    15/Marzo/2019       	Jose Sánchez          Emision inicial        */
/*    02/Mayo/2019   		Jose Sánchez 	 Correcion de errores al     */
/*  						 		 			ejecutar el script  	 */
/*************************************************************************/
USE cobis
GO

DECLARE 
@w_me_id_old int -- Codigo del menu a eliminar

-- Obtiene el codigo del menu a eliminar
SELECT @w_me_id_old = me_id FROM cew_menu WHERE me_name IN ('MNU_ASSETS_CONCILIATION_MANUAL')

-- Elimina el menu transaccion
DELETE FROM cew_menu_transaccion 
	WHERE mt_id_menu IN (@w_me_id_old)

-- Elimina el menu servicio
DELETE FROM cew_menu_service 
	WHERE ms_id_menu IN (@w_me_id_old)

-- Elimina el menu rol
DELETE FROM cew_menu_role
	WHERE mro_id_menu IN (@w_me_id_old)
	
-- Elimina el menu
DELETE FROM cew_menu
	WHERE me_name IN ('MNU_ASSETS_CONCILIATION_MANUAL')
	
GO

DECLARE 
@w_me_id  int, -- Codigo del menu
@w_me_id_parent int, -- Codigo del menu padre
@w_ro_rol int, -- Codigo del rol
@w_pd_producto int, -- Codigo del producto
@w_tn_trn_code int -- codigo de la transaccion
-- Obtiene el nuevo id para el menu
SELECT @w_me_id = isnull(max(me_id), 0) +1 FROM cew_menu

-- Obtiene el id del menu para el modulo de Cartera
SELECT @w_me_id_parent = me_id FROM cobis..cew_menu WHERE me_name = 'MNU_ASSETS'

-- Obtiene el id del producto 'Cartera'
SELECT @w_pd_producto = pd_producto FROM cobis..cl_producto WHERE pd_descripcion = 'CARTERA' AND pd_abreviatura = 'CCA'

INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	VALUES (@w_me_id, @w_me_id_parent, 'MNU_ASSETS_CONCILIATION_MANUAL', 1, 'views/ASSTS/CMMNS/T_ASSTSNZKCUGDD_542/1.0.0/VC_CONCILIALA_363542_TASK.html', 181,  @w_pd_producto,  0, 'Conciliación Manual')

-- Obtiene el id del rol de operaciones
SELECT @w_ro_rol = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'OPERACIONES'

IF EXISTS (SELECT 1 FROM cew_menu_role WHERE mro_id_menu = @w_me_id_parent AND mro_id_role = @w_ro_rol)
BEGIN
	PRINT 'YA EXISTE MENU CON EL ROL DE OPERACIONES'
END
ELSE
BEGIN
	PRINT 'SE CREA LA RELACION MENU-ROL CON EL ROL DE OPERACIONES'
	INSERT INTO cew_menu_role (mro_id_menu, mro_id_role) VALUES (@w_me_id_parent, @w_ro_rol)
END

INSERT INTO cew_menu_role (mro_id_menu, mro_id_role)
	VALUES (@w_me_id, @w_ro_rol)

INSERT INTO cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) 
	VALUES (@w_me_id, 'Loan.ConciliationManagement.SearchConciliationByFilters', @w_pd_producto, 'R', 0)
	
INSERT INTO cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) 
	VALUES (@w_me_id, 'Loan.ConciliationManagement.SearchMinorDateNotConciled', @w_pd_producto, 'R', 0)
	
INSERT INTO cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) 
	VALUES (@w_me_id, 'Loan.ConciliationManagement.ApplyOperationManualConciliation', @w_pd_producto, 'R', 0)

INSERT INTO cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) 
	VALUES (@w_me_id, 'Loan.ConciliationManagement.ApplyConcilationAutomatic', @w_pd_producto, 'R', 0)
		
-- Se inicializa el codigo de la transaccion
SELECT @w_tn_trn_code = 7316

INSERT INTO cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda)
	VALUES (@w_me_id, @w_tn_trn_code, @w_pd_producto, 'R', 0)
	
-- Se inicializa el codigo de la transaccion
SELECT @w_tn_trn_code = 7317

INSERT INTO cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda)
	VALUES (@w_me_id, @w_tn_trn_code, @w_pd_producto, 'R', 0)

SELECT @w_tn_trn_code = 7318

INSERT INTO cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda)
	VALUES (@w_me_id, @w_tn_trn_code, @w_pd_producto, 'R', 0)

	
GO
