package com.cobiscorp.ecobis.cobiscloudonboard.bsl.serv.bsl;

import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.AccessTokenResponse;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.ClientInformation;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenResponse;

public interface IOrchestationBioOnboardingService  {

	OpaqueTokenResponse execBioOnboard(ClientInformation clientInformation);
	
	AccessTokenResponse generateAccessToken(String urlAccessToken);

	OpaqueTokenResponse opaqueToken(ClientInformation clientInformation, AccessTokenResponse wAccessTokenResponse);
	
	OpaqueTokenResponse validateOpaqueToken(ClientInformation clientInformation, OpaqueTokenResponse wOpaqueTokenResponse, AccessTokenResponse wAccessTokenResponse);
}
