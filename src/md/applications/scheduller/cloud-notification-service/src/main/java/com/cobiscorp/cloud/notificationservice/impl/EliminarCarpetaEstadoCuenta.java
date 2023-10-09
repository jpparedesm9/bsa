package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.io.FileFilter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.apache.commons.io.filefilter.WildcardFileFilter;
import org.apache.log4j.Logger;
import org.apache.wicket.util.file.Folder;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;

public class EliminarCarpetaEstadoCuenta implements Job {

	private static final Logger logger = Logger.getLogger(EliminarCarpetaEstadoCuenta.class);

	private static String pattherfecha = "yyyyMMdd";

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		// TODO Auto-generated method stub

		try {
			logger.debug("JobName: " + arg0.getJobDetail().getName());
			eliminarCarpeta();
		} catch (Exception ex) {
			logger.error("Exception: " + ex);
		}

	}

	private void eliminarCarpeta() {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa a eliminarCarpeta");
		}

		String estadoEjecucion = "";
		String fechaEliminacion = "";

		CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.ECETC);
		String filePatther = "";
		String path = "";
		filePatther = copyFileJob.getFileNamePattern();
		path = copyFileJob.getSourceFolder();
		logger.debug(" filePatther--->" + filePatther);
		logger.debug(" path--->" + path);

		File currentDirectory = new File(path);

		if (filePatther == null || filePatther.equals("") || filePatther.equals(" ")) {
			logger.debug("No existe patthern");
		}

		if (path == null || path.equals("") || path.equals(" ")) {
			logger.debug("No existe carpeta raiz");
		}

		Connection cn = null;
		CallableStatement executeSP = null;
		try {
			cn = ConnectionManager.newConnection();
			ResultSet result = executeNotificationGeneral(cn, executeSP, "Q");
			while (result.next()) {
				fechaEliminacion = result.getString(1);
				estadoEjecucion = result.getString(2);

				logger.debug("fechaEliminacion: " + fechaEliminacion);
				logger.debug("estadoEjecucion: " + estadoEjecucion);
			}

			if (estadoEjecucion.equals("S")) {
				if (validarFecha(fechaEliminacion, pattherfecha)) {
					Date date = convertirFecha(fechaEliminacion, pattherfecha);
					logger.debug("Fecha de inicio eliminacion" + date);

					String[] patterns = filePatther.split("\\|");
					FileFilter fileFilter = new WildcardFileFilter(patterns[0]);
					File[] files = currentDirectory.listFiles(fileFilter);
					ArrayList<File> listDirectory = new ArrayList<File>();
					for (int i = 0; i < files.length; i++) {

						if (files[i].isDirectory()) {

							if (validarFecha(files[i].getName(), pattherfecha)) {
								listDirectory.add(files[i]);
								logger.debug("FechaDirectorio" + convertirFecha(files[i].getName(), pattherfecha));
								logger.debug("Fecha eliminacion" + date);
								if (convertirFecha(files[i].getName(), pattherfecha).compareTo(date) <= 0) {
									System.out.println("Ingresa");
									System.out.println("Fecha" + convertirFecha(files[i].getName(), pattherfecha));
									Folder fl = new Folder(files[i]);
									if (fl.remove()) {
										logger.debug("se borra la carpeta exitosamente");
									} else {
										logger.debug("No pudo borrarse la carpeta");
									}
								} else {
									logger.debug("La carpeta no debe eliminarse");
								}

							}
						}
					}
				}

			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public static ResultSet executeNotificationGeneral(Connection cn, CallableStatement executeSP, String operation) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa executeNotification General");
		}
		String query = "{ call cob_conta_super..sp_ns_eli_carpetas(?,?) }";

		try {
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, operation);
			executeSP.setInt(2, 112);
			executeSP.execute();
			return executeSP.getResultSet();
		} catch (Exception ex) {
			logger.error("ERROR executeNotification General -->", ex);
			throw ex;
		} finally {
			if (logger.isDebugEnabled()) {
				logger.debug("Finaliza executeNotification General");
			}
		}
	}

	public static boolean validarFecha(String fecha, String pattern) {
		try {
			// SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyyMMdd");
			SimpleDateFormat formatoFecha = new SimpleDateFormat(pattern);
			formatoFecha.setLenient(false);
			formatoFecha.parse(fecha);
		} catch (ParseException e) {
			return false;
		}
		return true;
	}

	public static Date convertirFecha(String fecha, String pattern) {
		SimpleDateFormat formato = new SimpleDateFormat(pattern);
		Date fechaDate = null;
		try {
			fechaDate = formato.parse(fecha);
		} catch (ParseException ex) {

			logger.debug("Error", ex);
		}
		return fechaDate;
	}

}
