/*
 * File: UpdateQrOperationInterceptor.java
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
import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.bo.PhysicalField;
import com.cobiscorp.ecobis.fpm.catalogs.service.ICatalogManager;
import com.cobiscorp.ecobis.fpm.cobis.portfolio.interceptors.service.utils.MessageManager;
import com.cobiscorp.ecobis.fpm.model.CoreTable;
import com.cobiscorp.ecobis.fpm.portfolio.bo.OperationData;
import com.cobiscorp.ecobis.fpm.portfolio.model.DefaultOperation;
import com.cobiscorp.ecobis.fpm.portfolio.service.IDefaultOperationManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;

/**
 * Intercepts the sp_qr_opeacion_tmp stored procedure
 * 
 * @author despinosa
 * 
 */
@SuppressWarnings(value = "all")
public class UpdateQrOperationInterceptor implements CobisInterceptor {

	private static final ILogger logger = LogFactory
			.getLogger(UpdateQrOperationInterceptor.class);
	private IDefaultOperationManager defaultOperationManager;
	// private ICatalogManager catalogService;
	private ICatalogManager catalogService;

	public void setDefaultOperationManager(
			IDefaultOperationManager defaultOperationManager) {
		this.defaultOperationManager = defaultOperationManager;
	}

	public void setCatalogService(ICatalogManager catalogService) {
		this.catalogService = catalogService;
	}

	/**
	 * Is executed after the sp_qr_operation_tmp. Deletes and updates the
	 * ca_default_toperacion, ca_operacion_tmp and cl_catalogo tables.
	 */
	public void execute(CobisInterceptorContext context) {

		logger.logDebug(MessageManager.getString(
				"UPDATEQROPERATIONINTERCEPTOR.001", "execute"));
		IProcedureResponse interceptorResponse = new ProcedureResponseAS();
		IProcedureRequest request = null;
		Boolean execute = false;
		try {
			request = context
					.getValue(CobisInterceptorContext.PROCEDURE_REQUEST_KEY);

			// Get module mnemonic
			if (context.getValue(
					request.readParam("@s_ssn").getValue().concat("mnemonic"))
					.equals("CCA")) {
				execute = true;
			}

			if (execute) {

				logger.logDebug(MessageManager.getString(
						"UPDATEQROPERATIONINTERCEPTOR.003", request.getSpName()));

				OperationData opData = this.defaultOperationManager
						.getOperationData(request.readParam("@i_codigo")
								.getValue());

				// Create and initialize DefaultOperation object
				DefaultOperation operationToDelete = new DefaultOperation();
				operationToDelete.setOperation(request.readParam("@s_ssn")
						.getValue());
				operationToDelete.setCurrency(opData.getCurrency());

				// Delete information in ca_default_toperacion
				defaultOperationManager
						.deleteDynamicCredit((Map<CoreTable, Map<String, PhysicalField>>) context
								.getValue("CORE_INFORMATION"));

				// Update field in create operation
				Integer registry = this.defaultOperationManager
						.updateCreateOperation(opData.getOperation(), context
								.getValue("opData2").toString());

				if (registry <= 0) {
					this.defaultOperationManager.updateCreateOperationDef(
							opData.getOperation(), context.getValue("opData2")
									.toString());
				}

				// Delete information in catalog
				Catalog catalog = new Catalog(request.readParam("@s_ssn")
						.getValue().trim(), "");
				catalogService.deleteCatalog("ca_toperacion", catalog);
			}

		} catch (Exception e) {

			logger.logError(MessageManager
					.getString("UPDATEQROPERATIONINTERCEPTOR.004"), e);

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
					"UPDATEQROPERATIONINTERCEPTOR.002", "execute"));
		}

	}

}
