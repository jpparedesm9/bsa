package com.cobiscorp.cloud.scheduler.utils;

import static com.cobiscorp.cloud.scheduler.utils.FileUtil.existFile;
import static com.cobiscorp.cloud.scheduler.utils.FileUtil.removeFolder;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

import org.apache.log4j.Logger;

import com.cobiscorp.cloud.notificationservice.dto.report.ReporteDTO;
import com.cobiscorp.cloud.notificationservice.key.CryptoFiles;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;

public class CopyFileJob extends FileJob {
	private static final Logger logger = Logger.getLogger(FileJob.class);

	public CopyFileJob(Job process) {
		super(process);
		getConfiguration();
	}

	public FileExchangeResponse copyFiles() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia copyFiles");
		}

		FileExchangeResponse fileExchangeResponse = null;

		if (!existZipFile()) {
			fileExchangeResponse = zipFiles();

			if (fileExchangeResponse.isSuccess()) {
				fileExchangeResponse = copyZipFile();
			}

			if (fileExchangeResponse.isSuccess()) {
				fileExchangeResponse = moveZipFileToHistory();
			}
		} else {
			fileExchangeResponse = new FileExchangeResponse(true, null);
			logger.info("Los archivos ya fueron procesados anteriormente");
		}

		return fileExchangeResponse;
	}

	public FileExchangeResponse copyFilesNormal() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia copyFilesNormal");
		}

		return copyFilesPatternDirectory();
	}

	public FileExchangeResponse copyFilesChangefileNamePattern(String fileNamePattern) {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia copyFiles");
		}

		setFileNamePattern(fileNamePattern);
		logger.debug("getFileNamePattern();" + getFileNamePattern());

		FileExchangeResponse fileExchangeResponse = null;

		if (!existZipFile()) {
			fileExchangeResponse = zipFiles();

			if (fileExchangeResponse.isSuccess()) {
				fileExchangeResponse = copyZipFile();
			}

			if (fileExchangeResponse.isSuccess()) {
				fileExchangeResponse = moveZipFileToHistory();
			}
		} else {
			fileExchangeResponse = new FileExchangeResponse(true, null);
			logger.info("Los archivos ya fueron procesados anteriormente");
		}

		return fileExchangeResponse;
	}

	public FileExchangeResponse copyFilesDelete() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia copyFilesDelete");
		}

		File[] fileList = zipFileList();

		FileExchangeResponse fileExchangeResponse = null;

		if (fileList.length != 0) {
			for (int x = 0; x < fileList.length; x++) {
				fileExchangeResponse = removeFile(fileList[x].getPath());
			}
		}

		if (fileList.length != 0) {
			fileExchangeResponse = copyZipFile();
		}

		if (fileExchangeResponse.isSuccess()) {
			fileExchangeResponse = moveZipFileToHistory();
		}

		return fileExchangeResponse;
	}

	public void sendMail(String messageOk) {
		super.sendMail(messageOk);
	}

	public FileExchangeResponse unzipFile() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia unzipFile");
		}

		FileExchangeResponse fileExchangeResponse = FileUtil.unzipFile(getDestinationFolder() + "\\" + getZipFileName());

		if (fileExchangeResponse.isSuccess()) {
			fileExchangeResponse = removeFile(getDestinationFolder() + "\\" + getZipFileName());
		}

		return fileExchangeResponse;
	}

	public FileExchangeResponse unzipFileToDestinationFolder() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia unzipFileToDestinationFolder");
		}

		return FileUtil.unzipFile(getSourceFolder() + "\\" + getZipFileName(), getDestinationFolder());
	}

	public FileExchangeResponse moveZippedFolder() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia moveZippedFolder");
		}

		FileExchangeResponse fileExchangeResponse = zipSourceFolder();

		if (fileExchangeResponse.isSuccess()) {
			fileExchangeResponse = moveZipFile();
		}

		if (fileExchangeResponse.isSuccess()) {
			fileExchangeResponse = removeFolder(getSourceFolder());
		}

		return fileExchangeResponse;
	}

	public FileExchangeResponse moveFileToUnzip() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia moveFileToUnzip");
		}

		FileExchangeResponse fileExchangeResponse = new FileExchangeResponse(true, "");

		if (!existFile(getSourceFolder() + "\\" + getZipFileName())) {
			fileExchangeResponse.setSuccess(false);
			fileExchangeResponse.setErrorMessage("No existe ningún archivo empaquetado para realizar el proceso");
		}

		if (fileExchangeResponse.isSuccess()) {
			fileExchangeResponse = getZipFile();
		}

		if (fileExchangeResponse.isSuccess()) {
			fileExchangeResponse = super.unzipFile();
		}

		return fileExchangeResponse;
	}

	public FileExchangeResponse copyFilesZip() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia copyFilesZip");
		}

		FileExchangeResponse fileExchangeResponse = null;
		File[] fileList = null;

		fileExchangeResponse = listZipFiles();

		/*
		 * if (fileList.length != 0) { for (int i = 0; i < fileList.length; i++) { fileExchangeResponse = moveFileToHistory(fileList[i]); } }
		 * 
		 * if (fileList.length != 0) { for (int x = 0; x < fileList.length; x++) { fileExchangeResponse = removeFile(fileList[x].getPath()); } }
		 */

		return fileExchangeResponse;
	}

	public FileExchangeResponse moveFileToHIstory(File file) {
		if (logger.isDebugEnabled()) {
			logger.debug("moveFileToHIstory File file");
		}

		return moveFileToDestination(file);
	}

	public File[] getListFilesPattern() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia getListFilesPattern");
		}

		return getlistFiles();
	}

	public FileExchangeResponse copyFilesToDestinationAndHistory() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia copyFilesToDestinationAndHistory");
		}

		FileExchangeResponse fileExchangeResponse = null;
		File[] fileList = getlistFiles();

		logger.debug("realizo la copia de archivos");
		logger.debug("fileList.length0.." + fileList.length);
		fileExchangeResponse = copyFilesPatternDeleteAndUpDirectory();

		logger.debug("fileList.length1.." + fileList.length);
		if (fileList.length != 0) {
			for (int i = 0; i < fileList.length; i++) {

				logger.debug("fileList.length1.." + fileList[i].getName());
				fileExchangeResponse = moveFileToHistory(fileList[i]);
			}
		}
		logger.debug("fileList.length2.." + fileList.length);
		if (fileList.length != 0) {
			for (int x = 0; x < fileList.length; x++) {
				logger.debug("fileList.length2.." + fileList[x].getName());
				fileExchangeResponse = removeFile(fileList[x].getPath());
			}
		}

		return fileExchangeResponse;
	}

	public FileExchangeResponse copyFilesToDestinationAndHistorySource() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia copyFilesToDestinationAndHistorySource");
		}

		FileExchangeResponse fileExchangeResponse = null;
		File[] fileList = getlistFiles();

		logger.debug("realizo la copia de archivos");
		logger.debug("fileList.length0.." + fileList.length);
		fileExchangeResponse = copyFilesPatternDeleteAndUpDirectoryAndSource();

		logger.debug("fileList.length1.." + fileList.length);
		if (fileList.length != 0) {
			for (int i = 0; i < fileList.length; i++) {

				logger.debug("fileList.length1.." + fileList[i].getName());
				fileExchangeResponse = moveFileToHistory(fileList[i]);
			}
		}
		logger.debug("fileList.length2.." + fileList.length);
		if (fileList.length != 0) {
			for (int x = 0; x < fileList.length; x++) {
				logger.debug("fileList.length2.." + fileList[x].getName());
				fileExchangeResponse = removeFile(fileList[x].getPath());
			}
		}

		return fileExchangeResponse;
	}

	public FileExchangeResponse copyFilesToDestinationAndHistoryandError() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia copyFilesToDestinationAndHistory");
		}

		FileExchangeResponse fileExchangeResponse = null;
		File[] fileList = getlistFiles();

		logger.debug("realizo la copia de archivos");
		logger.debug("fileList.length0.." + fileList.length);
		fileExchangeResponse = copyFilesPatternDeleteAndUpDirectory();

		logger.debug("fileList.length1.." + fileList.length);
		if (fileList.length != 0) {
			for (int i = 0; i < fileList.length; i++) {

				logger.debug("fileList.length1.." + fileList[i].getName());
				fileExchangeResponse = moveFileToHistory(fileList[i]);

				String nameError = fileList[i].getName();
				nameError = nameError.replace(".xls", ".err");
				File fileError = new File(fileList[i].getParent() + "//" + nameError);

				if (fileError.exists()) {
					logger.debug("fileError.." + fileError.getAbsolutePath());
					fileExchangeResponse = moveFileToHistory(fileError);
				}

			}
		}
		logger.debug("fileList.length2.." + fileList.length);
		if (fileList.length != 0) {
			for (int x = 0; x < fileList.length; x++) {
				logger.debug("fileList.length2.." + fileList[x].getName());
				fileExchangeResponse = removeFile(fileList[x].getPath());
				String nameErrorDelete = fileList[x].getName();
				nameErrorDelete = nameErrorDelete.replace(".xls", ".err");
				File fileErrorDelete = new File(fileList[x].getParent() + "//" + nameErrorDelete);

				if (fileErrorDelete.exists()) {
					logger.debug("fileErrorDelete.." + fileErrorDelete.getAbsolutePath());
					fileExchangeResponse = moveFileToHistory(fileErrorDelete);
				}

			}
		}

		return fileExchangeResponse;
	}

	public FileExchangeResponse copyFilesToCryptoAndHistoryandError(String path, String extension, String extensionNueva) {
		if (logger.isDebugEnabled()) {
			logger.debug("Start copyFilesToDestinationCryptoAndHistoryandError");
		}

		boolean continueProcess;

		FileExchangeResponse fileExchangeResponse = null;

		// Listado de archivos
		File[] fileList = getlistFiles();

		if (logger.isDebugEnabled()) {
			logger.debug("Number of files to process: " + fileList.length);

		}
		if (fileList.length == 0) {
			logger.debug("There are no files to process");
			return new FileExchangeResponse(true, "There are no files to process");
		}

		// Encripto el archivo
		if (fileList.length != 0) {
			for (int i = 0; i < fileList.length; i++) {

				String nameBeforeFile = fileList[i].getName();
				String pathBeforeFile = path + File.separator + nameBeforeFile;
				String nameAfterFile = fileList[i].getName().replace("_N" + extension, extension);
				String pathAfterFile = path + File.separator + nameAfterFile;

				// Nombre de archivos a mover y eliminar
				String nameErrorFile = fileList[i].getName().replace(extension, extensionNueva);
				String pathErrorFile = path + File.separator + nameErrorFile;

				if (logger.isDebugEnabled()) {
					logger.debug("File Origin: [" + i + "] " + nameBeforeFile);
					logger.debug("Path Origin: [" + i + "] " + pathBeforeFile);
					logger.debug("File Destine: [" + i + "] " + nameAfterFile);
					logger.debug("Path Destine: [" + i + "] " + pathAfterFile);
					logger.debug("File Error: [" + i + "] " + nameErrorFile);
					logger.debug("Path Error: [" + i + "] " + pathErrorFile);

				}

				CryptoFiles cf = new CryptoFiles();
				continueProcess = cf.cryotoFile("E", pathBeforeFile, pathAfterFile);

				if (logger.isDebugEnabled()) {
					logger.debug("Continue process: " + continueProcess);
				}

				if (continueProcess) {

					File fileError = new File(pathErrorFile);

					// Mover a historicos

					if (fileError.exists()) {
						logger.debug("Error file name to move: [" + i + "] " + fileError.getAbsolutePath());
						fileExchangeResponse = moveFileToHistory(fileError);
					}

					if (fileList[i].exists()) {
						if (logger.isDebugEnabled()) {
							logger.debug("Name of files to move: [" + i + "] " + fileList[i].getName());
						}
						fileExchangeResponse = moveFileToHistory(fileList[i]);

					}

					if (fileError.exists()) {
						logger.debug("Error file name to delete: [" + i + "] " + fileError.getPath());
						fileExchangeResponse = removeFile(fileError.getPath());
					}

					if (fileList[i].exists()) {
						if (logger.isDebugEnabled()) {
							logger.debug("Name of files to delete: [" + i + "] " + fileList[i].getName());
						}
						fileExchangeResponse = removeFile(fileList[i].getPath());

					}

				} else {
					logger.error("Error encrypting files");
				}

			}

		}

		if (logger.isDebugEnabled()) {
			logger.debug("End copyFilesToDestinationCryptoAndHistoryandError");
		}

		return fileExchangeResponse;
	}

	/* Decodificar ARchivos Mc Collect */
	public FileExchangeResponse copyFilesToDeCryptoAndHistory(String path, String extension) {
		if (logger.isDebugEnabled()) {
			logger.debug("Start copyFilesToDeCryptoAndHistory");
		}

		boolean continueProcess;

		FileExchangeResponse fileExchangeResponse = null;

		// Listado de archivos
		File[] fileList = getlistFiles();

		if (logger.isDebugEnabled()) {
			logger.debug("Number of files to process and Decrypt: " + fileList.length);

		}
		if (fileList.length == 0) {
			logger.debug("There are no files to process");
			return new FileExchangeResponse(true, "There are no files to process");
		}

		// Encripto el archivo
		if (fileList.length != 0) {
			for (int i = 0; i < fileList.length; i++) {

				String nameBeforeFile = fileList[i].getName();
				String pathBeforeFile = path + File.separator + nameBeforeFile;
				String nameAfterFile = fileList[i].getName().replace(extension, "_D" + extension);
				String pathAfterFile = path + File.separator + nameAfterFile;

				// Nombre de archivos a mover y eliminar
				// String nameErrorFile =
				// fileList[i].getName().replace(extension, extensionNueva);
				// String pathErrorFile = path + File.separator + nameErrorFile;

				if (logger.isDebugEnabled()) {
					logger.debug("File Origin: [" + i + "] " + nameBeforeFile);
					logger.debug("Path Origin: [" + i + "] " + pathBeforeFile);
					logger.debug("File Destine: [" + i + "] " + nameAfterFile);
					logger.debug("Path Destine: [" + i + "] " + pathAfterFile);
					// logger.debug("File Error: [" + i + "] " + nameErrorFile);
					// logger.debug("Path Error: [" + i + "] " + pathErrorFile);

				}

				CryptoFiles cf = new CryptoFiles();
				continueProcess = cf.cryotoFile("D", pathBeforeFile, pathAfterFile);

				if (logger.isDebugEnabled()) {
					logger.debug("Continue process: " + continueProcess);
				}

				if (continueProcess) {

					// File fileError = new File(pathErrorFile);

					// Mover a historicos

					/*
					 * if (fileError.exists()) { logger.debug("Error file name to move: [" + i + "] " + fileError.getAbsolutePath());
					 * fileExchangeResponse = moveFileToHistory(fileError); }
					 */

					if (fileList[i].exists()) {
						if (logger.isDebugEnabled()) {
							logger.debug("Name of files to move: [" + i + "] " + fileList[i].getName());
						}
						fileExchangeResponse = moveFileToHistory(fileList[i]);

					}

					/*
					 * if (fileError.exists()) { logger.debug("Error file name to delete: [" + i + "] " + fileError.getPath()); fileExchangeResponse =
					 * removeFile(fileError.getPath()); }
					 */

					if (fileList[i].exists()) {
						if (logger.isDebugEnabled()) {
							logger.debug("Name of files to delete: [" + i + "] " + fileList[i].getName());
						}
						fileExchangeResponse = removeFile(fileList[i].getPath());

					}

				} else {
					logger.error("Error al decrypting files");
				}

			}

		}

		if (logger.isDebugEnabled()) {
			logger.debug("End copyFilesToDeCryptoAndHistory");
		}

		return fileExchangeResponse;
	}

	/* Cargar Datos en la base de datos */
	public FileExchangeResponse cargaDataMcCopyFilesAndHistory() {
		if (logger.isDebugEnabled()) {
			logger.debug("Start cargaDataCopyFilesAndHistory");
		}

		boolean continueProcess;
		String internalError = null;

		FileExchangeResponse fileExchangeResponse = null;

		// Listado de archivos
		File[] fileList = getlistFiles();

		if (logger.isDebugEnabled()) {
			logger.debug("Number of files to process and Decrypt: " + fileList.length);

		}
		if (fileList.length == 0) {
			logger.debug("There are no files to process");
			return new FileExchangeResponse(true, "There are no files to process");
		}
		/* LOAD BLACK LIST INFORMATION TO DATABASE */
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa a ejecutar sp sp_carga_cobis_mc");
		}

		Connection cn = null;
		CallableStatement executeSP = null;
		try {
			if (fileList.length != 0) {
				for (int i = 0; i < fileList.length; i++) {

					try {
						cn = ConnectionManager.newConnection();
					} catch (SQLException e) {
						logger.error(e.toString());
						internalError = "No se pudo establecer la conexi\u00f3n a la base de datos A";
						return new FileExchangeResponse(false, internalError);
					} catch (Exception e) {
						logger.error("Exception: ", e);
						internalError = "No se pudo establecer la conexi\u00f3n a la base de datos B";
						return new FileExchangeResponse(false, internalError);
					}
					if (logger.isDebugEnabled()) {
						logger.debug("Se estableci\u00f3 la conexi\u00f3n a la base de datos");
					}

					String query = "{ ? = call cob_conta_super..sp_carga_cobis_mc(?) }";

					if (internalError == null) {
						try {
							executeSP = cn != null ? cn.prepareCall(query) : null;
						} catch (SQLException e) {
							logger.error(e.toString());
							internalError = "No se pudo preparar la sentencia SQL para cargar la informaci\u00f3n de Mc COllect";
							return new FileExchangeResponse(false, internalError);
						}
						if (logger.isDebugEnabled()) {
							logger.debug("Se preparó la sentencia SQL para la carga de información de Mc Collect");
						}
					}

					if (internalError == null) {
						try {
							if (executeSP != null) {
								logger.error("Nombre del Archivo parametro de entrada" + fileList[i].getName());
								executeSP.registerOutParameter(1, Types.INTEGER);
								executeSP.setString(2, fileList[i].getName());
							}
						} catch (SQLException e) {
							logger.error(e.toString());
							internalError = "No se pudo registrar el valor de retorno del procedimiento SQL";
							return new FileExchangeResponse(false, internalError);
						}
					}

					if (internalError == null) {
						try {
							if (executeSP != null) {
								executeSP.execute();
							}
						} catch (SQLException e) {
							logger.error(e.toString());
							internalError = "No se pudo cargar la informaci\u00f3n de MC Collect en la base de datos.";
							return new FileExchangeResponse(false, internalError);
						}
						if (logger.isDebugEnabled()) {
							logger.debug("Se ejecutó el proceso de carga de información de Mc Collect en la base de datos");
						}
					}

					if (internalError == null) {
						Integer returnValue = null;
						try {
							if (executeSP != null) {
								logger.debug("executeSP: " + executeSP);
								returnValue = executeSP.getInt(1);
							}
						} catch (SQLException e) {
							logger.error(e.toString());
							return new FileExchangeResponse(false, internalError);
						}
						if (logger.isDebugEnabled()) {
							logger.debug("Valor de retorno del procedimiento de carga de Mc Collect: " + (returnValue != null ? returnValue.toString() : null));
						}

						if (returnValue != null && returnValue != 0) {

							internalError = "No se pudo realizar la carga de la nueva información del archivo recibido por Mc collect.";
							return new FileExchangeResponse(false, internalError);

						}
					}

					logger.debug("internal A-->: " + internalError);
					if (internalError == null) {
						logger.debug("Pasoa: ");
						if (fileList[i].exists()) {
							if (logger.isDebugEnabled()) {
								logger.debug("Name of files to move: [" + i + "] " + fileList[i].getName());
							}
							logger.debug("Pasob: ");
							fileExchangeResponse = moveFileToHistory(fileList[i]);

						}

						if (fileList[i].exists()) {
							if (logger.isDebugEnabled()) {
								logger.debug("Name of files to delete: [" + i + "] " + fileList[i].getName());
							}
							fileExchangeResponse = removeFile(fileList[i].getPath());

						}

					}
					logger.debug("internal B-->: " + internalError);

				}
			}
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				logger.error("Error al cerrar la conexión: ", e);
			}
		}

		return fileExchangeResponse;
	}

	/**
	 * Mueve todos los archivos de la carpeta origen a la carpeta destino
	 */
	@Override
	public FileExchangeResponse moveFiles() {
		return super.moveFiles();
	}

	public FileExchangeResponse copyFilesZipPattern(String pattern) {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia copyFilesZipPattern");
		}

		FileExchangeResponse fileExchangeResponse = null;
		File[] fileList = null;

		fileExchangeResponse = listZipFilesPattern(pattern);

		return fileExchangeResponse;
	}

	// Reporte Generico
	public CopyFileJob(Job process, ReporteDTO inforForReport) {
		super(process);
		getConfigurationR(inforForReport);
	}
}
