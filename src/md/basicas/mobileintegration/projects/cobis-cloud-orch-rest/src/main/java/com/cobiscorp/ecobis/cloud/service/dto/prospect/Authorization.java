package com.cobiscorp.ecobis.cloud.service.dto.prospect;

import java.util.Calendar;

public class Authorization {

	private String typeAuthorization;
	private Calendar dateAuthorization;

	public String getTypeAuthorization() {
		return typeAuthorization;
	}

	public void setTypeAuthorization(String typeAuthorization) {
		this.typeAuthorization = typeAuthorization;
	}

	public Calendar getDateAuthorization() {
		return dateAuthorization;
	}

	public void setDateAuthorization(Calendar dateAuthorization) {
		this.dateAuthorization = dateAuthorization;
	}

}
