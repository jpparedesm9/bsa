package com.cobiscorp.ecobis.admintoken.interfaces;

import com.cobiscorp.ecobis.admintoken.dto.DataTokenRequest;
import com.cobiscorp.ecobis.admintoken.dto.DataTokenResponse;

public interface IAdminTokenUser {
	DataTokenResponse generateTokenUser(DataTokenRequest dataIn);

	DataTokenResponse validateTokenUser(DataTokenRequest dataIn);

	String getTokenLength();

	boolean isValidPasword(String clientId, String password, String login, int channel);
}
