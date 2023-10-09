package com.cobiscorp.ecobis.cloud.service.dto;

import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class Geocoding extends MapsJava {
	private final static ILogger logger = LogFactory.getLogger(Geocoding.class);
	private String addressFound;
	private String postalcode;
	private final static int TIMEOUT = 30000;

	static {
		disableSslVerification();
	}

	public String getAddressFound() {
		return this.addressFound;
	}

	public String getPostalcode() {
		return this.postalcode;
	}

	protected void onError(URL urlRequest, String status, Exception ex) {
		super.storageRequest(urlRequest.toString(), "Geocoding request", status, ex);
	}

	protected String getStatus(XPath xpath, Document document) {
		try {
			getClass();
			NodeList nodes = (NodeList) xpath.evaluate("GeocodeResponse/status", document, XPathConstants.NODESET);

			return nodes.item(0).getTextContent();
		} catch (XPathExpressionException ex) {
		}
		return null;
	}

	protected void storeInfoRequest(URL urlRequest, String info, String status, Exception exception) {
		super.storageRequest(urlRequest.toString(), "Geocoding request", status, exception);
	}

	private String getNodesPostalcode(NodeList node) {
		String result = "No data";
		int i = 0;
		while (i < node.getLength()) {
			String nodeString = node.item(i).getTextContent();
			if (nodeString.contains("postal_code")) {
				result = nodeString.replace(" ", "").substring(1, 6);
				break;
			}
			i++;
		}
		return result;
	}

	private URL createURL(String address, String urlComplete) throws UnsupportedEncodingException, MalformedURLException {

		URL urlReturn = new URL(urlComplete + "address=" + URLEncoder.encode(address, "utf-8") + super.getSelectPropertiesRequest());

		logger.logDebug("url a conectar: " + urlReturn);

		return urlReturn;
	}

	private URL createURL(Double latitude, Double longitude, String urlCOmplete) throws UnsupportedEncodingException, MalformedURLException {
		URL urlReturn = new URL(urlCOmplete + "latlng=" + latitude + "," + longitude + super.getSelectPropertiesRequest());
		return urlReturn;
	}

	public Coordenadas getCoordinates(String address, String urlComplete) {
		Coordenadas coordenadas = null;

		this.addressFound = "";

		try {
			HttpURLConnection urlConnection = null;
			URL url = createURL(address, urlComplete);
			urlConnection = (HttpURLConnection) url.openConnection();
			urlConnection.setConnectTimeout(TIMEOUT);
			urlConnection.setReadTimeout(TIMEOUT);
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document document = builder.parse(url.openStream());

			XPathFactory xpathFactory = XPathFactory.newInstance();
			XPath xpath = xpathFactory.newXPath();

			NodeList nodeLatLng = (NodeList) xpath.evaluate("GeocodeResponse/result/geometry/location[1]/*", document, XPathConstants.NODESET);

			NodeList nodeAddress = (NodeList) xpath.evaluate("GeocodeResponse/result/formatted_address", document, XPathConstants.NODESET);

			getClass();
			NodeList nodePostal = (NodeList) xpath.evaluate("GeocodeResponse/result/address_component", document, XPathConstants.NODESET);

			double lat = java.lang.Double.valueOf(0.0D);
			double lng = java.lang.Double.valueOf(0.0D);
			try {
				this.postalcode = getNodesPostalcode(nodePostal);
				this.addressFound = "No data";
				this.addressFound = nodeAddress.item(0).getTextContent();
				lat = java.lang.Double.valueOf(nodeLatLng.item(0).getTextContent());
				lng = java.lang.Double.valueOf(nodeLatLng.item(1).getTextContent());
			} catch (Exception e) {
				onError(url, "NO STATUS", e);
				logger.logDebug("NO STATUS", e);
			}
			coordenadas = new Coordenadas(lat, lng);
			storeInfoRequest(url, null, getStatus(xpath, document), null);
			return coordenadas;
		} catch (MalformedURLException e) {
			logger.logDebug("Error MalformedURLException : ", e);
		} catch (javax.net.ssl.SSLHandshakeException e) {
			logger.logDebug("Error Certificado Caducado: ", e);
		} catch (Exception e) {
			logger.logDebug("Error Exception: ", e);
		}
		return null;
	}

	public ArrayList<String> getAddress(Double latitude, Double longitude, String urlComplete) throws UnsupportedEncodingException, MalformedURLException {
		URL url = createURL(latitude, longitude, urlComplete);
		try {
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document document = builder.parse(url.openStream());

			XPathFactory xpathFactory = XPathFactory.newInstance();
			XPath xpath = xpathFactory.newXPath();

			NodeList nodeAddress = (NodeList) xpath.evaluate("GeocodeResponse/result/formatted_address", document, XPathConstants.NODESET);

			getClass();
			NodeList nodePostal = (NodeList) xpath.evaluate("GeocodeResponse/result/address_component", document, XPathConstants.NODESET);

			ArrayList<String> result = super.getNodesString(nodeAddress);
			this.postalcode = getNodesPostalcode(nodePostal);

			storeInfoRequest(url, null, getStatus(xpath, document), null);
			return result;
		} catch (Exception e) {
			onError(url, "NO STATUS", e);
		}
		return null;
	}

	private static void disableSslVerification() {
		try {
			// Create a trust manager that does not validate certificate chains
			logger.logDebug("Inicia metodo disableSslVerification - rest");
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

			logger.logDebug("Finaliza metodo disableSslVerification - rest");
		} catch (NoSuchAlgorithmException ex) {

			logger.logError("Error al encontrar el algoritmo", ex);

		} catch (KeyManagementException ex) {

			logger.logError("Error en el manejo del key", ex);
		}
	}
}
