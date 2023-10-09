package com.cobiscorp.cobis.inbox.storage.services.impl;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.charset.Charset;

import javax.xml.transform.TransformerException;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.fileupload.FileItem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.cobiscorp.cobis.inbox.storage.conf.reader.StorageConfiguration;
import com.cobiscorp.cobis.inbox.storage.services.IStorageService;

public class AlfrescoService implements IStorageService {

	private static final Logger log = LoggerFactory.getLogger(AlfrescoService.class);

	@Override
	public String list(String libraryName, String user, String password) {

		String responseBody = "";

		if (log.isDebugEnabled())
			log.debug("Ingresando a listar la carpeta: " + libraryName);

		try {
			String url = StorageConfiguration.getConfiguration(1, "endpointDomain")
					+ "/api/-default-/public/cmis/versions/1.1/browser/root/" + libraryName
					+ "?cmisselector=children&succinct=true";

			HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();
			connection.setRequestProperty("Authorization", getAuthorizationHeader(user, password));

			connection.setRequestMethod("GET");

			int responseCode = connection.getResponseCode();
			if (responseCode == 200) {
				String result = processResponse(connection.getInputStream());

				int inicial = result.indexOf("cmis:contentStreamFileName");

				while (inicial > 0) {
					responseBody = responseBody + ","
							+ result.substring(inicial + 29, result.indexOf("\"", inicial + 29));
					inicial = result.indexOf("cmis:contentStreamFileName", inicial + 30);
				}

			} else {
				log.error("No se encontro el directorio");
			}
		} catch (Exception e) {
			log.error(getErrorMessage(e), e);
			responseBody = getErrorMessage(e);
		} finally {
			if (log.isDebugEnabled())
				log.debug("Saliendo de listar la carpeta: " + libraryName);
		}
		return responseBody;
	}

	@Override
	public String createFolder(String libraryName, String newFolderName, String user, String password) {

		if (log.isDebugEnabled())
			log.debug("Ingresando a crear la carpeta: " + newFolderName);
		
		String newFolderUUID = findFolderUUIDWithSelect(libraryName + "/" + newFolderName, user, password);
		
		String responseBody = null;
		
		if (newFolderUUID.length() == 0) {			
		try {

			String nameFolder = "";
			String parent = "";
			if (newFolderName.lastIndexOf("/") > 0) {
				nameFolder = newFolderName.substring(newFolderName.lastIndexOf("/") + 1);

				parent = newFolderName.substring(0, newFolderName.lastIndexOf("/"));
			} else {
				nameFolder = newFolderName;

				parent = "";
			}

				String folderUUID = findFolderUUIDWithSelect(libraryName + "/" + parent, user, password);

			String url = StorageConfiguration.getConfiguration(1, "endpointDomain")
					+ "/s/api/node/folder/workspace/SpacesStore/" + folderUUID;

			HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();
			connection.setRequestProperty("Authorization", getAuthorizationHeader(user, password));
			connection.setRequestProperty("Content-Type", "application/json; charset=UTF-8");

			connection.setDoOutput(true);
			connection.setRequestMethod("POST");

			if (log.isDebugEnabled()){
				log.debug("nameFolder: " + nameFolder);
				log.debug("url: " + url);
				log.debug("libraryName  /  parent: " + libraryName + "/" + parent);
			}
			
			OutputStream output = connection.getOutputStream();
			output.write(("{\"name\": \"" + nameFolder + "\",\"title\": \"" + nameFolder + "\",\"description\": \""
					+ nameFolder + "\",\"type\": \"cm:folder\"}").getBytes());

			int responseCode = connection.getResponseCode();
			if (responseCode == 200) {
				responseBody = "true";
			} else {
				log.error("No se pudo crear la carpeta");
				log.error(connection.getResponseCode() + ": " + connection.getResponseMessage());
				responseBody = "false";
			}
		} catch (Exception e) {
			log.error(getErrorMessage(e), e);
			responseBody = getErrorMessage(e);
		} finally {
			if (log.isDebugEnabled())
				log.debug("Saliendo de crear la carpeta: " + newFolderName);
		}
		} else {
			if (log.isDebugEnabled())
				log.debug("Ya existe la carpeta: " + newFolderName);
			responseBody = "true";
		}

		return responseBody;
	}

	@Override
	public byte[] getFile(String libraryName, String fileName, String targetFolderPath, String user, String password) {

		if (log.isDebugEnabled())
			log.debug("Ingresando a descargar el archivo: " + fileName);

		try {
			String uuid = findFileUUID(libraryName, fileName, user, password);

			String url = StorageConfiguration.getConfiguration(1, "endpointDomain")
					+ "/api/-default-/public/cmis/versions/1.1/atom/content?id=" + uuid;
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
			log.error(getErrorMessage(e), e);
			return null;
		} finally {
			if (log.isDebugEnabled())
				log.debug("Saliendo de descargar archivo: " + fileName);
		}
	}

