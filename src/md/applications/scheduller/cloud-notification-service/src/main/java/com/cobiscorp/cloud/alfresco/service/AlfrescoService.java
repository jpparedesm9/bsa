package com.cobiscorp.cloud.alfresco.service;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.Charset;

import org.apache.commons.codec.binary.Base64;
import org.apache.log4j.Logger;
import org.apache.wicket.util.upload.FileItem;

public class AlfrescoService {
	private static final Logger log = Logger.getLogger(AlfrescoService.class);

	public String list(String libraryName, String user, String password, String endpointDomain) {
		String responseBody = "";
		if (log.isDebugEnabled())
			log.debug("Ingresando a listar la carpeta: " + libraryName);
		HttpURLConnection connection = null;
		try {
			String url = endpointDomain + "/api/-default-/public/cmis/versions/1.1/browser/root/" + libraryName + "?cmisselector=children&succinct=true";
			connection = (HttpURLConnection) (new URL(url)).openConnection();
			connection.setConnectTimeout(25000);
			connection.setReadTimeout(25000);
			connection.setRequestProperty("Authorization", getAuthorizationHeader(user, password));
			connection.setRequestMethod("GET");
			int responseCode = connection.getResponseCode();
			if (responseCode == 200) {
				String result = processResponse(connection.getInputStream());
				int inicial = result.indexOf("cmis:contentStreamFileName");
				while (inicial > 0) {
					responseBody = responseBody + "," + result.substring(inicial + 29, result.indexOf("\"", inicial + 29));
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
			if (connection != null)
				connection.disconnect();
		}
		return responseBody;
	}

	public String createFolder(String libraryName, String newFolderName, String user, String password, String endpointDomain) {
		if (log.isDebugEnabled())
			log.debug("Ingresando a crear la carpeta: " + newFolderName);
		String newFolderUUID = findFolderUUIDWithSelect(libraryName + "/" + newFolderName, user, password, endpointDomain);

		if (log.isDebugEnabled())
			log.debug("Name Folder UUID: " + newFolderUUID);

		String responseBody = null;
		HttpURLConnection connection = null;
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
				String folderUUID = findFolderUUIDWithSelect(libraryName + "/" + parent, user, password, endpointDomain);
				

				if (log.isDebugEnabled())
					log.debug("Name Folder UUID: " + newFolderUUID);
				
				String url = endpointDomain + "/s/api/node/folder/workspace/SpacesStore/" + folderUUID;				

				
				connection = (HttpURLConnection) (new URL(url)).openConnection();
				connection.setConnectTimeout(25000);
				connection.setReadTimeout(25000);
				connection.setRequestProperty("Authorization", getAuthorizationHeader(user, password));
				connection.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
				connection.setDoOutput(true);
				connection.setRequestMethod("POST");
				if (log.isDebugEnabled()) {
					log.debug("nameFolder: " + nameFolder);
					log.debug("url: " + url);
					log.debug("libraryName  /  parent: " + libraryName + "/" + parent);
				}
				OutputStream output = connection.getOutputStream();
				output.write(("{\"name\": \"" + nameFolder + "\",\"title\": \"" + nameFolder + "\",\"description\": \"" + nameFolder + "\",\"type\": \"cm:folder\"}").getBytes());
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
				if (connection != null)
					connection.disconnect();
			}
		} else {
			if (log.isDebugEnabled())
				log.debug("Ya existe la carpeta: " + newFolderName);
			responseBody = "true";
		}
		return responseBody;
	}

	public byte[] getFile(String libraryName, String fileName, String targetFolderPath, String user, String password, String endpointDomain) throws Exception {
		if (log.isDebugEnabled())
			log.debug("Ingresando a descargar el archivo: " + fileName);
		HttpURLConnection connection = null;
		try {
			String uuid = findFileUUID(libraryName, fileName, user, password, endpointDomain);
			String url = endpointDomain + "/api/-default-/public/cmis/versions/1.1/atom/content?id=" + uuid;
			connection = (HttpURLConnection) (new URL(url)).openConnection();
			connection.setConnectTimeout(25000);
			connection.setReadTimeout(25000);
			connection.setRequestProperty("Authorization", getAuthorizationHeader(user, password));
			connection.setRequestMethod("GET");
			int responseCode = connection.getResponseCode();
			if (responseCode == 200) {
				InputStream response = connection.getInputStream();
				byte[] buffer = new byte[4096];
				ByteArrayOutputStream output = new ByteArrayOutputStream();
				int n;
				while ((n = response.read(buffer)) != -1)
					output.write(buffer, 0, n);
				output.close();
				return output.toByteArray();
			}
			return null;
		} catch (Exception e) {
			log.error(getErrorMessage(e), e);
			throw new Exception("Error de comunicación con alfresco");
		} finally {
			if (log.isDebugEnabled())
				log.debug("Saliendo de descargar archivo: " + fileName);
			if (connection != null)
				connection.disconnect();
		}
	}

