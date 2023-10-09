package com.cobiscorp.cloud.scheduler.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.Properties;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.filefilter.WildcardFileFilter;
import org.apache.log4j.Logger;

import com.cobiscorp.cloud.notificationservice.dto.report.ReporteDTO;
import com.cobiscorp.cloud.notificationservice.key.CryptoUtils;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

public abstract class FileJob {
	private static final Logger logger = Logger.getLogger(FileJob.class);

	private Job process;
	private boolean propertiesLoaded = false;
	private String workFolder;
	private String sourceFolder;
	private String destinationFolder;
	private String fileNamePattern;
	private String to;
	private String cc;
	private String subject;
	private String zipFileName;
	private String zipFileNameHistory;
	private String fileErrNamePattern;
	private String method;

	public Job getProcess() {
		return process;
	}

	public String getWorkFolder() {
		return workFolder;
	}

	public String getSourceFolder() {
		return sourceFolder;
	}

	public String getDestinationFolder() {
		return destinationFolder;
	}

	public String getFileNamePattern() {
		return fileNamePattern;
	}

	public void setFileNamePattern(String fileNamePattern) {
		this.fileNamePattern = fileNamePattern;
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

	public String getZipFileName() {
		return zipFileName;
	}

	public String getFileErrNamePattern() {
		return fileErrNamePattern;
	}

	public void setFileErrNamePattern(String fileErrNamePattern) {
		this.fileErrNamePattern = fileErrNamePattern;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public enum Job {
		XTRRS, // Extracción de Reportes de Seguros
		CPYRA, // Copia de Reportes de Alertas
		XTRRA, // Extracción de Reportes de Alertas
		CPYSF, // Copiar Reportes de Seguros Funeral
		CPYSFRA, // Copiar Reportes de Seguros Funeral a la carpeta de Regulatorios Altas
		CPYSFRB, // Copiar Reportes de Seguros Funeral a la carpeta de Regulatorios Bajas
		XTRSF, // Extracción de Reportes de Seguros Funeral
		CPYRP, // Copiar Reportes de Pagos
		XTRRP, // Extracción de Reportes de Pagos
		CPYIF, // Copia estado de cuenta Interfactura
		CPYIFP, // Copia Xml Interfactura Procesados,
		CPYIFR, // Copia Xml Interfactura Procesados,
		CPYIFD, // Copia estado de cuenta Interfactura mismo dia
		CPYRAF, // Copia de reporte de Alertas a FTP de Cobis
		GXMLCI, // Archivo de Propiedades donde se copiaran los archivos SAT.
		INFAC, // Generación de Estados de Cuenta
		ZFIEC, // Empaquetado de Estados de Cuenta Interfactura
		MPDFI, // Movilizacion del archivo,
		ECETC, // Eliminacion de Carpetas de Interfactura
		CPYN4, // Copia de archivos N4
		GACMC, // Generar archivo cifrado de Cobranza Mc Collect
		CACMC, // Copia de archivo cifrado de Cobranza Mc Collect a la capa web
		ELCMC, // Eliminar Carpetas Mc Collect a partir de tres mese
		CAMCW, // Copiar archivo de la capa web a la base de datso
		GADMC, // Generar archivo desifrado Mc Collect
		CDMCC, // Carga de Data que entrega Mc Collect a COBIS
		CPYASG, // Copia Reportes Asignaciones
		XCRYS, // Encriptar con RSA y copiar reporte seguros COKA
		CPYSZ, // Seguros Zurich
		CPYNODS, // Copia reportes NODS
		CPYCTFS, // Reportes de contabilidad FileShare
		CPYINFA, // Copia Reportes Inclusion Financiera FileShare
		CPYINFB,  // Copia Reportes Inclusion Financiera FileShare
		CPYMC ,  // Movimientos Contables
		CPYODS,
		CPYHRC,
		CPYREE,   //Copia Reportes Reestructura 
		GXMLCO, // GenerarXmlComplemento
		CPYCO, // Copia de Xml COmplemento,
		CPYZFAC, // Copia de Zips de facturas a los conectores
		CPYZCOM, // Copia de Zips de complementos a los conectores
		CPYRCU,
		CPYRR, //Copiar Archivos Reportes de Reintegros
        XTRRR, // Extrar Archivos Reportes de Reintegros
        CRRRR,  // Carga Reportes de Reintegros
        GRAOB, // Generacion reportes AutoOnBoarding
        CRAOB, // Copia reportes AutoOnBoarding
        CPYRGE, //Copia reporte Geolocalizacion
        RCAUPD, // Reintento de carga archivos a alfresco y actualizacion cobis
        GCRCOLI //REQ#193431 Reporte Cobranza linea
	}

	FileJob(Job process) {
		this.process = process;
	}

	synchronized FileExchangeResponse getConfiguration() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia getConfiguration");
		}

		boolean continueProcess = true;
		String internalError = null;

		if (!propertiesLoaded) {
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

				workFolder = properties.getProperty("workFolder");
				sourceFolder = properties.getProperty("sourceFolder");
				destinationFolder = properties.getProperty("destinationFolder");
				fileNamePattern = properties.getProperty("fileNamePattern");
				zipFileName = properties.getProperty("zipFileName");
				zipFileNameHistory = properties.getProperty("zipFileNameHistory");
				fileErrNamePattern = properties.getProperty("fileErrNamePattern");
				method = (properties.getProperty("method") != null ? properties.getProperty("method") : "0");

				/* Envío de Correo */
				to = properties.getProperty("to");
				cc = properties.getProperty("cc");
				subject = properties.getProperty("subject");

				if (logger.isDebugEnabled()) {
					logger.debug("workFolder: " + workFolder);
					logger.debug("sourceFolder: " + sourceFolder);
					logger.debug("destinationFolder: " + destinationFolder);
					logger.debug("zipFileNameHistory: " + zipFileNameHistory);
					logger.debug("fileErrNamePattern: " + fileErrNamePattern);
					logger.debug("method: " + fileErrNamePattern);
				}

				sourceFolder = Util.validateDateFormat(sourceFolder);
				zipFileNameHistory = Util.validateDateFormat(zipFileNameHistory);
				workFolder = Util.validateDateFormat(workFolder);
				destinationFolder = Util.validateDateFormat(destinationFolder);
				if (process.equals(Job.XCRYS)) {
					fileNamePattern = Util.validateDateFormat(fileNamePattern);
				}

				if (logger.isDebugEnabled()) {
					logger.debug("workFolder: " + workFolder);
					logger.debug("sourceFolder: " + sourceFolder);
					logger.debug("destinationFolder: " + destinationFolder);
					logger.debug("fileNamePattern: " + fileNamePattern);
					logger.debug("zipFileName: " + zipFileName);
					logger.debug("zipFileNameHistory: " + zipFileNameHistory);
					logger.debug("to: " + to);
					logger.debug("cc: " + cc);
					logger.debug("subject: " + subject);
				}

				propertiesLoaded = true;
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
		}

		return new FileExchangeResponse(continueProcess, internalError);
	}

