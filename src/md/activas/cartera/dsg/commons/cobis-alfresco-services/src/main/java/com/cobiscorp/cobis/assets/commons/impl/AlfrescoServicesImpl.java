package com.cobiscorp.cobis.assets.commons.impl;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URISyntaxException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.xml.transform.TransformerException;

import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.cobiscorp.cobis.assets.commons.bsl.IAlfrescoServices;
import com.cobiscorp.cobis.assets.commons.bsl.Version;
import com.cobiscorp.cobis.assets.commons.utils.FileServletUtils;
import com.cobiscorp.cobis.inbox.storage.conf.reader.StorageConfiguration;

public class AlfrescoServicesImpl implements IAlfrescoServices {

	private static final Logger LOGGER = LoggerFactory.getLogger(AlfrescoServicesImpl.class);

	@Override
	public byte[] getFileHistorical(String libraryName, String fileName, String version, String user, String password) {

		if (LOGGER.isDebugEnabled())
			LOGGER.debug("Ingresando a descargar el archivo: " + fileName);

		try {
			String uuid = findFileUUID(libraryName, fileName, user, password);

			String url = StorageConfiguration.getConfiguration(1, "endpointDomain") + "/api/-default-/public/cmis/versions/1.1/atom/content?id=" + uuid + ";" + version;
			HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();
			connection.setRequestProperty("Authorization", getAuthorizationHeader(user, password));

			connection.setRequestMethod("GET");

			int responseCode = connection.getResponseCode();
			if (responseCode == 200) {
				InputStream response = connection.getInputStream();

				byte[] buffer = new byte[4096];
				int n;

				ByteArrayOutputStream output = new ByteArrayOutputStream();
				while ((n = response.read(buffer)) != -1) {
					output.write(buffer, 0, n);
				}
				output.close();
				return output.toByteArray();
			} else {
				return null;
			}
		} catch (Exception e) {
			LOGGER.error(getErrorMessage(e), e);
			return null;
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.debug("Saliendo de descargar archivo: " + fileName);
		}
	}

	@Override
	public List<Version> getVersions(String libraryName, String fileName, String user, String password) {
		// String responseBody = "";

		if (LOGGER.isDebugEnabled())
			LOGGER.debug("Ingresando a listar la carpeta: " + libraryName);

		List<Version> resultVersions = new ArrayList<Version>();

		try {
			String uuid = findFileUUID(libraryName, fileName, user, password);
			
			LOGGER.debug("fileName: " + fileName);
			
			LOGGER.debug("findFileUUID: " + uuid);
			
			String url = StorageConfiguration.getConfiguration(1, "endpointDomain") + "/api/-default-/public/alfresco/versions/1/nodes/" + uuid
					+ "/versions?skipCount=0&maxItems=10000";

			HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();
			connection.setRequestProperty("Authorization", getAuthorizationHeader(user, password));

			connection.setRequestMethod("GET");

			int responseCode = connection.getResponseCode();
			if (responseCode == 200) {
				String result = processResponse(connection.getInputStream());
				int index = result.indexOf("modifiedAt");

				do {
					Version version = new Version();
					String fecha = result.substring(index + 13, index + 41);
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
					Date date = formatter.parse(fecha.replaceAll("Z$", "+0000"));
					version.setDate(date);
					LOGGER.debug("Fecha en getVersions" + date);
					int indexId = result.indexOf("id", index);
					indexId = result.indexOf("id", indexId + 10);
					String id = result.substring(indexId + 5, result.indexOf("\"", indexId + 5));
					version.setVersion(id);
					LOGGER.debug("ID en getVersions" + id);
					index = result.indexOf("modifiedAt", index + 10);

					resultVersions.add(version);
				} while (index >= 0);

			} else {
				LOGGER.error("No se encontro el directorio");
			}
		} catch (Exception e) {
			LOGGER.error(getErrorMessage(e), e);
			// responseBody = getErrorMessage(e);
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.debug("Saliendo de listar la carpeta: " + libraryName);
		}
		return resultVersions;
	}

	private String findFileUUID(String libraryName, String fileName, String username, String password) {

		if (LOGGER.isDebugEnabled())
			LOGGER.debug("Ingresando a buscar el uuid del archivo: " + fileName);

		String responseBody = "";
		FileServletUtils fileServletUtils = new FileServletUtils();
		
		try {

			String nameFile = "";
			String parentFolder = "";
			if (fileName.lastIndexOf("/") > 0) {
				nameFile = fileName.substring(fileName.lastIndexOf("/") + 1);

				parentFolder = fileName.substring(0, fileName.lastIndexOf("/"));
			} else {
				nameFile = fileName;

				parentFolder = "";
			}
			
			LOGGER.debug("Buscar libraryName: " + libraryName);
			LOGGER.debug("Buscar nameFile: " + nameFile);
			
			String url = StorageConfiguration.getConfiguration(1, "endpointDomain") + "/api/-default-/public/cmis/versions/1.1/browser/root/" + libraryName + "/" + parentFolder
					+ "?cmisselector=children&succinct=true";

			HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();
			connection.setRequestProperty("Authorization", getAuthorizationHeader(username, password));

			connection.setRequestMethod("GET");

			int responseCode = connection.getResponseCode();
			if (responseCode == 200) {
				String result = processResponse(connection.getInputStream());
				
				LOGGER.debug("Buscar result: " + result);
				
				result = fileServletUtils.convertToServerDefinedEnconding(result);
				
				LOGGER.debug("Buscar result decodificado: " + result);
				
				nameFile = nameFile.trim();
				
				int inicial = result.indexOf(nameFile);
				
				LOGGER.debug("Buscar inicial: " + inicial);
				
				responseBody = result.substring(result.indexOf("cmis:objectId", inicial) + 16, result.indexOf(";", result.indexOf("cmis:objectId", inicial + 17)));

				LOGGER.debug("Buscar responseBody: " + responseBody);
				
			} else {
				LOGGER.error("No se encontro el archivo: " + fileName + " en el directorio: " + libraryName);
			}
		} catch (Exception e) {
			LOGGER.error(getErrorMessage(e), e);
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.debug("Saliendo de buscar el uuid del archivo: " + fileName);
		}
		if (LOGGER.isDebugEnabled())
			LOGGER.debug("UUDI del archivo: " + responseBody);
		return responseBody;
	}

	private String getAuthorizationHeader(String user, String password) {
		String authString = user + ":" + password;
		byte[] authEncBytes = Base64.encodeBase64(authString.getBytes());
		return "Basic " + new String(authEncBytes);
	}

	private String getErrorMessage(Exception e) {
		StringBuilder sb = new StringBuilder();
		if (e instanceof TransformerException) {
			sb.append("Error transformacion XML: ");
		} else if (e instanceof URISyntaxException) {
			sb.append("Error creacion URI: ");
		} else if (e instanceof IOException) {
			sb.append("Error manejar streams: ");
		} else {
			sb.append("Error Inesperado: ");
		}
		sb.append(e.getMessage());
		return sb.toString();
	}

	private String processResponse(InputStream response) {

		try {
			InputStreamReader isr = new InputStreamReader(response);

			int numCharsRead;
			char[] charArray = new char[1024];
			StringBuffer sb = new StringBuffer();
			while ((numCharsRead = isr.read(charArray)) > 0) {
				sb.append(charArray, 0, numCharsRead);
			}
			return sb.toString();

		} catch (Exception e) {
			LOGGER.error(getErrorMessage(e), e);
			return "";
		}
	}
}