	private String findFileUUID(String libraryName, String fileName, String username, String password, String endpointDomain) throws Exception {
		if (log.isDebugEnabled())
			log.debug("Ingresando a buscar el uuid del archivo: " + fileName);
		String responseBody = "";
		HttpURLConnection connection = null;
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
			String url = endpointDomain + "/api/-default-/public/cmis/versions/1.1/browser/root/" + libraryName + "/" + parentFolder + "?cmisselector=children&succinct=true";
			log.debug("URL de conexión: " + url);
			connection = (HttpURLConnection) (new URL(url)).openConnection();
			connection.setConnectTimeout(25000);
			connection.setReadTimeout(25000);
			connection.setRequestProperty("Authorization", getAuthorizationHeader(username, password));
			connection.setRequestMethod("GET");
			int responseCode = connection.getResponseCode();
			if (responseCode == 200) {
				String result = processResponse(connection.getInputStream());
				int inicial = result.indexOf(nameFile);
				responseBody = result.substring(result.indexOf("cmis:objectId", inicial) + 16, result.indexOf(";", result.indexOf("cmis:objectId", inicial + 17)));
			} else {
				log.error("No se encontro el archivo: " + fileName + " en el directorio: " + libraryName);
			}
		} catch (Exception e) {
			log.error(getErrorMessage(e), e);
			throw new Exception("Error de comunicación con alfresco");
		} finally {
			if (log.isDebugEnabled())
				log.debug("Saliendo de buscar el uuid del archivo: " + fileName);
			if (connection != null)
				connection.disconnect();
		}
		if (log.isDebugEnabled())
			log.debug("UUDI del archivo: " + responseBody);
		return responseBody;
	}

	public String saveFile(String libraryName, String fileName, FileItem fileItem, String user, String password, String endpointDomain) {
		if (log.isDebugEnabled())
			log.debug("Ingresando a guardando el archivo: " + fileName);
		String responseBody = "";
		HttpURLConnection connection = null;
		try {
			String folderUuid = findFolderUUIDWithSelect(libraryName, user, password, endpointDomain);
			String CRLF = "\r\n";
			String boundary = Long.toHexString(System.currentTimeMillis());
			String url = endpointDomain + "/s/api/upload";
			connection = (HttpURLConnection) (new URL(url)).openConnection();
			connection.setConnectTimeout(25000);
			connection.setReadTimeout(25000);
			connection.setRequestProperty("Authorization", getAuthorizationHeader(user, password));
			connection.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
			connection.setDoOutput(true);
			connection.setRequestMethod("POST");
			OutputStream output = connection.getOutputStream();
			PrintWriter writer = new PrintWriter(new OutputStreamWriter(output, Charset.forName("UTF-8").newEncoder()), true);
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
			writer.append("Content-Disposition: form-data; name=\"filedata\"; filename=\"" + fileItem.getName() + "\"").append(CRLF);
			writer.append("Content-Type: " + fileItem.getContentType()).append(CRLF);
			writer.append("Content-Transfer-Encoding: binary").append(CRLF);
			writer.append(CRLF).flush();
			InputStream file = fileItem.getInputStream();
			byte[] buffer = new byte[4096];
			int length;
			while ((length = file.read(buffer)) > 0)
				output.write(buffer, 0, length);
			output.flush();
			writer.append(CRLF).flush();
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
			if (connection != null)
				connection.disconnect();
		}
		return responseBody;
	}

	private String findFolderUUIDWithSelect(String libraryName, String username, String password, String endpointDomain) {
		if (log.isDebugEnabled())
			log.debug("Ingresando a buscar el uuid de la carpeta: " + libraryName);
		String responseBody = "";
		HttpURLConnection connection = null;
		try {
			String nameFolder = "";
			if (libraryName.lastIndexOf("/") > 0) {
				nameFolder = libraryName.substring(libraryName.lastIndexOf("/") + 1);
			} else {
				nameFolder = libraryName;
			}
			String url = endpointDomain + "/api/-default-/public/cmis/versions/1.1/browser/?cmisselector=query&succinct=true&q=SELECT+cmis:path,+cmis:objectId+FROM+cmis:folder+WHERE+cmis:name='"
					+ nameFolder + "'";
			connection = (HttpURLConnection) (new URL(url)).openConnection();
			connection.setConnectTimeout(25000);
			connection.setReadTimeout(25000);
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
				log.info("No se encontro la carpeta: " + libraryName);
			}
		} catch (Exception e) {
			log.error(getErrorMessage(e), e);
		} finally {
			if (log.isDebugEnabled())
				log.debug("Saliendo de buscar el uuid de la carpeta: " + libraryName);
			if (connection != null)
				connection.disconnect();
		}

		return responseBody;
	}

	private String getAuthorizationHeader(String user, String password) {
		String authString = user + ":" + password;
		byte[] authEncBytes = Base64.encodeBase64(authString.getBytes());
		return "Basic " + new String(authEncBytes);
	}

	private String getErrorMessage(Exception e) {
		StringBuilder sb = new StringBuilder();
		if (e instanceof javax.xml.transform.TransformerException) {
			sb.append("Error transformacion XML: ");
		} else if (e instanceof java.net.URISyntaxException) {
			sb.append("Error creacion URI: ");
		} else if (e instanceof java.io.IOException) {
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
			char[] charArray = new char[1024];
			StringBuffer sb = new StringBuffer();
			int numCharsRead;
			while ((numCharsRead = isr.read(charArray)) > 0)
				sb.append(charArray, 0, numCharsRead);
			return sb.toString();
		} catch (Exception e) {
			log.error(getErrorMessage(e), e);
			return "";
		}
	}

}