	/**
	 * Mueve todos los archivos de la carpeta origen a la carpeta destino
	 */
	FileExchangeResponse moveFiles() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia moveFiles");
		}

		FileExchangeResponse fileExchangeResponse = null;

		File directory = new File(sourceFolder);

		if (!directory.exists() || !directory.isDirectory()) {
			return new FileExchangeResponse(false, "No existe el directorio origen: " + sourceFolder);
		}

		String[] patterns = fileNamePattern.split("\\|");

		Collection fileCollection = FileUtils.listFiles(directory, new WildcardFileFilter(patterns[0]), null);
		for (int i = 1; i < patterns.length; i++) {
			fileCollection.addAll(FileUtils.listFiles(directory, new WildcardFileFilter(patterns[i]), null));
		}

		if (logger.isDebugEnabled()) {
			logger.debug("Archivos encontrados: " + fileCollection.toString());
		}

		for (Object found : fileCollection) {
			File file = (File) found;
			fileExchangeResponse = moveFileToDestination(file);
			if (!fileExchangeResponse.isSuccess()) {
				return fileExchangeResponse;
			}
		}

		return new FileExchangeResponse(true, "Proceso exitoso");
	}

	FileExchangeResponse zipFiles() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia zipFiles");
		}

		boolean continueProcess = true;
		String internalError = null;

		File directory = new File(sourceFolder);

		if (!directory.exists() || !directory.isDirectory()) {
			return new FileExchangeResponse(false, "No existe el directorio origen: " + sourceFolder);
		}

		String[] patterns = fileNamePattern.split("\\|");

		Collection fileCollection = FileUtils.listFiles(directory, new WildcardFileFilter(patterns[0]), null);
		for (int i = 1; i < patterns.length; i++) {
			fileCollection.addAll(FileUtils.listFiles(directory, new WildcardFileFilter(patterns[i]), null));
		}

		if (logger.isDebugEnabled()) {
			logger.debug("fileCollection: " + fileCollection.size());
		}

		if (fileCollection.size() == 0) {
			return new FileExchangeResponse(false, "No existen archivos para copiar");
		}

		File zipFile = new File(workFolder + "\\" + zipFileName);

		// create the ZIP file
		ZipOutputStream out = null;
		FileInputStream in = null;

		try {

			try {
				out = new ZipOutputStream(new FileOutputStream(zipFile));
			} catch (FileNotFoundException e) {
				logger.error(e.toString());
				internalError = "No se pudo crear el archivo para empaquetar los archivos de origen";
				continueProcess = false;
			}

			if (continueProcess) {

				byte[] buf = new byte[1024];

				// compress the files
				for (Object found : fileCollection) {
					String fileToZip = ((File) found).getName();

					if (logger.isDebugEnabled()) {
						logger.debug("fileToZip: " + fileToZip);
					}

					try {
						in = new FileInputStream(((File) found).getCanonicalFile());
					} catch (IOException e) {
						logger.error(e.toString());
						throw new COBISInfrastructureRuntimeException("No se pudo obtener el archivo " + fileToZip);
					}

					// add ZIP entry to output stream
					try {
						out.putNextEntry(new ZipEntry(fileToZip));
					} catch (IOException e) {
						logger.error(e.toString());
						throw new COBISInfrastructureRuntimeException("No se pudo iniciar el empaquetamiento del archivo " + fileToZip);
					}

					// transfer bytes from the file to the ZIP file
					int len;
					while ((len = in.read(buf)) > 0) {
						try {
							out.write(buf, 0, len);
						} catch (IOException e) {
							logger.error(e.toString());
							throw new COBISInfrastructureRuntimeException("No se pudo leer el archivo " + ((File) found).getName() + " para empaquetarlo");
						}
					}

					// complete the entry
					try {
						in.close();
					} catch (IOException e) {
						logger.error(e.toString());
						throw new COBISInfrastructureRuntimeException("No se pudo cerrar el archivo " + ((File) found).getName());
					}

					try {
						out.closeEntry();
					} catch (IOException e) {
						logger.error(e.toString());
						throw new COBISInfrastructureRuntimeException("No se pudo cerrar la entrada del empaquetado correspondiente a " + ((File) found).getName());
					}
				}

				try {
					out.close();
				} catch (IOException e) {
					logger.error(e.toString());
					throw new COBISInfrastructureRuntimeException("No se pudo cerrar el archivo " + zipFile.getName());
				}
			}
		} catch (IOException e) {
			logger.error(e.toString());
			throw new COBISInfrastructureRuntimeException("No se pudo crear el empaquetado " + zipFile.getName());
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {
					internalError = "No se pudo cerrar el archivo a empaquetarse";
					continueProcess = false;
				}
			}
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
					internalError = "No se pudo cerrar el archivo " + zipFile.getName();
					continueProcess = false;
				}
			}
		}

		return new FileExchangeResponse(continueProcess, internalError);
	}

	boolean existZipFile() {
		return FileUtil.existFile(workFolder + "\\history\\" + zipFileNameHistory);
	}

	File[] zipFileList() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia zipFiles");
		}

		boolean continueProcess = true;
		String internalError = null;
		File[] fileList = null;

		File directory = new File(sourceFolder);

		String[] patterns = fileNamePattern.split("\\|");

		Collection fileCollection = FileUtils.listFiles(directory, new WildcardFileFilter(patterns[0]), null);
		for (int i = 1; i < patterns.length; i++) {
			fileCollection.addAll(FileUtils.listFiles(directory, new WildcardFileFilter(patterns[i]), null));
		}

		if (logger.isDebugEnabled()) {
			logger.debug("fileCollection: " + fileCollection.size());
		}

		File zipFile = new File(workFolder + "\\" + zipFileName);
		fileList = new File(sourceFolder).listFiles();
		logger.debug("sourceFolder delete: " + sourceFolder);
		for (int x = 0; x < fileList.length; x++) {
			logger.debug("getName fileList[" + x + "]: " + fileList[x].getName());
			logger.debug("getPath fileList[" + x + "]: " + fileList[x].getPath());
			logger.debug("getAbsolutePath fileList[" + x + "]: " + fileList[x].getAbsolutePath());
		}

		// create the ZIP file
		ZipOutputStream out = null;
		FileInputStream in = null;

		try {

			try {
				out = new ZipOutputStream(new FileOutputStream(zipFile));
			} catch (FileNotFoundException e) {
				logger.error(e.toString());
				internalError = "No se pudo crear el archivo para empaquetar los archivos de origen";
				continueProcess = false;
			}

			if (continueProcess) {

				byte[] buf = new byte[1024];

				// compress the files
				for (Object found : fileCollection) {
					String fileToZip = ((File) found).getName();

					if (logger.isDebugEnabled()) {
						logger.debug("fileToZip: " + fileToZip);
					}

					try {
						in = new FileInputStream(((File) found).getCanonicalFile());
					} catch (IOException e) {
						logger.error(e.toString());
						throw new COBISInfrastructureRuntimeException("No se pudo obtener el archivo " + fileToZip);
					}

					// add ZIP entry to output stream
					try {
						out.putNextEntry(new ZipEntry(fileToZip));
					} catch (IOException e) {
						logger.error(e.toString());
						throw new COBISInfrastructureRuntimeException("No se pudo iniciar el empaquetamiento del archivo " + fileToZip);
					}

					// transfer bytes from the file to the ZIP file
					int len;
					while ((len = in.read(buf)) > 0) {
						try {
							out.write(buf, 0, len);
						} catch (IOException e) {
							logger.error(e.toString());
							throw new COBISInfrastructureRuntimeException("No se pudo leer el archivo " + ((File) found).getName() + " para empaquetarlo");
						}
					}

					// complete the entry
					try {
						in.close();
					} catch (IOException e) {
						logger.error(e.toString());
						throw new COBISInfrastructureRuntimeException("No se pudo cerrar el archivo " + ((File) found).getName());
					}

					try {
						out.closeEntry();
					} catch (IOException e) {
						logger.error(e.toString());
						throw new COBISInfrastructureRuntimeException("No se pudo cerrar la entrada del empaquetado correspondiente a " + ((File) found).getName());
					}
				}

				try {
					out.close();
				} catch (IOException e) {
					logger.error(e.toString());
					throw new COBISInfrastructureRuntimeException("No se pudo cerrar el archivo " + zipFile.getName());
				}
			}
		} catch (IOException e) {
			logger.error(e.toString());
			throw new COBISInfrastructureRuntimeException("No se pudo crear el empaquetado " + zipFile.getName());
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {
					internalError = "No se pudo cerrar el archivo a empaquetarse";
					continueProcess = false;
				}
			}
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
					internalError = "No se pudo cerrar el archivo " + zipFile.getName();
					continueProcess = false;
				}
			}
		}

		return fileList;
	}

	FileExchangeResponse copyZipFile() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia copyZipFile");
		}

		return FileUtil.copyFile(workFolder + "\\" + zipFileName, destinationFolder + "\\" + zipFileName);
	}

	FileExchangeResponse copyFilesPatternDirectory() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia copyFilesNormal");
		}

		boolean continueProcess = true;
		String internalError = null;

		File directory = new File(sourceFolder);

		if (!directory.exists() || !directory.isDirectory()) {
			return new FileExchangeResponse(false, "No existe el directorio origen: " + sourceFolder);
		}

		String[] patterns = fileNamePattern.split("\\|");

		Collection fileCollection = FileUtils.listFiles(directory, new WildcardFileFilter(patterns[0]), null);
		for (int i = 1; i < patterns.length; i++) {
			fileCollection.addAll(FileUtils.listFiles(directory, new WildcardFileFilter(patterns[i]), null));
		}

		if (logger.isDebugEnabled()) {
			logger.debug("fileCollection: " + fileCollection.size());
		}

		if (fileCollection.size() == 0) {

			logger.debug("No existen archivos para copiar");
			// return new FileExchangeResponse(false, "No existen archivos para copiar");
		}
		if (fileCollection.size() > 0) {
			for (Object found : fileCollection) {
				String fileToCopy = ((File) found).getName();

				System.out.println("obeto a copiar" + fileToCopy);
				System.out.println("obeto a copiar version normal" + ((File) found).getName());

				if (!FileUtil.existFile(destinationFolder + "\\" + fileToCopy)) {
					logger.info("carpeta de origen para copia...." + workFolder + "\\" + fileToCopy);
					logger.info("carpeta de destino para copia..." + destinationFolder + "\\" + fileToCopy);
					FileUtil.copyFile(sourceFolder + "\\" + fileToCopy, destinationFolder + "\\" + fileToCopy);
				} else {
					logger.info("Los archivos ya fue copiado anteriormente");
				}

			}
		}

		return new FileExchangeResponse(continueProcess, internalError);
	}

	FileExchangeResponse moveZipFileToHistory() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia moveZipFileToHistory");
		}

		File historyFolder = new File(workFolder + "\\history");
		if (!historyFolder.exists()) {
			historyFolder.mkdir();
		}

		return FileUtil.moveFile(workFolder + "\\" + zipFileName, historyFolder.getAbsolutePath() + "\\" + zipFileNameHistory);
	}

	FileExchangeResponse moveZipFileToHistory(String dateTimePattern) {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia moveZipFileToHistory");
		}

		File historyFolder = new File(workFolder + "\\history");
		if (!historyFolder.exists()) {
			historyFolder.mkdir();
		}

		DateFormat dateFormat = new SimpleDateFormat(dateTimePattern);
		String dateTime = dateFormat.format(new Date());

		return FileUtil.moveFile(workFolder + "\\" + zipFileName, historyFolder.getAbsolutePath() + "\\" + dateTime + zipFileName);
	}

	void sendMail(String messageOk) {
		Email.send(null, to, cc, subject, messageOk, null);
	}

	/**
	 * Obtiene el listado de archivos de la carpeta origen
	 */
	public File[] getlistFiles() {
		File[] fileList = null;
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia getlistFiles");
		}

		File directory = new File(sourceFolder);

		if (!directory.exists() || !directory.isDirectory()) {
			logger.debug("No existe el directorio origen: " + sourceFolder);
			return fileList;
		}

		String[] patterns = fileNamePattern.split("\\|");

		for (int i = 0; i < patterns.length; i++) {
			System.out.println("patterns" + i + "" + patterns[i]);
		}

		Collection fileCollection = FileUtils.listFiles(directory, new WildcardFileFilter(patterns[0]), null);
		for (int i = 1; i < patterns.length; i++) {
			fileCollection.addAll(FileUtils.listFiles(directory, new WildcardFileFilter(patterns[i]), null));
		}

		if (fileCollection.size() == 0) {
			logger.debug("No existen archivos para copiar");
		}
		fileList = new File[fileCollection.size()];
		int iterador = 0;
		for (Object found : fileCollection) {
			logger.debug("Nombre del archivo" + ((File) found).getName());
			fileList[iterador] = (File) found;
			iterador = iterador + 1;
			logger.debug("iterador++.." + iterador);
		}

		return fileList;
	}

	public FileExchangeResponse listZipFiles() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia listZipFiles");
		}
		System.out.println("Ingresa");
		FileExchangeResponse fileExchangeResponse = null;
		boolean continueProcess = true;
		String internalError = null;

		File directory = new File(sourceFolder);

		if (!directory.exists() || !directory.isDirectory()) {

			logger.debug("No existe el directorio origen: " + sourceFolder);
			// return new FileExchangeResponse(false, "No existe el directorio origen: " +
			// sourceFolder);
		}

		System.out.println("Ingresa" + directory.getAbsolutePath());

		String[] patterns = fileNamePattern.split("\\|");
		logger.debug("patterns" + patterns);
		for (int i = 0; i < patterns.length; i++) {
			System.out.println("patterns" + i + "" + patterns[i]);
		}

		Collection fileCollection = FileUtils.listFiles(directory, new WildcardFileFilter(patterns[0]), null);
		for (int i = 1; i < patterns.length; i++) {
			fileCollection.addAll(FileUtils.listFiles(directory, new WildcardFileFilter(patterns[i]), null));

		}

		if (fileCollection.size() == 0) {
			logger.debug("No existe el directorio origen: " + sourceFolder);
			// return new FileExchangeResponse(false, "No existen archivos para copiar");
		}

		for (Object found : fileCollection) {
			String fileToZip = ((File) found).getName();
			logger.debug("obeto a ziper" + ((File) found).getName());
		}
		File[] fileList = new File[fileCollection.size()];
		int iterador = 0;
		for (Object found : fileCollection) {
			String fileToZip = ((File) found).getName();
			logger.debug("obeto a ziper" + ((File) found).getName());
			fileList[iterador] = (File) found;
			iterador = iterador + 1;
			logger.debug("iterador++  " + iterador);
		}

		for (int i = 0; i < fileList.length; i++) {

			String fileToZip = getFileNamewithoutExtension(fileList[i]);
			File zipFile = new File(destinationFolder + "\\" + fileToZip + ".zip");
			logger.debug("Nombre de1 archivo a  zipear--  " + zipFile.getName());
			ZipOutputStream out = null;
			FileInputStream in = null;

			try {

				try {
					out = new ZipOutputStream(new FileOutputStream(zipFile));
				} catch (FileNotFoundException e) {
					logger.error(e.toString());
					logger.debug("No existe el directorio destinationFolder o no tiene acceso:");
					internalError = "No se pudo crear el archivo para empaquetar los archivos de origen";
					continueProcess = false;

				}

				if (continueProcess) {

					byte[] buf = new byte[1024];

					// compress the files

					try {
						in = new FileInputStream(fileList[i].getCanonicalFile());
					} catch (IOException e) {
						logger.error(e.toString());
						throw new COBISInfrastructureRuntimeException("No se pudo obtener el archivo " + fileToZip);
					}

					// add ZIP entry to output stream
					try {
						out.putNextEntry(new ZipEntry(fileList[i].getName()));
					} catch (IOException e) {
						logger.error(e.toString());
						throw new COBISInfrastructureRuntimeException("No se pudo iniciar el empaquetamiento del archivo " + fileToZip);
					}

					// transfer bytes from the file to the ZIP file
					int len;
					while ((len = in.read(buf)) > 0) {
						try {
							out.write(buf, 0, len);
						} catch (IOException e) {
							logger.error(e.toString());
							throw new COBISInfrastructureRuntimeException("No se pudo leer el archivo " + fileList[i].getName() + " para empaquetarlo");
						}
					}

					// complete the entry
					try {
						in.close();
					} catch (IOException e) {
						logger.error(e.toString());
						throw new COBISInfrastructureRuntimeException("No se pudo cerrar el archivo " + fileList[i].getName());
					}

					try {
						out.closeEntry();
					} catch (IOException e) {
						logger.error(e.toString());
						throw new COBISInfrastructureRuntimeException("No se pudo cerrar la entrada del empaquetado correspondiente a " + fileList[i].getName());
					}

					try {
						out.close();
					} catch (IOException e) {
						logger.error(e.toString());
						throw new COBISInfrastructureRuntimeException("No se pudo cerrar el archivo " + zipFile.getName());
					}

					fileExchangeResponse = moveFileToHistory(fileList[i]);
					fileExchangeResponse = removeFile(fileList[i].getPath());

				}
			} catch (IOException e) {
				logger.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se pudo crear el empaquetado " + zipFile.getName());
			} finally {
				if (in != null) {
					try {
						in.close();
					} catch (IOException e) {
						internalError = "No se pudo cerrar el archivo a empaquetarse";
						continueProcess = false;
					}
				}
				if (out != null) {
					try {
						out.close();
					} catch (IOException e) {
						internalError = "No se pudo cerrar el archivo " + zipFile.getName();
						continueProcess = false;
					}
				}
			}

		}

		return new FileExchangeResponse(true, null);
	}

	private static String getFileNamewithoutExtension(File file) {
		String fileName = file.getName();
		if (fileName.lastIndexOf(".") != -1 && fileName.lastIndexOf(".") != 0) {
			return fileName.substring(0, fileName.lastIndexOf("."));
		}
		return "";
	}

	public static FileExchangeResponse removeFile(String filePathName) {

		File file = new File(filePathName);
		file.delete();

		return new FileExchangeResponse(true, null);
	}

	public FileExchangeResponse moveFileToHistory(File file) {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia moveFileToHistory");
		}

		File historyFolder = new File(workFolder + "\\history");
		if (logger.isDebugEnabled()) {
			logger.debug("Ruta del archivo origen: " + file.getAbsolutePath());
			logger.debug("Ruta del archivo destino: " + historyFolder.getAbsolutePath() + "\\" + file.getName());
		}

		if (!historyFolder.exists()) {
			if (!historyFolder.mkdirs()) {
				return new FileExchangeResponse(false, "No se pudo crear el directorio destino");
			}
		}

		if (FileUtil.existFile(historyFolder.getAbsolutePath() + "\\" + file.getName())) {
			removeFile(historyFolder.getAbsolutePath() + "\\" + file.getName());
		}

		return FileUtil.moveFile(file.getAbsolutePath(), historyFolder.getAbsolutePath() + "\\" + file.getName());
	}

	public FileExchangeResponse moveFileToDestination(File file) {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia moveFileToDestination");
		}

		File destinationFolder = new File(this.destinationFolder);
		if (logger.isDebugEnabled()) {
			logger.debug("Ruta del archivo origen: " + file.getAbsolutePath());
			logger.debug("Ruta del archivo destino: " + destinationFolder.getAbsolutePath() + "\\" + file.getName());
		}

		if (!destinationFolder.exists()) {
			if (!destinationFolder.mkdirs()) {
				return new FileExchangeResponse(false, "No se pudo crear el directorio destino");
			}
		}

		if (FileUtil.existFile(destinationFolder.getAbsolutePath() + "\\" + file.getName())) {
			removeFile(destinationFolder.getAbsolutePath() + "\\" + file.getName());
		}

		return FileUtil.moveFile(file.getAbsolutePath(), destinationFolder.getAbsolutePath() + "\\" + file.getName());
	}

	public FileExchangeResponse moveFileToDestinationInterfactura(File file, String dato) {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia moveFileToDestination");
		}

		String patchDestination = this.destinationFolder + "\\" + dato + "\\" + "FACTURA";

		File destinationFolder = new File(patchDestination);
		if (logger.isDebugEnabled()) {
			logger.debug("Ruta del archivo origen: " + file.getAbsolutePath());
			logger.debug("Ruta del archivo destino: " + destinationFolder.getAbsolutePath() + file.getName());
		}

		if (!destinationFolder.exists()) {
			if (!destinationFolder.mkdirs()) {
				return new FileExchangeResponse(false, "No se pudo crear el directorio destino");
			}
		}

		if (FileUtil.existFile(destinationFolder.getAbsolutePath() + "\\" + file.getName())) {
			removeFile(destinationFolder.getAbsolutePath() + "\\" + file.getName());
		}

		return FileUtil.moveFile(file.getAbsolutePath(), destinationFolder.getAbsolutePath() + "\\" + file.getName());
	}

	public FileExchangeResponse moveFileToWorkFolder(File file) {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia moveFileToWorkFolder");
		}

		File workFolder = new File(this.workFolder);
		if (logger.isDebugEnabled()) {
			logger.debug("Ruta del archivo origen: " + file.getAbsolutePath());
			logger.debug("Ruta del archivo destino: " + workFolder.getAbsolutePath() + "\\" + file.getName());
		}

		if (!workFolder.exists()) {
			if (!workFolder.mkdirs()) {
				return new FileExchangeResponse(false, "No se pudo crear el directorio destino");
			}
		}

		if (FileUtil.existFile(workFolder.getAbsolutePath() + "\\" + file.getName())) {
			removeFile(workFolder.getAbsolutePath() + "\\" + file.getName());
		}

		return FileUtil.moveFile(file.getAbsolutePath(), workFolder.getAbsolutePath() + "\\" + file.getName());
	}

	public FileExchangeResponse copyFileToWorkFolder(File file) {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia moveFileToWorkFolder");
		}

		File workFolder = new File(this.workFolder);
		if (logger.isDebugEnabled()) {
			logger.debug("Ruta del archivo origen: " + file.getAbsolutePath());
			logger.debug("Ruta del archivo destino: " + workFolder.getAbsolutePath() + "\\" + file.getName());
		}

		if (!workFolder.exists()) {
			if (!workFolder.mkdirs()) {
				return new FileExchangeResponse(false, "No se pudo crear el directorio destino");
			}
		}

		if (FileUtil.existFile(workFolder.getAbsolutePath() + "\\" + file.getName())) {
			removeFile(workFolder.getAbsolutePath() + "\\" + file.getName());
		}

		return FileUtil.copyFile(file.getAbsolutePath(), workFolder.getAbsolutePath() + "\\" + file.getName());
	}

	FileExchangeResponse copyFilesPatternDeleteAndUpDirectory() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia copyFilesPatternDeleteAndUpDirectory");
		}

		boolean continueProcess = true;
		String internalError = null;

		File directory = new File(Util.validateDateFormat(sourceFolder));

		if (!directory.exists() || !directory.isDirectory()) {
			return new FileExchangeResponse(false, "No existe el directorio origen: " + sourceFolder);
		}

		String[] patterns = fileNamePattern.split("\\|");

		Collection fileCollection = FileUtils.listFiles(directory, new WildcardFileFilter(patterns[0]), null);
		for (int i = 1; i < patterns.length; i++) {
			fileCollection.addAll(FileUtils.listFiles(directory, new WildcardFileFilter(patterns[i]), null));
		}

		if (logger.isDebugEnabled()) {
			logger.debug("fileCollection: " + fileCollection.size());
		}

		if (fileCollection.size() == 0) {

			logger.debug("No existen archivos para copiar");
			// return new FileExchangeResponse(false, "No existen archivos para copiar");
		}
		if (fileCollection.size() > 0) {
			for (Object found : fileCollection) {
				String fileToCopy = ((File) found).getName();

				System.out.println("obeto a copiar" + fileToCopy);
				System.out.println("obeto a copiar version normal" + ((File) found).getName());

				if (!FileUtil.existFile(destinationFolder + "\\" + fileToCopy)) {
					logger.info("carpeta de origen para copia...." + workFolder + "\\" + fileToCopy);
					logger.info("carpeta de destino para copia..." + destinationFolder + "\\" + fileToCopy);
					FileUtil.copyFile(sourceFolder + "\\" + fileToCopy, destinationFolder + "\\" + fileToCopy);
				} else {
					logger.info("carpeta de origen para copia cuando existe el archivo...." + workFolder + "\\" + fileToCopy);
					logger.info("carpeta de origen para copia cuando existe el archivo...." + destinationFolder + "\\" + fileToCopy);
					removeFile(destinationFolder + "\\" + fileToCopy);
					FileUtil.copyFile(sourceFolder + "\\" + fileToCopy, destinationFolder + "\\" + fileToCopy);
				}

			}
		}

		return new FileExchangeResponse(continueProcess, internalError);
	}

	FileExchangeResponse copyFilesPatternDeleteAndUpDirectoryAndSource() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia copyFilesPatternDeleteAndUpDirectoryAndSource");
		}

		boolean continueProcess = true;
		String internalError = null;

		File directory = new File(sourceFolder);
		logger.debug("directory-->" + directory.getAbsolutePath());
		if (!directory.exists() || !directory.isDirectory()) {
			return new FileExchangeResponse(false, "No existe el directorio origen: " + sourceFolder);
		}

		File directoryDestination = new File(destinationFolder);
		logger.debug("sourceFolder-->" + destinationFolder);

		if (!directoryDestination.exists()) {
			if (!directoryDestination.mkdirs()) {
				return new FileExchangeResponse(false, "No se pudo crear el directorio destino" + destinationFolder);
			}
		}

		String[] patterns = fileNamePattern.split("\\|");

		Collection fileCollection = FileUtils.listFiles(directory, new WildcardFileFilter(patterns[0]), null);
		for (int i = 1; i < patterns.length; i++) {
			fileCollection.addAll(FileUtils.listFiles(directory, new WildcardFileFilter(patterns[i]), null));
		}

		if (logger.isDebugEnabled()) {
			logger.debug("fileCollection: " + fileCollection.size());
		}

		if (fileCollection.size() == 0) {

			logger.debug("No existen archivos para copiar");
			// return new FileExchangeResponse(false, "No existen archivos para copiar");
		}
		if (fileCollection.size() > 0) {
			for (Object found : fileCollection) {
				String fileToCopy = ((File) found).getName();

				System.out.println("objeto a copiar" + fileToCopy);
				System.out.println("objeto a copiar version normal" + ((File) found).getName());

				if (!FileUtil.existFile(destinationFolder + "\\" + fileToCopy)) {
					logger.info("carpeta de origen para copia...." + workFolder + "\\" + fileToCopy);
					logger.info("carpeta de destino para copia..." + destinationFolder + "\\" + fileToCopy);
					FileUtil.copyFile(sourceFolder + "\\" + fileToCopy, destinationFolder + "\\" + fileToCopy);
				} else {
					logger.info("carpeta de origen para copia cuando existe el archivo...." + workFolder + "\\" + fileToCopy);
					logger.info("carpeta de origen para copia cuando existe el archivo...." + destinationFolder + "\\" + fileToCopy);
					removeFile(destinationFolder + "\\" + fileToCopy);
					FileUtil.copyFile(sourceFolder + "\\" + fileToCopy, destinationFolder + "\\" + fileToCopy);
				}

			}
		}

		return new FileExchangeResponse(continueProcess, internalError);
	}

	public FileExchangeResponse copyFilesAndErrFilesPatternDeleteAndUpDirectoryAndSource() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia copyFilesPatternDeleteAndUpDirectoryAndSource");
		}

		boolean continueProcess = true;
		String internalError = null;

		File directory = new File(sourceFolder);
		logger.debug("directory-->" + directory.getAbsolutePath());
		if (!directory.exists() || !directory.isDirectory()) {
			return new FileExchangeResponse(false, "No existe el directorio origen: " + sourceFolder);
		}

		File directoryDestination = new File(destinationFolder);
		File historyFolder = new File(workFolder);
		if (!historyFolder.exists()) {
			historyFolder.mkdir();
		}

		logger.debug("sourceFolder-->" + destinationFolder);

		if (!directoryDestination.exists()) {
			if (!directoryDestination.mkdirs()) {
				return new FileExchangeResponse(false, "No se pudo crear el directorio destino" + destinationFolder);
			}
		}
		String[] patternsErr = fileErrNamePattern.split("\\|");
		Collection fileCollectionErrAndFiles = FileUtils.listFiles(directory, new WildcardFileFilter(patternsErr[0]), null);
		for (int i = 1; i < patternsErr.length; i++) {
			logger.debug("patternsErr >> " + patternsErr[i]);
			fileCollectionErrAndFiles.addAll(FileUtils.listFiles(directory, new WildcardFileFilter(patternsErr[i]), null));
		}

		String[] patterns = fileNamePattern.split("\\|");
		Collection fileCollection = FileUtils.listFiles(directory, new WildcardFileFilter(patterns[0]), null);
		for (int i = 1; i < patterns.length; i++) {
			fileCollection.addAll(FileUtils.listFiles(directory, new WildcardFileFilter(patterns[i]), null));
		}

		fileCollectionErrAndFiles.addAll(fileCollection);

		if (logger.isDebugEnabled()) {
			logger.debug("fileCollection: " + fileCollection.size());
		}

		if (fileCollection.size() == 0) {

			logger.debug("No existen archivos para copiar");
			// return new FileExchangeResponse(false, "No existen archivos para copiar");
		}

		if (fileCollectionErrAndFiles.size() == 0) {

			logger.debug("No existen archivos de error para copiar");
			// return new FileExchangeResponse(false, "No existen archivos para copiar");
		}

		if (fileCollection.size() > 0) {
			for (Object found : fileCollection) {
				String fileToCopy = ((File) found).getName();

				System.out.println("objeto a copiar" + fileToCopy);
				System.out.println("objeto a copiar version normal" + ((File) found).getName());

				if (!FileUtil.existFile(destinationFolder + "\\" + fileToCopy)) {
					logger.info("carpeta de destino para copia..." + destinationFolder + "\\" + fileToCopy);
					FileUtil.copyFile(sourceFolder + "\\" + fileToCopy, destinationFolder + "\\" + fileToCopy);
				} else {
					logger.info("carpeta de origen para copia cuando existe el archivo...." + destinationFolder + "\\" + fileToCopy);
					removeFile(destinationFolder + "\\" + fileToCopy);
					FileUtil.copyFile(sourceFolder + "\\" + fileToCopy, destinationFolder + "\\" + fileToCopy);
				}

			}
		}

		// Copia a históricos y eliminación de carpeta origen
		if (fileCollectionErrAndFiles.size() > 0) {

			for (Object found : fileCollectionErrAndFiles) {
				String fileToCopy = ((File) found).getName();

				System.out.println("Err objeto a copiar" + fileToCopy);
				System.out.println("Err objeto a copiar version normal" + ((File) found).getName());

				if (!FileUtil.existFile(workFolder + "\\" + fileToCopy)) {
					logger.info("carpeta de destino para copia..." + workFolder + "\\" + fileToCopy);
					FileUtil.copyFile(sourceFolder + "\\" + fileToCopy, workFolder + "\\" + fileToCopy);
					removeFile(sourceFolder + "\\" + fileToCopy);
				} else {
					logger.info("carpeta de origen para copia cuando existe el archivo...." + workFolder + "\\" + fileToCopy);
					removeFile(workFolder + "\\" + fileToCopy);
					FileUtil.copyFile(sourceFolder + "\\" + fileToCopy, workFolder + "\\" + fileToCopy);
					removeFile(sourceFolder + "\\" + fileToCopy);
				}

			}
		}

		return new FileExchangeResponse(continueProcess, internalError);
	}

	public FileExchangeResponse removeFiletoHistoryIfExiste() {

		if (logger.isDebugEnabled()) {
			logger.debug("Inicia removeFiletoHistoryIfExiste");
		}

		File historyFolder = new File(workFolder + "\\history");
		logger.debug("Arrchivo a eliminar si existe en historicos... " + historyFolder.getAbsolutePath() + "\\" + zipFileNameHistory);
		if (FileUtil.existFile(historyFolder.getAbsolutePath() + "\\" + zipFileNameHistory)) {
			logger.debug("Ingresa a eliminar si existe en historicos.. " + historyFolder.getAbsolutePath() + "\\" + zipFileNameHistory);
			File file = new File(historyFolder.getAbsolutePath() + "\\" + zipFileNameHistory);
			file.delete();
		}

		return new FileExchangeResponse(true, null);
	}

	FileExchangeResponse zipSourceFolder() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia zipSourceFolder");
		}

		return FileUtil.zipFolder(sourceFolder, workFolder + "\\" + zipFileName);
	}

	FileExchangeResponse moveZipFile() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia copyZipFile");
		}

		return FileUtil.moveFile(workFolder + "\\" + zipFileName, destinationFolder + "\\" + zipFileName);
	}

	FileExchangeResponse getZipFile() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia getZipFile");
		}

		return FileUtil.moveFile(sourceFolder + "\\" + zipFileName, workFolder + "\\" + zipFileName);
	}

	FileExchangeResponse unzipFile() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia unzipFile");
		}

		FileExchangeResponse fileExchangeResponse = FileUtil.unzipFile(workFolder + "\\" + zipFileName, destinationFolder);

		if (fileExchangeResponse.isSuccess()) {
			fileExchangeResponse = moveZipFileToHistory();
		}

		if (fileExchangeResponse.isSuccess()) {
			fileExchangeResponse = removeFile(workFolder + "\\" + zipFileName);
		}

		return fileExchangeResponse;
	}

	public void encryptRSAAndMoveFile(String pvtKeyFile) {
		String fileToEncrypt = this.workFolder + "\\" + this.fileNamePattern;
		if (logger.isDebugEnabled()) {
			logger.debug("FILE TO ENCRYPT: " + fileToEncrypt);
		}
		try {
			CryptoUtils.encryptFileRSAWithAES(pvtKeyFile, fileToEncrypt);
			renameEncryptedFile(fileToEncrypt);
			if (logger.isDebugEnabled()) {
				logger.debug("MOVER ARCHIVO ENCRIPTADO: " + fileToEncrypt);
			}
			moveFileToDestination(new File(fileToEncrypt));
		} catch (CryptoException ce) {
			logger.error("Error al encryptar archivo", ce);
		} catch (Exception e) {
			logger.error("Error al encryptar y mover archivo:", e);
		}

	}

	private static void renameEncryptedFile(String fileOrigin) throws IOException {
		File file = new File(fileOrigin.replace(".txt", ".enc"));
		File file2 = new File(fileOrigin);

		if (file.exists()) {
			if (logger.isDebugEnabled()) {
				logger.debug("Existe archivo: " + file.getName());
			}
		}

		if (file2.exists()) {
			if (logger.isDebugEnabled()) {
				logger.debug("Se elimina archivo de trabajo: " + file2.getName());
			}
			file2.delete();
		}
		if (!file2.exists()) {
			if (logger.isDebugEnabled()) {
				logger.debug("No existe archivo: " + file2.getName());
			}
			file2 = new File(fileOrigin);
		}

		if (file.renameTo(file2)) {
			if (logger.isDebugEnabled()) {
				logger.debug("Se renombro el archivo");
			}
		} else {
			if (logger.isDebugEnabled()) {
				logger.debug("No de pudo renombrar el archivo");
			}
		}
	}

	public FileExchangeResponse listZipFilesPattern(String pattern) {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia listZipFiles");
		}
		System.out.println("Ingresa");
		FileExchangeResponse fileExchangeResponse = null;
		boolean continueProcess = true;
		String internalError = null;

		File directory = new File(sourceFolder);

		if (!directory.exists() || !directory.isDirectory()) {

			logger.debug("No existe el directorio origen: " + sourceFolder);
			// return new FileExchangeResponse(false, "No existe el directorio origen: " + sourceFolder);
		}

		logger.debug("Ingresa" + directory.getAbsolutePath());

		/*
		 * String[] patterns = fileNamePattern.split("\\|"); logger.debug("patterns" + patterns); for (int i = 0; i < patterns.length; i++) {
		 * logger.debug("patterns" + i + "" + patterns[i]); }
		 */

		Collection fileCollection = FileUtils.listFiles(directory, new WildcardFileFilter(pattern), null);
		/*
		 * for (int i = 1; i < patterns.length; i++) { fileCollection.addAll(FileUtils.listFiles(directory, new WildcardFileFilter(patterns[i]),
		 * null));
		 * 
		 * }
		 */

		if (fileCollection.size() == 0) {
			logger.debug("No existen archivos en el dierectorio : " + sourceFolder + " para " + pattern);
			// return new FileExchangeResponse(false, "No existen archivos para copiar");
		}

		/*
		 * for (Object found : fileCollection) { String fileToZip = ((File) found).getName(); logger.debug("obeto a ziper" + ((File)
		 * found).getName()); }
		 */
		File[] fileList = new File[fileCollection.size()];
		int iterador = 0;
		for (Object found : fileCollection) {
			String fileToZip = ((File) found).getName();
			logger.debug("obeto a ziper" + ((File) found).getName());
			fileList[iterador] = (File) found;
			iterador = iterador + 1;
			logger.debug("iterador++  " + iterador);
		}

		for (int i = 0; i < fileList.length; i++) {

			String fileToZip = getFileNamewithoutExtension(fileList[i]);
			File zipFile = new File(destinationFolder + "\\" + fileToZip + ".zip");
			logger.debug("Nombre de1 archivo a  zipear--  " + zipFile.getName());
			ZipOutputStream out = null;
			FileInputStream in = null;

			try {

				try {
					out = new ZipOutputStream(new FileOutputStream(zipFile));
				} catch (FileNotFoundException e) {
					logger.error(e.toString());
					logger.debug("No existe el directorio destinationFolder o no tiene acceso:");
					internalError = "No se pudo crear el archivo para empaquetar los archivos de origen";
					continueProcess = false;

				}

				if (continueProcess) {

					byte[] buf = new byte[1024];

					// compress the files

					try {
						in = new FileInputStream(fileList[i].getCanonicalFile());
					} catch (IOException e) {
						logger.error(e.toString());
						throw new COBISInfrastructureRuntimeException("No se pudo obtener el archivo " + fileToZip);
					}

					// add ZIP entry to output stream
					try {
						out.putNextEntry(new ZipEntry(fileList[i].getName()));
					} catch (IOException e) {
						logger.error(e.toString());
						throw new COBISInfrastructureRuntimeException("No se pudo iniciar el empaquetamiento del archivo " + fileToZip);
					}

					// transfer bytes from the file to the ZIP file
					int len;
					while ((len = in.read(buf)) > 0) {
						try {
							out.write(buf, 0, len);
						} catch (IOException e) {
							logger.error(e.toString());
							throw new COBISInfrastructureRuntimeException("No se pudo leer el archivo " + fileList[i].getName() + " para empaquetarlo");
						}
					}

					// complete the entry
					try {
						in.close();
					} catch (IOException e) {
						logger.error(e.toString());
						throw new COBISInfrastructureRuntimeException("No se pudo cerrar el archivo " + fileList[i].getName());
					}

					try {
						out.closeEntry();
					} catch (IOException e) {
						logger.error(e.toString());
						throw new COBISInfrastructureRuntimeException("No se pudo cerrar la entrada del empaquetado correspondiente a " + fileList[i].getName());
					}

					try {
						out.close();
					} catch (IOException e) {
						logger.error(e.toString());
						throw new COBISInfrastructureRuntimeException("No se pudo cerrar el archivo " + zipFile.getName());
					}

					fileExchangeResponse = moveFileToHistory(fileList[i]);
					fileExchangeResponse = removeFile(fileList[i].getPath());

				}
			} catch (IOException e) {
				logger.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se pudo crear el empaquetado " + zipFile.getName());
			} finally {
				if (in != null) {
					try {
						in.close();
					} catch (IOException e) {
						internalError = "No se pudo cerrar el archivo a empaquetarse";
						continueProcess = false;
					}
				}
				if (out != null) {
					try {
						out.close();
					} catch (IOException e) {
						internalError = "No se pudo cerrar el archivo " + zipFile.getName();
						continueProcess = false;
					}
				}
			}

		}

		return new FileExchangeResponse(true, null);
	}

	synchronized FileExchangeResponse getConfigurationR(ReporteDTO inforForReport) {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia FileJob-->>getConfigurationR");
		}

		boolean continueProcess = true;
		String internalError = null;

		if (!propertiesLoaded) {
			try {
				workFolder = inforForReport.getWorkFolderD();
				sourceFolder = inforForReport.getSourceFolderD();
				destinationFolder = inforForReport.getDestinationFolder();
				fileNamePattern = inforForReport.getReportNameD();
				zipFileName = "";
				zipFileNameHistory = "";
				fileErrNamePattern = "";
				method = "0";

				if (logger.isDebugEnabled()) {
					logger.debug("workFolder: " + workFolder);
					logger.debug("sourceFolder: " + sourceFolder);
					logger.debug("destinationFolder: " + destinationFolder);
					logger.debug("fileNamePattern: " + fileNamePattern);
				}

				sourceFolder = Util.validateDateFormat(sourceFolder);
				workFolder = Util.validateDateFormat(workFolder);
				destinationFolder = Util.validateDateFormat(destinationFolder);
				fileNamePattern = Util.validateDateFormat(fileNamePattern);

				if (logger.isDebugEnabled()) {
					logger.debug("workFolder: " + workFolder);
					logger.debug("sourceFolder: " + sourceFolder);
					logger.debug("destinationFolder: " + destinationFolder);
					logger.debug("fileNamePattern: " + fileNamePattern);
				}

				propertiesLoaded = true;
			} finally {
				if (logger.isDebugEnabled()) {
					logger.debug("Finaliza FileJob-->>getConfigurationR");
				}
			}
		}

		return new FileExchangeResponse(continueProcess, internalError);
	}
}
