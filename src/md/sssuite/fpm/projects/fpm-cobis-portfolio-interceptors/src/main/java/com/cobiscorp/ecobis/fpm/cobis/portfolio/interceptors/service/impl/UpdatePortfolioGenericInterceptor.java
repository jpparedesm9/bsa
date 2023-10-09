/*
 * File: UpdatePortfolioGenericInterceptor.java
 * Date: April 04 2012
 *
 * Copyright (c) 2011 Cobiscorp (Banking Technology Partners) SA, All Rights Reserved.
 *
 * This code is confidential to Cobiscorp and shall not be disclosed outside Cobiscorp                                      
 * without the prior written permission of the Technology Center.
 *
 * In the event that such disclosure is permitted the code shall not be copied
 * or distributed other than on a need-to-know basis and any recipients may be
 * required to sign a confidentiality undertaking in favor of Cobiscorp SA.
 */

package com.cobiscorp.ecobis.fpm.cobis.portfolio.interceptors.service.impl;

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
import com.cobiscorp.ecobis.fpm.portfolio.service.IDefaultOperationManager;

/**
 * Update field opt_toperacion in the ca_operacion_tmp and delete registry in
 * the ca_rubro
 * 
 * @author oguano
 * 
 */
public class UpdatePortfolioGenericInterceptor implements CobisInterceptor {

	// region Fields
	/** Cobis Logger */
	private static final ILogger logger = LogFactory
			.getLogger(UpdatePortfolioGenericInterceptor.class);

	/** OperationManager Service */
	private IDefaultOperationManager defaultOperationManager;

	// end-region

	// region Properties
	/**
	 * @param operationManagerService
	 */

	public void setDefaultOperationManager(
			IDefaultOperationManager defaultOperationManager) {
		this.defaultOperationManager = defaultOperationManager;
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
	public void execute(CobisInterceptorContext context) {

		logger.logDebug(MessageManager.getString(
				"UPDATEPORTFOLIOGENERICINTERCEPTOR.001", "execute"));

		IProcedureResponse interceptorResponse = new ProcedureResponseAS();
		IProcedureRequest request = null;

		try {

			request = context
					.getValue(CobisInterceptorContext.PROCEDURE_REQUEST_KEY);

			if (request.readParam("@i_banco") != null) {

				logger.logDebug(MessageManager.getString(
						"UPDATEPORTFOLIOGENERICINTERCEPTOR.003",
						request.getSpName()));

				if (request.getSpName().trim()
						.equals("cob_cartera..sp_rubro_tmp")) {
					if (request.readParam("@i_operacion") != null) {
						if (!request.readParam("@i_operacion").getValue()
								.trim().equals("S")
								&& !request.readParam("@i_operacion")
										.getValue().trim().equals("M")) {
							portfolioGenericUpdateOperation(request, context);
						}
					} else {
						portfolioGenericUpdateOperation(request, context);
					}
				} else {
					portfolioGenericUpdateOperation(request, context);
				}
			}
		} catch (Exception e) {
			logger.logError(MessageManager
					.getString("UPDATEPORTFOLIOGENERICINTERCEPTOR.004"), e);

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
					"UPDATEPORTFOLIOGENERICINTERCEPTOR.002", "execute"));
		}

	}

	// end-region

	// region Utility Methods
	/**
	 * 
	 * Update field opt_toperacion in ca_operacion_tmp and delete data in
	 * ca_rubro
	 * 
	 * @param request
	 * @param context
	 */
	private void portfolioGenericUpdateOperation(IProcedureRequest request,
			CobisInterceptorContext context) throws Exception {

		// Get module mnemonic
		if (context.getValue(
				request.readParam("@s_ssn").getValue().concat("mnemonic"))
				.equals("CCA")) {

			// Get id create operation
			int codeCreateOperation = defaultOperationManager.getOperationData(
					request.readParam("@i_banco").getValue()).getOperation();

			// Update field opt_toperacion in ca_operacion_tmp
			Integer registry = defaultOperationManager.updateCreateOperation(
					codeCreateOperation,
					context.getValue(
							request.readParam("@s_ssn").getValue()
									.concat("tOperation")).toString());

			if (registry <= 0) {
				defaultOperationManager.updateCreateOperationDef(
						codeCreateOperation,
						context.getValue(
								request.readParam("@s_ssn").getValue()
										.concat("tOperation")).toString());
			}

			if (request.readParam("@i_toperacion") != null) {
				request.readParam("@i_toperacion").setValue(
						context.getValue(
								request.readParam("@s_ssn").getValue()
										.concat("tOperation")).toString());
			}

			// Delete data in ca_rubro
			List<Map<CoreTable, Map<String, PhysicalField>>> coreTableInformationList = context
					.getValue("CORETABLE_LIST");

			for (Map<CoreTable, Map<String, PhysicalField>> map : coreTableInformationList) {
				
				defaultOperationManager.deleteDynamicCredit(map);
			}

		}
	}

	// end-region
}
