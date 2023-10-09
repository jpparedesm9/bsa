package com.cobiscorp.cloud.scheduler.utils;

import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;

import java.io.*;
import java.nio.channels.FileChannel;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

public abstract class FileUtil {
	private static final Logger logger = Logger.getLogger(FileUtil.class);

	private static final int BUFFER_SIZE = 4096;

	public static boolean existFile(String filePath) {
		File f = new File(filePath);
		return (f.exists() && !f.isDirectory());
	}

	public static FileExchangeResponse copyFile(String srcFilePathName, String dstFilePathName) {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia copyFile");
		}

		boolean continueProcess = true;
		String internalError = null;

		FileChannel srcFileChannel = null;
		FileChannel dstFileChannel = null;
		File srcFile;

		try {

			srcFile = new File(srcFilePathName);

			try {
				srcFileChannel = new FileInputStream(srcFile).getChannel();
			} catch (FileNotFoundException e) {
				logger.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se puede encontrar el archivo " + srcFilePathName);
			}

			try {
				dstFileChannel = new FileOutputStream(dstFilePathName).getChannel();
			} catch (FileNotFoundException e) {
				logger.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se puede encontrar el destino " + dstFilePathName);
			}

			try {
				dstFileChannel.transferFrom(srcFileChannel, 0, srcFileChannel.size());
			} catch (IOException e) {
				logger.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se puede copiar el archivo " + srcFilePathName + " a " + dstFilePathName);
			}
			if (logger.isDebugEnabled()) {
				logger.debug("Se copi\u00f3 el archivo " + srcFilePathName + " a " + dstFilePathName);
			}

		} finally {
			if (srcFileChannel != null) {
				try {
					srcFileChannel.close();
				} catch (IOException e) {
					logger.error(e.toString());
					internalError = "No se pudo cerrar el canal de lectura del archivo de origen: " + srcFilePathName;
					continueProcess = false;
				}
			}
			if (dstFileChannel != null) {
				try {
					dstFileChannel.close();
				} catch (IOException e) {
					logger.error(e.toString());
					internalError = "No se pudo cerrar el canal de escritura del archivo de destino: " + dstFilePathName;
					continueProcess = false;
				}
			}
		}

