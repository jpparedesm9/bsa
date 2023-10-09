package com.cobiscorp.ecobis.clientviewer.bl;

import java.util.List;

public interface PrepareProductsDataManager {

	/**
	 * Method used to prepare all the information for a specific customer and
	 * insert into tables that will be shown later in the VCC.
	 * 
	 * @param clientId
	 *            , it's a customer code for the consultation.
	 * @param groupId
	 *            , it's a group code for the consultation.
	 * @return A list with the information of a specific customer
	 */
	List<String> prepareProductsData(Integer clientId, Integer groupId, String dateFormat);

	List<String> prepareProductsDataHistory(Integer clientId, Integer groupId, String dateFormat);
}
