package com.cobiscorp.ecobis.clientviewer.impl;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.clientviewer.QueryProductsService;
import com.cobiscorp.ecobis.clientviewer.bl.QueryProductsManager;
import com.cobiscorp.ecobis.clientviewer.dto.ProductsByClientDTO;

public class QueryProductsServiceImpl implements QueryProductsService {
	private static ILogger logger = LogFactory.getLogger(QueryProductsServiceImpl.class);

	private QueryProductsManager queryProductsManager;

	public QueryProductsManager getQueryProductsManager() {
		return queryProductsManager;
	}

	public void setQueryProductsManager(QueryProductsManager queryProductsManager) {
		this.queryProductsManager = queryProductsManager;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.QueryProductsService#
	 * queryProductsByClientId(java.lang.Integer, java.lang.Integer)
	 */
	public ProductsByClientDTO queryProductsByClientId(Integer customerCode, String documentId, Integer spid) {
		try {
			logger.logDebug("Execute queryProductsByClientId");
			ProductsByClientDTO productsByClientResponse = queryProductsManager.getQueryProductsByClientId(customerCode, documentId, spid);

			logger.logDebug("productsByClientResponse... " + productsByClientResponse);
			logger.logDebug("productsByClientResponse.getProductsByClientDTO()... " + productsByClientResponse.getProductsByClientDTO());
			// queryProductsManager.deleteQueryProductsByClientId(spid);
			return productsByClientResponse;
		} finally {
			logger.logDebug("Finaliza queryProductsByClientId");
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.QueryProductsService#
	 * queryProductsByClientId(java.lang.Integer, java.lang.Integer)
	 */
	public ProductsByClientDTO queryHistoryProductsByClientId(Integer customerCode, Integer spid) {
		try {
			logger.logDebug("Execute queryProductsByClientId");
			ProductsByClientDTO productsByClientResponse = queryProductsManager.getQueryHistoryProductsByClientId(customerCode, spid);
			queryProductsManager.deleteQueryProductsByClientId(spid);
			return productsByClientResponse;
		} finally {
			logger.logDebug("Finaliza queryProductsByClientId");
		}
	}

}
