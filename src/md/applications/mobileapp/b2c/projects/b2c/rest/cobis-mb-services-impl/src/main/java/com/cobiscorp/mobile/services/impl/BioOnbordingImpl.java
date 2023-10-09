package com.cobiscorp.mobile.services.impl;

import java.security.Key;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.crypt.ICobisCrypt;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.ecobis.cobiscloudfingerid.impl.OrchestrationFingerIDServiceSERVImpl;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.ClientInformation;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.ErrorMessage;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.SecObjData;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.SecObjInfoBean;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.SecObjRec;
import com.cobiscorp.ecobis.cobiscloudonboard.impl.OrchestrationBioOnboardingServiceSERVImpl;
import com.cobiscorp.ecobis.cobiscloudonboard.util.impl.Utils;
import com.cobiscorp.ecobis.cobiscloudonbrenapo.impl.OrchestationRenapoServiceSERVImpl;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.Client;
import com.cobiscorp.mobile.model.ErrorResponse;
import com.cobiscorp.mobile.model.fingerid.FingerRequestNode;
import com.cobiscorp.mobile.model.fingerid.FingerResponseNode;
import com.cobiscorp.mobile.model.OpaqueTokenResponse;
import com.cobiscorp.mobile.model.RenapoClientRequest;
import com.cobiscorp.mobile.model.RenapoClientResponse;
import com.cobiscorp.mobile.request.FingerPrintRequest;
import com.cobiscorp.mobile.request.FingerprintBiometricRequest;
import com.cobiscorp.mobile.request.TopicRequest;
import com.cobiscorp.mobile.response.BiometryScore;
import com.cobiscorp.mobile.response.DocumentScore;
import com.cobiscorp.mobile.response.OCRMsgResponse;
import com.cobiscorp.mobile.response.Ocr;
import com.cobiscorp.mobile.response.SCORESMsgResponse;
import com.cobiscorp.mobile.response.Scores;
import com.cobiscorp.mobile.service.interfaces.IBioOnbording;
import com.cobiscorp.mobile.services.impl.utils.CharactersUtil;
import com.cobiscorp.mobile.services.impl.utils.ManagerException;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.gson.Gson;

import cobiscorp.ecobis.businesstoconsumer.dto.BioOnboardDetailResponse;
import cobiscorp.ecobis.businesstoconsumer.dto.BioOnboardHeaderResponse;
import cobiscorp.ecobis.businesstoconsumer.dto.BioOnboardingRequest;
import cobiscorp.ecobis.businesstoconsumer.dto.FingerIDRequest;
import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.parameter.dto.ParameterSearchResponse;

@Component
@Service({ IBioOnbording.class })
@Properties({ @Property(name = "service.impl", value = "current") })
public class BioOnbordingImpl extends ServiceBase implements IBioOnbording {

