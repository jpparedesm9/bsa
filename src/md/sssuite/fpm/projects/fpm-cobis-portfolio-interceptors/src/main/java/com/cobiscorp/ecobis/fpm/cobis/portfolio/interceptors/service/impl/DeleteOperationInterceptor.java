/*
 * File: DeleteOperationInterceptor.java
 * Date: April 16, 2012
 *
 * This application is part of banking packages owned by COBISCORP. 
 * Unauthorized use is prohibited as well as any alteration or 
 * addition made by any of its users without due due COBISCORP 
 * written consent.
 * This program is protected by copyright law and by international 
 * intellectual property conventions. Its unauthorized use COBISCORP 
 * right to give orders for retention and to prosecute those 
 * responsible for any breach.
 */

package com.cobiscorp.ecobis.fpm.cobis.portfolio.interceptors.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.IMessageBlock;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.dtos.MessageBlock;
import com.cobiscorp.cobis.cts.dtos.ProcedureResponseAS;
import com.cobiscorp.cobis.cts.interceptors.CobisInterceptor;
import com.cobiscorp.cobis.cts.interceptors.CobisInterceptorContext;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.bo.PhysicalField;
import com.cobiscorp.ecobis.fpm.cobis.portfolio.interceptors.service.utils.MessageManager;
import com.cobiscorp.ecobis.fpm.model.CoreTable;
import com.cobiscorp.ecobis.fpm.portfolio.model.DefaultOperation;
import com.cobiscorp.ecobis.fpm.portfolio.model.ItemsPortfolio;
import com.cobiscorp.ecobis.fpm.portfolio.service.IDefaultOperationManager;
import com.cobiscorp.ecobis.fpm.portfolio.service.IItemPortfolioManager;

/**
 * Intercepts the sp_crear_operacion stored procedure, delete information
 * previously inserted
 * 
 * @author oguano
 * 
 */
/**
 * @author oguano
 * 
 */
public class DeleteOperationInterceptor implements CobisInterceptor {

	// region Fields
	/** Cobis Logger */
	private static final ILogger logger = LogFactory
			.getLogger(DeleteOperationInterceptor.class);
	/** DefaultOperationManager Service */
	private IDefaultOperationManager defaultOperationManagerService;
	/** ItemPortfolioManager Service */
	private IItemPortfolioManager itemPortfolioManagerService;

	// end-region

	// region Properties
	/**
	 * @param defaultOperationManagerService
	 */

	public void setDefaultOperationManagerService(
			IDefaultOperationManager defaultOperationManagerService) {
		this.defaultOperationManagerService = defaultOperationManagerService;
	}

	/**
	 * @param itemPortfolioManagerService
	 */
	public void setItemPortfolioManagerService(
			IItemPortfolioManager itemPortfolioManagerService) {
		this.itemPortfolioManagerService = itemPortfolioManagerService;
	}

	// end-region

