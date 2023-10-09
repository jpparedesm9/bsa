package com.cobiscorp.ecobis.cloud.service.integration;

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
import com.cobiscorp.cobis.cts.services.utilservices.api.ICobisParameter;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.dto.Coordenadas;
import com.cobiscorp.ecobis.cloud.service.dto.Geocoding;
import com.cobiscorp.ecobis.cloud.service.dto.geolocation.GeoReference;
import com.cobiscorp.ecobis.cloud.service.dto.geolocation.OfficeGeoReference;
import com.cobiscorp.ecobis.cloud.service.util.SessionUtil;

public class LocationService {

	private OfficeIntegrationService officeService;
	private final static ILogger LOGGER = LogFactory.getLogger(LocationService.class);
	private static String SEARCH = "SHORT_NAME:#,TYPES:[COUNTRY";
	private final static int TIMEOUT = 30000;
	private ICobisParameter parameterService;
	private static boolean loaded = false;

	private static boolean isInsideCountry(String urlComplete, double latitude, double longitude, String country) {
		LOGGER.logDebug("Ingresa a isInsideCountry - cobis-cloud-orch-rest");
		LOGGER.logDebug("Variable para evitar la carga: " + loaded + " cobis-cloud-orch-rest");

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
				//TO DO ALL Cambiar el 500 por un parámetro desde backend para tamaño de la trama de reponse del api de googlemaps
				if (count == 500) { // Se restringe las primeras 500 lineas del primer componente
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

	public Coordenadas isSearchGeolocalization(String address) {
		Geocoding geo = new Geocoding();
		/* Parametros URL */
		String urlParam = parameterService.getParameter(null, "CLI", "URLGEO", String.class);
		int puertoParam = parameterService.getParameter(null, "CLI", "PRTGEO", Long.class) == null ? null : parameterService.getParameter(null, "CLI", "PRTGEO", Long.class).intValue();
		String servicioParamXml = parameterService.getParameter(null, "CLI", "URLGXM", String.class);

		LOGGER.logDebug("urlParam--> " + urlParam);
		LOGGER.logDebug("puertoParam--> " + puertoParam);
		LOGGER.logDebug("servicioParamXml--> " + servicioParamXml);
		// Url del servicio
		String urlComplete = urlParam + puertoParam + servicioParamXml;

		return geo.getCoordinates(address, urlComplete);
	}

	private static double getDistance(double latitude1, double longitude1, double latitude2, double longitude2) {
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

	public ServiceResponse validateOfficeGeo(GeoReference geoClient, GeoReference geoOfficer) {
		ServiceResponse geoResponse = new ServiceResponse();
		geoResponse.setResult(true);
		// Validaciones GeoReferencia
		OfficeGeoReference officeGeo = new OfficeGeoReference();
		LOGGER.logDebug("Se consultan parámetros");
		LOGGER.logDebug("Filial es: " + parameterService.getParameter(null, "CRE", "FILSAN", Long.class));
		String country = parameterService.getParameter(null, "CLI", "PAISGE", String.class);
		int filialId = parameterService.getParameter(null, "CRE", "FILSAN", Long.class) == null ? null : parameterService.getParameter(null, "CRE", "FILSAN", Long.class).intValue();
		double minDistance = parameterService.getParameter(null, "CLI", "DISGEO", Long.class) == null ? null : parameterService.getParameter(null, "CLI", "DISGEO", Long.class).intValue();
		int maxDistance = parameterService.getParameter(null, "CLI", "RADGEO", Long.class) == null ? null : parameterService.getParameter(null, "CLI", "RADGEO", Long.class).intValue();
		/* Parametros URL */
		String urlParam = parameterService.getParameter(null, "CLI", "URLGEO", String.class);
		int puertoParam = parameterService.getParameter(null, "CLI", "PRTGEO", Long.class) == null ? null : parameterService.getParameter(null, "CLI", "PRTGEO", Long.class).intValue();
		String servicioParam = parameterService.getParameter(null, "CLI", "SERGEO", String.class);
		// Url del servicio
		String urlComplete = urlParam + puertoParam + servicioParam;

		officeGeo = OfficeGeoReference.fromResponse(officeService.searchOfficeGeoReference(SessionUtil.getUser(), filialId));
		minDistance = minDistance / 1000; // convertir de metros a kilometros
		if (officeGeo == null) {
			geoResponse.setResult(false);
			geoResponse.addMessage("1", "No existe geolocalización de la oficina");
			return geoResponse;
		}
		LOGGER.logDebug("country: " + country);
		LOGGER.logDebug("Latitud&Logitude UbicacionActual: " + geoOfficer.getLatitude() + "&" + geoOfficer.getLongitude());
		LOGGER.logDebug("Latitud&Logitude Oficina: " + officeGeo.getLatitude() + "&" + officeGeo.getLongitude());
		// verifico si esta dentro del pais
		boolean client = isInsideCountry(urlComplete, geoClient.getLatitude(), geoClient.getLongitude(), country);
		boolean officer = isInsideCountry(urlComplete, geoOfficer.getLatitude(), geoOfficer.getLongitude(), country);
		if (!client) {
			geoResponse.setResult(false);
			geoResponse.addMessage("1", "La dirección no se encuentra dentro del país México");
			return geoResponse;
		}
		if (!officer) {
			geoResponse.setResult(false);
			geoResponse.addMessage("1", "La ubicación actual no se encuentra dentro del país México");
			return geoResponse;
		}
		double distanceClient = getDistance(officeGeo.getLatitude(), officeGeo.getLongitude(), geoClient.getLatitude(), geoClient.getLongitude());
		// double distanceOfficer = getDistance(officeGeo.getLatitude(), officeGeo.getLongitude(), geoOfficer.getLatitude(),
		// geoOfficer.getLongitude());
		LOGGER.logDebug("Distancia de los puntos Cliente: " + distanceClient);
		LOGGER.logDebug("Distancia permitida: " + minDistance + " - Radio máximo: " + maxDistance);
		if (distanceClient < minDistance) {
			geoResponse.setResult(false);
			geoResponse.addMessage("1", "La ubicación es menor a la distancia permitida con respecto a la oficina");
			return geoResponse;
		}
		if (distanceClient > maxDistance) {
			geoResponse.setResult(false);
			geoResponse.addMessage("1", "La ubicación es mayor a la distancia permitida con respecto a la oficina");
			return geoResponse;
		}
		return geoResponse;
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

	public void setParameterService(ICobisParameter parameterService) {
		this.parameterService = parameterService;
	}

	public void unsetParameterService(ICobisParameter parameterService) {
		this.parameterService = null;
	}

	public void setOfficeService(OfficeIntegrationService officeService) {
		this.officeService = officeService;
	}

	public void unsetOfficeService(OfficeIntegrationService officeService) {
		this.officeService = null;
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
			loaded = true;
			LOGGER.logDebug("Finaliza metodo disableSslVerification - rest");
		} catch (NoSuchAlgorithmException ex) {
			loaded = false;
			LOGGER.logError("Error al encontrar el algoritmo", ex);

		} catch (KeyManagementException ex) {
			loaded = false;
			LOGGER.logError("Error en el manejo del key", ex);
		}
	}

}
