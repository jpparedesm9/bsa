package com.cobiscorp.notification.client;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.nio.charset.StandardCharsets;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.notification.client.dtos.TokenRequest;
import com.cobiscorp.notification.client.dtos.TokenResponse;
import com.cobiscorp.notification.client.utils.TrustAnyTrustManager;
import com.google.gson.Gson;

public class TokenRestClient {

	private static final ILogger logger = LogFactory.getLogger(TokenRestClient.class);

	private static final int RESPONSE_OK = 200;
	private HttpsURLConnection con;

	public TokenRestClient(String url) throws Exception {
		try {
			URL urlConnection = new URL(url);
			con = (HttpsURLConnection) urlConnection.openConnection();
			// EVITA validar los certificados digitales, se debe eliminar cuando se agregue
			// el certificado al notificador
			SSLContext sc = SSLContext.getInstance("SSL");
			sc.init(null, new TrustManager[] { new TrustAnyTrustManager() }, new java.security.SecureRandom());
			con.setSSLSocketFactory(sc.getSocketFactory());
		} catch (MalformedURLException e) {
			logger.logError("Url mal formada", e);
			throw new Exception("URL mal formada");
		}
	}

	private byte[] generatePostData(TokenRequest tokenRequest) {
		StringBuilder sb = new StringBuilder();
		sb.append("scope=").append(tokenRequest.getScope()).append("&");
		sb.append("grant_type=").append(tokenRequest.getGrantType()).append("&");
		sb.append("client_id=").append(tokenRequest.getClientId()).append("&");
		sb.append("client_secret=").append(tokenRequest.getClientSecret()).append("&");
		sb.append("token=").append(tokenRequest.getToken());
		return sb.toString().getBytes(StandardCharsets.UTF_8);
	}

	public TokenResponse getToken(TokenRequest tokenRequest) throws Exception {

		logger.logDebug("Start token response");
		logger.logDebug("TokenRequest: " + tokenRequest);

		byte[] postData = generatePostData(tokenRequest);
		DataOutputStream wr = null;
		BufferedReader br = null;
		StringBuilder content = new StringBuilder();
		String line = null;
		try {
			con.setDoOutput(true);
			con.setRequestMethod("POST");
			con.setRequestProperty("User-Agent", "Java client");
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

			wr = new DataOutputStream(con.getOutputStream());
			wr.write(postData);

			int code = con.getResponseCode();

			if (code == RESPONSE_OK) {

				br = new BufferedReader(new InputStreamReader(con.getInputStream()));

				while ((line = br.readLine()) != null) {
					content.append(line);
					content.append(System.lineSeparator());

				}

				logger.logDebug("Content: " + content);

				Gson gson = new Gson();
				TokenResponse response = gson.fromJson(content.toString(), TokenResponse.class);

				logger.logDebug("TokenResponse: " + response);
				
				return response;
			} else {
				throw new Exception("El servidor responde con error: " + code + " " + con.getResponseMessage());
			}
		} catch (ProtocolException e) {
			logger.logError("Error en el protocolo");
			throw new Exception("Error en el protocolo");
		} catch (IOException e) {
			logger.logError("Error en la información enviada");
			throw new Exception("Error en la información enviada");
		} finally {
			con.disconnect();
			if (wr != null) {
				try {
					wr.close();
				} catch (IOException e) {
					logger.logError("Error al cerrar la sección DataOutputStream");
				}
			}
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					logger.logError("Error al cerrar la sección BufferedReader");
				}
			}
		}
	}

}