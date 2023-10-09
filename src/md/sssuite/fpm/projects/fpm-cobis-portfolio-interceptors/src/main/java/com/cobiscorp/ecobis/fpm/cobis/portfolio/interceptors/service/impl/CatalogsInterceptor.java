/*
 * File: CatalogsInterceptor.java
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

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.IMessageBlock;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetBlock;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetData;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetHeader;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetRow;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetRowColumnData;
import com.cobiscorp.cobis.cts.dtos.MessageBlock;
import com.cobiscorp.cobis.cts.dtos.ProcedureResponseAS;
import com.cobiscorp.cobis.cts.dtos.sp.ResultSetBlock;
import com.cobiscorp.cobis.cts.dtos.sp.ResultSetData;
import com.cobiscorp.cobis.cts.dtos.sp.ResultSetHeader;
import com.cobiscorp.cobis.cts.dtos.sp.ResultSetHeaderColumn;
import com.cobiscorp.cobis.cts.dtos.sp.ResultSetRow;
import com.cobiscorp.cobis.cts.dtos.sp.ResultSetRowColumnData;
import com.cobiscorp.cobis.cts.interceptors.CobisInterceptor;
import com.cobiscorp.cobis.cts.interceptors.CobisInterceptorContext;
import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.catalogs.service.ICatalogManager;
import com.cobiscorp.ecobis.fpm.cobis.portfolio.interceptors.service.utils.CatalogUtils;
import com.cobiscorp.ecobis.fpm.cobis.portfolio.interceptors.service.utils.MessageManager;
import com.cobiscorp.ecobis.fpm.cobis.portfolio.interceptors.service.utils.Utils;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.CurrencyProduct;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;

/**
 * Intercepts transactions for portfolio catalogs
 * 
 * @author oguano
 * 
 */
public class CatalogsInterceptor implements CobisInterceptor {

	/** CTS logger */
	private static final ILogger logger = LogFactory.getLogger(CatalogsInterceptor.class);
	/** BankingProductManager Service */
	private IBankingProductManager bankingProductService;
	/** The catalog service */
	private ICatalogManager catalogService;

	// end-region

	// region Property

	public void setBankingProductService(IBankingProductManager bankingProductService) {
		this.bankingProductService = bankingProductService;
	}

	public void setCatalogService(ICatalogManager catalogService) {
		this.catalogService = catalogService;
	}

	// end-region