	@Override
	public String saveFile(String libraryName, String fileName, FileItem fileItem, String user, String password){

		if (log.isDebugEnabled())
			log.debug("Ingresando a guardando el archivo: " + fileName);

		String responseBody = "";
		try {

			String folderUuid = findFolderUUIDWithSelect(libraryName, user, password);

			String CRLF = "\r\n";

			String boundary = Long.toHexString(System.currentTimeMillis());

			String url = StorageConfiguration.getConfiguration(1, "endpointDomain") + "/s/api/upload";

			HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();
			connection.setRequestProperty("Authorization", getAuthorizationHeader(user, password));
			connection.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);

			connection.setDoOutput(true);
			connection.setRequestMethod("POST");

			OutputStream output = connection.getOutputStream();
			PrintWriter writer = new PrintWriter(new OutputStreamWriter(output, Charset.forName("UTF-8").newEncoder()),
					true);

			// Send normal param.
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

			// Send binary file.
			writer.append("--" + boundary).append(CRLF);
			writer.append("Content-Disposition: form-data; name=\"filedata\"; filename=\"" + fileItem.getName() + "\"")
					.append(CRLF);
			writer.append("Content-Type: " + fileItem.getContentType()).append(CRLF);
			writer.append("Content-Transfer-Encoding: binary").append(CRLF);
			writer.append(CRLF).flush();

			InputStream file = fileItem.getInputStream();

			byte[] buffer = new byte[4096];
			int length;
			while ((length = file.read(buffer)) > 0) {
				output.write(buffer, 0, length);
			}

			output.flush(); // Important before continuing with writer!
			writer.append(CRLF).flush(); // CRLF is important! It indicates end
											// of boundary.

			// End of multipart/form-data.
			writer.append("--" + boundary + "--").append(CRLF).flush();

			int responseCode = connection.getResponseCode();
			if (responseCode == 200) {
				String result = processResponse(connection.getInputStream());

				int inicial = result.indexOf("SpacesStore") + 12;

				responseBody = result.substring(inicial, result.indexOf("\"", inicial));

			} else {
				log.error("No se pudo crear el archivo");
				log.error(connection.getResponseCode() + ": " + connection.getResponseMessage());
				responseBody = "0";
				throw new RuntimeException(connection.getResponseCode() + ": " + connection.getResponseMessage());
			}

		} catch (Exception e) {
			log.error(getErrorMessage(e), e);
			responseBody = getErrorMessage(e);
			throw new RuntimeException(e);
		} finally {
			if (log.isDebugEnabled())
				log.debug("Saliendo de guardar el archivo: " + fileName);
		}
		return responseBody;
	} 

	private String findFolderUUID(String libraryName, String username, String password) {

		if (log.isDebugEnabled())
			log.debug("Ingresando a buscar el uuid de la carpeta: " + libraryName);

		if (libraryName.endsWith("/")) {
			libraryName = libraryName.substring(0, libraryName.length() - 1);
		}

		String responseBody = "";
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

			String url = StorageConfiguration.getConfiguration(1, "endpointDomain")
					+ "/api/-default-/public/cmis/versions/1.1/browser/root/" + parent
					+ "?cmisselector=children&succinct=true";

			HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();
			connection.setRequestProperty("Authorization", getAuthorizationHeader(username, password));
			connection.setRequestProperty("Content-Type", "application/json; charset=UTF-8");

			connection.setDoOutput(true);
			connection.setRequestMethod("GET");
			int responseCode = connection.getResponseCode();
			if (responseCode == 200) {
				InputStream response = connection.getInputStream();

				InputStreamReader isr = new InputStreamReader(response);

				int numCharsRead;
				char[] charArray = new char[1024];
				StringBuffer sb = new StringBuffer();
				while ((numCharsRead = isr.read(charArray)) > 0) {
					sb.append(charArray, 0, numCharsRead);
				}
				String result = sb.toString();
				int path = result.indexOf("cmis:name\":\"" + nameFolder);

				int inicial = result.lastIndexOf("cmis:objectId", path) + 16;
				responseBody = result.substring(inicial, result.indexOf("\"", inicial + 16));

			} else {
				log.info("No se encontró la carpeta: " + libraryName);
			}
		} catch (Exception e) {
			log.error(getErrorMessage(e), e);
		} finally {
			if (log.isDebugEnabled())
				log.debug("Saliendo de buscar el uuid de la carpeta: " + libraryName);
		}
		return responseBody;
	}

	private String findFolderUUIDWithSelect(String libraryName, String username, String password) {

		if (log.isDebugEnabled())
			log.debug("Ingresando a buscar el uuid de la carpeta: " + libraryName);
		
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
				log.info("No se encontró la carpeta: " + libraryName);
			}
		} catch (Exception e) {
			log.error(getErrorMessage(e), e);
		} finally {
			if (log.isDebugEnabled())
				log.debug("Saliendo de buscar el uuid de la carpeta: " + libraryName);
		}
		return responseBody;
	}

	private String findFileUUID(String libraryName, String fileName, String username, String password) {

		if (log.isDebugEnabled())
			log.debug("Ingresando a buscar el uuid del archivo: " + fileName);

		String responseBody = "";

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

			String url = StorageConfiguration.getConfiguration(1, "endpointDomain")
					+ "/api/-default-/public/cmis/versions/1.1/browser/root/" + libraryName + "/" + parentFolder
					+ "?cmisselector=children&succinct=true";

			HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();
			connection.setRequestProperty("Authorization", getAuthorizationHeader(username, password));

			connection.setRequestMethod("GET");

			int responseCode = connection.getResponseCode();
			if (responseCode == 200) {
				String result = processResponse(connection.getInputStream());

				int inicial = result.indexOf(nameFile);

				responseBody = result.substring(result.indexOf("cmis:objectId", inicial) + 16,
						result.indexOf(";", result.indexOf("cmis:objectId", inicial + 17)));

			} else {
				log.error("No se encontro el archivo: " + fileName + " en el directorio: " + libraryName);
			}
		} catch (Exception e) {
			log.error(getErrorMessage(e), e);
		} finally {
			if (log.isDebugEnabled())
				log.debug("Saliendo de buscar el uuid del archivo: " + fileName);
		}
		if (log.isDebugEnabled())
			log.debug("UUDI del archivo: " + responseBody);
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
			log.error(getErrorMessage(e), e);
			return "";
		}
	}
}