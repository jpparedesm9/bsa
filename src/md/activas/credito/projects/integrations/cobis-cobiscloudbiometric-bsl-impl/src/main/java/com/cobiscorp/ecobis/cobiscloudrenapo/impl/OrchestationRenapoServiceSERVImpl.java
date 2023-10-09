package com.cobiscorp.ecobis.cobiscloudrenapo.impl;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;

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
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.RenapoClientRequest;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.RenapoClientResponse;
import com.cobiscorp.ecobis.cobiscloudbiometric.impl.OrchestrationBiometricServiceSERVImpl;
import com.cobiscorp.ecobis.cobiscloudbiometric.impl.ServiceBase;
import com.cobiscorp.ecobis.cobiscloudbiometric.util.config.reader.BiometricConfiguration;
import com.cobiscorp.ecobis.cobiscloudbiometric.util.constants.Parameter;
import com.cobiscorp.ecobis.cobiscloudbiometric.util.impl.Event;
import com.cobiscorp.ecobis.cobiscloudbiometric.util.impl.Utils;
import com.cobiscorp.ecobis.cobiscloudrenapo.bsl.serv.bsl.IOrchestationRenapoService;
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
	public RenapoClientResponse renapoQueryByDetail(RenapoClientRequest renapoClientRequest) throws Exception {

		// to include in code order use key:
		// cobiscloudorchestration.OrchestrationClientValidationServiceImpl.validate
		RenapoClientResponse renapoClientResponse = null;

		String wInfo = "[OrchestationRenapoServiceSERVImpl][renapoQueryByDetail]";
		if (renapoClientRequest != null) {

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("------> START RENAPO <-------");
			}

			HttpURLConnection con = null;
			DataOutputStream wr = null;
			InputStream inputStream = null;
			String result = null;
			ObjectMapper objectMapper = new ObjectMapper();

			try {
				// Invocacion token de acceso
				OrchestrationBiometricServiceSERVImpl orchestationBiometricService = new OrchestrationBiometricServiceSERVImpl();
				String urlRenapo = BiometricConfiguration.getUrlFromXML("urlRenapo");
				LOGGER.logDebug(">>>> START ACCESS TOKEN SERVICE CALL");
				AccessTokenResponse accessToken = orchestationBiometricService.accessToken(BiometricConfiguration.getUrlFromXML("urlAccessTokenAccesoRenapo"), Parameter.RENAPO_FLAG);
				LOGGER.logDebug("[ACCESS TOKEN :: " + accessToken + "]");
				LOGGER.logDebug("FINISH ACCESS TOKEN SERVICE CALL <<<<");

				if (null != accessToken && null != urlRenapo) {
					LOGGER.logDebug(">>>> START RENAPO SERVICE CALL");
					URL obj = new URL(urlRenapo);

					if (urlRenapo.contains("https")) {
						con = (HttpsURLConnection) obj.openConnection();
					} else {
						con = (HttpURLConnection) obj.openConnection();
					}

					con.setDoOutput(true);
					con.setRequestProperty("Content-Type", Parameter.JSON);
					con.setRequestProperty("accept", Parameter.JSON);
					con.setRequestProperty("x-ibm-client-id", BiometricConfiguration.getUrlFromXML("clientIdREN"));
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

}
