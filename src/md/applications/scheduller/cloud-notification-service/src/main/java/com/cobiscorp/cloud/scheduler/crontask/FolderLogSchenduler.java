package com.cobiscorp.cloud.scheduler.crontask;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.RollingFileAppender;

public class FolderLogSchenduler extends RollingFileAppender {

	@Override
	public synchronized void setFile(String fileName, boolean append, boolean bufferedIO, int bufferSize)
			throws IOException {
		// Captura la fecha actual
		Date fechaActual = new Date();

		// Formatea la fecha y captura el anio y mes
		SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM");
		String directorioFecha = formato.format(fechaActual);

		// Verifica si existe el directorio log si existe no crea nada
		// si no existe, lo crea
		File directorioLog = new File("./log");
		if (!directorioLog.exists()) {
			directorioLog.mkdir();
		}

		// Verifica si existe el directorio fecha yyyyMM si existe no crea nada
		// si no existe, lo crea
		File directorio = new File("./log/" + directorioFecha);
		if (!directorio.exists()) {
			directorio.mkdirs();
		}

		super.setFile(fileName, append, bufferedIO, bufferSize);
	}
}