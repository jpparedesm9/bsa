package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.configuration.ConfigManager;
import com.cobiscorp.cloud.notificationservice.dto.report.ReportesAutoOnboardDTO;
import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.DigitizedDocumentProcessing;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.UploadAlfrescoFile;

public class ReintentoCargaAlfresco extends NotificationGeneric implements Job {

	private static final Logger LOGGER = Logger.getLogger(ReintentoCargaAlfresco.class);
	String finishStatus = "T";
	String errorStatus = "E";
	Integer mode1 = 1;

	@Override	
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		List<Object> dataCollection = new ArrayList<Object>();
		return dataCollection;
	}

	/* No borrar el metdodo xmlToDTO se requiere para la clase */
	@Override
	public List<?> xmlToDTO(File inputData) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setParameterToSendMail");
		}
		return null;
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {
		ReportesAutoOnboardDTO reportesAutoOnboardDTO = (ReportesAutoOnboardDTO) inputDto;

		Map<String, Object> parameters = new HashMap<String, Object>();

		return parameters;

	}

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		try {
			LOGGER.debug("-->>execute-->>JobName: " + arg0.getJobDetail().getName());
			executeByTransaction(arg0);
		} catch (Exception ex) {
			LOGGER.error("-->>execute-->>Exception: ", ex);
		}
	}

	// La clase es llamada por el job directo
	public void executeByTransaction(JobExecutionContext arg0) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeByTransaction");
		}
		DigitizedDocumentProcessing aDigitizedDocumentProcessing = new DigitizedDocumentProcessing();
		ReportesAutoOnboardDTO reportesAutoOnboardDTO = new ReportesAutoOnboardDTO();
		Connection cn = null;
		CallableStatement executeSP = null;
		CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.GRAOB);
		File pathSourceFolder = new File(copyFileJob.getSourceFolder());
		File pathDestinationFolder = new File(copyFileJob.getDestinationFolder());

		try {

			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			// clase Padre
			// ResultSet resultMain = executeRetryNotification(cn, executeSP, "Q", null, errorStatus, null, null, null, mode1);
			ResultSet resultMain = executeRetryNotification(cn, executeSP, "Q", null, errorStatus, null, null, null, mode1, finishStatus);
			while (resultMain.next()) {
				Integer customerId = resultMain.getInt(1);
				String buc = resultMain.getString(2);
				String bank = resultMain.getString(3);
				Integer application = resultMain.getInt(4);
				String documentCode = resultMain.getString(5);
				String reportName = resultMain.getString(6);
				Date proccessDate = resultMain.getDate(7);
				String jasperFileName = resultMain.getString(8);
				String filePathName = resultMain.getString(9);

				String endingAcronymName = resultMain.getString(11);
				String isAlfresco = resultMain.getString(12);
				Integer groupId = resultMain.getInt(13);
				Integer proccessInst = resultMain.getInt(14);
				String docName = resultMain.getString(15);
				String folder = resultMain.getString(16);
				String operType = resultMain.getString(17);

				String isLoadAlfresco = resultMain.getString(18);
				String codeDocTypeCstmr = resultMain.getString(19);
				String groupUnif = resultMain.getString(20);
				Integer idCodInstAct = resultMain.getInt(21);
				Integer codCodigoTipoDoc = resultMain.getInt(22);

				File file = aDigitizedDocumentProcessing.getFile(filePathName);
				boolean isUploaded = UploadAlfrescoFile.uploadAlfrescoFile(file, groupId.toString(), proccessInst.toString(), customerId.toString(), docName, folder);

				LOGGER.debug("-->>processNotificationReportsByClient-->>Resultado Query Detalle -- >>isUploaded: " + isUploaded);

				if (isUploaded) {

					aDigitizedDocumentProcessing.executeUpdateDocuments(cn, executeSP, proccessInst, idCodInstAct, codCodigoTipoDoc, docName, customerId, groupId, folder, codeDocTypeCstmr);

					aDigitizedDocumentProcessing.executeNotification(cn, executeSP, "U", customerId, "T", documentCode,
							bank, filePathName, 5, null);

				} else {
					aDigitizedDocumentProcessing.executeNotification(cn, executeSP, "U", customerId, "E", documentCode,
							bank, filePathName, 5, null);// ERROR }

				}
			}
		} catch (Exception e) {
			LOGGER.error("-->> executeByTransaction -- >> Error en Padre -->> Exception: ", e);

		} finally {
			try {
				if (executeSP != null) {
					executeSP.close();
				}
				if (cn != null) {
					cn.close();

				}
			} catch (SQLException e) {
				LOGGER.error("-->> executeByTransaction -- >> Error en Padre -->> Error SQLException: ", e);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeByTransaction Padre");
			}
		}
	}

	public ResultSet executeRetryNotification(Connection cn, CallableStatement executeSP, String operation, Integer customerId, String status, String documentCode, String bank,
			String filenameWithPath, Integer mode, String finishStatus) throws Exception {

		LOGGER.debug("-->>Ingreso executeRetryNotification");

		String query = "{ call cob_credito..sp_reintento_envio_doc_autoonboarding(?,?,?,?,?,?,?,?) }";
		
		LOGGER.debug(String.format("exec cob_credito..sp_reintento_envio_doc_autoonboarding %s , %s , %s , %s , %s , %s ,%s , %s ", operation, customerId, status, documentCode, bank, filenameWithPath,
				mode, finishStatus));

		try {
			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());
			executeSP = cn.prepareCall(query);

			executeSP.setString(1, operation);

			if (customerId == null)
				executeSP.setNull(2, java.sql.Types.INTEGER);
			else
				executeSP.setInt(2, customerId);

			if (status == null)
				executeSP.setNull(3, java.sql.Types.VARCHAR);
			else
				executeSP.setString(3, status);

			if (documentCode == null)
				executeSP.setNull(4, java.sql.Types.VARCHAR);
			else
				executeSP.setString(4, documentCode);

			if (bank == null)
				executeSP.setNull(5, java.sql.Types.VARCHAR);
			else
				executeSP.setString(5, bank);

			if (filenameWithPath == null)
				executeSP.setNull(6, java.sql.Types.VARCHAR);
			else
				executeSP.setString(6, filenameWithPath);

			if (mode == null)
				executeSP.setNull(7, java.sql.Types.INTEGER);
			else
				executeSP.setInt(7, mode);

			if (finishStatus == null)
				executeSP.setNull(8, java.sql.Types.VARCHAR);
			else
				executeSP.setString(8, finishStatus);

			executeSP.execute();

			return executeSP.getResultSet();

		} catch (Exception ex) {
			LOGGER.error("-->>ERROR executeRetryNotification -->", ex);
			throw ex;
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("-->>Finaliza executeRetryNotification");
			}
		}
	}

}
