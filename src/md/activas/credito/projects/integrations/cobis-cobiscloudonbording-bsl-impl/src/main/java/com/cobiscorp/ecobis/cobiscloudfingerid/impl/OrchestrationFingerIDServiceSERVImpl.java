/**
 * Archivo: OrchestrationFingerIDServiceSERVImpl.java
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

package com.cobiscorp.ecobis.cobiscloudfingerid.impl;

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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;
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
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.ErrorMessage;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.FingerPrintRequest;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenRequest;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.OpaqueTokenResponse;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.SecObjData;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.SecObjInfoRequest;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.SecObjSel;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.SecObjSelRequest;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.serv.bsl.IOrchestationFingerIDService;
import com.cobiscorp.ecobis.cobiscloudonboard.impl.ServiceBase;
import com.cobiscorp.ecobis.cobiscloudonboard.util.config.reader.BioOnboardingConfiguration;
import com.cobiscorp.ecobis.cobiscloudonboard.util.constants.Parameter;
import com.cobiscorp.ecobis.cobiscloudonboard.util.impl.Utils;
import com.fasterxml.jackson.databind.ObjectMapper;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

@Component
@Service({ IOrchestationFingerIDService.class })
public class OrchestrationFingerIDServiceSERVImpl extends ServiceBase implements IOrchestationFingerIDService {
	private static final int END_POS = 3;

	private static final String NEW_USR_PREF = "00000000";

	private static final int IDEXP_LEN = 25;

	private static final String STR_TYPE = "STRING";

	private static ILogger LOGGER = LogFactory.getLogger(OrchestrationFingerIDServiceSERVImpl.class);

	@Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}
	
	// ==================================================================
	// =========================== IMPORTANTE ===========================
	// Solo opara pruebas en DESA - INI
	// ==================================================================
	static {
		disableSslVerification();
	}

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
	// ==================================================================
	// Solo para pruebas en DESA - FIN
	// ==================================================================
	
	
	@Override
	public OpaqueTokenResponse fingerprintCapture(FingerPrintRequest fingerPrintRequest)  throws Exception{
		
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl fingerprintCapture] ------> Inicia Exec de FingerID <-------");
		}
		OpaqueTokenResponse wOpaqueTokenResponse = null;
		// Generate Accesss Oauth Token
		AccessTokenResponse wAccessTokenResponse = generateAccessToken(Parameter.FINGER_CHANNEL);
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl fingerprintCapture] ------> wAccessTokenResponse ---> " + wAccessTokenResponse.toString());
		}
		
		if(wAccessTokenResponse != null && wAccessTokenResponse.getAccessToken()!=null) {
			// Generate Opaque Token
			wOpaqueTokenResponse = opaqueToken(fingerPrintRequest, wAccessTokenResponse);
			return wOpaqueTokenResponse;
		}

		return null;
	}

	@Override
	public OpaqueTokenResponse fingerprintBiometricValidation(FingerPrintRequest fingerPrintRequest) throws Exception{
		
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl fingerprintBiometricValidation] ------> Inicia Exec de Bionoboarding <-------");
		}
		OpaqueTokenResponse wOpaqueTokenResponse = null;
		// 1) Generate Accesss Oauth Token
		AccessTokenResponse wAccessTokenResponse = generateAccessToken(Parameter.FINGER_CHANNEL);

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl fingerprintBiometricValidation] ------> wAccessTokenResponse ---> " + wAccessTokenResponse.toString());
		}
		// 2) Generate Opaque Token
		if(wAccessTokenResponse != null && wAccessTokenResponse.getAccessToken()!=null) {
			// Generate Opaque Token
			wOpaqueTokenResponse = validateOpaqueToken(fingerPrintRequest, wAccessTokenResponse);
			return wOpaqueTokenResponse; //generateOpaqueTokenResponse(wOpaqueTokenResponse, fingerPrintRequest);
		}
		
		return null;
	}

	@Override
	public OpaqueTokenResponse opaqueToken(FingerPrintRequest fingerPrintRequest, AccessTokenResponse wAccessTokenResponse) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl opaqueToken] ------> Inicia generacion de token Opaco <-------");
			LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl opaqueToken] clientInformation2 ---> " + fingerPrintRequest.toString());
		}

		OpaqueTokenResponse opaqueTokenResponse = null;
		HttpURLConnection con = null;
		DataOutputStream wr = null;
		ObjectMapper objectMapper = new ObjectMapper();
		// Lectura URL archivo de configuracion
		String urlOpaqueToken = BioOnboardingConfiguration.getUrlFromXML("urlGenerateOpaqueToken");
		String clientId = BioOnboardingConfiguration.getUrlFromXML("clientId");
		LOGGER.logDebug("UrlTokenOpaco: " + urlOpaqueToken);;

		try {
			// Invocacion token de acceso
			//AccessTokenResponse accessToken = generateAccessToken(BioOnboardingConfiguration.getUrlFromXML("urlAccessTokenAccesoTOpaco"));

			if (null != urlOpaqueToken && null != wAccessTokenResponse) {
				URL obj = new URL(urlOpaqueToken);
				if (urlOpaqueToken.contains("https")) {
					con = (HttpsURLConnection) obj.openConnection();
				} else {
					con = (HttpURLConnection) obj.openConnection();
				}

				LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl opaqueToken] ------> Inicia Conexion <-------");
				
				// Creacion de MsgRqHdr -- objeto q es parte del header
				String msgRqHdr = generateMsgRqHdrOpaqueToken(fingerPrintRequest);
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl opaqueToken] ------> msgRqHdr = " + msgRqHdr);
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

				byte[] input = generateOpaqueTokenRequest(fingerPrintRequest).getBytes(Parameter.UTF_8);
				wr.write(input);
				wr.flush();

				LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl opaqueToken] con.getInputStream():" + con.getInputStream().toString());
				// Capturando respuesta
				BufferedReader reader = new BufferedReader(new InputStreamReader(con.getInputStream()));
				StringBuilder response = new StringBuilder();
				String responseLine = null;

				if (con.getResponseCode() == 200) {
					while ((responseLine = reader.readLine()) != null) {
						LOGGER.logDebug("responseLine >>" + responseLine);
						response.append(responseLine);
					}

					LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl opaqueToken] response ---> " + response.toString());

					opaqueTokenResponse = objectMapper.readValue(response.toString(), OpaqueTokenResponse.class);
					//opaqueTokenResponse.setSequential(fingerPrintRequest.getIdSesionCliente());

					LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl opaqueToken] opaqueTokenResponse ---> " + opaqueTokenResponse.toString());
				} else {
					LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl opaqueToken] Ingresa al error ---> " + con.getErrorStream().toString());
					responseLine = Utils.readBufferReader(new BufferedReader(new InputStreamReader(con.getErrorStream())));
				}

				LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl opaqueToken] Respuesta del servicio Token Opaco ---->" + response.toString());
			} else {
				LOGGER.logError("[OrchestrationFingerIDServiceSERVImpl opaqueToken] No se puede ejecutar servicio para obtener el Token Opaco");
			}

		} catch (Exception e) {
			LOGGER.logError("[OrchestrationFingerIDServiceSERVImpl opaqueToken] Error en la ejecucion del servicio para obtener el Token Opaco1:", e);
			// Seteo de mensajes de error
			ErrorMessage error = getErrorMessage(con);
			if (null != error) {
				opaqueTokenResponse = new OpaqueTokenResponse();
				opaqueTokenResponse.setErrorMessage(error);
			}

			LOGGER.logError("[OrchestrationFingerIDServiceSERVImpl opaqueToken] Error en la ejecucion del servicio para obtener el Token Opaco2:", e);

		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl opaqueToken]------> Finaliza generacion de token Opaco <-------");
			}

			try {
				con.disconnect();
				wr.close();
			} catch (Exception e) {
				LOGGER.logError("[OrchestrationFingerIDServiceSERVImpl opaqueToken] Error al cerrar conexion de servicio: ", e);
			}
		}
		return opaqueTokenResponse;
	}
	
	@Override
	public OpaqueTokenResponse validateOpaqueToken(FingerPrintRequest fingerPrintRequest, AccessTokenResponse wAccessTokenResponse) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl validateOpaqueToken] ------> Inicia validacion de token Opaco <-------");
			LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl validateOpaqueToken] fingerPrintRequest ---> " + fingerPrintRequest.toString());
		}

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
			//AccessTokenResponse accessToken = generateAccessToken(BioOnboardingConfiguration.getUrlFromXML("urlValidateOpaqueToken"));

			if (null != urlOpaqueToken && null != wAccessTokenResponse) {
				URL obj = new URL(urlOpaqueToken);
				if (urlOpaqueToken.contains("https")) {
					con = (HttpsURLConnection) obj.openConnection();
				} else {
					con = (HttpURLConnection) obj.openConnection();
				}

				LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl validateOpaqueToken] ------> Inicia Conexion <-------");
				
				// Creacion de MsgRqHdr -- objeto q es parte del header
				String msgRqHdr = generateMsgRqHdrOpaqueToken(fingerPrintRequest);

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

				byte[] input = generateValOpaqueTokenRequest(fingerPrintRequest).getBytes(Parameter.UTF_8);
				wr.write(input);
				wr.flush();

				LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl validateOpaqueToken] con.getInputStream():" + con.getInputStream().toString());
				// Capturando respuesta
				BufferedReader reader = new BufferedReader(new InputStreamReader(con.getInputStream()));
				StringBuilder response = new StringBuilder();
				String responseLine = null;

				if (con.getResponseCode() == 200) {
					while ((responseLine = reader.readLine()) != null) {
						LOGGER.logDebug("responseLine >>" + responseLine);
						response.append(responseLine);
					}

					LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl validateOpaqueToken] response ---> " + response.toString());

					opaqueTokenResponse = objectMapper.readValue(response.toString(), OpaqueTokenResponse.class);
					//opaqueTokenResponse.setSequential(clientInformation.getIdSesionCliente());

					LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl validateOpaqueToken] opaqueTokenResponse ---> " + opaqueTokenResponse.toString());
				} else {
					LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl validateOpaqueToken] Ingresa al error ---> " + con.getErrorStream().toString());
					responseLine = Utils.readBufferReader(new BufferedReader(new InputStreamReader(con.getErrorStream())));
				}

				LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl validateOpaqueToken] Respuesta del servicio Token Opaco ---->" + response.toString());
			} else {
				LOGGER.logError("[OrchestrationFingerIDServiceSERVImpl validateOpaqueToken] No se puede ejecutar servicio para obtener el Token Opaco");
			}

		} catch (Exception e) {
			LOGGER.logError("[OrchestrationFingerIDServiceSERVImpl validateOpaqueToken] Error en la ejecucion del servicio para obtener el Token Opaco1:", e);
			// Seteo de mensajes de error
			ErrorMessage error = getErrorMessage(con);
			if (null != error) {
				opaqueTokenResponse = new OpaqueTokenResponse();
				opaqueTokenResponse.setErrorMessage(error);
			}

			LOGGER.logError("[OrchestrationFingerIDServiceSERVImpl validateOpaqueToken] Error en la ejecucion del servicio para obtener el Token Opaco2:", e);

		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl validateOpaqueToken]------> Finaliza generacion de token Opaco <-------");
			}

			try {
				con.disconnect();
				wr.close();
			} catch (Exception e) {
				LOGGER.logError("[OrchestrationFingerIDServiceSERVImpl validateOpaqueToken] Error al cerrar conexion de servicio: ", e);
			}
		}
		return opaqueTokenResponse;
	}
	
	public AccessTokenResponse generateAccessToken(String channelPrefix) {
		AccessTokenResponse accessTokenResponse = null;
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("------> Inicia generacion de Access Token - HttpExecution <-------");
		}
		String urlAccessToken = BioOnboardingConfiguration.getConfigValue("urlAccessOauthToken", channelPrefix);
		LOGGER.logDebug("HttpExecution - urlAccessTokenAccesoTOpaco: " + urlAccessToken);
		
		
		String clientId = BioOnboardingConfiguration.getConfigValue("clientId", channelPrefix);
		String clientSecret = BioOnboardingConfiguration.getConfigValue("clientSecret", channelPrefix); 
		
		HttpsURLConnection con = null;
		DataOutputStream wr = null;

		try {

			// Creacion Cabera nueva
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("grant_type", Parameter.GRANTTYPE_CLICRED);
			params.put("client_id", clientId);
			params.put("client_secret", clientSecret);
			params.put("scope", Parameter.OAUTH_TOKEN_MNG);

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("HttpExecution - scope Token Acceso: "+params.get("scope"));
			}
			
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
				wr = new DataOutputStream(con.getOutputStream());
				wr.write(postDataBytes);
				wr.flush();
				
				// Capturando respuesta
				LOGGER.logDebug("[AccessTokenResponse accessToken] - con.getResponseCode():" + con.getResponseCode());
				String result = null;
				ObjectMapper objectMapper = new ObjectMapper();
				LOGGER.logDebug("[AccessTokenResponse accessToken] - con.getInputStream():" + con.getInputStream());				
				if (con.getResponseCode() == 200) { // OK
					result = Utils.readBufferReader(new BufferedReader(new InputStreamReader(con.getInputStream())));
					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("HttpExecution - result: "+result);
					}
					accessTokenResponse = objectMapper.readValue(result, AccessTokenResponse.class);

				} else if (con.getResponseCode() == 401) {
					accessTokenResponse = new AccessTokenResponse();
					result = Utils.readBufferReader(new BufferedReader(new InputStreamReader(con.getInputStream())));
					accessTokenResponse.setErrorMessage(objectMapper.readValue(result, ErrorMessage.class));
				}
				LOGGER.logDebug("Respuesta del servicio Access Token ---->" + accessTokenResponse.getAccessToken());
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
		LOGGER.logDebug("[HttpExecution getErrorMessage] - Inicio metodo");
		String jsonMessage = null;
		ErrorMessage errorMessage = null;
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			LOGGER.logDebug("[HttpExecution getErrorMessage] - con.getErrorStream():" + con.getErrorStream());
			jsonMessage = Utils.readBufferReader(new BufferedReader(new InputStreamReader(con.getErrorStream())));
			errorMessage = objectMapper.readValue(jsonMessage, ErrorMessage.class);
			LOGGER.logDebug("[HttpExecution getErrorMessage] - errorMessage.toString():" + errorMessage.toString());
			LOGGER.logDebug("Mensajes de error ---> " + errorMessage.toString());
			
		} catch (IOException e) {
			LOGGER.logDebug("[HttpExecution getErrorMessage] - e:", e);
			errorMessage = new ErrorMessage();
			try {
				errorMessage.setHttpCode(String.valueOf(con.getResponseCode()));
				errorMessage.setHttpMessage(con.getErrorStream().toString());
			} catch (IOException e1) {
				LOGGER.logError("[HttpExecution getErrorMessage] Error al obtener la informacion del error: ", e1);
			}
			LOGGER.logError("[HttpExecution getErrorMessage] Error al obtener mensajes de error de respuesta de servicio: ", e);
		}
		return errorMessage;
	}

	public String generateMsgRqHdrOpaqueToken(FingerPrintRequest fingerPrintRequest) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl generateMsgRqHdrOpaqueToken]----> Inicia generateHeaderRequestOT <------");
		}

		String result = null;
		if (fingerPrintRequest != null) {
			String initJson = "{\"UserId\": \"";
			String userIdValue = fingerPrintRequest.getCustomerId() != null ? fingerPrintRequest.getCustomerId() : "";
			String clientIPAddressValue = fingerPrintRequest.getIpLocal() != null ? fingerPrintRequest.getIpLocal() : "";
			String clientSessionIdValue = fingerPrintRequest.getIdSesionCliente() != null ? fingerPrintRequest.getIdSesionCliente() : "";
			String clientId = fingerPrintRequest.getCustomerId() != null ? fingerPrintRequest.getCustomerId() : "";
			String finalJson = "\"}";
			result = initJson.concat(userIdValue).concat("\",\"ClientIPAddress\": \"").concat(clientIPAddressValue).concat("\",\"ClientSessionId\": \"")
					.concat(clientSessionIdValue).concat("\",\"ClientId\": \"").concat(clientId).concat(finalJson);
		} else {
			LOGGER.logError("[OrchestrationFingerIDServiceSERVImpl generateMsgRqHdrOpaqueToken] Error al obtener la informacion del cliente");
		}

		return result;
	}

	private String generateValOpaqueTokenRequest(FingerPrintRequest fingerPrintRequest) {
		String jsonObject = null;
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl generateValOpaqueTokenRequest]----> Inicia <------");
		}
		try {
			if(null != fingerPrintRequest && fingerPrintRequest.getTokenToValid()!= null ) {
				Map<String, Object> informacion = new HashMap<String, Object>();
				
				informacion.put("opaqueToken", fingerPrintRequest.getTokenToValid());
				
				SecObjSelRequest secObjSel = new SecObjSelRequest();
				secObjSel.setRqUID(Parameter.BLANCK_SPACE);
				//ArrayList<SecObjSel> listSecObjData = new ArrayList<SecObjSel>();
				
				SecObjSel secObjData = new SecObjSel();
				for (Map.Entry<String, Object> map : informacion.entrySet()) {
					secObjData.setSecObjPurpose(null);
					secObjData.setSecObjValue(String.valueOf(map.getValue()));
					//listSecObjData.add(secObjData);
				}
				//secObjSel.setSecObjSel(listSecObjData);
				
				OpaqueTokenRequest opaqueTokenRequest = new OpaqueTokenRequest();
				opaqueTokenRequest.setRqUID(Parameter.BLANCK_SPACE);
				opaqueTokenRequest.setSecObjSel(secObjData);
				
				// Convertir objeto final a json
				ObjectMapper mapper = new ObjectMapper();
				jsonObject = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(opaqueTokenRequest);

				LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl generateValOpaqueTokenRequest] Objeto final ---> " + jsonObject);
			} else {
				LOGGER.logError("[OrchestrationFingerIDServiceSERVImpl generateValOpaqueTokenRequest] No se pudo recuperar la información del cliente: " + fingerPrintRequest.toString2());
			}
		} catch (Exception e) {
			LOGGER.logError("[OrchestrationFingerIDServiceSERVImpl generateValOpaqueTokenRequest] Error en la creación del objeto Request del Token Opaco ---> ", e);
		}
		return jsonObject;
	}
	
	public String generateOpaqueTokenRequest(FingerPrintRequest fingerPrintRequest) {
		String jsonObject = null;
		if(LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl generateOpaqueTokenRequest] - INI - fingerPrintRequest=" + fingerPrintRequest.toString());
		}
		// Creacion del request
		try {
			if (null != fingerPrintRequest) {
				// Obtencion de informacion del cliente
				Map<String, Object> informacion = new HashMap<String, Object>();
				
				//String customerId = fingerPrintRequest.getCustomerId();
				//if(customerId != null) { informacion.put("customerId",customerId); }
				informacion.put("customerId",NEW_USR_PREF);

				String trxType = fingerPrintRequest.getTransactionType() == null ? "":fingerPrintRequest.getTransactionType(); // "7002"; //
				if(trxType != null) { informacion.put("transactionType", trxType); }				
				
				//String trxId =fingerPrintRequest.getTransactionId() == null ? "":fingerPrintRequest.getTransactionId(); // BUC + YYYY MM DD HH mm ss sss
				//if(trxId != null) { informacion.put("transactionId", trxId); }
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");			      
				informacion.put("transactionId", NEW_USR_PREF + dateFormat.format(new Date()));
				
				String branch = fingerPrintRequest.getBranch() == null ? "":fingerPrintRequest.getBranch(); // "0000"; //
				if(branch != null) { informacion.put("branch", branch); }				
				String channel = fingerPrintRequest.getChannel() == null ? "":fingerPrintRequest.getChannel(); // "000"; //
				if(channel != null) { informacion.put("channel", channel); }

				String ocr = fingerPrintRequest.getOcr() == null ? "":fingerPrintRequest.getOcr();
				if(ocr != null) { informacion.put("ocr", ocr); }
				String cic = fingerPrintRequest.getCic() == null ? "":fingerPrintRequest.getCic();
				if(cic != null) { informacion.put("cic", cic); }
				String name = fingerPrintRequest.getName() == null ? "":fingerPrintRequest.getName();
				if(name != null) { informacion.put("name", name); }
				String paternName = fingerPrintRequest.getPaterName() == null ? "":fingerPrintRequest.getPaterName();
				if(paternName != null) { informacion.put("paternName", paternName); }
				String maternName = fingerPrintRequest.getMaternName() == null ? "":fingerPrintRequest.getMaternName();
				if(maternName != null) { informacion.put("maternName", maternName); }
				String registryYear = fingerPrintRequest.getRegistryYear() == null ? "":fingerPrintRequest.getRegistryYear();
				if(registryYear != null) { informacion.put("yearRecord", registryYear); }
				String expeditionYear = fingerPrintRequest.getExpeditionYear() == null ? "":fingerPrintRequest.getExpeditionYear();
				if(expeditionYear != null) { informacion.put("yearEmision", expeditionYear); }
				String numCredEmission = fingerPrintRequest.getNumCredEmission() == null ? "":fingerPrintRequest.getNumCredEmission();
				if(numCredEmission != null) { informacion.put("numCredEmission", numCredEmission); }
				String electoralKey = fingerPrintRequest.getElectoralKey() == null ? "":fingerPrintRequest.getElectoralKey();
				if(electoralKey != null) { informacion.put("electoralKey", electoralKey); }
				
				String latitude = fingerPrintRequest.getLatitude() == null ? "":formatGeolocationPoint(fingerPrintRequest.getLatitude());
				if(latitude != null) { informacion.put("latitude", latitude); }
				String longitude = fingerPrintRequest.getLongitude() == null ? "":formatGeolocationPoint(fingerPrintRequest.getLongitude());
				if(longitude != null) { informacion.put("longitude", longitude); }
				
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
				opaqueTokenRequest.setRqUID(Parameter.BLANCK_SPACE);
				opaqueTokenRequest.setSecObjInfo(secObjInfo);

				// Convertir objeto final a json
				ObjectMapper mapper = new ObjectMapper();
				jsonObject = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(opaqueTokenRequest);
				if(LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("[OrchestrationFingerIDServiceSERVImpl generateOpaqueTokenRequest] Objeto final ---> " + jsonObject);
				}
			} else {
				LOGGER.logError("[OrchestrationFingerIDServiceSERVImpl generateOpaqueTokenRequest] No se pudo recuperar la información del cliente");
			}

		} catch (Exception e) {
			LOGGER.logError("[OrchestrationFingerIDServiceSERVImpl generateOpaqueTokenRequest] Error en la creación del objeto Request del Token Opaco ---> ", e);
		}
		return jsonObject;
	}

	private String formatGeolocationPoint(String geoPoint) {
		String separator = Pattern.quote(".");
        String[] parts = geoPoint.split(separator);
        if(parts[1].length() >= 3) {
        	return parts[0] + "." + parts[1].substring(0,END_POS);
        }
        return geoPoint;
	}

}