	private static final String CHNL_FNGR = "FI";
	private static final String CHNL_BIO = "BIO";

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	@Reference(bind = "setCobisCrypt", unbind = "unsetCobisCrypt", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICobisCrypt cobisCrypt;
	private static final int IDEXP_LEN = 25;

	/** Vars for log */
	private static final String CLASS_NAME = " [ MB ---> BioOnbordingImpl] ";
	private static final String ID_APPLICATION = "bancaMovil";
	private static final String M = "bancaMovil";
	private ILogger LOGGER = LogFactory.getLogger(BioOnbordingImpl.class);

	private static final String CURP_MESSAGE_NOT_EXIST = "La CURP indicada no muestra ningún resultado. Por favor revisa la información capturada y reintenta nuevamente.";

	private Map<String, Key> privateKeysMap;
	private ISPOrchestrator spOrchestrator;

	public void setPrivateKeysMap(Map<String, Key> privateKeysMap) {
		this.privateKeysMap = privateKeysMap;
	}

	@Override
	public RenapoClientResponse generateQuery(RenapoClientRequest clientRequest, String cobisSessionId)
			throws MobileServiceException {

		MessageTO messageTO = new MessageTO();
		RenapoClientResponse response = new RenapoClientResponse();
		OrchestationRenapoServiceSERVImpl orchestationRenapoServiceSERVImpl = new OrchestationRenapoServiceSERVImpl();
		com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.RenapoClientResponse renapoClientResponse = new com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.RenapoClientResponse();
		com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.RenapoClientRequest renapoClientRequest = new com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.RenapoClientRequest();

		renapoClientRequest.setCurp(clientRequest.getCurp());

		// Carga de parametros a la aplicación
		StringBuilder transactionId = new StringBuilder();
		ParameterServiceImpl parameterService = new ParameterServiceImpl();
		parameterService.setServiceIntegration(serviceIntegration);

		ParameterSearchResponse channel = parameterService.searchParameter("RENCHN", "CLI", cobisSessionId);
		ParameterSearchResponse branch = parameterService.searchParameter("RENBRN", "CLI", cobisSessionId);
		ParameterSearchResponse transactionType = parameterService.searchParameter("RENTTP", "CLI", cobisSessionId);

		renapoClientRequest.setBranch(branch.getCharValue());
		renapoClientRequest.setTransactionType(transactionType.getCharValue());
		renapoClientRequest.setChannel(channel.getCharValue());

		// Se obtiene el transacción id desde un randomico

		Random random = new Random();
		for (int i = 0; i < 25; i++) {
			transactionId.append(random.nextInt(10));
		}

		renapoClientRequest.setTransactionId(transactionId.toString());

		try {
			renapoClientResponse = orchestationRenapoServiceSERVImpl.renapoQueryByCurp(renapoClientRequest);

			response = changeRenapoClientResponse(renapoClientResponse);

			if (response.getErrores() != null)
				throw new MobileServiceException(CURP_MESSAGE_NOT_EXIST);

			if (response.getErrorMessage() != null)
				throw new MobileServiceException(CURP_MESSAGE_NOT_EXIST);

			return response;

		} catch (Exception e) {
			LOGGER.logError("BioOnbordingImpl - generateQuery Error:" + e);
			LOGGER.logError("BioOnbordingImpl - generateQuery Error:" + e.getMessage());
			throw new MobileServiceException(e.getMessage());
		}

	}

	@Override
	public OpaqueTokenResponse executeBioOnboarding(Client clientInfor, String cobisSessionId)
			throws MobileServiceException {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("BioOnbordingImpl - executeBioOnborading - INI");
		}
		com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.ClientInformation clientInformation = new com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.ClientInformation();
		clientInformation.setIdCliente(clientInfor.getIdCliente());
		setAdditionalParameters(clientInformation, clientInfor, cobisSessionId);

		OrchestrationBioOnboardingServiceSERVImpl orchOnboardServSERVImpl = new OrchestrationBioOnboardingServiceSERVImpl();
		try {
			// Solo para pruebas en DESA - INI 
			//com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenResponse opaqueTokenResp = new com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenResponse();
			com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenResponse opaqueTokenResp = orchOnboardServSERVImpl
					.execBioOnboard(clientInformation);
			// Solo para pruebas en DESA - FIN
			
			OpaqueTokenResponse otReq = new OpaqueTokenResponse();

			otReq.setIdExpediente(opaqueTokenResp.getFileId());
			otReq.setUrlWeb(concatenateTokenToUrl(opaqueTokenResp, cobisSessionId, CHNL_BIO));
			if (opaqueTokenResp.getErrorMessage() != null) {
				otReq.setCode(opaqueTokenResp.getErrorMessage().getError());
				otReq.setMessage(opaqueTokenResp.getErrorMessage().getErrorDescription());
				throw new MobileServiceException(otReq.getCode(), otReq.getMessage());
			}

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("BioOnbordingImpl - executeBioOnborading - FIN");
			}
			return otReq;
		} catch (Exception e) {
			LOGGER.logError("BioOnbordingImpl - executeBioOnborading Error:", e);
		}
		return null;
	}

	@Override
	public OpaqueTokenResponse fingerprintCapture(FingerPrintRequest fingerPrintRequest, String cobisSessionId)
			throws MobileServiceException {

		com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.FingerPrintRequest fingerPrintReq = createFingerPrintRequest(
				fingerPrintRequest, cobisSessionId);
		setAdditionalParameters(fingerPrintReq, cobisSessionId);

		OrchestrationFingerIDServiceSERVImpl orchFingerIDServSERVImpl = new OrchestrationFingerIDServiceSERVImpl();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("BioOnbordingImpl - fingerprintCapture - INI");
		}

		try {
			// Solo para pruebas en DESA - INI 
//			com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenResponse opaqueTokenResp = new com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenResponse();
			com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenResponse opaqueTokenResp = orchFingerIDServSERVImpl
					.fingerprintCapture(fingerPrintReq);
			// Solo para pruebas en DESA - FIN
			
			OpaqueTokenResponse otReq = new OpaqueTokenResponse();

			otReq.setUrlWeb(getUrlWebParameter(cobisSessionId, CHNL_FNGR));
			if (LOGGER.isDebugEnabled() && opaqueTokenResp != null && opaqueTokenResp.getStatus() != null) {
				LOGGER.logDebug("BioOnbordingImpl - fingerprintCapture - getStatusCode" + opaqueTokenResp.getStatus().getStatusCode());
				if (opaqueTokenResp.getStatus().getStatusCode() == 10000) {
					LOGGER.logDebug("BioOnbordingImpl - fingerprintCapture - OpakeToken" + opaqueTokenResp.getSecObjRec().getSecObjInfo().getSecObjValue());
				}
			}
			if (opaqueTokenResp != null && opaqueTokenResp.getStatus() != null
					&& opaqueTokenResp.getStatus().getStatusCode() == 10000) {
				otReq.setOpakeToken(opaqueTokenResp.getSecObjRec().getSecObjInfo().getSecObjValue());
			}
			if (opaqueTokenResp != null && opaqueTokenResp.getErrorMessage() != null && opaqueTokenResp.getErrorMessage().getError() != null
					&& !"".equals(opaqueTokenResp.getErrorMessage().getError())) {
				otReq.setCode(opaqueTokenResp.getErrorMessage().getError());
				otReq.setMessage(opaqueTokenResp.getErrorMessage().getErrorDescription());
				LOGGER.logError("Error en la ejecucion de Biometria: " + opaqueTokenResp.getErrorMessage().getError()
						+ opaqueTokenResp.getErrorMessage().getErrorDescription());
				throw new MobileServiceException(otReq.getCode(), otReq.getMessage());
			} else if (opaqueTokenResp != null && opaqueTokenResp.getErrorMessage() != null
					&& opaqueTokenResp.getErrorMessage().getHttpCode() != null
					&& !"".equals(opaqueTokenResp.getErrorMessage().getHttpCode())) {
				otReq.setCode(opaqueTokenResp.getErrorMessage().getHttpCode());
				otReq.setMessage("Error en la ejecucion de Biometria.");
				LOGGER.logError("Error en la ejecucion de Biometria: " + opaqueTokenResp.getErrorMessage().getHttpCode()
						+ opaqueTokenResp.getErrorMessage().getHttpMessage());
				throw new MobileServiceException(otReq.getCode(), otReq.getMessage());
			} else if (opaqueTokenResp != null && opaqueTokenResp.getStatus() != null
					&& opaqueTokenResp.getStatus().getStatusCode() != 10000) {
				otReq.setCode(String.valueOf(opaqueTokenResp.getStatus().getStatusCode()));
				otReq.setMessage("Error en la ejecucion de Biometria.2");
				LOGGER.logError("Error en la ejecucion de Biometria2: " + opaqueTokenResp.getStatus().getStatusCode()
						+ opaqueTokenResp.getStatus().getStatusDesc());
				throw new MobileServiceException(otReq.getCode(), otReq.getMessage());
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("BioOnbordingImpl - fingerprintCapture - FIN");
			}

			return otReq;
		} catch (Exception e) {
			LOGGER.logError("BioOnbordingImpl - fingerprintCapture Error:", e);
		}
		return null;
	}

	public OpaqueTokenResponse fingerprintCaptureValidation(FingerprintBiometricRequest fingerBiometricRequest,
			String cobisSessionId) throws MobileServiceException {
		OrchestrationFingerIDServiceSERVImpl orchFingerIDServSERVImpl = new OrchestrationFingerIDServiceSERVImpl();

		com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.FingerPrintRequest fingerPrintReq = new com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.FingerPrintRequest();
		fingerPrintReq.setTokenToValid(fingerBiometricRequest.getToken());
		try {

			// PAra pruebas en DESA - INI
//			com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenResponse opaqueTokenResp = new com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenResponse();
			com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenResponse opaqueTokenResp = orchFingerIDServSERVImpl
					.fingerprintBiometricValidation(fingerPrintReq);

			if(opaqueTokenResp !=null) {
				saveFingerIdValidationResponse(opaqueTokenResp, cobisSessionId);
			}else {
				throw new MobileServiceException("Error en Validación de Biomovil");
			}

			OpaqueTokenResponse otReq = new OpaqueTokenResponse();
//			otReq.setEvaluation("APROBADO");
			otReq.setEvaluation(opaqueTokenResp.getEvaluation());

			if(opaqueTokenResp.getErrorMessage() != null) {
				otReq.setCode(opaqueTokenResp.getErrorMessage().getError());
				otReq.setMessage(opaqueTokenResp.getErrorMessage().getErrorDescription());
				LOGGER.logError("Error en la ejecucion de Biometria: " + opaqueTokenResp.getErrorMessage().getError() + opaqueTokenResp.getErrorMessage().getErrorDescription());
				throw new MobileServiceException(otReq.getCode(),otReq.getMessage());
			}else if(opaqueTokenResp.getErrorMessage() != null && opaqueTokenResp.getErrorMessage().getHttpCode() != null && opaqueTokenResp.getErrorMessage().getHttpCode() != "" ) {
				otReq.setCode(opaqueTokenResp.getErrorMessage().getHttpCode());
				otReq.setMessage("Error en la ejecucion de Biometria:" + opaqueTokenResp.getErrorMessage().getHttpMessage());
				LOGGER.logError("Error en la ejecucion de Biometria: " + opaqueTokenResp.getErrorMessage().getHttpCode() + opaqueTokenResp.getErrorMessage().getHttpMessage());
				throw new MobileServiceException(otReq.getCode(),otReq.getMessage());
			}
			// PAra pruebas en DESA - FIN

			return otReq;
		} catch (Exception e) {
			LOGGER.logError("BioOnbordingImpl - fingerprintCaptureValidation Error:" + e);
		}
		return null;
	}

	@Override
	public OCRMsgResponse recieveOCRMsg(TopicRequest topicRequest, String cobisSessionId)
			throws MobileServiceException {
		OCRMsgResponse wOCRMsgResponse = new OCRMsgResponse();
		BioOnboardingRequest boReq = new BioOnboardingRequest();
		boReq.setFileId(topicRequest.getIdExpediente());

		try {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(ID_APPLICATION + CLASS_NAME + "recieveOCRMsg - INI");
			}
			ServiceRequestTO serviceRequest = new ServiceRequestTO();
			serviceRequest.addValue("inBioOnboardingRequest", boReq);

			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER,
					"BusinessToConsumer.BioOnboardManagement.QueryOCRInfor", cobisSessionId, serviceRequest);
			if (serviceResponseTO.isSuccess()) {
				BioOnboardHeaderResponse[] bioOnbHeaderRespo = (BioOnboardHeaderResponse[]) serviceResponseTO.getData()
						.get("returnBioOnboardHeaderResponse");
				BioOnboardDetailResponse[] bioOnbDetailRespo = (BioOnboardDetailResponse[]) serviceResponseTO.getData()
						.get("returnBioOnboardDetailResponse");
				setOCRInformation(wOCRMsgResponse, bioOnbHeaderRespo, bioOnbDetailRespo);
				wOCRMsgResponse.setTriesNumber(getTriesNumberParam(cobisSessionId));
			} else {
				manageResponseError(serviceResponseTO, LOGGER);
			}

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(ID_APPLICATION + CLASS_NAME + "recieveOCRMsg - FIN");
			}
		} catch (Exception e) {
			LOGGER.logError(ID_APPLICATION + CLASS_NAME + "recieveOCRMsg - ERROR:", e);
		}
		return wOCRMsgResponse;
	}

	@Override
	public SCORESMsgResponse recieveSCORESMsg(TopicRequest topicRequest, String cobisSessionId)
			throws MobileServiceException {
		// Crear el tema de las consultas con el GSON de los archivo SCORES.txt
		// Gson g = new Gson();
		// String jsonString =
		// "{\"idExpediente\":\"lKgANQz\",\"idValidas\":\"8a60361c5fc04672b505f04016bc074a\",\"scores\":{\"BiometryScores\":[{\"name\":\"ValidasScoreSelfie\",\"value\":0.8850150221854044},{\"name\":\"ValidasScorePhotoId\",\"value\":0.8850150221854044},{\"name\":\"ValidasScoreDuplicateAttack\",\"value\":0.7818295713466911},{\"name\":\"ValidasScoreLifeProof\",\"value\":0.9995763661532303},{\"name\":\"ValidasScoreVideo\",\"value\":0.9998530762313068}],\"DocumentScores\":[{\"name\":\"ScoreVal-PD_BirthPlaceStateName_ID-MinimumLength\",\"value\":0},{\"name\":\"ScoreVal-PD_BirthPlaceStateName_ID-Blacklist\",\"value\":1},{\"name\":\"ScoreVal-PD_BirthPlaceStateName_ID-Blacklist-2\",\"value\":1},{\"name\":\"ScoreVal-PD_BirthPlaceStateName_ID-Blacklist-3\",\"value\":1},{\"name\":\"ScoreVal-PD_BirthPlaceStateName_ID-Blacklist-4\",\"value\":1},{\"name\":\"ScoreGroup-OD_RegistrationDate-DataValidity\",\"value\":0},{\"name\":\"ScoreVal-PD_BirthPlaceStateName_CURP-MinimumLength\",\"value\":0},{\"name\":\"ScoreVal-PD_BirthPlaceStateName_CURP-Blacklist\",\"value\":1},{\"name\":\"ScoreVal-PD_BirthPlaceStateName_CURP-Blacklist-2\",\"value\":1},{\"name\":\"ScoreVal-PD_BirthPlaceStateName_CURP-Blacklist-3\",\"value\":1},{\"name\":\"ScoreVal-PD_BirthPlaceStateName_CURP-Blacklist-4\",\"value\":1},{\"name\":\"ScoreGroup-DataValidity\",\"value\":0.8518518518518517},{\"name\":\"ScoreVal-DD_ExpirationDate_MRZ-DateRange\",\"value\":1},{\"name\":\"ScoreVal-DD_ExpirationDate_FrontNoFlash-DateRange\",\"value\":0},{\"name\":\"ScoreVal-OD_RegistrationDate_Out-Regular\",\"value\":0},{\"name\":\"ScoreGroup-MRZDecoding\",\"value\":0.5},{\"name\":\"ScoreVal-PD_BirthPlaceStateCode_Out-Regular\",\"value\":0.5},{\"name\":\"ScoreRel-PD_BirthPlaceStateCode_CURP-PD_BirthPlaceStateCode_ID-Text\",\"value\":0},{\"name\":\"ScoreVal-OD_MRZLasTwoChar_MRZ-Value\",\"value\":1},{\"name\":\"ScoreVal-PD_LastName1_FrontNoFlash-Dictionary\",\"value\":0},{\"name\":\"ScoreVal-PD_LastName1_FrontNoFlash-MinimumLength\",\"value\":1},{\"name\":\"ScoreVal-PD_LastName1_FrontNoFlash-Blacklist\",\"value\":1},{\"name\":\"ScoreVal-PD_LastName1_FrontNoFlash-Blacklist-2\",\"value\":1},{\"name\":\"ScoreVal-PD_LastName1_FrontNoFlash-Blacklist-3\",\"value\":1},{\"name\":\"ScoreVal-PD_LastName1_FrontNoFlash-Blacklist-4\",\"value\":1},{\"name\":\"ScoreVal-PD_BirthDate_Out-DateRange\",\"value\":0},{\"name\":\"ScoreVal-PD_BirthDate_FrontNoFlash-DateRange\",\"value\":0},{\"name\":\"ScoreVal-OD_CURP_Out-Regular\",\"value\":0.7222222222222222},{\"name\":\"ScoreVal-OD_CURPGenerated_Out-Regular\",\"value\":0}]}}";
		SCORESMsgResponse wSCORESMsgResponse = new SCORESMsgResponse();
		BioOnboardingRequest boReq = new BioOnboardingRequest();
		boReq.setFileId(topicRequest.getIdExpediente());
		try {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(ID_APPLICATION + CLASS_NAME + "recieveSCORESMsg - INI");
			}
			ServiceRequestTO serviceRequest = new ServiceRequestTO();
			serviceRequest.addValue("inBioOnboardingRequest", boReq);

			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER,
					"BusinessToConsumer.BioOnboardManagement.QuerySCORESInfor", cobisSessionId, serviceRequest);
			if (serviceResponseTO.isSuccess()) {
				BioOnboardHeaderResponse[] bioOnbHeaderRespo = (BioOnboardHeaderResponse[]) serviceResponseTO.getData()
						.get("returnBioOnboardHeaderResponse");
				BioOnboardDetailResponse[] bioOnbDetailBioResp = (BioOnboardDetailResponse[]) serviceResponseTO
						.getData().get("returnBioOnboardDetailResponse");
				BioOnboardDetailResponse[] bioOnbDetailDocResp = (BioOnboardDetailResponse[]) serviceResponseTO
						.getData().get("returnBioOnboardDetailResponse2");
				setSCORESInformation(wSCORESMsgResponse, bioOnbHeaderRespo, bioOnbDetailBioResp, bioOnbDetailDocResp);
				wSCORESMsgResponse.setTriesNumber(getTriesNumberParam(cobisSessionId));
			} else {
				manageResponseError(serviceResponseTO, LOGGER);
			}

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(ID_APPLICATION + CLASS_NAME + "recieveSCORESMsg - wSCORESMsgResponse="
						+ wSCORESMsgResponse.toString());
				LOGGER.logDebug(ID_APPLICATION + CLASS_NAME + "recieveSCORESMsg - FIN");
			}
			return wSCORESMsgResponse;
		} catch (Exception e) {
			LOGGER.logError(ID_APPLICATION + CLASS_NAME + "recieveSCORESMsg - ERROR:", e);
		}
		return null;
	}

	private void saveFingerIdValidationResponse(
			com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenResponse wOpaqueTokenResponse,
			String cobisSessionId) throws MobileServiceException {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(
					"[OrchestrationFingerIDServiceSERVImpl saveFingerIdValidationResponse] ------> wOpaqueTokenResponse ---> "
							+ wOpaqueTokenResponse.toString());
		}
		// llamada al SG para guardar el response
		FingerIDRequest fiReq = setFingerIDRequest(wOpaqueTokenResponse);
		if (fiReq != null) {

			ServiceRequestTO serviceRequest = new ServiceRequestTO();
			serviceRequest.addValue("inFingerIDRequest", fiReq);

			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER,
					"BusinessToConsumer.BioOnboardManagement.InsertFingerIDResponse", cobisSessionId, serviceRequest);
			if (serviceResponseTO != null && serviceResponseTO.isSuccess()) {
				Map<String, Object> customerResponse = (Map<String, Object>) serviceResponseTO
						.getValue("com.cobiscorp.cobis.cts.service.response.output");
				wOpaqueTokenResponse.setEvaluation(Utils.getOutputs(customerResponse, "@o_respuesta").toString());// APROBADO
			} else {
				manageResponseError(serviceResponseTO, LOGGER);
			}
		} else {
			throw new MobileServiceException("Error al validar generar FingerID Request");
		}
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(
					"[OrchestrationFingerIDServiceSERVImpl saveFingerIdValidationResponse] ------> wOpaqueTokenResponse.getEvaluation ---> "
							+ wOpaqueTokenResponse.getEvaluation());
		}
	}

	private FingerIDRequest setFingerIDRequest(
			com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenResponse wOpaqueTokenResponse) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl validateOpaqueTokenResponse] ------> INI ---> ");
		}

		// Solo para pruebas en DESA - INI
