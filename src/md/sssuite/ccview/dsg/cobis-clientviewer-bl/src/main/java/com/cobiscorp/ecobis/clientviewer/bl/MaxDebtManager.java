package com.cobiscorp.ecobis.clientviewer.bl;

import com.cobiscorp.ecobis.clientviewer.dto.MaxDebtDTO;

public interface MaxDebtManager {

	/**
	 * Method used to obtain Maximum Debts of Customer or Economic Group
	 * 
	 * @param customerCode
	 *            , it's a customer code for the consultation
	 * @param groupCode
	 *            , it's a group code for the consultation
	 * @return object MaxDebtDTO, contain many parameter to wait a page
	 * @see MaxDebtDTO
	 */
	public MaxDebtDTO getMaxDebt(Integer customerCode, Integer groupCode);

}
