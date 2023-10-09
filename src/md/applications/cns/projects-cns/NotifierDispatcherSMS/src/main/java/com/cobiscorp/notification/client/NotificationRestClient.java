package com.cobiscorp.notification.client;

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

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.notification.client.dtos.NotificationHeader;
import com.cobiscorp.notification.client.dtos.NotificationRequest;
import com.cobiscorp.notification.client.dtos.NotificationResponse;
import com.cobiscorp.notification.client.utils.TrustAnyTrustManager;
import com.google.gson.Gson;

public class NotificationRestClient {

	private static final ILogger logger = LogFactory.getLogger(NotificationRestClient.class);
	private HttpsURLConnection con;

	public NotificationRestClient(String url) throws Exception {
		try {
			URL urlConnection = new URL(url);
			con = (HttpsURLConnection) urlConnection.openConnection();
			// EVITA validar los certificados digitales, se debe eliminar cuando se agregue
			// el certificado al notificador
			SSLContext sc = SSLContext.getInstance("SSL");
			sc.init(null, new TrustManager[] { new TrustAnyTrustManager() }, new java.security.SecureRandom());
			con.setSSLSocketFactory(sc.getSocketFactory());
		} catch (MalformedURLException e) {
			e.printStackTrace();
			throw new Exception("URL mal formada");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (KeyManagementException e) {
			e.printStackTrace();
		}
	}

	public NotificationResponse sendNotification(NotificationHeader header, NotificationRequest request) {
		logger.logDebug("Start send Notification");
		String body;
		Gson gson = new Gson();
		body = gson.toJson(request);
		logger.logDebug("Header: " + header);
		logger.logDebug("Body: " + body);

		NotificationResponse notificationResponse = new NotificationResponse();
		byte[] postData = body.getBytes(StandardCharsets.UTF_8);
		try {
			con.setDoOutput(true);
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/json");
			con.setRequestProperty("Accept", "application/json");
			con.setRequestProperty("x-ibm-client-id", header.getXIbmClientId());
			con.setRequestProperty("Authorization", "Bearer " + header.getAccesToken());
			con.setRequestProperty("X-Santander-Session-Id", "2");
			con.setRequestProperty("branchID", "1");
			con.setRequestProperty("msgRqHdr", "{\"channelId\":\"" + header.getChannelId() + "\",\"clientIPAddress\":\""
					+ header.getClientIPAdress() + "\"}");
			// "{\"channelId\":\"1\",\"clientIPAddress\":\"0.0.0.0\"}");

			try (DataOutputStream wr = new DataOutputStream(con.getOutputStream())) {

				wr.write(postData);
			}

			int code = con.getResponseCode();
			logger.logDebug("Code Conecction: " + code);

			StringBuilder content;

			try (BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()))) {

				String line;
				content = new StringBuilder();

				while ((line = br.readLine()) != null) {
					content.append(line);
					content.append(System.lineSeparator());
				}
			}

			logger.logDebug("Content: " + content);

			notificationResponse = gson.fromJson(content.toString(), NotificationResponse.class);

			logger.logDebug("notificationResponse: " + notificationResponse);

			return notificationResponse;
		} catch (Exception e) {
			logger.logError("Error en el envío de notificacion",e);
		} finally {

			con.disconnect();
		}
		return null;
	}

}