package com.cobiscorp.cloud.scheduler.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.channels.FileChannel;
import java.sql.Connection;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import org.apache.log4j.Logger;

import com.cobiscorp.cloud.notificationservice.dto.report.ReporteDTO;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;

public abstract class FileExchangeJob {
	private static final Logger logger = Logger.getLogger(FileExchangeJob.class);

	public enum Job {
		DSCDM, // Descarga Domiciliacion
		CRGDM, // Carga Domiciliacion
		CRGRS, // Carga Reportes Seguro
		CRGRN, // Carga Reportes Seguro No Cobrados
		CRGRA, // Carga Reportes Alertas
		CRFNA, // Carga Reportes Seguro Funeral Net Altas
		CRFNB, // Carga Reportes Seguro Funeral Net Bajas
		CRPAG,  // Carga Reportes de pagos
		CPYIFRP,
		CARSZ,  // Reportes seguros Zurich
        CARNODS, // Carga reportes NODS		
        CARCTFS, // Carga Reportes Contabilidad FileShare
        CARINF, // Carga Reportes Inclusion Financiera FileShare
        CARMC ,   // Mivimientos contables		
        CARODS,
        CARHRC,
        CRREE,    //Carga Reportes Reestructura 
		CAZCOCA, // Carga de arhivo de complementos para timbrado conector A
		CAZCOCB, // Carga de arhivo de complementos para timbrado conector A
		CAZCOCC, // Carga de arhivo de complementos para timbrado conector A
		CAZCOCD, // Carga de arhivo de complementos para timbrado conector A
		CAFACCA, // Carga de archivo de facturas para timbrado conector A
		CAFACCB, // Carga de archivo de facturas para timbrado conector B
		CAFACCC, // Carga de archivo de facturas para timbrado conector C
		CAFACCD, // Carga de archivo de facturas para timbrado conector D
		DAFACCA, // Descarga archivo de respuesta para timbrado conector A
		DAFACCB, // Descarga archivo de respuesta para timbrado conector A
		DAFACCC, // Descarga archivo de respuesta para timbrado conector A
		DAFACCD, // Descarga archivo de respuesta para timbrado conector A
		DAEFAC, // Descarga archivo de error de facturas de timbrado.        
        CARRCU, 
		CPYRR, //Copiar Archivos Reportes de Reintegros
        CRRRR,  // Carga Reportes de Reintegros
        CARRGE //Carga reporte Geolocalizacion
	}

	public enum Authentication {
		PASSWORD, // Contraseña
		PRIVATE_KEY, // Archivo de llave pública/privada
		PASS_KEY // Autenticacion combinada Laave publica y password
	}

	public ChannelSftp getChannelSftp() {
		return channelSftp;
	}

	public String getDownloadFilePattern() {
		return downloadFilePattern;
	}

	public String getDownloadPath() {
		return downloadPath;
	}

	public String getRemoteDownloadPath() {
		return remoteDownloadPath;
	}

	public String getRemoteDownloadHistoryPath() {
		return remoteDownloadHistoryPath;
	}

	public String getRemoteUploadPath() {
		return remoteUploadPath;
	}

