package com.cobiscorp.ecobis.business.commons.platform.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.busin.model.RenapoRequest;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CharactersUtil;
import com.cobiscorp.ecobis.business.commons.platform.utils.Outputs;
import com.cobiscorp.ecobis.business.commons.platform.utils.ServiceId;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.ErrorResponse;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.RenapoClientRequest;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.RenapoClientResponse;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.RenapoMessage;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.RenapoResponse;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.SatellitePosition;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.EquivalenceRequest;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

public class BiometricManager extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(BiometricManager.class);

	private static final String RENAPO_VALIDATED = "S";
	private static final String RENAPO_ERROR_AT_GETTING_DATA = "I";
	private static final String RENAPO_CONNECTION_ERROR = "E";
	private static final String RENAPO_PENDING_RESPONSE = "N";
	private static final String CATALOG_CURP = "ENT_CURP";
	private static final String CATALOG_FED = "ENT_FED";

	public BiometricManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public RenapoResponse queryCurpFromRenapo(RenapoRequest renapoRequest) throws BusinessException, Exception {
		LOGGER.logDebug("BiometricManager starts queryCurpFromRenapo");
		RenapoResponse renapoResponse = new RenapoResponse();

		String channel = "";
		String branch = "";
		String transactionType = "";
		String latitude = "";
		String longitude = "";
		String codeOK002 = "";

		StringBuilder transactionId = new StringBuilder();
		ParameterManager parameterManager = new ParameterManager(getServiceIntegration());
		ParameterResponse channelParam = parameterManager.getParameterFromManager(4, "RENCHN", "CLI");
		ParameterResponse branchParam = parameterManager.getParameterFromManager(4, "RENBRN", "CLI");
		ParameterResponse transactionTypeParam = parameterManager.getParameterFromManager(4, "RENTTP", "CLI");
		ParameterResponse latitudeParam = parameterManager.getParameterFromManager(4, "RENLAT", "CLI");
		ParameterResponse longitudeParam = parameterManager.getParameterFromManager(4, "RENLON", "CLI");

		ParameterResponse OK0002 = parameterManager.getParameterFromManager(4, "RENOK2", "CLI");

		if (channelParam == null) {
			new BusinessException(103403);
		} else {
			LOGGER.logDebug(channelParam.getParameterValue());
			channel = channelParam.getParameterValue();
		}

		if (branchParam == null) {
			new BusinessException(103403);
		} else {
			branch = branchParam.getParameterValue();
		}

		if (transactionTypeParam == null) {
			new BusinessException(103403);
		} else {
			transactionType = transactionTypeParam.getParameterValue();
		}

		if (latitudeParam == null) {
			latitude = "1";
		} else {
			latitude = latitudeParam.getParameterValue();
		}

		if (longitudeParam == null) {
			longitude = "1";
		} else {
			longitude = longitudeParam.getParameterValue();
		}

		if (OK0002 == null) {
			new BusinessException(103403);
		} else {
			codeOK002 = OK0002.getParameterValue();
		}

		Map<String, String> response = new HashMap<String, String>();
		String equivalence = "";
		RenapoClientRequest renapoClientRequest = new RenapoClientRequest();

		EquivalenceRequest equivalenceRequest = new EquivalenceRequest();
		equivalenceRequest.setCatalog(CATALOG_FED);
		equivalenceRequest.setCatalog1(CATALOG_CURP);
		equivalenceRequest.setEquivalence(renapoRequest.getBirthPlace());
		equivalenceRequest.setMode(1);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue("inEquivalenceRequest", equivalenceRequest);

		ServiceResponse serviceResponseEquiv = this.execute(getServiceIntegration(), LOGGER, ServiceId.QUERY_EQUIVALENCES, serviceRequestTO);
		if (serviceResponseEquiv == null) {
			LOGGER.logError("Eror al consultar equivalencias");
			throw new BusinessException(601321);
		} else {
			if (serviceResponseEquiv.isResult()) {
				ServiceResponseTO dataResponse = (ServiceResponseTO) serviceResponseEquiv.getData();

				Map<String, Object> output = (Map<String, Object>) dataResponse.getData().get(Outputs.OUTPUT);
				if (output != null) {
					equivalence = output.get(Outputs.OUT_VALOR_EQUIV) == null ? "" : (String) output.get(Outputs.OUT_VALOR_EQUIV);
					LOGGER.logDebug("Equivalencia >>" + equivalence);
				}
			} else {
				LOGGER.logError("No se encontraron equivalencias");
				throw new BusinessException(601321);
			}
		}

		Random random = new Random();
		for (int i = 0; i < 25; i++) {
			transactionId.append(random.nextInt(10));
		}
		renapoClientRequest.setBirthDate(renapoRequest.getBirthDate());
		renapoClientRequest.setBirthPlace(equivalence);
		renapoClientRequest.setName(renapoRequest.getName());
		renapoClientRequest.setLastName(renapoRequest.getLastName());
		renapoClientRequest.setSecondLastName(renapoRequest.getSecondLastName());
		renapoClientRequest.setGender("M".equals(renapoRequest.getGender()) ? "H" : "F".equals(renapoRequest.getGender()) ? "M" : "");
		renapoClientRequest.setChannel(channel);
		renapoClientRequest.setBranch(branch);
		renapoClientRequest.setTransactionType(transactionType);
		renapoClientRequest.setTransactionId(transactionId.toString());
		SatellitePosition satellitePosition = new SatellitePosition();
		satellitePosition.setLatitude(latitude);
		satellitePosition.setLongitude(longitude);
		renapoClientRequest.setSatellitePosition(satellitePosition);

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), LOGGER, ServiceId.RENAPO_QUERY_BY_DETAIL, new Object[] { renapoClientRequest });

		if (serviceResponse != null && serviceResponse.isResult()) {
			RenapoClientResponse renapoClientResponse = (RenapoClientResponse) serviceResponse.getData();
			String status = null;
			if (renapoClientResponse != null) {

				LOGGER.logDebug("renapoClientResponse>>" + renapoClientResponse);
				if (renapoClientResponse.getErrorMessage() != null) {
					LOGGER.logDebug("1.. Errores ::" + renapoClientResponse.getErrorMessage());
					status = RENAPO_PENDING_RESPONSE;
					List<RenapoMessage> messages = new ArrayList<RenapoMessage>();
					messages.add(new RenapoMessage(renapoClientResponse.getErrorMessage().getError(), renapoClientResponse.getErrorMessage().getErrorDescription()));
					renapoResponse.setMessages(messages);
				} else if (renapoClientResponse.getErrores() != null && renapoClientResponse.getErrores().length > 0) {
					LOGGER.logDebug("2.. Errores ::" + renapoClientResponse.getErrores());
					status = RENAPO_PENDING_RESPONSE;
					List<RenapoMessage> messages = new ArrayList<RenapoMessage>();
					for (ErrorResponse error : renapoClientResponse.getErrores()) {
						messages.add(new RenapoMessage(error.getCode(), "ERROR RENAPO: " + error.getCode() + " - " + error.getMessage()));
						if (codeOK002.equals(error.getCode())) {
							status = RENAPO_ERROR_AT_GETTING_DATA;
						}
					}
					renapoResponse.setMessages(messages);
				} else {

					List<RenapoMessage> messages = new ArrayList<RenapoMessage>();
					messages.add(new RenapoMessage(renapoClientResponse.getCode(), renapoClientResponse.getMessage()));
					status = renapoClientResponse.getCurp() == null || "".equals(renapoClientResponse.getCurp().trim()) ? RENAPO_PENDING_RESPONSE : RENAPO_VALIDATED;
				}
				renapoResponse.setStatus(status);
				renapoResponse.setCurp(renapoClientResponse.getCurp() == null || "".equals(renapoClientResponse.getCurp().trim()) ? null : renapoClientResponse.getCurp());
			} else {
				LOGGER.logDebug("No hay respuesta RENAPO");
			}
		} else {
			renapoResponse.setStatus(RENAPO_PENDING_RESPONSE);
			renapoResponse.setCurp(null);
		}

		LOGGER.logDebug("RESPUESTA RENAPO>>" + renapoResponse.toString());
		return renapoResponse;
	}

	public RenapoResponse queryRenapoByCurp(RenapoRequest renapoRequest) throws BusinessException, Exception {
		String LOOGER = "BiometricManager - queryRenapoByCurp ->> ";
		LOGGER.logDebug(LOOGER + "Nueva Consulta a RENAPO por CURP desde web");
		RenapoResponse renapoResponse = new RenapoResponse();
		String channel = "";
		String branch = "";
		String transactionType = "";
		String latitude = "";
		String longitude = "";
		String codeOK002 = "";

		com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.RenapoClientResponse renapoClientResponse = new com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.RenapoClientResponse();
		com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.RenapoClientRequest renapoClientRequest = new com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.RenapoClientRequest();

		// Carga de parametros a la aplicación
		StringBuilder transactionId = new StringBuilder();
		ParameterManager parameterManager = new ParameterManager(getServiceIntegration());
		ParameterResponse channelParam = parameterManager.getParameterFromManager(4, "RENCHN", "CLI");
		ParameterResponse branchParam = parameterManager.getParameterFromManager(4, "RENBRN", "CLI");
		ParameterResponse transactionTypeParam = parameterManager.getParameterFromManager(4, "RENTTP", "CLI");
		ParameterResponse OK0002 = parameterManager.getParameterFromManager(4, "RENOK2", "CLI");

		if (channelParam == null) {
			new BusinessException(103403);
		} else {
			LOGGER.logDebug(channelParam.getParameterValue());
			channel = channelParam.getParameterValue();
		}

		if (branchParam == null) {
			new BusinessException(103403);
		} else {
			branch = branchParam.getParameterValue();
		}

		if (transactionTypeParam == null) {
			new BusinessException(103403);
		} else {
			transactionType = transactionTypeParam.getParameterValue();
		}

		if (OK0002 == null) {
			new BusinessException(103403);
		} else {
			codeOK002 = OK0002.getParameterValue();
		}

		renapoClientRequest.setBranch(branchParam.getParameterValue());
		renapoClientRequest.setTransactionType(transactionTypeParam.getParameterValue());
		renapoClientRequest.setChannel(channelParam.getParameterValue());
		renapoClientRequest.setCurp(renapoRequest.getCurp());

		// Se obtiene el transacción id desde un randomico
		Random random = new Random();
		for (int i = 0; i < 25; i++) {
			transactionId.append(random.nextInt(10));
		}

		renapoClientRequest.setTransactionId(transactionId.toString());

		try {
			ServiceResponse serviceResponse = this.execute(getServiceIntegration(), LOGGER, ServiceId.RENAPO_QUERY_BY_CURP, new Object[] { renapoClientRequest });

			if (serviceResponse != null && serviceResponse.isResult()) {

				renapoClientResponse = (com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.RenapoClientResponse) serviceResponse.getData();

				renapoResponse = changeRenapoResponse(renapoClientResponse);

				LOGGER.logDebug(LOOGER + "renapoClientResponse: " + renapoClientResponse);

				String status = null;
				if (renapoClientResponse != null) {
					LOGGER.logDebug(LOOGER + "renapoClientResponse>>" + renapoClientResponse);
					if (renapoResponse.getErrorMessage() != null) {
						LOGGER.logDebug("1.. Errores ::" + renapoClientResponse.getErrorMessage());
						status = RENAPO_PENDING_RESPONSE;
						List<RenapoMessage> messages = new ArrayList<RenapoMessage>();
						messages.add(new RenapoMessage(renapoClientResponse.getErrorMessage().getError(), renapoClientResponse.getErrorMessage().getErrorDescription()));
						renapoResponse.setMessages(messages);

					} else if (renapoClientResponse.getErrores() != null && renapoClientResponse.getErrores().length > 0) {
						LOGGER.logDebug(LOOGER + "2.. Errores ::" + renapoClientResponse.getErrores());
						status = RENAPO_PENDING_RESPONSE;

						if (codeOK002.equals(renapoClientResponse.getCode())) {
							status = RENAPO_ERROR_AT_GETTING_DATA;
						}

					} else {

						List<RenapoMessage> messages = new ArrayList<RenapoMessage>();
						messages.add(new RenapoMessage(renapoClientResponse.getCode(), renapoClientResponse.getMessage()));
						status = renapoClientResponse.getCurp() == null || "".equals(renapoClientResponse.getCurp().trim()) ? RENAPO_PENDING_RESPONSE : RENAPO_VALIDATED;
					}
					renapoResponse.setStatus(status);
					renapoResponse.setCurp(renapoClientResponse.getCurp() == null || "".equals(renapoClientResponse.getCurp().trim()) ? null : renapoClientResponse.getCurp());
				} else {
					LOGGER.logDebug(LOOGER + "No hay respuesta RENAPO");
				}
			} else {
				renapoResponse.setStatus(RENAPO_PENDING_RESPONSE);
				renapoResponse.setCurp(null);
			}

		} catch (

		Exception e) {
			LOGGER.logError("BioOnbordingImpl - generateQuery Error:" + e);
			LOGGER.logError("BioOnbordingImpl - generateQuery Error:" + e.getMessage());
			renapoResponse.setStatus(RENAPO_PENDING_RESPONSE);
			renapoResponse.setCurp(null);
		}

		return renapoResponse;
	}

	private RenapoResponse changeRenapoResponse(com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.RenapoClientResponse renapoClientResponse) {
		// private RenapoClientResponse
		// changeRenapoClientResponse(com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.RenapoClientResponse
		// renapoClientResponse) {

		String INFO = "BiometricManager - changeRenapoClientResponse -->> ";
		LOGGER.logDebug(INFO + "renapoClientResponse.toString(): => " + renapoClientResponse.toString());
		CharactersUtil util = new CharactersUtil();

		RenapoResponse renapoResponse = new RenapoResponse();

		// equivalencias
		String equivalence = "";
		RenapoClientRequest renapoClientRequest = new RenapoClientRequest();

		EquivalenceRequest equivalenceRequest = new EquivalenceRequest();
		equivalenceRequest.setCatalog(CATALOG_FED);
		equivalenceRequest.setCatalog1(CATALOG_CURP);
		equivalenceRequest.setEquivalence(renapoClientResponse.getBirthPlace());
		equivalenceRequest.setMode(3);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue("inEquivalenceRequest", equivalenceRequest);

		ServiceResponse serviceResponseEquiv = this.execute(getServiceIntegration(), LOGGER, ServiceId.QUERY_EQUIVALENCES, serviceRequestTO);
		if (serviceResponseEquiv == null) {
			LOGGER.logError("Eror al consultar equivalencias");
			throw new BusinessException(601321);
		} else {
			if (serviceResponseEquiv.isResult()) {
				ServiceResponseTO dataResponse = (ServiceResponseTO) serviceResponseEquiv.getData();

				Map<String, Object> output = (Map<String, Object>) dataResponse.getData().get(Outputs.OUTPUT);
				if (output != null) {
					equivalence = output.get(Outputs.OUT_VALOR_EQUIV) == null ? "" : (String) output.get(Outputs.OUT_VALOR_EQUIV);
					LOGGER.logDebug("Equivalencia >>" + equivalence);
				}
			} else {
				LOGGER.logError("No se encontraron equivalencias");
				throw new BusinessException(601321);
			}
		}

		renapoResponse.setBirthPlace(equivalence);
		renapoResponse.setCode(renapoClientResponse.getCode());
		renapoResponse.setMessage(renapoClientResponse.getMessage());
		renapoResponse.setCurp(renapoClientResponse.getCurp());

		// String nomres = "MARIA. DE LOS ANGELES";
		String names = renapoClientResponse.getName();
		String firstName = "";
		String secondName = "";

		firstName = names.split(" ")[0];
		secondName = names.substring(firstName.length(), names.length()).trim();

		renapoResponse.setName(util.replaceSpecialCharacters(firstName));
		renapoResponse.setSecondName(util.replaceSpecialCharacters(secondName));
		renapoResponse.setLastName(util.replaceSpecialCharacters(renapoClientResponse.getLastName()));
		renapoResponse.setSecondLastName(util.replaceSpecialCharacters(renapoClientResponse.getSecondLastName()));

		renapoResponse.setSex("H".equals(renapoClientResponse.getSex()) ? "M" : "M".equals(renapoClientResponse.getSex()) ? "F" : "");
		renapoResponse.setBirthDate(renapoClientResponse.getBirthDate());
		renapoResponse.setNationality(renapoClientResponse.getNationality());

		if (null != renapoClientResponse.getErrorMessage()) {
			renapoResponse.getErrorMessage().setError(renapoClientResponse.getErrorMessage().getError());
			renapoResponse.getErrorMessage().setHttpCode(renapoClientResponse.getErrorMessage().getHttpCode());
			renapoResponse.getErrorMessage().setHttpMessage(renapoClientResponse.getErrorMessage().getHttpMessage());
			renapoResponse.getErrorMessage().setMoreInformation(renapoClientResponse.getErrorMessage().getMoreInformation());
			renapoResponse.getErrorMessage().setErrorDescription(renapoClientResponse.getErrorMessage().getErrorDescription());

			if (null != renapoClientResponse.getErrorMessage().getStatus()) {
				renapoResponse.getErrorMessage().getStatus().setStatusCode(renapoClientResponse.getErrorMessage().getStatus().getStatusCode());
				renapoResponse.getErrorMessage().getStatus().setStatusDesc(renapoClientResponse.getErrorMessage().getStatus().getStatusDesc());
			}
		}

		if (null != renapoClientResponse.getErrores()) {
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
			renapoResponse.setErrores(errorResponseDto);
		}
		LOGGER.logDebug(INFO + "renapoResponse.toString(): => " + renapoResponse.toString());
		return renapoResponse;

	}
}
