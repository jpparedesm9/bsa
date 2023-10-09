package com.cobiscorp.mobile.service.interfaces;

import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.Client;
import com.cobiscorp.mobile.model.OpaqueTokenResponse;
import com.cobiscorp.mobile.model.RenapoClientRequest;
import com.cobiscorp.mobile.model.RenapoClientResponse;
import com.cobiscorp.mobile.request.FingerPrintRequest;
import com.cobiscorp.mobile.request.FingerprintBiometricRequest;
import com.cobiscorp.mobile.request.TopicRequest;
import com.cobiscorp.mobile.response.OCRMsgResponse;
import com.cobiscorp.mobile.response.SCORESMsgResponse;

public interface IBioOnbording {

	/**
	 * Realiza la consulta a Renapo
	 * 
	 * @param curp
	 * @return información del cliente por curp
	 * @throws MobileServiceException
	 */

	RenapoClientResponse generateQuery(RenapoClientRequest Curp, String cobisSessionId) throws MobileServiceException;
	
	OpaqueTokenResponse executeBioOnboarding(Client clientInformation, String cobisSessionId) throws MobileServiceException;

	OpaqueTokenResponse fingerprintCapture(FingerPrintRequest fingerPrintRequest, String cobisSessionId) throws MobileServiceException;
	OpaqueTokenResponse fingerprintCaptureValidation(FingerprintBiometricRequest fingerBiometricRequest, String cobisSessionId) throws MobileServiceException;
	
	OCRMsgResponse recieveOCRMsg(TopicRequest topicRequest, String cobisSessionId) throws MobileServiceException;
	SCORESMsgResponse recieveSCORESMsg(TopicRequest topicRequest, String cobisSessionId) throws MobileServiceException;

}
