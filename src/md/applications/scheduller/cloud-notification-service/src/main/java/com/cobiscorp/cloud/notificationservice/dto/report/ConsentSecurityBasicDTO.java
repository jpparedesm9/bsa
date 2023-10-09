package com.cobiscorp.cloud.notificationservice.dto.report;

import java.util.List;

public class ConsentSecurityBasicDTO {

	private List<ConsentOfSegurityDTO> listConsentSecurityBasic;

	/**
	 * @return the listConsentSecurityBasic
	 */
	public List<ConsentOfSegurityDTO> getListConsentSecurityBasic() {
		return listConsentSecurityBasic;
	}

	/**
	 * @param listConsentSecurityBasic the listConsentSecurityBasic to set
	 */
	public void setListConsentSecurityBasic(List<ConsentOfSegurityDTO> listConsentSecurityBasic) {
		this.listConsentSecurityBasic = listConsentSecurityBasic;
	}

}
