package com.cobiscorp.airmovil.client;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;

import com.cobiscorp.airmovil.client.dtos.TokenRequestAirmovil;
import com.cobiscorp.airmovil.client.dtos.TokenResponseAirmovil;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.notification.client.utils.TrustAnyTrustManager;
import com.google.gson.Gson;

public class TokenRestClientAirmovil {

	private static final ILogger logger = LogFactory.getLogger(TokenRestClientAirmovil.class);

	private static final int RESPONSE_OK = 200;
	private HttpsURLConnection con;

	public TokenRestClientAirmovil(String url) throws Exception {
		try {
			URL urlConnection = new URL(url);
			con = (HttpsURLConnection) urlConnection.openConnection();
			// EVITA validar los certificados digitales, se debe eliminar cuando se agregue el certificado al notificador
			SSLContext sc = SSLContext.getInstance("SSL");
			sc.init(null, new TrustManager[] { new TrustAnyTrustManager() }, new java.security.SecureRandom());
			con.setSSLSocketFactory(sc.getSocketFactory());

		} catch (MalformedURLException e) {
			e.printStackTrace();
			throw new Exception("URL mal formada");
		}
	}

	private byte[] generatePostData(TokenRequestAirmovil tokenRequestAirmovil) {
		StringBuilder sb = new StringBuilder();
		sb.append("grant_type").append("=").append(tokenRequestAirmovil.getGrantType()).append("&");
		sb.append("username").append("=").append(tokenRequestAirmovil.getUsername()).append("&");
		sb.append("password").append("=").append(tokenRequestAirmovil.getPassword());
		
		logger.logDebug("sb: " + sb);
		
		return sb.toString().getBytes(StandardCharsets.UTF_8);
	}

	public TokenResponseAirmovil getToken(TokenRequestAirmovil tokenRequest) throws Exception {
		byte[] postData = generatePostData(tokenRequest);
		DataOutputStream wr = null;
		BufferedReader br = null;
		StringBuilder content = new StringBuilder();
		String encoded = Base64.getEncoder().encodeToString((tokenRequest.getUsernameAi() + ":" + tokenRequest.getPasswordAi()).getBytes());
	
		logger.logDebug("tokenRequest: " + tokenRequest);
		
		String line = null;
		try {
			con.setDoOutput(true);
			con.setRequestMethod("POST");
			con.setRequestProperty("User-Agent", "Java client");
			con.setRequestProperty("Authorization", "Basic " + encoded);
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			con.setConnectTimeout(RESPONSE_OK);

			wr = new DataOutputStream(con.getOutputStream());
			wr.write(postData);

			int code = con.getResponseCode();

			if (code == RESPONSE_OK) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));

				while ((line = br.readLine()) != null) {
					content.append(line);
					content.append(System.lineSeparator());
				}
				logger.logDebug("Contenido: " + content.toString());
				Gson gson = new Gson();
				TokenResponseAirmovil response = gson.fromJson(content.toString(), TokenResponseAirmovil.class);
				logger.logDebug("Contenido: " + response);
				return response;
			} else {
				throw new Exception("El servidor responde con error: " + code + " " + con.getResponseMessage());
			}
		} catch (ProtocolException e) {
			e.printStackTrace();
			throw new Exception("Error en el protocolo");
		} catch (IOException e) {
			e.printStackTrace();
			throw new Exception("Error en la información enviada");
		} finally {
			con.disconnect();
			if (wr != null) {
				try {
					wr.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

}
