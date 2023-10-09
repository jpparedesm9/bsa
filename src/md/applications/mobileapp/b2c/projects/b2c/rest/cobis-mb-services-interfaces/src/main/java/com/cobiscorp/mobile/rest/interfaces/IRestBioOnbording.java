package com.cobiscorp.mobile.rest.interfaces;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Response;

import com.cobiscorp.mobile.model.Client;
import com.cobiscorp.mobile.model.RenapoClientRequest;
import com.cobiscorp.mobile.request.FingerPrintRequest;
import com.cobiscorp.mobile.request.FingerprintBiometricRequest;
import com.cobiscorp.mobile.request.TopicRequest;

public interface IRestBioOnbording {
	public Response queryRenapoByCurp(RenapoClientRequest clientRequest, HttpServletRequest httpRequest);
	public Response fingerprintCapture(FingerPrintRequest fingerPrintRequest, HttpServletRequest httpRequest);
	public Response fingerprintBiometricValidation(FingerprintBiometricRequest biometricRequest, HttpServletRequest httpRequest);
	public Response execBioOnboarding(Client clientInf, HttpServletRequest httpRequest);
	public Response recieveOCRMsg(TopicRequest topicRequest, HttpServletRequest httpRequest);
	public Response recieveSCORESMsg(TopicRequest topicRequest, HttpServletRequest httpRequest);

}