	// region implements CobisInterceptor

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.cobis.cts.interceptors.CobisInterceptor#execute(com.cobiscorp
	 * .cobis.cts.interceptors.CobisInterceptorContext)
	 */
	public void execute(CobisInterceptorContext context) {
		logger.logDebug(MessageManager.getString("CATALOGSINTERCEPTOR.001", "execute"));

		String requestDate = null;
		Date operationDate = null;
		BankingProduct bp = null;
		IProcedureResponse interceptorResponse = new ProcedureResponseAS();

		IResultSetHeader header = new ResultSetHeader();
		header.addColumnMetaData(new ResultSetHeaderColumn("Codigo", 48, 3));
		header.addColumnMetaData(new ResultSetHeaderColumn("Moneda", 47, 20));
		header.addColumnMetaData(new ResultSetHeaderColumn("Simbolo", 39, 10));

		try {
			// Retrieve request
			IProcedureRequest request = context.getValue(CobisInterceptorContext.PROCEDURE_REQUEST_KEY);
			if (request.readParam("@t_trn") != null)
				logger.logDebug("CatalogsInterceptor @t_trn: " + request.readParam("@t_trn").getValue());
			if (request.readParam("@i_workflow") != null)
				logger.logDebug("CatalogsInterceptor @i_workflow: " + request.readParam("@i_workflow").getValue());
			if (request.readParam("@i_toperacion") != null)
				logger.logDebug("CatalogsInterceptor @i_toperacion: " + request.readParam("@i_toperacion").getValue());

			if (request.readParam("@i_toperacion") != null && request.readParam("@i_toperacion").getValue() != null
					& request.readParam("@i_toperacion").getValue().trim().equals(""))
				request.readParam("@i_toperacion").setValue(null);

			logger.logDebug(MessageManager.getString("CATALOGSINTERCEPTOR.003", request.getSpName()));

			if (request.readParam("@t_trn") == null || request.readParam("@t_trn").getValue() == null) {
				logger.logError(MessageManager.getString("CATALOGSINTERCEPTOR.004"));

				IMessageBlock message = new MessageBlock(6901000, "No se pudo recuperar el identificador de la transacción.");
				interceptorResponse.addResponseBlock(message);
				interceptorResponse.setReturnCode(6901000);

				context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);

				return;

			}
			// Check if the execution is intercepted for the PUAC
			if (request.readParam("@t_trn").getValue().trim().equals("1556") && request.readParam("@i_workflow") != null && request.readParam("@i_workflow").getValue().equals("S")
					&& request.readParam("@i_toperacion") != null && request.readParam("@i_toperacion").getValue() != null) {
				logger.logDebug("@i_toperacion no nula");
				String productId = request.readParam("@i_toperacion").getValue();

				logger.logDebug(String.format("Interceptando transaction: %s sp: %s producto: %s", request.readParam("@t_trn").getValue(), request.getSpName(), productId));

				// Verified date value
				if (request.readParam("@i_fecha_ini") != null) {
					requestDate = request.readParam("@i_fecha_ini").getValue();

				} else if (request.readParam("@i_fecha_inicio") != null) {
					requestDate = request.readParam("@i_fecha_inicio").getValue();
				}

				// If the date is defined, consultation processes that date

				// Convert to date
				operationDate = Utils.parseDate(Utils.replaceLongTimeDate(requestDate));
				if (operationDate == null) {
					bp = bankingProductService.getBankingProductApprovedInformationById(productId);
				} else {// Consult by default
					bp = bankingProductService.getBankingProductApprovedInformationById(productId, operationDate);
				}

				List<Catalog> currencies = catalogService.getAllCurrencies();

				interceptorResponse.addFieldInHeader("serviceName", 'S', request.getSpName());

				IResultSetData data = new ResultSetData();
				for (CurrencyProduct currency : bp.getCurrencyProducts()) {
					IResultSetRow row = new ResultSetRow();
					IResultSetRowColumnData col1 = new ResultSetRowColumnData(false, currency.getId().getCurrencyId());
					Catalog catalogCurrency = CatalogUtils.getFromCatalogList(currencies, currency.getId().getCurrencyId());
					IResultSetRowColumnData col2 = new ResultSetRowColumnData(false, catalogCurrency == null ? "" : catalogCurrency.getName());
					IResultSetRowColumnData col3 = new ResultSetRowColumnData(true, null);
					row.addRowData(1, col1);
					row.addRowData(2, col2);
					row.addRowData(3, col3);
					data.addRow(row);
				}
				IResultSetBlock resultSet = new ResultSetBlock(header, data);
				interceptorResponse.addResponseBlock(resultSet);

				context.removeValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY);
				context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);
				// Modify the execution of sp to return empty result set
				if (request.readParam("@i_modo") != null) {
					request.readParam("@i_modo").setValue("99");
				}
			}
			// Se agrega condición para cuando la operación es nula
			// (Originación)
			else if (request.readParam("@t_trn").getValue().trim().equals("1556") && request.readParam("@i_workflow") != null
					&& request.readParam("@i_workflow").getValue().equals("S") && request.readParam("@i_toperacion") != null
					&& request.readParam("@i_toperacion").getValue() == null) {
				logger.logDebug("@i_toperacion nula:" + request.readParam("@i_toperacion"));

				List<Catalog> currencies = catalogService.getAllCurrencies();
				IResultSetData data = new ResultSetData();
				for (Catalog currency : currencies) {
					logger.logDebug("Nombre moneda: " + currency.getName());
					IResultSetRow row = new ResultSetRow();
					IResultSetRowColumnData col1 = new ResultSetRowColumnData(false, currency.getCode());
					IResultSetRowColumnData col2 = new ResultSetRowColumnData(false, currency.getName());
					IResultSetRowColumnData col3 = new ResultSetRowColumnData(true, null);
					row.addRowData(1, col1);
					row.addRowData(2, col2);
					row.addRowData(3, col3);
					data.addRow(row);
				}
				IResultSetBlock resultSet = new ResultSetBlock(header, data);
				interceptorResponse.addResponseBlock(resultSet);

				context.removeValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY);
				context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);
				// Modify the execution of sp to return empty result set
				if (request.readParam("@i_modo") != null) {
					request.readParam("@i_modo").setValue("99");
				}

			}

		} catch (Exception ex) {

			logger.logError(MessageManager.getString("CATALOGSINTERCEPTOR.014"), ex);

			IMessageBlock message = new MessageBlock(6901004, "Se ha presentado un error al momento de recuperar la información para el catálago.");
			interceptorResponse.addResponseBlock(message);
			interceptorResponse.setReturnCode(6901004);

			context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);

		} finally {

			logger.logDebug(MessageManager.getString("CATALOGSINTERCEPTOR.002", "execute"));
		}

	}
	// end-region

}