	public String getUploadPath() {
		return uploadPath;
	}

	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}

	public String getFileName() {
		return fileName;
	}

	public String getFileNameUpload() {
		return fileNameUpload;
	}

	public String getHistoryPath() {
		return historyPath;
	}

	public Integer getRetryDownload() {
		return retryDownload;
	}

	public Integer getRetryUpload() {
		return retryUpload;
	}

	public Integer getToDownloadExtract() {
		return toDownloadExtract;
	}

	public Integer getToUploadExtract() {
		return toUploadExtract;
	}

	public String getWorkFolder() {
		return workFolder;
	}

	public String getZipFileName() {
		return zipFileName;
	}

	public String getFrom() {
		return from;
	}

	public String getTo() {
		return to;
	}

	public String getCc() {
		return cc;
	}

	public String getSubject() {
		return subject;
	}

	public String getAttachment() {
		return attachment;
	}

	public Session getSessionConnect() {
		return sessionConnect;
	}

    public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getFileContentPatternZip() {
		return fileContentPatternZip;
	}

	public void setFileContentPatternZip(String fileContentPatternZip) {
		this.fileContentPatternZip = fileContentPatternZip;
	}

	public String getDestinationFolderZip() {
		return destinationFolderZip;
	}

	public void setDestinationFolderZip(String destinationFolderZip) {
		this.destinationFolderZip = destinationFolderZip;
	}

	private Job process;

	private Authentication authenticationType;
	private ChannelSftp channelSftp;
	private Session sessionConnect;

	private String username;
	private String password;
	private String host;
	private Integer port;
	private Integer timeout;
	private String keyPath;
	private String passPhrase;
	private String kex; // Key Exchange Algorithm

	private String workFolder;
	private String historyPath;
	private String zipFileName;

	private String downloadPath;
	private String downloadFilePattern;
	private String remoteDownloadPath;
	private String remoteDownloadHistoryPath;
	private Integer retryDownload;
	private Integer toDownloadExtract;

	private String remoteUploadPath;
	private String uploadPath;
	private String fileName;
	private String fileNameUpload;
	private Integer retryUpload;
	private Integer toUploadExtract;

	private String from;
	private String to;
	private String cc;
	private String subject;
	private String attachment;
    private String message;
	private String method;

	// Atributos para descompresion del contenido del zip descargado
	private String fileContentPatternZip;
	private String destinationFolderZip;

	protected FileExchangeJob(Job process) {
		this.process = process;
	}

	public FileExchangeResponse getConfiguration() {
		boolean continueProcess = true;
		String internalError = null;
		InputStream inputStreamPropertiesFile = null;

		try {

			try {
				inputStreamPropertiesFile = new FileInputStream("notification/properties/" + process.name() + ".properties");
			} catch (FileNotFoundException e) {
				logger.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se pudo encontrar el archivo de configuraci\u00f3n de " + process.name());
			}

			Properties properties = new Properties();
			try {
				properties.load(inputStreamPropertiesFile);
			} catch (IOException e) {
				logger.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se pudo cargar el archivo de configuraci\u00f3n de " + process.name());
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Se carg\u00f3 el archivo de configuraci\u00f3n de " + process.name());
			}

			// Connection
			username = properties.getProperty("username");
			password = properties.getProperty("password");
			host = properties.getProperty("host");
			port = Integer.parseInt(properties.getProperty("port"));
			timeout = Integer.parseInt(properties.getProperty("timeout"));
			keyPath = properties.getProperty("keyPath");
			passPhrase = properties.getProperty("passPhrase");
			kex = properties.getProperty("kex");

			// Job information
			workFolder = properties.getProperty("workFolder");
			historyPath = properties.getProperty("historyPath");
			zipFileName = properties.getProperty("zipFileName");
			method = (properties.getProperty("method") != null ? properties.getProperty("method") : "0");

			// Download
			downloadPath = properties.getProperty("downloadPath");
			downloadFilePattern = properties.getProperty("downloadFilePattern");
			remoteDownloadPath = properties.getProperty("remoteDownloadPath");
			remoteDownloadHistoryPath = properties.getProperty("remoteDownloadHistoryPath");
			retryDownload = Integer.parseInt(properties.getProperty("retryDownload"));
			toDownloadExtract = Integer.parseInt(properties.getProperty("toDownloadExtract"));

			// Upload
			remoteUploadPath = properties.getProperty("remoteUploadPath");
			uploadPath = properties.getProperty("uploadPath");
			fileName = properties.getProperty("fileName");
			fileNameUpload = properties.getProperty("fileNameUpload");
			retryUpload = Integer.parseInt(properties.getProperty("retryUpload"));
			toUploadExtract = Integer.parseInt(properties.getProperty("toUploadExtract"));

			/* Envio de Correo */
			from = properties.getProperty("from");
			to = properties.getProperty("to");
			cc = properties.getProperty("cc");
			subject = properties.getProperty("subject");
			attachment = properties.getProperty("attachment");
            message = properties.getProperty("message");

			// Datos para descompresión
			destinationFolderZip = properties.getProperty("destinationFolderZip");
			fileContentPatternZip = properties.getProperty("fileContentPatternZip");

			if (Authentication.PASSWORD.toString().equals(properties.getProperty("authenticationType"))) {
				authenticationType = Authentication.PASSWORD;
			} else if (Authentication.PRIVATE_KEY.toString().equals(properties.getProperty("authenticationType"))) {
				authenticationType = Authentication.PRIVATE_KEY;
			} else if (Authentication.PASS_KEY.toString().equals(properties.getProperty("authenticationType"))) {
				authenticationType = Authentication.PASS_KEY;
			}

			if (logger.isDebugEnabled()) {
				logger.debug("historyPath: " + historyPath);
				logger.debug("username: " + username);
				// logger.debug("password: " + password);
				logger.debug("host: " + host);
				logger.debug("port: " + port);
				logger.debug("timeout: " + timeout);
				logger.debug("keyPath: " + keyPath);
				logger.debug("kex: " + kex);
				logger.debug("downloadPath: " + downloadPath);
				logger.debug("downloadFilePattern: " + downloadFilePattern);
				logger.debug("remoteDownloadPath: " + remoteDownloadPath);
				logger.debug("remoteDownloadHistoryPath: " + remoteDownloadHistoryPath);
				logger.debug("destinationFolderZip: " + destinationFolderZip);
				logger.debug("fileContentPatternZip: " + fileContentPatternZip);
			}

		} finally {
			if (inputStreamPropertiesFile != null) {
				try {
					inputStreamPropertiesFile.close();
				} catch (IOException e) {
					logger.error(e.toString());
					internalError = "No se pudo cerrar el canal de lectura del archivo de configuraci\u00f3n de " + process.name();
					continueProcess = false;
				}
			}
		}

		return new FileExchangeResponse(continueProcess, internalError);
	}

	public void connectProvider() {
		Session session = null;
		Channel channel = null;
		Integer pass = 0;

		try {
			if (logger.isDebugEnabled()) {
				logger.debug("Ingreso connectProvider");
				logger.debug("authenticationType: " + authenticationType);
				logger.debug("keyPath: " + keyPath);
				logger.debug("passPhrase: " + passPhrase);
				logger.debug("username: " + username);
				logger.debug("host: " + host);
				logger.debug("port: " + port);
				logger.debug("password: " + password);
			}

			JSch jsch = new JSch();

			switch (authenticationType) {
			case PASSWORD:
				pass = 1;
				break;
			case PRIVATE_KEY:
				try {
					jsch.addIdentity(keyPath);
				} catch (JSchException e) {
					logger.error("Error JSchException al asignar Path ", e);
					throw new COBISInfrastructureRuntimeException("No se puede iniciar sesi\u00f3n SFTP");
				}
				break;
			case PASS_KEY:
				try {
					pass = 1;
					if (passPhrase != null && !passPhrase.equals("")) {
						jsch.addIdentity(keyPath, passPhrase);
					} else {
						jsch.addIdentity(keyPath);
					}
				} catch (JSchException e) {
					logger.error("Error JSchException al asignar Path ", e);
					throw new COBISInfrastructureRuntimeException("No se puede iniciar sesi\u00f3n SFTP");
				}
				break;
			}

			try {
				session = jsch.getSession(username, host, port);
			} catch (JSchException e) {
				logger.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se puede iniciar sesi\u00f3n SFTP");
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Se inici\u00f3 sesi\u00f3n SFTP");
			}

			if (pass == 1) {
				session.setPassword(password);
			}

			session.setConfig("StrictHostKeyChecking", "no");
			if (kex != null) {
				if (!kex.contentEquals("")) {
					session.setConfig("kex", kex);
				}
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Usa kex: " + session.getConfig("kex"));
			}

			try {
				session.connect(timeout);
			} catch (JSchException e) {
				logger.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se puede conectar al servidor SFTP");
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Se realiz\u00f3 la conexi\u00f3n al servidor SFTP");
			}

			try {
				channel = session.openChannel("sftp");
			} catch (JSchException e) {
				logger.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se puede abrir el canal SFTP");
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Se abri\u00f3 el canal SFTP");
			}

			try {
				channel.connect(timeout);
			} catch (JSchException e) {
				logger.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se puede abrir el canal SFTP");
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Se abre el canal de la sesi\u00f3n");
			}

			channelSftp = (ChannelSftp) channel;
			sessionConnect = session;

		} finally {
			logger.debug("Termina connectProvider");
		}
	}

	public static void copyFile(File sourceFile, File destFile) throws IOException {
		if (!destFile.exists()) {
			destFile.createNewFile();
		}

		FileChannel origen = null;
		FileChannel destino = null;
		try {
			origen = new FileInputStream(sourceFile).getChannel();
			destino = new FileOutputStream(destFile).getChannel();

			long count = 0;
			long size = origen.size();
			while ((count += destino.transferFrom(origen, count, size - count)) < size)
				;
		} finally {
			if (origen != null) {
				origen.close();
			}
			if (destino != null) {
				destino.close();
			}
		}
	}

	public static File changePathHistorical(String sourceFile, String type, String originalFile) throws IOException {

		try {
			DateFormat dateFormat = new SimpleDateFormat("\\yyyy\\MM\\dd\\");
			Date date = new Date();
			String fileNameToHistorical = sourceFile + type + dateFormat.format(date) + originalFile;
			File fileToChange = new File(fileNameToHistorical);
			if (logger.isDebugEnabled()) {
				logger.debug("fileNameToEncrypt: " + fileNameToHistorical);
			}

			File encryptInFolder = new File(fileToChange.getParent());
			logger.debug("Ver el getParent historyFolder: " + fileToChange.getParent());
			logger.debug("Absolute Path de historyFolder: " + encryptInFolder.getAbsolutePath());

			if (!encryptInFolder.exists()) {
				if (!encryptInFolder.mkdirs()) {
					throw new COBISInfrastructureRuntimeException("No se puede crear la carpeta de entrada para historial");
				} else if (logger.isDebugEnabled()) {
					logger.debug("Creación de la carpeta de entrada para cifrado: [" + encryptInFolder.getAbsolutePath() + "]");
				}
			}
			return new File(fileNameToHistorical);
		} finally {
			// TODO
		}
	}

	public static String changePath(String sourceFile, String staticCaracter) throws Exception {
		Connection cn = null;
		try {
			cn = ConnectionManager.newConnection();

			String date1 = Util.fechaProceso(cn, 111);
			String date2 = Util.fechaProceso(cn, 103);
			logger.debug("La fecha1 devuelta es: " + date1);
			logger.debug("La fecha2 devuelta es: " + date2);
			String firstPart = sourceFile.substring(0, sourceFile.indexOf('?'));
			String secondPart = sourceFile.substring(sourceFile.indexOf("?\\") + 1, sourceFile.indexOf('x'));
			String fileNameToHistorical = firstPart + date1.replace("/", "") + secondPart + date2.replace("/", "") + staticCaracter + "\\";

			return fileNameToHistorical;
		} catch (Exception e) {
			logger.error("Error al intentar cambiar ruta: ", e);
			throw e;
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				logger.error("Error al cerrar la conexión: ", e);
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Finaliza changePath");
			}
		}
	}

	public static String changeName(String sourceFile) throws Exception {
		Connection cn = null;
		try {
			cn = ConnectionManager.newConnection();

			String date1 = Util.fechaProceso(cn, 111);
			String date2 = Util.fechaProceso(cn, 103);
			logger.debug("La fecha1 devuelta es: " + date1);
			logger.debug("La fecha2 devuelta es: " + date2);

			String name1 = sourceFile.substring(0, sourceFile.indexOf('|'));
			String name2 = sourceFile.substring(31, 61);

			String firstPart = name1.substring(0, sourceFile.indexOf('?'));
			logger.debug("La firstPart es: " + firstPart);
			String secondPart = name2.substring(0, sourceFile.indexOf('?'));
			logger.debug("La secondPart es: " + secondPart);
			String fileNameToHistorical = firstPart + date2.replace("/", "") + ".txt" + "|" + secondPart + date2.replace("/", "") + ".txt";
			logger.debug("La fileNameToHistorical es: " + fileNameToHistorical);

			return fileNameToHistorical;
		} catch (Exception e) {
			logger.error("Error al intentar cambiar ruta: ", e);
			throw e;
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				logger.error("Error al cerrar la conexión: ", e);
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Finaliza changePath");
			}
		}
	}

	public static String changeNamePreviousDate(String sourceFile) throws Exception {
		Connection cn = null;
		try {
			cn = ConnectionManager.newConnection();

			String date = Util.fechaProcesoAnterior("dd/MM/yyyy");
			logger.debug("La fecha2 devuelta es: " + date);

			String name1 = sourceFile.substring(0, sourceFile.indexOf('|'));
			String name2 = sourceFile.substring(31, 61);

			String firstPart = name1.substring(0, sourceFile.indexOf('?'));
			logger.debug("La firstPart es: " + firstPart);
			String secondPart = name2.substring(0, sourceFile.indexOf('?'));
			logger.debug("La secondPart es: " + secondPart);
			String fileNameToHistorical = firstPart + date.replace("/", "") + ".txt" + "|" + secondPart + date.replace("/", "") + ".txt";
			logger.debug("La fileNameToHistorical es: " + fileNameToHistorical);

			return fileNameToHistorical;
		} catch (Exception e) {
			logger.error("Error al intentar cambiar ruta: ", e);
			throw e;
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				logger.error("Error al cerrar la conexión: ", e);
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Finaliza changePath");
			}
		}
	}

	public FileExchangeResponse getConfigurationR(ReporteDTO inforForReport) {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia FileExchangeJob-->>getConfigurationR");
		}
		boolean continueProcess = true;
		String internalError = null;

		try {
			// Connection
			username = inforForReport.getUsername();
			password = inforForReport.getPassword();
			host = inforForReport.getHost();
			port = inforForReport.getPort();
			timeout = inforForReport.getTimeout();
			keyPath = inforForReport.getKeyPath();
			passPhrase = "";
			kex = "";

			// Job information
			workFolder = inforForReport.getWorkFolderD();
			historyPath = "";
			zipFileName = "";
			method = "0";

			// Download
			downloadPath = inforForReport.getDownloadPath();
			downloadFilePattern = inforForReport.getDownloadFilePattern();
			remoteDownloadPath = inforForReport.getRemoteDownloadPath();
			remoteDownloadHistoryPath = inforForReport.getRemoteDownloadHistoryPath();
			retryDownload = Integer.parseInt(inforForReport.getRetryDownload());
			toDownloadExtract = Integer.parseInt(inforForReport.getToDownloadExtract());

			// Upload
			remoteUploadPath = inforForReport.getRemoteUploadPath();
			uploadPath = inforForReport.getUploadPath();
			fileName = "";
			fileNameUpload = inforForReport.getFileNameUpload();
			retryUpload = Integer.parseInt(inforForReport.getRetryUpload());
			toUploadExtract = Integer.parseInt(inforForReport.getToUploadExtract());

			/* Envio de Correo */
			from = "";
			to = "";
			cc = "";
			subject = "";
			attachment = "";
			message = "";

			// Datos para descompresión
			destinationFolderZip = "";
			fileContentPatternZip = "";

			if (Authentication.PASSWORD.toString().equals(inforForReport.getAuthenticationType())) {
				authenticationType = Authentication.PASSWORD;
			} else if (Authentication.PRIVATE_KEY.toString().equals(inforForReport.getAuthenticationType())) {
				authenticationType = Authentication.PRIVATE_KEY;
			} else if (Authentication.PASS_KEY.toString().equals(inforForReport.getAuthenticationType())) {
				authenticationType = Authentication.PASS_KEY;
			}

			if (logger.isDebugEnabled()) {
				logger.debug("username: " + username);
				logger.debug("password: " + password);
				logger.debug("host: " + host);
				logger.debug("port: " + port);
				logger.debug("timeout: " + timeout);
				logger.debug("keyPath: " + keyPath);
				logger.debug("workFolder: " + workFolder);
				logger.debug("downloadPath: " + downloadPath);
				logger.debug("downloadFilePattern: " + downloadFilePattern);
				logger.debug("remoteDownloadPath: " + remoteDownloadPath);
				logger.debug("remoteDownloadHistoryPath: " + remoteDownloadHistoryPath);
				logger.debug("retryDownload: " + retryDownload);
				logger.debug("toDownloadExtract: " + toDownloadExtract);
				logger.debug("remoteUploadPath: " + remoteUploadPath);
				logger.debug("uploadPath: " + uploadPath);
				logger.debug("fileNameUpload: " + fileNameUpload);
				logger.debug("retryUpload: " + retryUpload);
				logger.debug("toUploadExtract: " + toUploadExtract);
				logger.debug("authenticationType: " + authenticationType);
			}

		} finally {
			if (logger.isDebugEnabled()) {
				logger.debug("Finaliza FileExchangeJob-->>getConfigurationR");
			}
		}

		return new FileExchangeResponse(continueProcess, internalError);
	}
}
