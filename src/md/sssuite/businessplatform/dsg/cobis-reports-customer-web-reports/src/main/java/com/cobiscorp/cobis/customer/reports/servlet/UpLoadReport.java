package com.cobiscorp.cobis.customer.reports.servlet;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.Charset;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.inbox.storage.conf.reader.StorageConfiguration;

import org.apache.commons.codec.binary.Base64;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;

public class UpLoadReport {

	private static ILogger logger = LogFactory.getLogger(UpLoadReport.class);

	public static void saveFile(String libraryName, String fileName, byte[] parFile, String user, String password) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingresando a guardando el archivo: " + fileName + fileName);
		}
		String responseBody = "";
		HttpURLConnection connection=null;
		try {
			String folderUuid = findFolderUUIDWithSelect(libraryName, user, password);
			if (logger.isDebugEnabled()) {
				logger.logDebug("folderUuid: " + folderUuid);
			}

			String CRLF = "\r\n";

			String boundary = Long.toHexString(System.currentTimeMillis());

			String url = StorageConfiguration.getConfiguration(Integer.valueOf(1), "endpointDomain") + "/s/api/upload";

			logger.logDebug("UpLoadReport saveFile Direccion URL: " + url);

			connection = (HttpURLConnection) new URL(url).openConnection();
			connection.setRequestProperty("Authorization", getAuthorizationHeader(user, password));
			connection.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);

			connection.setDoOutput(true);
			connection.setConnectTimeout(25000);
			connection.setReadTimeout(25000);
			connection.setRequestMethod("POST");

			OutputStream output = connection.getOutputStream();
			PrintWriter writer = new PrintWriter(new OutputStreamWriter(output, Charset.forName("UTF-8").newEncoder()),
					true);

			writer.append("--" + boundary).append(CRLF);
			writer.append("Content-Disposition: form-data; name=\"filename\"").append(CRLF);
			writer.append(CRLF).append(fileName).append(CRLF).flush();

			writer.append("--" + boundary).append(CRLF);
			writer.append("Content-Disposition: form-data; name=\"destination\"").append(CRLF);
			writer.append(CRLF).append("workspace://SpacesStore/" + folderUuid).append(CRLF).flush();

			writer.append("--" + boundary).append(CRLF);
			writer.append("Content-Disposition: form-data; name=\"createdirectory\"").append(CRLF);
			writer.append(CRLF).append("true").append(CRLF).flush();

			writer.append("--" + boundary).append(CRLF);
			writer.append("Content-Disposition: form-data; name=\"overwrite\"").append(CRLF);
			writer.append(CRLF).append("true").append(CRLF).flush();

			writer.append("--" + boundary).append(CRLF);
			writer.append("Content-Disposition: form-data; name=\"filedata\"; filename=\"" + fileName + "\"")
					.append(CRLF);

			writer.append("Content-Type: " + "application/pdf").append(CRLF);
			writer.append("Content-Transfer-Encoding: binary").append(CRLF);
			writer.append(CRLF).flush();

			InputStream myInputStream = new ByteArrayInputStream(parFile);

			byte[] buffer = new byte[4096];
			int length;
			while ((length = myInputStream.read(buffer)) > 0) {
				output.write(buffer, 0, length);
			}

			output.flush();
			writer.append(CRLF).flush();

			writer.append("--" + boundary + "--").append(CRLF).flush();

			int responseCode = connection.getResponseCode();
			if (responseCode == 200) {
				String result = processResponse(connection.getInputStream());

				int inicial = result.indexOf("SpacesStore") + 12;

				responseBody = result.substring(inicial, result.indexOf("\"", inicial));
			} else {
				logger.logError("No se pudo crear el archivo");
				logger.logError(connection.getResponseCode() + ": " + connection.getResponseMessage());
				responseBody = "0";
			}
		} catch (Exception e) {
			logger.logError(e);

		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Saliendo de guardar el archivo: " + fileName);
			}
			if (connection != null) {
				connection.disconnect();
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug("Cierra Conexion: " + fileName);
			}
		}

	}

	private static String findFolderUUID(String libraryName, String username, String password) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingresando a buscar el uuid de la carpeta: " + libraryName);
		}
		if (libraryName.endsWith("/")) {
			libraryName = libraryName.substring(0, libraryName.length() - 1);
		}
		String responseBody = "";
		HttpURLConnection connection = null;
		try {
			String nameFolder = "";
			String parent = "";
			if (libraryName.lastIndexOf("/") > 0) {
				nameFolder = libraryName.substring(libraryName.lastIndexOf("/") + 1);

				parent = libraryName.substring(0, libraryName.lastIndexOf("/"));
			} else {
				nameFolder = libraryName;

				parent = "";
			}
			String url = StorageConfiguration.getConfiguration(Integer.valueOf(1), "endpointDomain")
					+ "/api/-default-/public/cmis/versions/1.1/browser/root/" + parent
					+ "?cmisselector=children&succinct=true";

			logger.logDebug("SaveFile findFolderUUID Direccion URL: " + url);

			connection = (HttpURLConnection) new URL(url).openConnection();
			connection.setRequestProperty("Authorization", getAuthorizationHeader(username, password));
			connection.setRequestProperty("Content-Type", "application/json; charset=UTF-8");

			connection.setDoOutput(true);
			connection.setConnectTimeout(25000);
			connection.setReadTimeout(25000);
			connection.setRequestMethod("GET");
			int responseCode = connection.getResponseCode();
			if (responseCode == 200) {
				InputStream response = connection.getInputStream();

				InputStreamReader isr = new InputStreamReader(response);

				char[] charArray = new char[1024];
				StringBuffer sb = new StringBuffer();
				int numCharsRead;
				while ((numCharsRead = isr.read(charArray)) > 0) {
					sb.append(charArray, 0, numCharsRead);
				}
				String result = sb.toString();
				int path = result.indexOf("cmis:name\":\"" + nameFolder);

				int inicial = result.lastIndexOf("cmis:objectId", path) + 16;
				responseBody = result.substring(inicial, result.indexOf("\"", inicial + 16));
			} else {
				logger.logDebug("No se encontró la carpeta: " + libraryName);
			}
		} catch (Exception e) {
			logger.logError(e);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Saliendo de buscar el uuid de la carpeta: " + libraryName);
			}
			if (connection != null) {
				connection.disconnect();
			}
		}
		return responseBody;
	}

	private static String getAuthorizationHeader(String user, String password) {
		String authString = user + ":" + password;
		byte[] authEncBytes = Base64.encodeBase64(authString.getBytes());
		return "Basic " + new String(authEncBytes);
	}

	private static String processResponse(InputStream response) {

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
			logger.logError("Excepcion processResponse --> ", e);
			return "";
		}
	}

	private static String findFolderUUIDWithSelect(String libraryName, String username, String password) {

		if (logger.isDebugEnabled())
			logger.logDebug("Ingresando a buscar el uuid de la carpeta: " + libraryName);

		String responseBody = "";
		try {
			String nameFolder = "";
			if (libraryName.lastIndexOf("/") > 0) {
				nameFolder = libraryName.substring(libraryName.lastIndexOf("/") + 1);
			} else {
				nameFolder = libraryName;
			}

			String url = StorageConfiguration.getConfiguration(1, "endpointDomain")
					+ "/api/-default-/public/cmis/versions/1.1/browser/?cmisselector=query&succinct=true&q="
					+ "SELECT+cmis:path,+cmis:objectId+FROM+cmis:folder+WHERE+cmis:name='" + nameFolder + "'";

			HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();
			connection.setRequestProperty("Authorization", getAuthorizationHeader(username, password));
			connection.setRequestProperty("Content-Type", "application/json; charset=UTF-8");

			connection.setDoOutput(true);
			connection.setRequestMethod("GET");
			int responseCode = connection.getResponseCode();
			if (responseCode == 200) {
				InputStream response = connection.getInputStream();

				String result = processResponse(response);
				String replace = libraryName.replace("/", "\\/");
				int path = result.indexOf("cmis:path\":\"" + replace + "\"");

				if (path > 0) {
					int inicial = result.indexOf("cmis:objectId", path) + 16;
					responseBody = result.substring(inicial, result.indexOf("\"", inicial + 16));
				} else {
					responseBody = "";
				}

			} else {
				logger.logDebug("No se encontró la carpeta: " + libraryName);
			}
		} catch (Exception e) {
			logger.logDebug(e);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("Saliendo de buscar el uuid de la carpeta: " + libraryName);
		}
		return responseBody;
	}

}
