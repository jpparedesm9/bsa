package com.cobiscorp.airmovil.client;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;

import com.cobiscorp.airmovil.client.dtos.NotificationAirmovilResponse;
import com.cobiscorp.airmovil.client.dtos.NotificationHeaderAirmovil;
import com.cobiscorp.airmovil.client.dtos.NotificationRequestAirmovil;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.notification.client.utils.TrustAnyTrustManager;
import com.google.gson.Gson;

public class NotificationRestClientAirmovil {
	private static final int DEFAULT_TIMEOUT = 3000;
	private HttpsURLConnection con;
	private static final ILogger logger = LogFactory.getLogger(NotificationRestClientAirmovil.class);

	public NotificationRestClientAirmovil(String url) throws Exception {
		try {
			URL urlConnection = new URL(url);
			con = (HttpsURLConnection) urlConnection.openConnection();
			con.setConnectTimeout(DEFAULT_TIMEOUT);
			con.setReadTimeout(DEFAULT_TIMEOUT);
			// EVITA validar los certificados digitales, se debe eliminar cuando se agregue el certificado al notificador
			SSLContext sc = SSLContext.getInstance("SSL");
			sc.init(null, new TrustManager[] { new TrustAnyTrustManager() }, new java.security.SecureRandom());
			con.setSSLSocketFactory(sc.getSocketFactory());
		} catch (MalformedURLException e) {
			logger.logError(e);			
			throw new Exception("URL mal formada");
		}catch (IOException e) {
			logger.logError(e);
			throw new Exception("IO Exception");
		} catch (NoSuchAlgorithmException e) {
			logger.logError(e);
			throw new Exception("URL algoritmo");
		} catch (KeyManagementException e) {
			logger.logError(e);
			throw new Exception("URL validacion llaves");
		}	 
	}

	public NotificationAirmovilResponse sendNotification(NotificationHeaderAirmovil header, NotificationRequestAirmovil request) throws Exception{
		logger.logDebug("Inicio de envio");
		String body;
		Gson gson = new Gson();
		body = gson.toJson(request);
		logger.logDebug("body: " + body);
		logger.logDebug("header: " + header);
		NotificationAirmovilResponse notificationResponse = new NotificationAirmovilResponse();
		byte[] postData = body.getBytes(StandardCharsets.UTF_8);
		try {
			con.setDoOutput(true);
			con.setRequestMethod("POST");
			con.setRequestProperty("Authorization", "Bearer " + header.getAccesToken());
			con.setRequestProperty("Content-Type", "application/json");
			con.setRequestProperty("Accept", "*/*");

			try (DataOutputStream wr = new DataOutputStream(con.getOutputStream())) {

				wr.write(postData);
			}

			int code = con.getResponseCode();
			logger.logDebug("Respuesta: " + code);
			StringBuilder content;

			try (BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()))) {

				String line;
				content = new StringBuilder();

				while ((line = br.readLine()) != null) {
					content.append(line);
					content.append(System.lineSeparator());
				}
			}

			logger.logDebug(content.toString());
			notificationResponse = gson.fromJson(content.toString(), NotificationAirmovilResponse.class);
			return notificationResponse;
		} catch (Exception e) {
			logger.logDebug(e);
			throw new Exception("Error al enviar el mensaje");			
		} finally {

			con.disconnect();
		}
        //return null;
	}

}