	// region Implements CobisInterceptor
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.cobis.cts.interceptors.CobisInterceptor#execute(com.cobiscorp
	 * .cobis.cts.interceptors.CobisInterceptorContext)
	 */
	@SuppressWarnings("unchecked")
	public void execute(CobisInterceptorContext context) {

		logger.logDebug(MessageManager.getString(
				"GENERALPARAMETERSINTERCEPTOR.001", "execute"));

		IProcedureRequest request = null;

		// ID of the banking product
		String operation = null;
		DefaultOperation defaultOperation = null;
		// List items existing in ca_rubro
		List<ItemsPortfolio> itemsPortfolioList = null;

		// Identifier create operation
		int codeCreateOperation;

		// Verified if logic must be executed
		Boolean execute = false;

		try {
			request = context
					.getValue(CobisInterceptorContext.PROCEDURE_REQUEST_KEY);

			// Get module mnemonic
			if (context.getValue(
					request.readParam("@s_ssn").getValue().concat("mnemonic"))
					.equals("CCA")) {
				execute = true;
				
				if (request.readParam("@t_trn") != null) {
					if(request.readParam("@t_trn").getValue().trim().equals("1800140"))
					{
						if (request.readParam("@i_operacion") != null) {
							if(!request.readParam("@i_operacion").getValue().trim().equals("C"))
							{
								execute = false;
							}
						}
					}
					
				}
			}

			if (execute) {

				logger.logDebug(MessageManager.getString(
						"DELETEOPERATIONINTERCEPTOR.003", request.getSpName()));

				operation = request.readParam("@i_toperacion").getValue();

				// Create and initialize DefaultOperation object
				defaultOperation = new DefaultOperation();
				defaultOperation.setOperation(operation);
				defaultOperation.setCurrency(Long.parseLong(request.readParam(
						"@i_moneda").getValue()));

				logger.logDebug(MessageManager
						.getString("DELETEOPERATIONINTERCEPTOR.004"));

				//ATO Delete registry in ca_default_toperacion by ssn
				defaultOperationManagerService.deleteDynamicCreditByProductOpt("dt_toperacion", request.readParam("@s_ssn").getValue().trim(), "ca_default_toperacion", "cob_cartera"); 

				//ATO Delete data in ca_rubro by ssn	
				defaultOperationManagerService.deleteDynamicCreditByProductOpt("ru_toperacion", request.readParam("@s_ssn").getValue().trim(), "ca_rubro", "cob_cartera");

				// Get identifier create operation
				codeCreateOperation = defaultOperationManagerService
						.getCodeCreateOperation(request.readParam(
								"@i_toperacion").getValue());

				if (codeCreateOperation > 0) {

					logger.logDebug(MessageManager
							.getString("DELETEOPERATIONINTERCEPTOR.007"));
					// Update field opt_toperacion in ca_operacion_tmp for
					// create operation

					Integer registry = defaultOperationManagerService
							.updateCreateOperation(
									codeCreateOperation,
									context.getValue(
											request.readParam("@s_ssn")
													.getValue()
													.concat("tOperation"))
											.toString());

					logger.logDebug("Registry" + registry);
				} else {

					// Get identifier create operation
					codeCreateOperation = defaultOperationManagerService
							.getCodeCreateOperationDef(request.readParam(
									"@i_toperacion").getValue());

					if (codeCreateOperation > 0) {
						logger.logDebug(MessageManager
								.getString("DELETEOPERATIONINTERCEPTOR.007"));
						// Update field op_toperacion in ca_operacion for create
						// operation
						defaultOperationManagerService
								.updateCreateOperationDef(
										codeCreateOperation,
										context.getValue(
												request.readParam("@s_ssn")
														.getValue()
														.concat("tOperation"))
												.toString());
					} else {

						logger.logWarning(MessageManager
								.getString("DELETEOPERATIONINTERCEPTOR.009"));
					}
				}

				defaultOperationManagerService.findAndChangeProcessedOperation(
						request.readParam("@i_toperacion").getValue(),
						context.getValue(
								request.readParam("@s_ssn").getValue()
										.concat("tOperation")).toString());

				// Modified Line Credit with original value
				if (request.readParam("@i_linea_credito") != null
						&& request.readParam("@i_toperacion") != null
						&& request.readParam("@i_producto") != null
						&& request.readParam("@i_proposito_op") != null
						&& request.readParam("@i_moneda") != null) {

					// Modified registry line credit product for currency with
					// original value
					defaultOperationManagerService
							.modifiedCreditLineNumberCurrency(
									request.readParam("@i_linea_credito")
											.getValue(),
									request.readParam("@i_toperacion")
											.getValue(),
									request.readParam("@i_producto").getValue(),
									request.readParam("@i_proposito_op")
											.getValue(),
									Integer.parseInt(request.readParam(
											"@i_moneda").getValue()),
									context.getValue(
											request.readParam("@s_ssn")
													.getValue()
													.concat("tOperation"))
											.toString());

				}

				// Modified value parameter @i_toperacion with original value
				if (request.readParam("@i_toperacion") != null) {
					request.readParam("@i_toperacion").setValue(
							context.getValue(
									request.readParam("@s_ssn").getValue()
											.concat("tOperation")).toString());
				}

			}

		} catch (Exception e) {

			logger.logError(
					MessageManager.getString("DELETEOPERATIONINTERCEPTOR.008"),
					e);

			IProcedureResponse interceptorResponse = new ProcedureResponseAS();
			IMessageBlock message = null;

			if(e instanceof BusinessException)
			{
				message = new MessageBlock(((BusinessException)e).getClientErrorCode(),
						((BusinessException)e).getMessage());
				interceptorResponse.setReturnCode(((BusinessException)e).getClientErrorCode());
				
			}else
			{
				message = new MessageBlock(6900001,
						"Existió un fallo en la operación. Comuníquese con el Administrador.");
				interceptorResponse.setReturnCode(6900001);
			}
			
			interceptorResponse.addResponseBlock(message);

			context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY,
					interceptorResponse);

		} finally {
			logger.logDebug(MessageManager.getString(
					"DELETEOPERATIONINTERCEPTOR.002", "execute"));
		}

	}

	// end-region

}
