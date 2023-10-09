package com.cobiscorp.ecobis.clientviewer;

import com.cobiscorp.ecobis.clientviewer.dto.MaxDebtDTO;


public interface MaxDebtService {
	
	/**
	 * Method used to obtain Maximum Debts of Customer or Economic Group.
	 * @param customerCode, it's a customer code for the consultation.
	 * @param groupCode, it's the economic group code for the consultation.
	 * @return object MaxDebtDTO, contain many parameter to wait a page.
	 */

	MaxDebtDTO getMaxDebt(Integer customerCode, Integer groupCode);
}
