package com.cobiscorp.ecobis.cobiscloudbiometric.bsl.serv.bsl;

import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.AccessTokenResponse;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.ClientInformation;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.OpaqueTokenResponse;

public interface IOrchestationBiometricService  {

	AccessTokenResponse accessToken(String urlAccessToken, String flagFunc);

	OpaqueTokenResponse opaqueToken(ClientInformation clientInformation);
	
	AccessTokenResponse accessTokenBC(String urlAccessToken);
}