		return new FileExchangeResponse(continueProcess, internalError);
	}

	public static FileExchangeResponse moveFile(String srcFilePathName, String dstFilePathName) {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia moveFile");
			logger.debug("srcFilePathName: " + srcFilePathName);
			logger.debug("dstFilePathName: " + dstFilePathName);
		}

		boolean continueProcess = true;
		String internalError = null;

		File srcFile = new File(srcFilePathName);
		if (srcFile.renameTo(new File(dstFilePathName))) {
			if (logger.isDebugEnabled()) {
				logger.debug("Se movi\u00f3 el archivo " + srcFilePathName + " a " + dstFilePathName);
			}
		} else {
			internalError = "No se pudo mover el archivo " + srcFilePathName + " a " + dstFilePathName;
			continueProcess = false;
		}

		return new FileExchangeResponse(continueProcess, internalError);
	}

	public static FileExchangeResponse unzipFile(String zipFilePath, String destDirectory) {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia unzipFile");
		}

		boolean continueProcess = true;
		String internalError = null;

		ZipInputStream zipIn = null;
		try {
			File destDir = new File(destDirectory);
			if (!destDir.exists()) {
				destDir.mkdir();
			}

			try {
				zipIn = new ZipInputStream(new FileInputStream(zipFilePath));
			} catch (FileNotFoundException e) {
				logger.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se pudo encontrar el archivo: " + zipFilePath);
			}

			ZipEntry entry = null;
			try {
				entry = zipIn.getNextEntry();
			} catch (IOException e) {
				logger.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se pudo leer la siguiente entrada del archivo: " + zipFilePath);
			}
			// iterates over entries in the zip file
			while (entry != null) {
				String filePath = destDirectory + File.separator + entry.getName();
				if (!entry.isDirectory()) {
					// if the entry is a file, extracts it
					new File(filePath).getParentFile().mkdirs();
					try {
						extractFile(zipIn, filePath);
					} catch (IOException e) {
						logger.error(e.toString());
						throw new COBISInfrastructureRuntimeException("No se pudo extraer el archivo " + filePath + " del empaquetado: " + zipFilePath);
					}
					System.out.println(filePath);
				} else {
					// if the entry is a directory, make the directory
					File dir = new File(filePath);
					System.out.println(filePath);
					dir.mkdirs();
				}
				try {
					zipIn.closeEntry();
				} catch (IOException e) {
					logger.error(e.toString());
					throw new COBISInfrastructureRuntimeException("No se pudo cerrar la entrada actual del empaquetado: " + zipFilePath);
				}
				try {
					entry = zipIn.getNextEntry();
				} catch (IOException e) {
					logger.error(e.toString());
					throw new COBISInfrastructureRuntimeException("No se pudo leer la siguiente entrada del archivo: " + zipFilePath);
				}
			}
			try {
				zipIn.close();
			} catch (IOException e) {
				logger.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se pudo cerrar el archivo: " + zipFilePath);
			}
		} finally {
			if (zipIn != null) {
				try {
					zipIn.close();
				} catch (IOException e) {
					logger.error(e.toString());
					internalError = "No se pudo cerrar el archivo: " + zipFilePath;
					continueProcess = false;
				}
			}
		}

		return new FileExchangeResponse(continueProcess, internalError);
	}

	public static FileExchangeResponse unzipFile(String srcZipFilePathName) {
		return unzipFile(srcZipFilePathName, (new File(srcZipFilePathName)).getParent());
	}

	public static FileExchangeResponse removeFile(String filePathName) {
		if (logger.isDebugEnabled()) {
			logger.debug("removeFile");
		}

		File file = new File(filePathName);
		file.delete();

		return new FileExchangeResponse(true, null);
	}

	public static FileExchangeResponse zipFolder(String sourceFolder, String zipFile) {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia zipFolder");
		}

		boolean continueProcess = true;
		String internalError = null;

		ZipOutputStream zipOutputStream = null;
		try {
			FileOutputStream dest;
			try {
				dest = new FileOutputStream(new File(zipFile));
			} catch (FileNotFoundException e) {
				logger.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se pudo crear el archivo empaquetado:" + zipFile);
			}
			zipOutputStream = new ZipOutputStream(dest);

			File rootFolder = new File(sourceFolder);
			try {
				zipDirectoryHelper(rootFolder, rootFolder, zipOutputStream);
			} catch (Exception e) {
				logger.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se pudo empaquetar la carpeta:" + sourceFolder);
			}

			try {
				zipOutputStream.close();
			} catch (IOException e) {
				logger.error(e.toString());
				throw new COBISInfrastructureRuntimeException("No se pudo cerrar el archivo empaquetado:" + zipFile);
			}
		} finally {
			if (zipOutputStream != null) {
				try {
					zipOutputStream.close();
				} catch (IOException e) {
					logger.error(e.toString());
					internalError = "No se pudo cerrar el archivo empaquetado:" + zipFile;
					continueProcess = false;
				}
			}
		}

		return new FileExchangeResponse(continueProcess, internalError);
	}

	private static void zipDirectoryHelper(File rootDirectory, File currentDirectory, ZipOutputStream out) throws Exception {
		byte[] data = new byte[BUFFER_SIZE];

		File[] files = currentDirectory.listFiles();
		if (files == null) {
			// no files were found or this is not a directory
		} else {
			for (File file : files) {
				if (file.isDirectory()) {
					zipDirectoryHelper(rootDirectory, file, out);
				} else {
					FileInputStream fi = new FileInputStream(file);
					// creating structure and avoiding duplicate file names
					String name = file.getAbsolutePath().replace(rootDirectory.getAbsolutePath(), rootDirectory.getName());

					ZipEntry entry = new ZipEntry(name);
					out.putNextEntry(entry);
					int count;
					BufferedInputStream origin = new BufferedInputStream(fi, BUFFER_SIZE);
					while ((count = origin.read(data, 0, BUFFER_SIZE)) != -1) {
						out.write(data, 0, count);
					}
					origin.close();
				}
			}
		}
	}

	public static FileExchangeResponse removeFolder(String folder) {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia removeFolder");
		}

		try {
			FileUtils.deleteDirectory(new File(folder));
		} catch (IOException e) {
			logger.error(e.toString());
			throw new COBISInfrastructureRuntimeException("No se pudo eliminar la carpeta: " + folder);
		}

		return new FileExchangeResponse(true, null);
	}

	private static void extractFile(ZipInputStream zipIn, String filePath) throws IOException {
		BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(filePath));
		byte[] bytesIn = new byte[BUFFER_SIZE];
		int read = 0;
		while ((read = zipIn.read(bytesIn)) != -1) {
			bos.write(bytesIn, 0, read);
		}
		bos.close();
	}

	public static FileExchangeResponse extractZipFile(String sourceFolder, String zipFile) {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia extractZipFile");
		}

		boolean continueProcess = true;
		String internalError = null;
		ZipInputStream zipInputStream = null;
		FileOutputStream fos = null;

		try {
			try {
				zipInputStream = new ZipInputStream(new FileInputStream(sourceFolder + zipFile));
				ZipEntry salida;
				while (null != (salida = zipInputStream.getNextEntry())) {
					logger.debug("Nombre del Archivo: " + salida.getName());
					fos = new FileOutputStream(sourceFolder + salida.getName());
					int leer;
					byte[] buffer = new byte[1024];
					while (0 < (leer = zipInputStream.read(buffer))) {
						fos.write(buffer, 0, leer);
					}
					fos.close();
					zipInputStream.closeEntry();
				}
			} catch (FileNotFoundException e) {
				logger.error("No se encuentra el archivo a descomprimir");
				logger.error(e.toString());
			} catch (IOException e) {
				logger.error("Error al descomprimir el archivo");
				logger.error(e.toString());
			}

			if (logger.isDebugEnabled()) {
				logger.debug("Termina descompresión extractZipFile");
			}

		} finally {
			if (zipInputStream != null) {
				try {
					zipInputStream.close();
				} catch (IOException e) {
					logger.error(e.toString());
					internalError = "No se pudo cerrar el archivo desempaquetado:" + zipFile;
					continueProcess = false;
				}
			}
			if (fos != null) {
				try {
					fos.close();
				} catch (IOException e) {
					logger.error(e.toString());
					internalError = "No se pudo cerrar el archivo desempaquetado:" + zipFile;
					continueProcess = false;
				}
			}
		}

		return new FileExchangeResponse(continueProcess, internalError);
	}

}
