package com.cobiscorp.cobis.cstmr.commons.services;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
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

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class LocationService {

	private final static ILogger LOGGER = LogFactory.getLogger(LocationService.class);
	private static String SEARCH = "SHORT_NAME:#,TYPES:[COUNTRY";
	private final static int TIMEOUT = 30000;
	private static boolean loaded = false;

	public static boolean isInsideCountry(String urlComplete, double latitude, double longitude, String country) {
		LOGGER.logDebug("Ingresa a isInsideCountry - cstmr.commons.events");
		LOGGER.logDebug("Variable para evitar la carga: " + loaded);

		if (!loaded) {
			disableSslVerification();
		}

		String key = "AIzaSyBRdzwaUFdmAGF8ExiNkTG3upBjWqIyP0c";
		// URL url;
		HttpURLConnection urlConnection = null;

		try {
			// url = new URL(urlComplete + "latlng=" + latitude + "," + longitude + "&sensor=true" + "&key=" + key);
			LOGGER.logDebug("url a conectar: " + urlComplete + "latlng=" + latitude + "," + longitude + "&sensor=true" + "&key=" + key);
			urlConnection = (HttpURLConnection) new URL(urlComplete + "latlng=" + latitude + "," + longitude + "&sensor=true" + "&key=" + key).openConnection();

			urlConnection.setConnectTimeout(TIMEOUT);
			urlConnection.setReadTimeout(TIMEOUT);
			InputStream in = urlConnection.getInputStream();
			// InputStream in = url.openStream();

			BufferedReader reader = new BufferedReader(new InputStreamReader(in));
			String line = null;
			StringBuffer response = new StringBuffer("");
			int count = 0;
			while ((line = reader.readLine()) != null) {
				response.append(line);
				count++;
				if (count == 500) { // Se restringe las primeras 500 lineas del primer cambiar tambien en /src/md/basicas/mobileintegration/projects/cobis-cloud-orch-rest/src/main/java/com/cobiscorp/ecobis/cloud/service/integration/LocationService.java
					break;
				}
			}
			LOGGER.logDebug("Response google Maps: " + response.toString());
			SEARCH = SEARCH.replace("#", country);
			SEARCH = remove1(SEARCH).toUpperCase();
			LOGGER.logDebug("Parametro pais UPPER: " + SEARCH);
			String serviceResponse = remove1(response.toString()).toUpperCase();
			serviceResponse = serviceResponse.replaceAll("\\s", "");
			serviceResponse = serviceResponse.replaceAll("\"", "");
			LOGGER.logDebug("ServicesResponse UPPER: " + serviceResponse);

			if (serviceResponse.contains(country)) {
				LOGGER.logDebug("Se encontró el país " + country);
				return true;
			}
		} catch (MalformedURLException e) {
			LOGGER.logError("Error GEO: ", e);
		} catch (javax.net.ssl.SSLHandshakeException e) {
			LOGGER.logError("Error Certificado Caducado: ", e);
		} catch (IOException e) {
			LOGGER.logError("Error GEO: ", e);
		} finally {
			urlConnection.disconnect();
		}
		return false;
	}

	public static double getDistance(double latitude1, double longitude1, double latitude2, double longitude2) {
		double radioTierra = 6371;// en kilómetros
		double dLat = Math.toRadians(latitude2 - latitude1);
		double dLng = Math.toRadians(longitude2 - longitude1);
		double sindLat = Math.sin(dLat / 2);
		double sindLng = Math.sin(dLng / 2);
		double va1 = Math.pow(sindLat, 2) + Math.pow(sindLng, 2) * Math.cos(Math.toRadians(latitude1)) * Math.cos(Math.toRadians(latitude2));
		double va2 = 2 * Math.atan2(Math.sqrt(va1), Math.sqrt(1 - va1));
		double distancia = radioTierra * va2;
		return Math.rint(distancia * 100) / 100;
	}

	private static String remove1(String texto) {
		String original = "ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýÿ";
		String ascii = "AAAAAAACEEEEIIIIDNOOOOOOUUUUYBaaaaaaaceeeeiiiionoooooouuuuyy";
		String output = texto;
		for (int i = 0; i < original.length(); i++) {
			output = output.replace(original.charAt(i), ascii.charAt(i));
		}
		return output;
	}

	private static void disableSslVerification() {
		try {
			// Create a trust manager that does not validate certificate chains
			LOGGER.logDebug("Inicia metodo disableSslVerification");

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
			loaded = true;

			LOGGER.logDebug("Finaliza metodo disableSslVerification");
		} catch (NoSuchAlgorithmException ex) {
			loaded = false;
			LOGGER.logError("Error al encontrar el algoritmo", ex);

		} catch (KeyManagementException ex) {
			loaded = false;
			LOGGER.logError("Error en el manejo del key", ex);
		}
	}

}