package com.cobiscorp.ecobis.cobiscloudonboard.bsl.serv.bsl;

import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.AccessTokenResponse;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.ClientInformation;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.FingerPrintRequest;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenResponse;

public interface IOrchestationFingerIDService  {

	OpaqueTokenResponse fingerprintCapture(FingerPrintRequest fingerPrintRequest) throws Exception;
	
	OpaqueTokenResponse fingerprintBiometricValidation(FingerPrintRequest fingerBiometricRequest)  throws Exception;
	
	//AccessTokenResponse generateAccessToken(String urlAccessToken);

	OpaqueTokenResponse opaqueToken(FingerPrintRequest fingerPrintRequest, AccessTokenResponse wAccessTokenResponse);
	
	OpaqueTokenResponse validateOpaqueToken(FingerPrintRequest fingerPrintRequest, AccessTokenResponse wAccessTokenResponse);
}
