/**
 * Archivo: OrchestrationClientValidationService.java
 * Fecha..:
 * Autor..: Team Evac
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

package com.cobiscorp.ecobis.cobiscloudbiometric.impl;

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
import java.util.Base64;
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
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.AccessTokenResponse;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.ClientInformation;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.ErrorMessage;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.OpaqueTokenResponse;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.PAdicional;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.StokenGeneratorRespMain;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.serv.bsl.IOrchestationBiometricService;
import com.cobiscorp.ecobis.cobiscloudbiometric.util.config.reader.BiometricConfiguration;
import com.cobiscorp.ecobis.cobiscloudbiometric.util.constants.Parameter;
import com.cobiscorp.ecobis.cobiscloudbiometric.util.impl.Utils;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

@Component
@Service({ IOrchestationBiometricService.class })

public class OrchestrationBiometricServiceSERVImpl extends ServiceBase implements IOrchestationBiometricService {

	private static final String CLIENT_SECRET_REN = "clientSecretREN";

	private static final String CLIENT_ID_REN = "clientIdREN";

	private static final String CLIENT_SECRET_BIO = "clientSecretBIO";

	private static final String CLIENT_ID_BIO = "clientIdBIO";

	private static ILogger LOGGER = LogFactory.getLogger(OrchestrationBiometricServiceSERVImpl.class);

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
	public AccessTokenResponse accessTokenBC(String urlAccessToken) {
		AccessTokenResponse accessTokenResponse = null;
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("------> Inicia generacion de Access Token BC <-------");
			LOGGER.logDebug("urlAccessTokenAccesoTOpaco: " + urlAccessToken);
		}
		String clientId = BiometricConfiguration.getUrlFromXML(CLIENT_ID_BIO) != null ? BiometricConfiguration.getUrlFromXML(CLIENT_ID_BIO).trim() : null;

		HttpsURLConnection con = null;
		DataOutputStream wr = null;
		try {
			// Creacion Cabera nueva
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("client_id", clientId);

			LOGGER.logDebug("client_id Token Acceso: " + params.get("client_id"));

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
				con.setRequestMethod("POST");
				con.setDoOutput(true);
				con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
				con.setRequestProperty("Content-Length", Integer.toString(postDataBytes.length));
				con.connect();
				LOGGER.logDebug("[AccessTokenResponse accessTokenBC] - con:" + con);
				// Enviar request
				ObjectMapper objectMapper = new ObjectMapper();
				wr = new DataOutputStream(con.getOutputStream());
				wr.write(postDataBytes);
				wr.flush();

				// Capturando respuesta
				LOGGER.logDebug("[AccessTokenResponse accessTokenBC] - con.getResponseCode():" + con.getResponseCode());
				String result = null;
				LOGGER.logDebug("[AccessTokenResponse accessTokenBC] - con.getInputStream():" + con.getInputStream());
				if (con.getResponseCode() == 200) { // OK
					ObjectMapper mapper = new ObjectMapper();
					result = Utils.readBufferReader(new BufferedReader(new InputStreamReader(con.getInputStream())));
					accessTokenResponse = objectMapper.readValue(result, AccessTokenResponse.class);

				} else if (con.getResponseCode() == 401) {
					accessTokenResponse = new AccessTokenResponse();
					result = Utils.readBufferReader(new BufferedReader(new InputStreamReader(con.getInputStream())));
					accessTokenResponse.setErrorMessage(objectMapper.readValue(result, ErrorMessage.class));
				}

				LOGGER.logDebug("Respuesta del servicio Access Token BC ---->" + accessTokenResponse.toString());

			} else {
				LOGGER.logError("No se puede ejecutar servicio para obtener el Access Token BC");
			}

		} catch (Exception e) {
			LOGGER.logError("[AccessTokenResponse accessTokenBC] - Error en la ejecucion del servicio para obtener el Access Token BC ---->", e);

			// Seteo de mensajes de error
			ErrorMessage error = getErrorMessage(con);
			if (null != error) {
				accessTokenResponse = new AccessTokenResponse();
				accessTokenResponse.setErrorMessage(error);
			}

			LOGGER.logError("Error en la ejecucion del servicio para obtener el Access Token BC ---->", e);

		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("------> Finaliza generacion de Access Token BC <-------");
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
	public AccessTokenResponse accessToken(String urlAccessToken, String flagsFunc) {
		AccessTokenResponse accessTokenResponse = null;
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("------> Inicia generacion de Access Token <-------");
		}

		LOGGER.logDebug("urlAccessTokenAccesoTOpaco: " + urlAccessToken);

		String clientId = BiometricConfiguration.getUrlFromXML(CLIENT_ID_BIO) != null ? BiometricConfiguration.getUrlFromXML(CLIENT_ID_BIO).trim() : null;
		String clientSecret = BiometricConfiguration.getUrlFromXML(CLIENT_SECRET_BIO) != null ? BiometricConfiguration.getUrlFromXML(CLIENT_SECRET_BIO).trim() : null;
		if (Parameter.RENAPO_FLAG.equals(flagsFunc)) {
			clientId = BiometricConfiguration.getUrlFromXML(CLIENT_ID_REN) != null ? BiometricConfiguration.getUrlFromXML(CLIENT_ID_REN).trim() : null;
			clientSecret = BiometricConfiguration.getUrlFromXML(CLIENT_SECRET_REN) != null ? BiometricConfiguration.getUrlFromXML(CLIENT_SECRET_REN).trim() : null;
		}

		HttpsURLConnection con = null;
		DataOutputStream wr = null;

		try {

			// Creacion Cabera nueva
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("grant_type", "client_credentials");
			params.put("client_id", clientId);
			params.put("client_secret", clientSecret);

			if (urlAccessToken.equals(BiometricConfiguration.getUrlFromXML("urlAccessTokenAccesoTOpaco"))) {
				params.put("scope", "oauth-token-management_1.0.0");
			} else {
				params.put("scope", "biometricData.read biometricData.engine biometricData.external");
			}
			if (Parameter.RENAPO_FLAG.equals(flagsFunc)) {
				params.put("scope", "resources.all");
			}

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
				con.setRequestMethod("POST");
				con.setDoOutput(true);
				con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
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

	@Override
	public OpaqueTokenResponse opaqueToken(ClientInformation clientInformation) {
		Utils.printDbgLog("[OrchestrationBiometricServiceSERVImpl opaqueToken] ------> Inicia generacion de token Opaco <-------");

		StokenGeneratorRespMain stokenGeneratorRespMain = null;
		OpaqueTokenResponse opaqueTokenResponse = null;
		HttpURLConnection con = null;
		ObjectMapper objectMapper = new ObjectMapper();
		// Lectura URL archivo de configuracion
		String urlOpaqueToken = BiometricConfiguration.getUrlFromXML("urlOpaqueToken");
		try {
			// Invocacion token de acceso
			AccessTokenResponse accessToken = accessTokenBC(BiometricConfiguration.getUrlFromXML("urlAccessTokenAccesoTOpaco"));
			String fullUrl = urlOpaqueToken + "?" + generateOpaqueTokenRequest(clientInformation); // .getBytes(Parameter.UTF_8);
			Utils.printDbgLog("[OrchestrationBiometricServiceSERVImpl opaqueToken] fullUrl: " + fullUrl);

			if (null != urlOpaqueToken && null != accessToken) {
				URL obj = new URL(fullUrl);
				if (urlOpaqueToken.contains("https")) {
					con = (HttpsURLConnection) obj.openConnection();
				} else {
					con = (HttpURLConnection) obj.openConnection();
				}
				Utils.printDbgLog("[OrchestrationBiometricServiceSERVImpl opaqueToken] ------> Inicia Conexion <-------");
				con.setRequestMethod("GET");
				con.setDoOutput(true);
				con.setRequestProperty("Accept", "*/*");
				con.setRequestProperty("Authorization", "Bearer ".concat(accessToken.getAccessToken()));
				con.connect();

				Utils.printDbgLog("[OrchestrationBiometricServiceSERVImpl opaqueToken] generateOpaqueTokenRequest ---> " + fullUrl);
				Utils.printDbgLog("[OrchestrationBiometricServiceSERVImpl opaqueToken] con.getInputStream():" + con.getInputStream().toString());

				// Capturando respuesta
				BufferedReader reader = new BufferedReader(new InputStreamReader(con.getInputStream()));
				StringBuilder response = new StringBuilder();
				String responseLine = null;

				if (con.getResponseCode() == 200) {
					while ((responseLine = reader.readLine()) != null) {
						Utils.printDbgLog("responseLine >>" + responseLine);
						response.append(responseLine);
					}
					Utils.printDbgLog("[OrchestrationBiometricServiceSERVImpl opaqueToken] response ---> " + response.toString());
					stokenGeneratorRespMain = objectMapper.readValue(response.toString(), StokenGeneratorRespMain.class);
					Utils.printDbgLog("[OrchestrationBiometricServiceSERVImpl opaqueToken] opaqueTokenResponse ---> " + stokenGeneratorRespMain.toString());
					opaqueTokenResponse = new OpaqueTokenResponse();
					opaqueTokenResponse.setStokenGeneratorResponse(stokenGeneratorRespMain.getStokenGeneratorResponse());
				} else {
					Utils.printDbgLog("[OrchestrationBiometricServiceSERVImpl opaqueToken] Ingresa al error ---> " + con.getErrorStream().toString());
					responseLine = Utils.readBufferReader(new BufferedReader(new InputStreamReader(con.getErrorStream())));
				}
				Utils.printDbgLog("[OrchestrationBiometricServiceSERVImpl opaqueToken] Respuesta del servicio Token Opaco ---->" + response.toString());
			} else {
				LOGGER.logError("[OrchestrationBiometricServiceSERVImpl opaqueToken] No se puede ejecutar servicio para obtener el Token Opaco");
			}
		} catch (Exception e) {
			LOGGER.logError("[OrchestrationBiometricServiceSERVImpl opaqueToken] Error en la ejecucion del servicio para obtener el Token Opaco", e);
			// Seteo de mensajes de error
			ErrorMessage error = getErrorMessage(con);
			if (null != error) {
				opaqueTokenResponse = new OpaqueTokenResponse();
				opaqueTokenResponse.setErrorMessage(error);
			}
			LOGGER.logError("[OrchestrationBiometricServiceSERVImpl opaqueToken] Error en la ejecucion del servicio para obtener el Token Opaco", e);

		} finally {
			Utils.printDbgLog("[OrchestrationBiometricServiceSERVImpl opaqueToken]------> Finaliza generacion de token Opaco <-------");
			try {
				con.disconnect();
			} catch (Exception e) {
				LOGGER.logError("[OrchestrationBiometricServiceSERVImpl opaqueToken] Error al cerrar conexion de servicio: ", e);
			}
		}
		return opaqueTokenResponse;
	}

	public String generateMsgRqHdrOpaqueToken(ClientInformation clientInformation) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("[OrchestrationBiometricServiceSERVImpl generateMsgRqHdrOpaqueToken]----> Inicia generateHeaderRequestOT <------");
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
			LOGGER.logError("[OrchestrationBiometricServiceSERVImpl generateMsgRqHdrOpaqueToken] Error al obtener la informacion del cliente");
		}

		return result;
	}

	public ErrorMessage getErrorMessage(HttpURLConnection con) {
		LOGGER.logDebug("[OrchestrationBiometricServiceSERVImpl getErrorMessage] - Inicio metodo");
		String jsonMessage = null;
		ErrorMessage errorMessage = null;
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			LOGGER.logDebug("[OrchestrationBiometricServiceSERVImpl getErrorMessage] - con.getErrorStream():" + con.getErrorStream());
			jsonMessage = Utils.readBufferReader(new BufferedReader(new InputStreamReader(con.getErrorStream())));
			errorMessage = objectMapper.readValue(jsonMessage, ErrorMessage.class);
			LOGGER.logDebug("[OrchestrationBiometricServiceSERVImpl getErrorMessage] - errorMessage.toString():" + errorMessage.toString());
			LOGGER.logDebug("Mensajes de error ---> " + errorMessage.toString());

		} catch (IOException e) {
			LOGGER.logDebug("[OrchestrationBiometricServiceSERVImpl getErrorMessage] - e:", e);
			errorMessage = new ErrorMessage();
			try {
				errorMessage.setHttpCode(String.valueOf(con.getResponseCode()));
				errorMessage.setHttpMessage(con.getErrorStream().toString());
			} catch (IOException e1) {
				LOGGER.logError("[OrchestrationBiometricServiceSERVImpl getErrorMessage] Error al obtener la informacion del error: ", e1);
			}
			LOGGER.logError("[OrchestrationBiometricServiceSERVImpl getErrorMessage] Error al obtener mensajes de error de respuesta de servicio: ", e);
		}
		return errorMessage;
	}

	public String generateOpaqueTokenRequest(ClientInformation clientInformation) {
		StringBuilder postData = new StringBuilder();
		Utils.printDbgLog("[OrchestrationBiometricServiceSERVImpl] - generateOpaqueTokenRequest()");

		// Creacion del request
		try {
			if (null != clientInformation) {
				// Obtencion de informacion del cliente
				Map<String, Object> informacion = new HashMap<String, Object>();

				if (clientInformation.getIpLocal() != null) {
					informacion.put("ipUsuario", clientInformation.getIpLocal());
				}
				if (clientInformation.getIdUsuario() != null) {
					informacion.put("idUsuario", "".equals(clientInformation.getIdUsuario()) ? "null" : clientInformation.getIdUsuario());
				} else {
					informacion.put("idUsuario", "null");
				}
				if (clientInformation.getOfficeId() != null) {
					informacion.put("sesionSN", clientInformation.getOfficeId());
				}
				if (clientInformation.getpAdicional() != null) {
					informacion.put("pAdicional", processAdditionalInfor(clientInformation));
				}
				if (clientInformation.getIdAplicativo() != null) {
					informacion.put("idAplicativo", clientInformation.getIdAplicativo());
				}
				for (Map.Entry<String, Object> param : informacion.entrySet()) {
					if (postData.length() != 0)
						postData.append('&');
					postData.append(URLEncoder.encode(param.getKey(), Parameter.UTF_8));
					postData.append('=');
					postData.append(URLEncoder.encode(String.valueOf(param.getValue()), Parameter.UTF_8));
				}
				Utils.printDbgLog("[OrchestrationBiometricServiceSERVImpl generateOpaqueTokenRequest] Objeto final ---> " + postData);

			} else {
				LOGGER.logError("[OrchestrationBiometricServiceSERVImpl generateOpaqueTokenRequest] No se pudo recuperar la información del cliente: " + clientInformation);
			}

		} catch (Exception e) {
			LOGGER.logError("[OrchestrationBiometricServiceSERVImpl generateOpaqueTokenRequest] Error en la creación del objeto Request del Token Opaco ---> ", e);
		}
		return postData.toString();
	}

	private String processAdditionalInfor(ClientInformation clientInformation) {
		// Convert to JSON and encode to BASE64
		Utils.printDbgLog("[OrchestrationBiometricServiceSERVImpl] - processAdditionalInfor()");
		PAdicional pAdic = clientInformation.getpAdicional();
		Gson gson = new Gson();
		Base64.Encoder encoder = Base64.getEncoder();
		try {
			// Se crea un mapa para almacenar los elementos de Json para data adicional
			Map<String, Object> infoAdicional = new HashMap<String, Object>();

			infoAdicional.put("UserId", pAdic.getUserId());
			infoAdicional.put("BUC", pAdic.getBuc());
			infoAdicional.put("Num.Sucursal", clientInformation.getOfficeId().toString());
			infoAdicional.put("Canal", pAdic.getCanal());
			infoAdicional.put("AppId", pAdic.getAppId());
			infoAdicional.put("TransactionId", generateTrxIdString(pAdic.getBuc()));
			infoAdicional.put("EstatusPersona", pAdic.getEstPers());
			infoAdicional.put("TipoOperacion", pAdic.getTipoOperacion());
			infoAdicional.put("TipoOperacionApp", pAdic.getTipoOpeApp());

			JsonObject jsonInfoAdicional = gson.toJsonTree(infoAdicional).getAsJsonObject();

			String jsonString = gson.toJson(jsonInfoAdicional);
			Utils.printDbgLog("[OrchestrationBiometricServiceSERVImpl] - processAdditionalInfor() --> jsonString => " + jsonString.toString());
			return encoder.encodeToString(jsonString.getBytes());
		} catch (Exception e) {
			LOGGER.logError("[OrchestrationBiometricServiceSERVImpl processAdditionalInfor] Error ---> ", e);
		}
		return "";
	}

	private String generateTrxIdString(String cstmrBuc) {
		DateFormat dateFormat = new SimpleDateFormat(Parameter.DATE_FORMAT_1);
		Date date = new Date();
		return cstmrBuc + dateFormat.format(date);
	}

}