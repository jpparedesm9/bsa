package com.cobiscorp.ecobis.clientviewer;

import com.cobiscorp.ecobis.clientviewer.dto.PrepareDataDTO;

public interface PrepareProductsDataService {

	/**
	 * Method used to prepare all the information for a specific customer and
	 * insert into tables that will be shown later in the VCC.
	 * 
	 * @param customerCode
	 *            , it's a customer code for the consultation.
	 * @param groupCode
	 *            , it's a group code for the consultation.
	 * @return A PrepareDataDTO Object with the information of a specific
	 *         customer
	 */
	PrepareDataDTO prepareProductsData(Integer customerCode, Integer groupCode,
			String dateFormat);

	/**
	 * Method used to prepare all the history information for a specific
	 * customer and insert into tables that will be shown later in the VCC.
	 * 
	 * @param customerCode
	 *            , it's a customer code for the consultation.
	 * @param groupCode
	 *            , it's a group code for the consultation.
	 * @return A PrepareDataDTO Object with the information of a specific
	 *         customer
	 */
	PrepareDataDTO prepareProductsDataHistory(Integer customerCode,
			Integer groupCode, String dateFormat);
}
