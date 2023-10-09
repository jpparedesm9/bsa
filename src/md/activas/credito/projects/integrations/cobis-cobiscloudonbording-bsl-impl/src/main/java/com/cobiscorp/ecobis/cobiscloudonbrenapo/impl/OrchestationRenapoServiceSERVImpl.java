package com.cobiscorp.ecobis.cobiscloudonbrenapo.impl;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.AccessTokenResponse;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.ErrorMessage;
import com.cobiscorp.ecobis.cobiscloudbiometric.util.constants.Parameter;
import com.cobiscorp.ecobis.cobiscloudbiometric.util.impl.Event;
import com.cobiscorp.ecobis.cobiscloudbiometric.util.impl.Utils;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.RenapoClientResponse;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.serv.bsl.IOrchestationRenapoService;
import com.cobiscorp.ecobis.cobiscloudonboard.impl.OrchestrationBioOnboardingServiceSERVImpl;
import com.cobiscorp.ecobis.cobiscloudonboard.impl.ServiceBase;
import com.cobiscorp.ecobis.cobiscloudonboard.util.config.reader.BioOnboardingConfiguration;
import com.fasterxml.jackson.databind.ObjectMapper;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

@Component
@Service({ IOrchestationRenapoService.class })
public class OrchestationRenapoServiceSERVImpl extends ServiceBase implements IOrchestationRenapoService {
	private static ILogger LOGGER = LogFactory.getLogger(OrchestationRenapoServiceSERVImpl.class);
	@Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	@Override
	public com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.RenapoClientResponse renapoQueryByCurp(com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.RenapoClientRequest renapoClientRequest)
			throws Exception {

		// to include in code order use key:
		// cobiscloudorchestration.OrchestrationClientValidationServiceImpl.validate
		RenapoClientResponse renapoClientResponse = null;

		String wInfo = "[OrchestationRenapoServiceSERVImpl][renapoQueryByCurp]";
		if (renapoClientRequest != null) {

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("------> START RENAPO BY CURP <-------");
			}

			HttpURLConnection con = null;
			DataOutputStream wr = null;
			InputStream inputStream = null;
			String result = null;
			ObjectMapper objectMapper = new ObjectMapper();

			try {
				// Invocacion token de acceso
				OrchestrationBioOnboardingServiceSERVImpl orchestationBiometricService = new OrchestrationBioOnboardingServiceSERVImpl();
				String urlRenapo = BioOnboardingConfiguration.getUrlFromXML("urlRenapoByCurp");
				LOGGER.logDebug(">>>> START ACCESS TOKEN SERVICE CALL");
				AccessTokenResponse accessToken = accessToken(BioOnboardingConfiguration.getUrlFromXML("urlAccessOauthTokenR"));
				LOGGER.logDebug("FINISH ACCESS TOKEN SERVICE CALL <<<<");

				LOGGER.logDebug("urlRenapoByCurp:  " + urlRenapo);

				if (null != accessToken && null != urlRenapo) {
					LOGGER.logDebug(">>>> START RENAPO SERVICE CALL");
					// Llamado a los parametros
					/*
					 * String channel = getCobisParameter().getParameter(null, "CLI", "RENCHN", String.class); String branch =
					 * getCobisParameter().getParameter(null, "CLI", "RENBRN", String.class); String transaccion =
					 * getCobisParameter().getParameter(null, "CLI", "RENTTP", String.class);
					 * 
					 * 
					 * 
					 * 
					 * LOGGER.logDebug("channel: " + channel); LOGGER.logDebug("branch: " + branch); LOGGER.logDebug("transaccion: " + transaccion);
					 * 
					 */

					URL obj = new URL(urlRenapo);

					if (urlRenapo.contains("https")) {
						con = (HttpsURLConnection) obj.openConnection();
					} else {
						con = (HttpURLConnection) obj.openConnection();
					}

					con.setDoOutput(true);
					con.setRequestProperty("Content-Type", Parameter.JSON);
					con.setRequestProperty("accept", Parameter.JSON);
					con.setRequestProperty("x-ibm-client-id", BioOnboardingConfiguration.getUrlFromXML("clientIdRenapo"));
					con.setRequestProperty("Authorization", "Bearer ".concat(accessToken.getAccessToken()));
					con.connect();
					LOGGER.logDebug("RENAPO REQUEST :: " + Event.objectToJson(renapoClientRequest));
					wr = new DataOutputStream(con.getOutputStream());
					byte[] input = Event.objectToJson(renapoClientRequest).getBytes(Parameter.UTF_8);
					wr.write(input);
					wr.flush();

					// Capturando respuesta

					inputStream = con.getInputStream();
					LOGGER.logDebug("RENAPO HTTP RESPONSE CODE :: " + con.getResponseCode());
					if (con.getResponseCode() == 200) {
						result = Utils.readBufferReader(new BufferedReader(new InputStreamReader(inputStream)));
						renapoClientResponse = objectMapper.readValue(result, RenapoClientResponse.class);

						String NAME = com.cobiscorp.ecobis.cobiscloudonboard.util.impl.Utils.removeAccents(renapoClientResponse.getName());
						String LASTNAME = com.cobiscorp.ecobis.cobiscloudonboard.util.impl.Utils.removeAccents(renapoClientResponse.getLastName());
						String SECONDLASTNAME = com.cobiscorp.ecobis.cobiscloudonboard.util.impl.Utils.removeAccents(renapoClientResponse.getSecondLastName());
						
						String NAME2 = com.cobiscorp.ecobis.cobiscloudonboard.util.impl.Utils.removeSpaces(NAME);
						String LASTNAME2 = com.cobiscorp.ecobis.cobiscloudonboard.util.impl.Utils.removeSpaces(LASTNAME);
						String SECONDLASTNAME2 = com.cobiscorp.ecobis.cobiscloudonboard.util.impl.Utils.removeSpaces(SECONDLASTNAME);

						renapoClientResponse.setName(NAME2);
						renapoClientResponse.setLastName(LASTNAME2);
						renapoClientResponse.setSecondLastName(SECONDLASTNAME2);
					}

					LOGGER.logDebug("SUCCESS RENAPO RESULT :: " + result);
				} else {
					LOGGER.logError(">>>  NO SE PUEDE EJECUTAR EL SERVICIO DE RENAPO <<<<");
				}

			} catch (IOException e) {
				inputStream = con.getErrorStream();
				try {

					if (con.getResponseCode() == 401 || con.getResponseCode() == 400) {
						result = Utils.readBufferReader(new BufferedReader(new InputStreamReader(inputStream)));
						renapoClientResponse = objectMapper.readValue(result, RenapoClientResponse.class);

						LOGGER.logDebug("ERROR RENAPO RESULT :: " + result);
						LOGGER.logDebug("RENAPO RESPONSE :: " + renapoClientResponse);
					} else {
						LOGGER.logDebug("IOEXCEPTION::", e);
						throw new IOException("ERROR: ERROR DE CONEXION CON RENAPO. CONTACTESE CON EL ADMINISTRADOR.");
					}
				} catch (IOException e1) {
					LOGGER.logError("ERROR AT CONNECTING RENAPO ::", e1);
				}
			} catch (Exception e) {
				LOGGER.logError("ERROR AT EXECUTE RENAPO ::", e);
				throw e;

			} finally {
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("------> FINISH RENAPO <-------");
				}
				try {
					con.disconnect();
					if (wr != null)
						wr.close();
				} catch (Exception e) {
					LOGGER.logError("ERROR AT CLOSE CONNECTION: ", e);
				}
			}
		}
		return renapoClientResponse;

	}

	public AccessTokenResponse accessToken(String urlAccessToken) {
		AccessTokenResponse accessTokenResponse = null;
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("------> Inicia generacion de Access Token Oauth <-------");
		}

		LOGGER.logDebug("Access Token Oauth: " + urlAccessToken);

		String clientId = BioOnboardingConfiguration.getUrlFromXML("clientIdRenapo") != null ? BioOnboardingConfiguration.getUrlFromXML("clientIdRenapo").trim() : null;
		String clientSecret = BioOnboardingConfiguration.getUrlFromXML("clientSecretRenapo") != null ? BioOnboardingConfiguration.getUrlFromXML("clientSecretRenapo").trim() : null;

		HttpsURLConnection con = null;
		DataOutputStream wr = null;

		try {

			// Creacion Cabera nueva
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("grant_type", "client_credentials");
			params.put("client_id", clientId);
			params.put("client_secret", clientSecret);
			params.put("scope", "resources.all");

			StringBuilder postData = new StringBuilder();
			for (Map.Entry<String, Object> param : params.entrySet()) {
				if (postData.length() != 0)
					postData.append('&');
				postData.append(URLEncoder.encode(param.getKey(), Parameter.UTF_8));
				postData.append('=');
				postData.append(URLEncoder.encode(String.valueOf(param.getValue()), Parameter.UTF_8));
			}
			byte[] postDataBytes = postData.toString().getBytes(Parameter.UTF_8);
			LOGGER.logDebug("------> postDataBytes <------- " + postDataBytes);

			if (null != urlAccessToken) {
				URL obj = new URL(urlAccessToken);
				con = (HttpsURLConnection) obj.openConnection();
				con.setRequestMethod("POST");
				con.setDoOutput(true);
				con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
				con.setRequestProperty("Content-Length", Integer.toString(postDataBytes.length));
				con.connect();
				// Enviar request
				ObjectMapper objectMapper = new ObjectMapper();
				wr = new DataOutputStream(con.getOutputStream());
				wr.write(postDataBytes);
				wr.flush();

				// Capturando respuesta
				LOGGER.logDebug("[AccessTokenResponse accessToken] - con.getResponseCode():" + con.getResponseCode());
				String result = null;
				if (con.getResponseCode() == 200) { // OK
					ObjectMapper mapper = new ObjectMapper();
					result = Utils.readBufferReader(new BufferedReader(new InputStreamReader(con.getInputStream())));
					accessTokenResponse = objectMapper.readValue(result, AccessTokenResponse.class);

				} else if (con.getResponseCode() == 401) {
					accessTokenResponse = new AccessTokenResponse();
					result = Utils.readBufferReader(new BufferedReader(new InputStreamReader(con.getInputStream())));
					accessTokenResponse.setErrorMessage(objectMapper.readValue(result, ErrorMessage.class));
				}

				LOGGER.logDebug("Respuesta del servicio Access Token ---->" + accessTokenResponse.toString());

			} else {
				LOGGER.logError("No se puede ejecutar servicio para obtener el Access Token");
			}

		} catch (Exception e) {
			LOGGER.logError("[AccessTokenResponse accessToken] - Error en la ejecucion del servicio para obtener el Access Token ---->", e);

			// Seteo de mensajes de error
			ErrorMessage error = getErrorMessage(con);
			if (null != error) {
				accessTokenResponse = new AccessTokenResponse();
				accessTokenResponse.setErrorMessage(error);
			}

			LOGGER.logError("Error en la ejecucion del servicio para obtener el Access Token ---->", e);

		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("------> Finaliza generacion de Access Token <-------");
			}
			try {
				con.disconnect();
				wr.close();
			} catch (Exception e) {
				LOGGER.logError("Error al cerrar conexion de servicio: ", e);
			}

		}
		return accessTokenResponse;
	}

	public ErrorMessage getErrorMessage(HttpURLConnection con) {
		LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl getErrorMessage] - Inicio metodo");
		String jsonMessage = null;
		ErrorMessage errorMessage = null;
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl getErrorMessage] - con.getErrorStream():" + con.getErrorStream());
			jsonMessage = Utils.readBufferReader(new BufferedReader(new InputStreamReader(con.getErrorStream())));
			errorMessage = objectMapper.readValue(jsonMessage, ErrorMessage.class);
			LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl getErrorMessage] - errorMessage.toString():" + errorMessage.toString());
			LOGGER.logDebug("Mensajes de error ---> " + errorMessage.toString());

		} catch (IOException e) {
			LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl getErrorMessage] - e:", e);
			errorMessage = new ErrorMessage();
			try {
				errorMessage.setHttpCode(String.valueOf(con.getResponseCode()));
				errorMessage.setHttpMessage(con.getErrorStream().toString());
			} catch (IOException e1) {
				LOGGER.logError("[OrchestrationBioOnboardingServiceSERVImpl getErrorMessage] Error al obtener la informacion del error: ", e1);
			}
			LOGGER.logError("[OrchestrationBioOnboardingServiceSERVImpl getErrorMessage] Error al obtener mensajes de error de respuesta de servicio: ", e);
		}
		return errorMessage;
	}

}