//		 com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenResponse xOpaqueTokenResponse = settingDataToOpaqueTokenResponse();
		// wOpaqueTokenResponse = xOpaqueTokenResponse;
		// Solo para pruebas en DESA - FIN

		if (validateOpaqueTokenResponse(wOpaqueTokenResponse)) {
			List<SecObjData> secObjDataList = wOpaqueTokenResponse.getSecObjRec().getSecObjInfoBean().getSecObjData();

			FingerIDRequest fiReq = new FingerIDRequest();
			for (SecObjData secObjData : secObjDataList) {
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug(
							"[OrchestrationFingerIDServiceSERVImpl validateOpaqueTokenResponse] ------> secObjData.getSecObjDataValue="
									+ secObjData.getSecObjDataValue());
				}

				if ("REQUEST".equals(secObjData.getSecObjDataKey())) {
					setREQUESTNode(fiReq, secObjData);
				}
				if ("RESPONSE".equals(secObjData.getSecObjDataKey())) {
					setRESPONSENode(fiReq, secObjData);
				}
				if ("TRX".equals(secObjData.getSecObjDataKey())) {
					fiReq.setTrxId(String.valueOf(secObjData.getSecObjDataValue()).replace("\"", ""));
				}
				if ("FCH_START".equals(secObjData.getSecObjDataKey())) {
					fiReq.setStartDate(String.valueOf(secObjData.getSecObjDataValue()));
				}
				if ("FCH_END".equals(secObjData.getSecObjDataKey())) {
					fiReq.setEndDate(String.valueOf(secObjData.getSecObjDataValue()));
				}
				if ("TYPE".equals(secObjData.getSecObjDataKey())) {
					fiReq.setTrxTypeDesc(String.valueOf(secObjData.getSecObjDataValue()));
				}
				if ("CODE".equals(secObjData.getSecObjDataKey())) {
					fiReq.setErrCode(String.valueOf(secObjData.getSecObjDataValue()));
				}

			}
			return fiReq;
		}
		return null;
	}

	private void setREQUESTNode(FingerIDRequest fiReq, SecObjData secObjData) {
		Gson g = new Gson();
		FingerRequestNode aFingerReqNode = g.fromJson(String.valueOf(secObjData.getSecObjDataValue()),
				FingerRequestNode.class);
		fiReq.setTrxType(aFingerReqNode.getTransactionType());
	}

	private void setRESPONSENode(FingerIDRequest fiReq, SecObjData secObjData) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(
					"[OrchestrationFingerIDServiceSERVImpl setRESPONSENode] ------> secObjData.getSecObjDataValue="
							+ secObjData.getSecObjDataValue());
		}
		Gson h = new Gson();
		FingerResponseNode aFingerResponse = h.fromJson(String.valueOf(secObjData.getSecObjDataValue())
				.replace("\"{\\\"", "{\"").replace("\\\"}\"", "\"}").replace("\\", ""),
				FingerResponseNode.class);

		if (aFingerResponse.getResponse() != null) {
			setResponseSection(fiReq, aFingerResponse);
		}
		
		if (aFingerResponse.getSignature() != null) {
			setSignatureSection(fiReq, aFingerResponse);
		}
		
		if (aFingerResponse.getTimeStamp() != null) {
			setTimeStampSection(fiReq, aFingerResponse);
		}
		if (aFingerResponse.getHash() != null) {
			fiReq.setHash(aFingerResponse.getHash());
		}
	}

	private void setResponseSection(FingerIDRequest fiReq, FingerResponseNode aFingerResponse) {
		fiReq.setAnswerCode(aFingerResponse.getResponse().getCodigoRespuesta());
		fiReq.setRequestDatetime(aFingerResponse.getResponse().getFechaHoraPeticion());
		fiReq.setIndexRequest(aFingerResponse.getResponse().getIndiceSolicitud());
		fiReq.setProcessingTime(aFingerResponse.getResponse().getTiempoProcesamiento());
		
		if (aFingerResponse.getResponse().getDataResponse() != null) {
			fiReq.setDataResponseCode(aFingerResponse.getResponse().getDataResponse().getCodigoRespuestaDatos());
			
			if (aFingerResponse.getResponse().getDataResponse().getRespuestaComparacion() != null) {
				setRespuestaComparacionSubSection(fiReq, aFingerResponse);
			}
			
			if (aFingerResponse.getResponse().getDataResponse().getRespuestaSituacionRegistral() != null) {
				setRespuestaSituacionRegistralSubSection(fiReq, aFingerResponse);
			}
		}
		
		if (aFingerResponse.getResponse().getMinutiaeResponse() != null) {
			setMinutiaeResponseSubSection(fiReq, aFingerResponse);
		}
	}

	private void setSignatureSection(FingerIDRequest fiReq, FingerResponseNode aFingerResponse) {
		fiReq.setXSerialNumber(
				String.valueOf(aFingerResponse.getSignature().getKeyInfo().getX509Data().getX509SerialNumber()));
		fiReq.setSignatureValue(aFingerResponse.getSignature().getSignatureValue());
		
		
		if (aFingerResponse.getSignature().getSignedInfo() != null) {
			if (aFingerResponse.getSignature().getSignedInfo().getCanonicalizationMethod() != null) {
				fiReq.setCanonicalizationMethod(aFingerResponse.getSignature().getSignedInfo()
						.getCanonicalizationMethod().getAlgorithm());
			}
			if (aFingerResponse.getSignature().getSignedInfo().getSignatureMethod() != null) {
				fiReq.setSignatureMethod(
						aFingerResponse.getSignature().getSignedInfo().getSignatureMethod().getAlgorithm());
			}
			if (aFingerResponse.getSignature().getSignedInfo().getReference()!= null) {
				
				if (aFingerResponse.getSignature().getSignedInfo().getReference()
							.getDigestMethod() != null) {
					fiReq.setDigestMethodReferenceAlg(aFingerResponse.getSignature().getSignedInfo().getReference()
							.getDigestMethod().getAlgorithm());
				}
				fiReq.setDigestMethodReferenceValue(
						aFingerResponse.getSignature().getSignedInfo().getReference().getDigestValue());
				fiReq.setDigestMethodReferenceUri(
						aFingerResponse.getSignature().getSignedInfo().getReference().getUri());
			}
		}
	}

	private void setTimeStampSection(FingerIDRequest fiReq, FingerResponseNode aFingerResponse) {
		fiReq.setMoment(String.valueOf(aFingerResponse.getTimeStamp().getMomento()));
		fiReq.setIndex(String.valueOf(aFingerResponse.getTimeStamp().getIndice()));
		fiReq.setSerialNumber(String.valueOf(aFingerResponse.getTimeStamp().getNumeroSerie()));
	}

	private void setRespuestaSituacionRegistralSubSection(FingerIDRequest fiReq, FingerResponseNode aFingerResponse) {
		fiReq.setTheftReportType(aFingerResponse.getResponse().getDataResponse()
				.getRespuestaSituacionRegistral().getTipoReporteRoboExtravio());
		fiReq.setTypeOfRegistrationStatus(aFingerResponse.getResponse().getDataResponse()
				.getRespuestaSituacionRegistral().getTipoSituacionRegistral());
	}

	private void setMinutiaeResponseSubSection(FingerIDRequest fiReq, FingerResponseNode aFingerResponse) {
		fiReq.setMinutiaeResponseCode(aFingerResponse.getResponse().getMinutiaeResponse().getCodigoRespuestaMinucia());
		fiReq.setSimilarity2(aFingerResponse.getResponse().getMinutiaeResponse().getSimilitud2());
		fiReq.setSimilarity7(aFingerResponse.getResponse().getMinutiaeResponse().getSimilitud7());
	}

	private void setRespuestaComparacionSubSection(FingerIDRequest fiReq, FingerResponseNode aFingerResponse) {
		fiReq.setIsOcr(aFingerResponse.getResponse().getDataResponse().getRespuestaComparacion().getOcr());
		fiReq.setIsCredentialIssuanceNumber(aFingerResponse.getResponse().getDataResponse()
				.getRespuestaComparacion().getNumeroEmisionCredencial());
		fiReq.setIsName(
				aFingerResponse.getResponse().getDataResponse().getRespuestaComparacion().getNombre());
		fiReq.setIsCurp(
				aFingerResponse.getResponse().getDataResponse().getRespuestaComparacion().getCurp());
		fiReq.setIsElectorKey(aFingerResponse.getResponse().getDataResponse().getRespuestaComparacion()
				.getClaveElector());
		fiReq.setIsLastname(aFingerResponse.getResponse().getDataResponse().getRespuestaComparacion()
				.getApellidoPaterno());
		fiReq.setIsSecLastname(aFingerResponse.getResponse().getDataResponse().getRespuestaComparacion()
				.getApellidoMaterno());
		fiReq.setIsYearOfIssue(
				aFingerResponse.getResponse().getDataResponse().getRespuestaComparacion().getAnioEmision());
		fiReq.setIsRegistrationYear(aFingerResponse.getResponse().getDataResponse()
				.getRespuestaComparacion().getAnioRegistro());
	}

	private boolean validateOpaqueTokenResponse(
			com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenResponse wOpaqueTokenResponse) {
		return wOpaqueTokenResponse != null && wOpaqueTokenResponse.getSecObjRec() != null
				&& wOpaqueTokenResponse.getSecObjRec().getSecObjInfoBean() != null
				&& wOpaqueTokenResponse.getSecObjRec().getSecObjInfoBean().getSecObjData() != null
				&& !wOpaqueTokenResponse.getSecObjRec().getSecObjInfoBean().getSecObjData().isEmpty();
	}

	// Solo para pruebas en DESA - INI
	private com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenResponse settingDataToOpaqueTokenResponse() {
		com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenResponse wOpaqueTokenResponse = new com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenResponse();

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(ID_APPLICATION + CLASS_NAME + " settingDataToOpaqueTokenResponse - INI");
		}
		String requestString = "{\"channel\":\"000\",\"branch\":\"0000\",\"transactionType\":\"7002\",\"transactionId\":\"5235248820220520091611490\",\"personalINEData\":{\"ocr\":\"2938087970648\",\"cic\":\"157080040\",\"name\":\"DAVID ALEJANDRO\",\"paternName\":\"RUIZ\",\"maternName\":\"BUCIO\",\"yearRecord\":null,\"yearEmision\":null,\"numberEmision\":\"03\",\"cveElector\":null,\"curp\":null},\"ubiety\":{\"location\":null,\"satellitePosition\":{\"latitude\":\"51.507\",\"longitude\":\"-0.128\"}},\"minutiae\":{\"type\":\"2\",\"width\":null,\"high\":null,\"minutiae2\":\"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\",\"minutiae7\":\"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\"},\"agree\":\"true\"}";

		String responseString = "\"{\\\"response\\\":{\\\"fechaHoraPeticion\\\":\\\"2022-05-20T09:16:12.365\\\",\\\"indiceSolicitud\\\":\\\"10386406\\\",\\\"dataResponse\\\":{\\\"respuestaSituacionRegistral\\\":{\\\"tipoSituacionRegistral\\\":\\\"VIGENTE\\\",\\\"tipoReporteRoboExtravio\\\":null},\\\"respuestaComparacion\\\":{\\\"anioRegistro\\\":null,\\\"claveElector\\\":null,\\\"apellidoPaterno\\\":true,\\\"anioEmision\\\":null,\\\"numeroEmisionCredencial\\\":true,\\\"nombre\\\":true,\\\"curp\\\":null,\\\"apellidoMaterno\\\":true,\\\"ocr\\\":true},\\\"codigoRespuestaDatos\\\":0},\\\"minutiaeResponse\\\":{\\\"codigoRespuestaMinucia\\\":0,\\\"similitud2\\\":\\\"100.0%\\\",\\\"similitud7\\\":\\\"100.0%\\\"},\\\"tiempoProcesamiento\\\":1431,\\\"codigoRespuesta\\\":0},\\\"signature\\\":{\\\"signedInfo\\\":{\\\"canonicalizationMethod\\\":{\\\"algorithm\\\":\\\"http://www.w3.org/TR/2001/REC-xml-c14n-20010315\\\"},\\\"signatureMethod\\\":{\\\"algorithm\\\":\\\"http://www.w3.org/2001/04/xmldsig-more#rsa-sha256\\\"},\\\"reference\\\":{\\\"digestMethod\\\":{\\\"algorithm\\\":\\\"http://www.w3.org/2001/04/xmlenc#sha256\\\"},\\\"digestValue\\\":\\\"q6PGHH4TcBVUoDSoLXNmMjyYMnn4pVvRzaG/MXgjELU=\\\",\\\"uri\\\":\\\"#DATA\\\"}},\\\"signatureValue\\\":\\\"CCCoEjOLPp76y1zmz6Z7NApp15giMnsJme4wVWr7UUPXp5qIZk0huJba5Kut+QpAxWtnRD78yxCf\\\\nu6um77c3ZafWuaqbjJvceRB7hpf1tK6nhIMPwVIOpbdmBSWAhKwgJRic2pQLZ1DlGZCbdKfpiLSX\\\\nm23UWAsnMZmS96qSQuHuWELx5VeCNLtFIOC5240sB+4tmpDBZ1zdePlraUb0h4chIfjD6dC8SQr1\\\\n0tpW8Dfe2HQZGcxUIk56MSPIn4vTQEgbPiqMUt5di4iYPUxE5d2mnsMI6YArzicL29UH4O2isE1h\\\\nKsFHiD3nm1e3Kuy2zWynXASEuyXY6zE83nFWHZO5nhcC7lPPasnGMApZylGV1MoFHny/5JmudTd9\\\\n3fpy/hbEAoZUIxTXToknic0AdbFJY9cR1Uv2GQuSo0l8Q0z9i3FDYoeB4pVuXLDwnODW9plJfBGc\\\\nVVpQyr4WMJYrx4urOOKu88BIDwnu9N/VgYXImq2+lPhjZENObr2QOLsEQ3N9snmADWTCMW4trXMq\\\\nMmkz8FprgA8at+nGOvqK7fXeBO+jSmZ3Cggwun6I9ieHaCzoRtpGvGQ/S73DSFunVzcpasav0eUc\\\\nxbiRqwBezOe40qQJxrehq6eYn2C2EvIRM/SpbV4LzDIEx9SNQ0lCkXri8oVx65F5Do5ItDKzPhE=\\\",\\\"keyInfo\\\":{\\\"x509Data\\\":{\\\"x509SerialNumber\\\":\\\"produccion_2020\\\"}}},\\\"timeStamp\\\":null,\\\"hash\\\":\\\"920307e501852f624661470d8050ace9a6230144ac0a8f0c34063d05f7342f11\\\"}\""
				.replace("\"{\\\"", "{\"").replace("\\\"}\"", "\"}").replace("\\", "");
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(ID_APPLICATION + CLASS_NAME + " settingDataToOpaqueTokenResponse - responseString="
					+ responseString);
		}

		SecObjRec secObjRec = new SecObjRec();
		SecObjInfoBean secObjInfoBean = new SecObjInfoBean();
		List<SecObjData> secObjData = new ArrayList<SecObjData>();

		SecObjData aSecObjData = new SecObjData();
		aSecObjData.setSecObjDataKey("REQUEST");
		aSecObjData.setSecObjDataValue(requestString);
		aSecObjData.setSecObjDataType("String");

		SecObjData bSecObjData = new SecObjData();
		bSecObjData.setSecObjDataKey("RESPONSE");
		bSecObjData.setSecObjDataValue(responseString);
		bSecObjData.setSecObjDataType("String");

		SecObjData cSecObjData = new SecObjData();
		cSecObjData.setSecObjDataKey("CODE");
		cSecObjData.setSecObjDataValue("OK0000");
		cSecObjData.setSecObjDataType("String");

		SecObjData dSecObjData = new SecObjData();
		dSecObjData.setSecObjDataKey("TRX");
		dSecObjData.setSecObjDataValue("\"845454875655898655656\"");
		dSecObjData.setSecObjDataType("String");

		SecObjData eSecObjData = new SecObjData();
		eSecObjData.setSecObjDataKey("FCH_START");
		eSecObjData.setSecObjDataValue("21-02-2022");
		eSecObjData.setSecObjDataType("String");

		SecObjData fSecObjData = new SecObjData();
		fSecObjData.setSecObjDataKey("FCH_END");
		fSecObjData.setSecObjDataValue("21-03-2022");
		fSecObjData.setSecObjDataType("String");

		SecObjData gSecObjData = new SecObjData();
		gSecObjData.setSecObjDataKey("TYPE");
		gSecObjData.setSecObjDataValue("VER_BIO");
		gSecObjData.setSecObjDataType("String");

		secObjData.add(aSecObjData);
		secObjData.add(bSecObjData);
		secObjData.add(cSecObjData);
		secObjData.add(dSecObjData);
		secObjData.add(eSecObjData);
		secObjData.add(fSecObjData);
		secObjData.add(gSecObjData);

		secObjInfoBean.setSecObjData(secObjData);
		secObjRec.setSecObjInfoBean(secObjInfoBean);
		wOpaqueTokenResponse.setSecObjRec(secObjRec);

		return wOpaqueTokenResponse;
	}
	// Solo para pruebas en DESA - FIN

	private void setAdditionalParameters(
			com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.FingerPrintRequest fingerPrintReq, String cobisSessionId)
			throws MobileServiceException {
		ParameterServiceImpl parameterService = new ParameterServiceImpl();
		parameterService.setServiceIntegration(serviceIntegration);

		ParameterSearchResponse trxTypeParam = parameterService.searchParameter("FITRTP", "CLI", cobisSessionId);
		ParameterSearchResponse branchParam = parameterService.searchParameter("FIBRNC", "CLI", cobisSessionId);
		ParameterSearchResponse channelParam = parameterService.searchParameter("FICHNL", "CLI", cobisSessionId);

		fingerPrintReq.setTransactionType(trxTypeParam.getCharValue());
		fingerPrintReq.setTransactionId(getTransaccionIdString());
		fingerPrintReq.setBranch(branchParam.getCharValue());
		fingerPrintReq.setChannel(channelParam.getCharValue());
	}

	private String getTransaccionIdString() {
		StringBuilder transactionId = new StringBuilder();
		Random random = new Random();
		for (int i = 0; i < IDEXP_LEN; i++) {
			transactionId.append(random.nextInt(10));
		}
		return transactionId.toString();
	}

	private void setAdditionalParameters(ClientInformation clientInformation, Client clientInfor, String cobisSessionId)
			throws MobileServiceException {
		ParameterServiceImpl parameterService = new ParameterServiceImpl();
		parameterService.setServiceIntegration(serviceIntegration);

		ParameterSearchResponse channelId = parameterService.searchParameter("IDCHAN", "CLI", cobisSessionId);
		ParameterSearchResponse originId = parameterService.searchParameter("IDORIG", "CLI", cobisSessionId);
		ParameterSearchResponse countryId = parameterService.searchParameter("IDCOUN", "CLI", cobisSessionId);
		ParameterSearchResponse portNumber = parameterService.searchParameter("URLPOR", "CLI", cobisSessionId);
		ParameterSearchResponse urlDom = parameterService.searchParameter("URLDOM", "CLI", cobisSessionId);
		ParameterSearchResponse protocol = parameterService.searchParameter("URLPRO", "CLI", cobisSessionId);
		ParameterSearchResponse flow = parameterService.searchParameter("TIFLOW", "CLI", cobisSessionId);

		/*
		 * if(channelId.getCharValue() == null && originId.getCharValue() == null &&
		 * countryId.getCharValue() == null && portNumber.getCharValue() == null &&
		 * urlDom.getCharValue() == null && protocol.getCharValue() == null &&
		 * flow.getCharValue() == null) { throw new MobileServiceException("123",
		 * "Error"); }
		 */

		clientInformation.setChannelId(channelId.getCharValue());
		clientInformation.setOriginId(originId.getCharValue());
		clientInformation.setCountryId(countryId.getCharValue());
		clientInformation.setRedirectURL(protocol.getCharValue() + urlDom.getCharValue()
				+ (portNumber.getCharValue() == null || "".equals(portNumber.getCharValue().trim()) ? ""
						: ":" + portNumber.getCharValue().trim()));
		clientInformation.setFlow(flow.getCharValue());
		clientInformation.setIdSesionCliente(clientInfor.getIdSesionCliente());
		clientInformation.setIpLocal(clientInfor.getIpLocal());

	}

	private String concatenateTokenToUrl(
			com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenResponse opaqueTokenResp, String cobisSessionId,
			String channel) throws MobileServiceException {
		String urlWebFull = "";
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("BioOnbordingImpl - concatenateTokenToUrl - INI - channel="+channel);
		}
		//Solo para pruebas en DESA - INI
		if (opaqueTokenResp != null && opaqueTokenResp.getSecObjRec() != null
				&& opaqueTokenResp.getSecObjRec().getSecObjInfo() != null
				&& opaqueTokenResp.getSecObjRec().getSecObjInfo().getSecObjValue() != null
				&& !"".equals(opaqueTokenResp.getSecObjRec().getSecObjInfo().getSecObjValue())) {
			
			urlWebFull = getUrlWebParameter(cobisSessionId, channel)
					+ opaqueTokenResp.getSecObjRec().getSecObjInfo().getSecObjValue();
			
		}
		//urlWebFull = getUrlWebParameter(cobisSessionId, channel) + urlWebFull;
		// Solo para pruebas en DESA - FIN
		
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("BioOnbordingImpl - concatenateTokenToUrl - urlWebFull=" + urlWebFull);
		}
		return urlWebFull;
	}

	private String getUrlWebParameter(String cobisSessionId, String channel) throws MobileServiceException {
		ParameterServiceImpl parameterService = new ParameterServiceImpl();
		parameterService.setServiceIntegration(serviceIntegration);
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("BioOnbordingImpl - getUrlWebParameter - INI");
		}

		ParameterSearchResponse protocol = null;
		ParameterSearchResponse domain = null;
		ParameterSearchResponse domain2 = null;
		ParameterSearchResponse domain3 = null;
		ParameterSearchResponse domain4 = null;
		ParameterSearchResponse portNumber = null;
		ParameterSearchResponse uri = null;
		String urlWeb = null;

		if (channel != null && !"".equals(channel)) {
			if (CHNL_FNGR.equals(channel)) {
				protocol = parameterService.searchParameter("FIUPRO", "CLI", cobisSessionId);
				domain = parameterService.searchParameter("FIUDO1", "CLI", cobisSessionId);
				domain2 = parameterService.searchParameter("FIUDO2", "CLI", cobisSessionId);
				domain3 = parameterService.searchParameter("FIUDO3", "CLI", cobisSessionId);
				portNumber = parameterService.searchParameter("FIUPOR", "CLI", cobisSessionId);
				uri = parameterService.searchParameter("FIUURI", "CLI", cobisSessionId);

				urlWeb = protocol.getCharValue() + valCharNullOrEmpty(domain) + valCharNullOrEmpty(domain2)
						+ valCharNullOrEmpty(domain3) + valPortCharNullOrEmpty(portNumber) + valCharNullOrEmpty(uri);

			} else if (CHNL_BIO.equals(channel)) {
				protocol = parameterService.searchParameter("BOUPRO", "CLI", cobisSessionId);
				domain = parameterService.searchParameter("BOUDO1", "CLI", cobisSessionId);
				domain2 = parameterService.searchParameter("BOUDO2", "CLI", cobisSessionId);
				domain3 = parameterService.searchParameter("BOUDO3", "CLI", cobisSessionId);
				domain4 = parameterService.searchParameter("BOUDO4", "CLI", cobisSessionId);
				portNumber = parameterService.searchParameter("BOUPOR", "CLI", cobisSessionId);
				uri = parameterService.searchParameter("BOUURI", "CLI", cobisSessionId);

				urlWeb = protocol.getCharValue() + valCharNullOrEmpty(domain) + valCharNullOrEmpty(domain2)
						+ valCharNullOrEmpty(domain3) + valCharNullOrEmpty(domain4) + valPortCharNullOrEmpty(portNumber)
						+ valCharNullOrEmpty(uri);
			}
		}
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("BioOnbordingImpl - getUrlWebParameter - urlWeb=" + urlWeb);
		}
		return urlWeb;
	}

	private String valCharNullOrEmpty(ParameterSearchResponse param) {
		return param.getCharValue() == null || "".equals(param.getCharValue().trim()) ? ""
				: param.getCharValue().trim();
	}

	private String valPortCharNullOrEmpty(ParameterSearchResponse param) {
		return param.getCharValue() == null || "".equals(param.getCharValue().trim()) ? ""
				: ":" + param.getCharValue().trim();
	}

	private com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.FingerPrintRequest createFingerPrintRequest(
			FingerPrintRequest fingerPrintRequest, String cobisSessionId) throws MobileServiceException {
		// Carga de parametros a la aplicación
		StringBuilder transactionId = new StringBuilder();
		ParameterServiceImpl parameterService = new ParameterServiceImpl();
		parameterService.setServiceIntegration(serviceIntegration);

		com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.FingerPrintRequest fingerPrintReq = new com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.FingerPrintRequest();
		fingerPrintReq.setCustomerId(fingerPrintRequest.getCustomerId());
		fingerPrintReq.setOcr(fingerPrintRequest.getOcr());
		fingerPrintReq.setCic(fingerPrintRequest.getCic());
		fingerPrintReq.setName(fingerPrintRequest.getName());
		fingerPrintReq.setPaterName(fingerPrintRequest.getPaterName());
		fingerPrintReq.setMaternName(fingerPrintRequest.getMaternName());
		fingerPrintReq.setRegistryYear(fingerPrintRequest.getRegistryYear());
		fingerPrintReq.setExpeditionYear(fingerPrintRequest.getExpeditionYear());
		fingerPrintReq.setNumCredEmission(fingerPrintRequest.getNumCredEmission());
		fingerPrintReq.setElectoralKey(fingerPrintRequest.getElectoralKey());
		fingerPrintReq.setLatitude(fingerPrintRequest.getLatitude());
		fingerPrintReq.setLongitude(fingerPrintRequest.getLongitude());

		ParameterSearchResponse channel = parameterService.searchParameter("FICHNL", "CLI", cobisSessionId);
		ParameterSearchResponse branch = parameterService.searchParameter("FIBRNC", "CLI", cobisSessionId);
		ParameterSearchResponse transactionType = parameterService.searchParameter("FITRTP", "CLI", cobisSessionId);

		Random random = new Random();
		for (int i = 0; i < 25; i++) {
			transactionId.append(random.nextInt(10));
		}

		fingerPrintReq.setBranch(branch.getCharValue());
		fingerPrintReq.setTransactionType(transactionType.getCharValue());
		fingerPrintReq.setChannel(channel.getCharValue());
		fingerPrintReq.setTransactionId(transactionId.toString());
		return fingerPrintReq;
	}

	private int getTriesNumberParam(String cobisSessionId) throws MobileServiceException {
		ParameterServiceImpl parameterService = new ParameterServiceImpl();
		parameterService.setServiceIntegration(serviceIntegration);
		ParameterSearchResponse triesNumber = parameterService.searchParameter("NUMINT", "CLI", cobisSessionId);
		return triesNumber.getTinyintValue();
	}

	private void setOCRInformation(OCRMsgResponse wOCRMsgResponse, BioOnboardHeaderResponse[] bioOnbHeaderResp,
			BioOnboardDetailResponse[] bioOnbDetailResp) throws MobileServiceException {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(ID_APPLICATION + CLASS_NAME + "setOCRInformation - INI");
			LOGGER.logDebug(ID_APPLICATION + CLASS_NAME + "setOCRInformation - bioOnbHeaderResp=" + bioOnbHeaderResp);
		}
		if (bioOnbHeaderResp != null && bioOnbHeaderResp.length > 0) {
			BioOnboardHeaderResponse bioOnbHeader = bioOnbHeaderResp[0];

			List<Ocr> ocrList = null;
			if (bioOnbDetailResp != null && bioOnbDetailResp.length > 0) {
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug(ID_APPLICATION + CLASS_NAME + "setOCRInformation - bioOnbDetailResp.length="
							+ bioOnbDetailResp.length);
				}
				ocrList = new ArrayList<Ocr>();
				for (BioOnboardDetailResponse bioOnbDetail : bioOnbDetailResp) {
					Ocr ocrItem = new Ocr();
					ocrItem.setFieldName(bioOnbDetail.getFieldName());
					ocrItem.setName(bioOnbDetail.getName());
					ocrItem.setText(bioOnbDetail.getText());
					ocrList.add(ocrItem);
				}
			}
			wOCRMsgResponse.setIdExpediente(bioOnbHeader.getFileId());
			wOCRMsgResponse.setIdValidas(bioOnbHeader.getValidasId());
			wOCRMsgResponse.setDocumentType(bioOnbHeader.getDocumentType());
			wOCRMsgResponse.setOcr(ocrList);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(ID_APPLICATION + CLASS_NAME + "setOCRInformation - wOCRMsgResponse="
						+ wOCRMsgResponse.toString());
			}
		} else {
			throw new MobileServiceException("001", "Error en consulta de informacion del IxExpediente indicado.");
		}
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(ID_APPLICATION + CLASS_NAME + "setOCRInformation - FIN");
		}
	}

	private void setSCORESInformation(SCORESMsgResponse wSCORESMsgResponse, BioOnboardHeaderResponse[] bioOnbHeaderResp,
			BioOnboardDetailResponse[] bioOnbDetailBioResp, BioOnboardDetailResponse[] bioOnbDetailDocResp)
			throws MobileServiceException {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(ID_APPLICATION + CLASS_NAME + "setSCORESInformation - INI");
			LOGGER.logDebug(ID_APPLICATION + CLASS_NAME + "setSCORESInformation - bioOnbHeaderResp.length="
					+ bioOnbHeaderResp.length);
		}
		if (bioOnbHeaderResp != null && bioOnbHeaderResp.length > 0) {
			BioOnboardHeaderResponse bioOnbHeader = bioOnbHeaderResp[0];

			Scores scores = new Scores();
			List<BiometryScore> biometryScrsList = null;
			List<DocumentScore> documentScrsList = null;
			if (bioOnbDetailBioResp != null && bioOnbDetailBioResp.length > 0) {
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug(ID_APPLICATION + CLASS_NAME + "setSCORESInformation - bioOnbDetailBioResp.length="
							+ bioOnbDetailBioResp.length);
				}
				biometryScrsList = new ArrayList<BiometryScore>();
				for (BioOnboardDetailResponse bioOnbDetail : bioOnbDetailBioResp) {
					BiometryScore bioScore = new BiometryScore();
					bioScore.setName(bioOnbDetail.getName());
					bioScore.setValue(bioOnbDetail.getValue());

					biometryScrsList.add(bioScore);
				}
				scores.setBiometryScores(biometryScrsList);
			}
			if (bioOnbDetailDocResp != null && bioOnbDetailDocResp.length > 0) {
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug(ID_APPLICATION + CLASS_NAME + "setSCORESInformation - bioOnbDetailDocResp.length="
							+ bioOnbDetailDocResp.length);
				}
				documentScrsList = new ArrayList<DocumentScore>();
				for (BioOnboardDetailResponse bioOnbDetail : bioOnbDetailDocResp) {
					DocumentScore docScore = new DocumentScore();
					docScore.setName(bioOnbDetail.getName());
					docScore.setValue(bioOnbDetail.getValue());

					documentScrsList.add(docScore);
				}
				scores.setDocumentScores(documentScrsList);
			}
			wSCORESMsgResponse.setIdExpediente(bioOnbHeader.getFileId());
			wSCORESMsgResponse.setIdValidas(bioOnbHeader.getValidasId());
			wSCORESMsgResponse.setScores(scores);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(ID_APPLICATION + CLASS_NAME + "setSCORESInformation - wOCRMsgResponse="
						+ wSCORESMsgResponse.toString());
			}
		} else {
			throw new MobileServiceException("001", "Error en consulta de informacion del IxExpediente indicado.");
		}
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(ID_APPLICATION + CLASS_NAME + "setSCORESInformation - FIN");
		}

	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void setCobisCrypt(ICobisCrypt cobisCrypt) {
		this.cobisCrypt = cobisCrypt;
	}

	public void unsetCobisCrypt(ICobisCrypt cobisCrypt) {
		this.cobisCrypt = cobisCrypt;
	}

	public Map<String, Key> getPrivateKeysMap() {
		return this.privateKeysMap;
	}

	public ISPOrchestrator getSpOrchestrator() {
		return spOrchestrator;
	}

	public void setSpOrchestrator(ISPOrchestrator spOrchestrator) {
		this.spOrchestrator = spOrchestrator;
	}

	private RenapoClientResponse changeRenapoClientResponse(
			com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.RenapoClientResponse renapoClientResponse) {
		
		CharactersUtil util=new CharactersUtil();

		RenapoClientResponse response = new RenapoClientResponse();
		response.setCode(renapoClientResponse.getCode());
		response.setMessage(renapoClientResponse.getMessage());
		response.setCurp(renapoClientResponse.getCurp());
		
		response.setName(util.replaceSpecialCharacters(renapoClientResponse.getName()));
		response.setLastName(util.replaceSpecialCharacters(renapoClientResponse.getLastName()));
		response.setSecondLastName(util.replaceSpecialCharacters(renapoClientResponse.getSecondLastName()));
		LOGGER.logDebug(ID_APPLICATION + CLASS_NAME + " - responseName => " + response.getName());
		LOGGER.logDebug(ID_APPLICATION + CLASS_NAME + " - responseLastName => " + response.getLastName());
		LOGGER.logDebug(ID_APPLICATION + CLASS_NAME + " - responseSecondLastName => " + response.getSecondLastName());		response.setSex(renapoClientResponse.getSex());

		response.setSex(renapoClientResponse.getSex());
		response.setBirthDate(renapoClientResponse.getBirthDate());
		response.setBirthPlace(renapoClientResponse.getBirthPlace());
		response.setNationality(renapoClientResponse.getNationality());

		// RenapoClientResponse [code=null, message=null, curp=null, name=null,
		// lastName=null, secondLastName=null, sex=null, birthDate=null,
		// birthPlace=null, nationality=null,
		// errorMessage=null,
		// errores=[ErrorResponse [code=BAD001, message=ERROR EN LOS PARAMETROS DE
		// ENTRADA, level=1,
		// description=ERROR EN EL FORMATO DEL CAMPO O LOS CAMPOS: curp,
		// moreInfo=SANTANDER.MX/ERRORES]]]

		if (null != renapoClientResponse.getErrorMessage()) {
			response.getErrorMessage().setError(renapoClientResponse.getErrorMessage().getError());
			response.getErrorMessage().setHttpCode(renapoClientResponse.getErrorMessage().getHttpCode());
			response.getErrorMessage().setHttpMessage(renapoClientResponse.getErrorMessage().getHttpMessage());
			response.getErrorMessage().setMoreInformation(renapoClientResponse.getErrorMessage().getMoreInformation());
			response.getErrorMessage()
					.setErrorDescription(renapoClientResponse.getErrorMessage().getErrorDescription());

			if (null != renapoClientResponse.getErrorMessage().getStatus()) {
				response.getErrorMessage().getStatus()
						.setStatusCode(renapoClientResponse.getErrorMessage().getStatus().getStatusCode());
				response.getErrorMessage().getStatus()
						.setStatusDesc(renapoClientResponse.getErrorMessage().getStatus().getStatusDesc());
			}
		}

		if (null != renapoClientResponse.getErrores()) {
			// ErrorResponse[] errorResponseDto = null;
			ErrorResponse[] errorResponseDto = new ErrorResponse[renapoClientResponse.getErrores().length];
			for (int i = 0; i < renapoClientResponse.getErrores().length; i++) {
				ErrorResponse errerRes = new ErrorResponse();
				errerRes.setCode(renapoClientResponse.getErrores()[i].getCode());
				errerRes.setMessage(renapoClientResponse.getErrores()[i].getMessage());
				errerRes.setLevel(renapoClientResponse.getErrores()[i].getLevel());
				errerRes.setDescription(renapoClientResponse.getErrores()[i].getDescription());
				errerRes.setMoreInfo(renapoClientResponse.getErrores()[i].getMoreInfo());

				errorResponseDto[i] = errerRes;

			}

			response.setErrores(errorResponseDto);
		}

		return response;

	}


}

