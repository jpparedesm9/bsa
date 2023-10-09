package com.cobiscorp.cloud.notificationservice.impl;


import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.notificationservice.model.ConectorTimbrado;
import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.FileUtil;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;

public class CopiaConectorComplemento extends Thread implements Job {

	private static final Logger logger = Logger.getLogger(CopiaConectorComplemento.class);

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		Connection cn = null;
		CallableStatement executeSP = null;
		List<ConectorTimbrado> listConectorTimbrados = new ArrayList<ConectorTimbrado>();
		CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.CPYZCOM);
		File[] filesZipsToCopy = null;

		try {

			filesZipsToCopy = getFileList(copyFileJob.getWorkFolder());

			if (filesZipsToCopy != null) {
				cn = ConnectionManager.newConnection();
				listConectorTimbrados = getConnectorList(cn, executeSP);
				logger.debug("The list obtained from the database is " + listConectorTimbrados.toString());

				List<ConectorTimbrado> listValidate = validatePathConnector(listConectorTimbrados);

				if (!listValidate.isEmpty()) {
					copyZipToConnector(listConectorTimbrados, copyFileJob.getWorkFolder());
				} else {
					logger.debug("There are no active connectors or not exists paths");
				}
			} else {

				logger.debug("There are no files in the working folder");
			}

		} catch (Exception e) {
			logger.error("Error executing job ", e);
		} finally {
			try {
				if (cn != null) {
					ConnectionManager.saveConnection(cn);
					logger.debug("Connection to the database closed successfully");
				}
			} catch (Exception e) {
				logger.error("Failed to close connection: ", e);
			}
		}

	}

	private static void copyZipToConnector(List<ConectorTimbrado> listConnector, String pathWorkFolder) {
		if (logger.isDebugEnabled()) {
			logger.debug("Start copy zip to connectors");
		}

		File directoryZips = new File(pathWorkFolder);
		int sequencialConector = 0;

		if (directoryZips.exists()) {
			File[] filesZips = directoryZips.listFiles();
			if (filesZips.length > 0) {
				int countFilesZip = filesZips.length;
				int countConecctors = listConnector.size();
				logger.debug("Number of zips to copy: " + countFilesZip);

				for (File file : filesZips) {
					String pathOrigin = file.getAbsolutePath();
					String pathDestine = listConnector.get(sequencialConector).getRutaEntrada() + File.separator + file.getName();

					FileUtil.moveFile(pathOrigin, pathDestine);

					if (sequencialConector < countConecctors - 1) {
						sequencialConector++;

					} else {
						sequencialConector = 0;
					}

				}

			} else {
				logger.debug("There are no files to move");
			}

		} else {
			logger.debug("Destination directory does not exist");
		}

		if (logger.isDebugEnabled()) {
			logger.debug("End copy zip to connectors");
		}
	}

	private static List<ConectorTimbrado> getConnectorList(Connection cn, CallableStatement executeSP) {
		List<ConectorTimbrado> resultListConector = new ArrayList<ConectorTimbrado>();

		try {
			ResultSet result = executeGetActiveConnector(cn, executeSP);

			logger.debug("Database call response: " + result);

			while (result.next())
				resultListConector.add(new ConectorTimbrado(result.getString(1), result.getString(2), result.getString(3), result.getString(4)));

		} catch (Exception e) {

			logger.error("Failed to get the list of connectors", e);
		}

		return resultListConector;

	}

	private static ResultSet executeGetActiveConnector(Connection cn, CallableStatement executeSp) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("Start query for active connectors");
		}

		String query = "{ call cob_conta_super..sp_admin_conect_timb(?,?,?,?,?,?,?,?) }";

		try {
			executeSp = cn.prepareCall(query);
			executeSp.setString(1, "C");
			executeSp.setString(2, "");
			executeSp.setString(3, "");
			executeSp.setString(4, "");
			executeSp.setString(5, "");
			executeSp.setString(6, "");
			executeSp.setString(7, "");
			executeSp.setString(8, "C");
			executeSp.execute();

			return executeSp.getResultSet();

		} catch (SQLException e) {
			logger.error("Error executing method executeGetActiveConnector", e);
			throw e;
		} finally {
			if (logger.isDebugEnabled()) {
				logger.debug("Finish query of active connectors");
			}

		}

	}

	private static List<ConectorTimbrado> validatePathConnector(List<ConectorTimbrado> lisConectorTimbrados) {
		if (logger.isDebugEnabled()) {
			logger.debug("Start connector destination path validation");
		}

		if (lisConectorTimbrados != null) {
			logger.debug("Number of paths to validate: " + lisConectorTimbrados.size());
		}

		List<ConectorTimbrado> list = new ArrayList<ConectorTimbrado>();

		for (int i = 0; i <= lisConectorTimbrados.size() - 1; i++) {
			File file = new File(lisConectorTimbrados.get(i).getRutaEntrada().trim());
			if (file.exists()) {
				logger.debug("Path [" + i + "] " + lisConectorTimbrados.get(i).getRutaEntrada() + " successfully validated");
				list.add(lisConectorTimbrados.get(i));
			} else {
				logger.debug("Path [" + i + "] " + lisConectorTimbrados.get(i).getRutaEntrada() + " not exist");
			}

		}

		if (logger.isDebugEnabled()) {
			logger.debug("End connector destination path validation");
		}

		return list;

	}

	private static File[] getFileList(String pathWorkfolder) {
		File file = new File(pathWorkfolder);
		File[] fileList = null;

		if (file.exists()) {
			fileList = file.listFiles();
		}

		return fileList;

	}

}
