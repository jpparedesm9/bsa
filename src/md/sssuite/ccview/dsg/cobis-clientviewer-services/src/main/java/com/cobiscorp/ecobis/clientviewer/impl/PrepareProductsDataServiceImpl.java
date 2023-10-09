package com.cobiscorp.ecobis.clientviewer.impl;

import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.clientviewer.PrepareProductsDataService;
import com.cobiscorp.ecobis.clientviewer.bl.PrepareProductsDataManager;
import com.cobiscorp.ecobis.clientviewer.dto.PrepareDataDTO;

public class PrepareProductsDataServiceImpl implements PrepareProductsDataService {

	public PrepareProductsDataManager prepareProductsDataManager;

	private static ILogger logger = LogFactory.getLogger(PrepareProductsDataServiceImpl.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.PrepareProductsDataService#
	 * prepareProductsData(java.lang.Integer, java.lang.Integer)
	 */
	public PrepareDataDTO prepareProductsData(Integer customerCode, Integer groupCode, String dateFormat) {
		try {
			logger.logDebug("Inicia prepareProductsData");

			List<String> response = prepareProductsDataManager.prepareProductsData(customerCode, groupCode, dateFormat);

			PrepareDataDTO dataResponse = new PrepareDataDTO();
			if (response.size() == 2) {
				dataResponse.setSpid(response.get(0));
				dataResponse.setSesn(response.get(1));
			}

			return dataResponse;

		} finally {
			logger.logDebug("Finaliza prepareProductsData");
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.PrepareProductsDataService#
	 * prepareProductsDataHistory(java.lang.Integer, java.lang.Integer)
	 */
	public PrepareDataDTO prepareProductsDataHistory(Integer customerCode, Integer groupCode, String dateFormat) {
		try {
			logger.logDebug("Inicia prepareProductsDataHistory");

			List<String> response = prepareProductsDataManager.prepareProductsDataHistory(customerCode, groupCode, dateFormat);

			PrepareDataDTO dataResponse = new PrepareDataDTO();
			if (response.size() == 2) {
				dataResponse.setSpid(response.get(0));
				dataResponse.setSesn(response.get(1));
			}

			return dataResponse;

		} finally {
			logger.logDebug("Finaliza prepareProductsDataHistory");
		}
	}

	public PrepareProductsDataManager getPrepareProductsDataManager() {
		return prepareProductsDataManager;
	}

	public void setPrepareProductsDataManager(PrepareProductsDataManager prepareProductsDataManager) {
		this.prepareProductsDataManager = prepareProductsDataManager;
	}
}
