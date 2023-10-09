/**
 * Archivo: OrchestrationBioOnboardingServiceSERVImpl.java
 * Fecha..:
 * Autor..: Team SANTANDER
 * <p>
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.ecobis.cobiscloudonboard.impl;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.AccessTokenResponse;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.ClientInformation;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.ErrorMessage;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenRequest;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenResponse;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.SecObjData;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.SecObjInfoRequest;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.SecObjSel;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.SecObjSelRequest;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.serv.bsl.IOrchestationBioOnboardingService;
import com.cobiscorp.ecobis.cobiscloudonboard.util.config.reader.BioOnboardingConfiguration;
import com.cobiscorp.ecobis.cobiscloudonboard.util.constants.Parameter;
import com.cobiscorp.ecobis.cobiscloudonboard.util.impl.Utils;
import com.fasterxml.jackson.databind.ObjectMapper;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

@Component
@Service({ IOrchestationBioOnboardingService.class })

public class OrchestrationBioOnboardingServiceSERVImpl extends ServiceBase implements IOrchestationBioOnboardingService {

	private static final int IDEXP_LEN = 24;

	private static final String STR_TYPE = "STRING";

	private static ILogger LOGGER = LogFactory.getLogger(OrchestrationBioOnboardingServiceSERVImpl.class);

	@Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	// Solo opara pruebas en DESA - INI
	static {
		disableSslVerification();
	}
	// Solo opara pruebas en DESA - FIN

	@Override
	public OpaqueTokenResponse execBioOnboard(ClientInformation clientInformation) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl execBioOnboard] ------> Inicia Exec de Bionoboarding <-------");
		}
		OpaqueTokenResponse wOpaqueTokenResponse = null;
		
		// Generate Accesss Oauth Token
		String urlAccessOauthToken = BioOnboardingConfiguration.getUrlFromXML("urlAccessOauthToken");
		AccessTokenResponse wAccessTokenResponse = generateAccessToken(urlAccessOauthToken);
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl execBioOnboard] ------> wAccessTokenResponse ---> " + wAccessTokenResponse.toString());
		}
		// Generate Opaque Token
		if (wAccessTokenResponse != null && wAccessTokenResponse.getAccessToken() != null) {
			clientInformation.setFileId(generateFileIdString(clientInformation.getIdCliente()));
			wOpaqueTokenResponse = opaqueToken(clientInformation, wAccessTokenResponse);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl execBioOnboard] ------> wAccessTokenResponse ---> " + wOpaqueTokenResponse.toString());
			}
			/*
			// Validate Opaque Token
			if (wOpaqueTokenResponse != null && wOpaqueTokenResponse.getStatus() != null && wOpaqueTokenResponse.getStatus().getStatusCode() == 10000) {
				xOpaqueTokenResponse = validateOpaqueToken(clientInformation, wOpaqueTokenResponse, wAccessTokenResponse);
				if (xOpaqueTokenResponse != null && xOpaqueTokenResponse.getStatus() != null && xOpaqueTokenResponse.getStatus().getStatusCode() == SUCCESS_VAL) {
					// wOpaqueTokenResponse.setFileId(generateFileIdString(clientInformation.getIdCliente()));
					return wOpaqueTokenResponse;
				}
			}*/
		}

		return wOpaqueTokenResponse;
	}

	private String generateFileIdString(String idCliente) {
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMddhhmmss");
		Date date = new Date();
		String fileId = idCliente + dateFormat.format(date);
		fileId = Utils.padRightZeros(fileId, IDEXP_LEN);
		return fileId;
	}

	// Solo opara pruebas en DESA - INI
	private static void disableSslVerification() {
		try {
			// Create a trust manager that does not validate certificate chains
			LOGGER.logDebug("Inicia metodo disableSslVerification - rest");
			TrustManager[] trustAllCerts = new TrustManager[] { new X509TrustManager() {
				@Override
				public java.security.cert.X509Certificate[] getAcceptedIssuers() {
					return null;
				}

				@Override
				public void checkClientTrusted(X509Certificate[] certs, String authType) {
				}

				@Override
				public void checkServerTrusted(X509Certificate[] certs, String authType) {
				}
			} };
			// Install the all-trusting trust manager
			SSLContext sc = SSLContext.getInstance("SSL");
			sc.init(null, trustAllCerts, new java.security.SecureRandom());
			HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
			// HostnameVerifier allHostsValid = (String hostname, SSLSession session) -> true;
			HostnameVerifier allHostsValid = new HostnameVerifier() {
				@Override
				public boolean verify(String s, SSLSession session) {
					return true;
				}
			};
			// Install the all-trusting host verifier
			HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);

			LOGGER.logDebug("Finaliza metodo disableSslVerification - rest");
		} catch (NoSuchAlgorithmException ex) {

			LOGGER.logError("Error al encontrar el algoritmo", ex);

		} catch (KeyManagementException ex) {

			LOGGER.logError("Error en el manejo del key", ex);
		}
	}
	// Solo para pruebas en DESA - FIN

	@Override
	public AccessTokenResponse generateAccessToken(String urlAccessToken) {
		AccessTokenResponse accessTokenResponse = null;
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("------> Inicia generacion de Access Token <-------");
		}

		LOGGER.logDebug("urlAccessTokenAccesoTOpaco: " + urlAccessToken);

		String clientId = BioOnboardingConfiguration.getUrlFromXML("clientId") != null ? BioOnboardingConfiguration.getUrlFromXML("clientId").trim() : null;
		String clientSecret = BioOnboardingConfiguration.getUrlFromXML("clientSecret") != null ? BioOnboardingConfiguration.getUrlFromXML("clientSecret").trim() : null;

		HttpsURLConnection con = null;
		DataOutputStream wr = null;

		try {

			// Creacion Cabera nueva
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("grant_type", "client_credentials");
			params.put("client_id", clientId);
			params.put("client_secret", clientSecret);
			params.put("scope", Parameter.OAUTH_TOKEN_MNG);

			LOGGER.logDebug("scope Token Acceso: " + params.get("scope"));

			StringBuilder postData = new StringBuilder();
			for (Map.Entry<String, Object> param : params.entrySet()) {
				if (postData.length() != 0)
					postData.append('&');
				postData.append(URLEncoder.encode(param.getKey(), Parameter.UTF_8));
				postData.append('=');
				postData.append(URLEncoder.encode(String.valueOf(param.getValue()), Parameter.UTF_8));
			}
			byte[] postDataBytes = postData.toString().getBytes(Parameter.UTF_8);

			if (null != urlAccessToken) {
				URL obj = new URL(urlAccessToken);
				con = (HttpsURLConnection) obj.openConnection();
				con.setRequestMethod(Parameter.POST_METHOD);
				con.setDoOutput(true);
				con.setRequestProperty("Content-Type", Parameter.FORM_URLENCOD);
				con.setRequestProperty("Content-Length", Integer.toString(postDataBytes.length));
				con.connect();
				LOGGER.logDebug("[AccessTokenResponse accessToken] - con:" + con);
				// Enviar request
				ObjectMapper objectMapper = new ObjectMapper();
				wr = new DataOutputStream(con.getOutputStream());
				wr.write(postDataBytes);
				wr.flush();

				// Capturando respuesta
				LOGGER.logDebug("[AccessTokenResponse accessToken] - con.getResponseCode():" + con.getResponseCode());
				String result = null;
				LOGGER.logDebug("[AccessTokenResponse accessToken] - con.getInputStream():" + con.getInputStream());
				if (con.getResponseCode() == 200) { // OK
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

	@Override
	public OpaqueTokenResponse opaqueToken(ClientInformation clientInformation, AccessTokenResponse wAccessTokenResponse) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl opaqueToken] ------> Inicia generacion de token Opaco <-------");
			LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl opaqueToken] clientInformation2 ---> " + clientInformation.toString());
		}

		OpaqueTokenResponse opaqueTokenResponse = null;
		HttpURLConnection con = null;
		DataOutputStream wr = null;
		ObjectMapper objectMapper = new ObjectMapper();
		// Lectura URL archivo de configuracion
		String urlOpaqueToken = BioOnboardingConfiguration.getUrlFromXML("urlGenerateOpaqueToken");
		String clientId = BioOnboardingConfiguration.getUrlFromXML("clientId");
		LOGGER.logDebug("UrlTokenOpaco: " + urlOpaqueToken);
		;

		try {
			// Invocacion token de acceso
			// AccessTokenResponse accessToken = generateAccessToken(BioOnboardingConfiguration.getUrlFromXML("urlAccessTokenAccesoTOpaco"));

			if (null != urlOpaqueToken && null != wAccessTokenResponse) {
				URL obj = new URL(urlOpaqueToken);
				if (urlOpaqueToken.contains("https")) {
					con = (HttpsURLConnection) obj.openConnection();
				} else {
					con = (HttpURLConnection) obj.openConnection();
				}

				LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl opaqueToken] ------> Inicia Conexion <-------");

				// Creacion de MsgRqHdr -- objeto q es parte del header
				String msgRqHdr = generateMsgRqHdrOpaqueToken(clientInformation);
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl opaqueToken] ------> msgRqHdr = " + msgRqHdr);
				}
				con.setRequestMethod("POST");
				con.setDoOutput(true);
				con.setRequestProperty("Content-type", Parameter.JSON);
				con.setRequestProperty("accept", Parameter.JSON);
				con.setRequestProperty("x-ibm-client-id", clientId);
				con.setRequestProperty("Authorization", "Bearer ".concat(wAccessTokenResponse.getAccessToken()));
				con.setRequestProperty("MsgRqHdr", msgRqHdr);

				con.connect();

				// Enviar request
				wr = new DataOutputStream(con.getOutputStream());

				byte[] input = generateOpaqueTokenRequest(clientInformation).getBytes(Parameter.UTF_8);
				wr.write(input);
				wr.flush();

				LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl opaqueToken] generateOpaqueTokenRequest ---> " + generateOpaqueTokenRequest(clientInformation));
				LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl opaqueToken] con.getInputStream():" + con.getInputStream().toString());
				// Capturando respuesta
				BufferedReader reader = new BufferedReader(new InputStreamReader(con.getInputStream()));
				StringBuilder response = new StringBuilder();
				String responseLine = null;

				if (con.getResponseCode() == 200) {
					while ((responseLine = reader.readLine()) != null) {
						LOGGER.logDebug("responseLine >>" + responseLine);
						response.append(responseLine);
					}

					LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl opaqueToken] response ---> " + response.toString());

					opaqueTokenResponse = objectMapper.readValue(response.toString(), OpaqueTokenResponse.class);
					opaqueTokenResponse.setSequential(clientInformation.getIdSesionCliente());
					opaqueTokenResponse.setFileId(clientInformation.getFileId());

					LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl opaqueToken] opaqueTokenResponse ---> " + opaqueTokenResponse.toString());
				} else {
					LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl opaqueToken] Ingresa al error ---> " + con.getErrorStream().toString());
					responseLine = Utils.readBufferReader(new BufferedReader(new InputStreamReader(con.getErrorStream())));
				}

				LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl opaqueToken] Respuesta del servicio Token Opaco ---->" + response.toString());
			} else {
				LOGGER.logError("[OrchestrationBioOnboardingServiceSERVImpl opaqueToken] No se puede ejecutar servicio para obtener el Token Opaco");
			}

		} catch (Exception e) {
			// Seteo de mensajes de error
			ErrorMessage error = getErrorMessage(con);
			if (null != error) {
				opaqueTokenResponse = new OpaqueTokenResponse();
				opaqueTokenResponse.setErrorMessage(error);
			}

			LOGGER.logError("[OrchestrationBioOnboardingServiceSERVImpl opaqueToken] Error en la ejecucion del servicio para obtener el Token Opaco", e);

		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl opaqueToken]------> Finaliza generacion de token Opaco <-------");
			}

			try {
				con.disconnect();
				wr.close();
			} catch (Exception e) {
				LOGGER.logError("[OrchestrationBioOnboardingServiceSERVImpl opaqueToken] Error al cerrar conexion de servicio: ", e);
			}
		}
		return opaqueTokenResponse;
	}

	@Override
	public OpaqueTokenResponse validateOpaqueToken(ClientInformation clientInformation, OpaqueTokenResponse wOpaqueTokenResponse, AccessTokenResponse wAccessTokenResponse) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl validateOpaqueToken] ------> Inicia validacion de token Opaco <-------");
		}

		LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl validateOpaqueToken] clientInformation2 ---> " + clientInformation.toString());

		OpaqueTokenResponse opaqueTokenResponse = null;
		HttpURLConnection con = null;
		DataOutputStream wr = null;
		ObjectMapper objectMapper = new ObjectMapper();
		// Lectura URL archivo de configuracion
		String urlOpaqueToken = BioOnboardingConfiguration.getUrlFromXML("urlValidateOpaqueToken");
		String clientId = BioOnboardingConfiguration.getUrlFromXML("clientId");
		LOGGER.logDebug("UrlTokenOpaco: " + urlOpaqueToken);

		try {
			// Invocacion token de acceso
			// AccessTokenResponse accessToken = generateAccessToken(BioOnboardingConfiguration.getUrlFromXML("urlValidateOpaqueToken"));

			if (null != urlOpaqueToken && null != wAccessTokenResponse) {
				URL obj = new URL(urlOpaqueToken);
				if (urlOpaqueToken.contains("https")) {
					con = (HttpsURLConnection) obj.openConnection();
				} else {
					con = (HttpURLConnection) obj.openConnection();
				}

				LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl validateOpaqueToken] ------> Inicia Conexion <-------");

				// Creacion de MsgRqHdr -- objeto q es parte del header
				String msgRqHdr = generateMsgRqHdrOpaqueToken(clientInformation);

				con.setRequestMethod("POST");
				con.setDoOutput(true);
				con.setRequestProperty("Content-type", Parameter.JSON);
				con.setRequestProperty("accept", Parameter.JSON);
				con.setRequestProperty("x-ibm-client-id", clientId);
				con.setRequestProperty("Authorization", "Bearer ".concat(wAccessTokenResponse.getAccessToken()));
				con.setRequestProperty("MsgRqHdr", msgRqHdr);

				con.connect();

				// Enviar request
				wr = new DataOutputStream(con.getOutputStream());

				byte[] input = generateValOpaqueTokenRequest(wOpaqueTokenResponse).getBytes(Parameter.UTF_8);
				wr.write(input);
				wr.flush();

				LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl validateOpaqueToken] generateOpaqueTokenRequest ---> " + generateOpaqueTokenRequest(clientInformation));
				LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl validateOpaqueToken] con.getInputStream():" + con.getInputStream().toString());
				// Capturando respuesta
				BufferedReader reader = new BufferedReader(new InputStreamReader(con.getInputStream()));
				StringBuilder response = new StringBuilder();
				String responseLine = null;

				if (con.getResponseCode() == 200) {
					while ((responseLine = reader.readLine()) != null) {
						LOGGER.logDebug("responseLine >>" + responseLine);
						response.append(responseLine);
					}

					LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl validateOpaqueToken] response ---> " + response.toString());

					opaqueTokenResponse = objectMapper.readValue(response.toString(), OpaqueTokenResponse.class);
					opaqueTokenResponse.setSequential(clientInformation.getIdSesionCliente());

					LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl validateOpaqueToken] opaqueTokenResponse ---> " + opaqueTokenResponse.toString());
				} else {
					LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl validateOpaqueToken] Ingresa al error ---> " + con.getErrorStream().toString());
					responseLine = Utils.readBufferReader(new BufferedReader(new InputStreamReader(con.getErrorStream())));
				}

				LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl validateOpaqueToken] Respuesta del servicio Token Opaco ---->" + response.toString());
			} else {
				LOGGER.logError("[OrchestrationBioOnboardingServiceSERVImpl validateOpaqueToken] No se puede ejecutar servicio para obtener el Token Opaco");
			}

		} catch (Exception e) {
			LOGGER.logError("[OrchestrationBioOnboardingServiceSERVImpl validateOpaqueToken] Error en la ejecucion del servicio para obtener el Token Opaco", e);
			// Seteo de mensajes de error
			ErrorMessage error = getErrorMessage(con);
			if (null != error) {
				opaqueTokenResponse = new OpaqueTokenResponse();
				opaqueTokenResponse.setErrorMessage(error);
			}

			LOGGER.logError("[OrchestrationBioOnboardingServiceSERVImpl validateOpaqueToken] Error en la ejecucion del servicio para obtener el Token Opaco", e);

		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl validateOpaqueToken]------> Finaliza validacion de token Opaco <-------");
			}

			try {
				con.disconnect();
				wr.close();
			} catch (Exception e) {
				LOGGER.logError("[OrchestrationBioOnboardingServiceSERVImpl validateOpaqueToken] Error al cerrar conexion de servicio: ", e);
			}
		}
		return opaqueTokenResponse;
	}

	public String generateMsgRqHdrOpaqueToken(ClientInformation clientInformation) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl generateMsgRqHdrOpaqueToken]----> Inicia generateHeaderRequestOT <------");
		}

		String result = null;
		if (clientInformation != null) {
			String initJson = "{\"UserId\": \"";
			String userIdValue = clientInformation.getIdCliente() != null ? clientInformation.getIdCliente() : "";
			String clientIPAddressValue = clientInformation.getIpLocal() != null ? clientInformation.getIpLocal() : "";
			String clientSessionIdValue = clientInformation.getIdSesionCliente() != null ? clientInformation.getIdSesionCliente() : "";
			String clientId = clientInformation.getIdCliente() != null ? clientInformation.getIdCliente() : "";
			String finalJson = "\"}";
			result = initJson.concat(userIdValue).concat("\",\"ClientIPAddress\": \"").concat(clientIPAddressValue).concat("\",\"ClientSessionId\": \"").concat(clientSessionIdValue)
					.concat("\",\"ClientId\": \"").concat(clientId).concat(finalJson);
		} else {
			LOGGER.logError("[OrchestrationBioOnboardingServiceSERVImpl generateMsgRqHdrOpaqueToken] Error al obtener la informacion del cliente");
		}

		return result;
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

	private String generateValOpaqueTokenRequest(OpaqueTokenResponse wOpaqueTokenResponse) {
		String jsonObject = null;
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl generateValOpaqueTokenRequest]----> Inicia <------");
		}
		try {
			if (null != wOpaqueTokenResponse && wOpaqueTokenResponse.getSecObjRec() != null && wOpaqueTokenResponse.getSecObjRec().getSecObjInfo() != null
					&& wOpaqueTokenResponse.getSecObjRec().getSecObjInfo().getSecObjValue() != null) {
				Map<String, Object> informacion = new HashMap<String, Object>();
				informacion.put("opaqueToken", wOpaqueTokenResponse.getSecObjRec().getSecObjInfo().getSecObjValue());

				SecObjSelRequest secObjSel = new SecObjSelRequest();
				secObjSel.setRqUID(Parameter.BLANCK_SPACE);
				// ArrayList<SecObjSel> listSecObjData = new ArrayList<SecObjSel>();

				SecObjSel secObjData = new SecObjSel();
				for (Map.Entry<String, Object> map : informacion.entrySet()) {
					secObjData.setSecObjPurpose(null);
					secObjData.setSecObjValue(String.valueOf(map.getValue()));
					// listSecObjData.add(secObjData);
				}
				// secObjSel.setSecObjSel(listSecObjData);

				OpaqueTokenRequest opaqueTokenRequest = new OpaqueTokenRequest();
				opaqueTokenRequest.setRqUID(Parameter.BLANCK_SPACE);
				opaqueTokenRequest.setSecObjSel(secObjData);

				// Convertir objeto final a json
				ObjectMapper mapper = new ObjectMapper();
				jsonObject = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(opaqueTokenRequest);

				LOGGER.logDebug("[OrchestrationBioOnboardingServiceSERVImpl generateValOpaqueTokenRequest] Objeto final ---> " + jsonObject);
			} else {
				LOGGER.logError("[OrchestrationBioOnboardingServiceSERVImpl generateValOpaqueTokenRequest] No se pudo recuperar la información del cliente: " + wOpaqueTokenResponse);
			}
		} catch (Exception e) {
			LOGGER.logError("[OrchestrationBioOnboardingServiceSERVImpl generateValOpaqueTokenRequest] Error en la creación del objeto Request del Token Opaco ---> ", e);
		}
		return jsonObject;
	}

	public String generateOpaqueTokenRequest(ClientInformation clientInfor) {
		String jsonObject = null;

		// Creacion del request
		try {
			if (null != clientInfor) {
				// Obtencion de informacion del cliente
				Map<String, Object> informacion = new HashMap<String, Object>();
				if (clientInfor.getFileId() != null) {
					informacion.put("idExpediente", clientInfor.getFileId());
				}
				if (clientInfor.getChannelId() != null) {
					informacion.put("idCanal", clientInfor.getChannelId());
				}
				if (clientInfor.getOriginId() != null) {
					informacion.put("idOrigen", clientInfor.getOriginId());
				}
				if (clientInfor.getCountryId() != null) {
					informacion.put("idPais", clientInfor.getCountryId());
				}
				if (clientInfor.getRedirectURL() != null) {
					informacion.put("redirectURL", clientInfor.getRedirectURL());
				}
				if (clientInfor.getFlow() != null) {
					informacion.put("flow", clientInfor.getFlow());
				}

				SecObjInfoRequest secObjInfo = new SecObjInfoRequest();
				ArrayList<SecObjData> listSecObjData = new ArrayList<SecObjData>();
				for (Map.Entry<String, Object> map : informacion.entrySet()) {
					SecObjData secObjData = new SecObjData();
					secObjData.setSecObjDataKey(map.getKey());
					secObjData.setSecObjDataValue(String.valueOf(map.getValue()));
					secObjData.setSecObjDataType(STR_TYPE);
					listSecObjData.add(secObjData);
				}
				secObjInfo.setSecObjData(listSecObjData);

				// Creacion del objeto de request completo
				OpaqueTokenRequest opaqueTokenRequest = new OpaqueTokenRequest();
				// opaqueTokenRequest.setRqUID(Parameter.BLANCK_SPACE);
				opaqueTokenRequest.setSecObjInfo(secObjInfo);

				// Convertir objeto final a json
				ObjectMapper mapper = new ObjectMapper();
				jsonObject = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(opaqueTokenRequest);

				LOGGER.logDebug("[OrchestrationBiometricServiceSERVImpl generateOpaqueTokenRequest] Objeto final ---> " + jsonObject);

			} else {
				LOGGER.logError("[OrchestrationBiometricServiceSERVImpl generateOpaqueTokenRequest] No se pudo recuperar la información del cliente: " + clientInfor);
			}

		} catch (Exception e) {
			LOGGER.logError("[OrchestrationBiometricServiceSERVImpl generateOpaqueTokenRequest] Error en la creación del objeto Request del Token Opaco ---> ", e);
		}
		return jsonObject;
	}

}