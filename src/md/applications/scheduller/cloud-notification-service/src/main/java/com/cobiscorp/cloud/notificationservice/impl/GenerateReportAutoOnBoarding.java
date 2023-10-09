package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.configuration.ConfigManager;
import com.cobiscorp.cloud.notificationservice.dto.report.ReportesAutoOnboardDTO;
import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.DigitizedDocumentProcessing;
import com.cobiscorp.cloud.scheduler.utils.FileJob;

public class GenerateReportAutoOnBoarding extends NotificationGeneric implements Job {

	private static final String TOPER_LCR = "REVOLVENTE";
	private static final String TOPER_GRP = "GRUPAL";
	private static final String TOPER_IND = "INDIVIDUAL";

	private static final Logger LOGGER = Logger.getLogger(GenerateReportAutoOnBoarding.class);

	Date fechaInterfactura = new Date();
	SimpleDateFormat dateformat = new SimpleDateFormat("MM/dd/yyyy");
	Calendar calendarInterfactura = Calendar.getInstance();
	String diaInter = null;
	String mesInter = null;
	String anioInter = null;
	String errorStatus = "E";
	String finishStatus = "T";
	String pendingStatus = "P";
	Integer mode1 = 1; // padre
	Integer mode2 = 2; // hijas
	Integer mode3 = 3; // Padre envio

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

	// La clase es llamada por el job directo
	public void executeByTransaction(JobExecutionContext arg0) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeByTransaction");
		}

		Connection cn = null;
		CallableStatement executeSP = null;

		DigitizedDocumentProcessing aDigitizedDocumentProcessing = new DigitizedDocumentProcessing();

		try {

			CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.GRAOB);
			File pathSourceFolder = new File(copyFileJob.getSourceFolder());
			File pathDestinationFolder = new File(copyFileJob.getDestinationFolder());

			aDigitizedDocumentProcessing.processNotificationReportsByTOper(cn, executeSP, arg0, pathSourceFolder, pathDestinationFolder, copyFileJob, TOPER_IND);

			aDigitizedDocumentProcessing.processNotificationReportsByTOper(cn, executeSP, arg0, pathSourceFolder, pathDestinationFolder, copyFileJob, TOPER_LCR);

			aDigitizedDocumentProcessing.processNotificationReportsByTOper(cn, executeSP, arg0, pathSourceFolder, pathDestinationFolder, copyFileJob, TOPER_GRP);
			// aDigitizedDocumentProcessing.processNotificationGroupReports(cn, executeSP, arg0, pathSourceFolder, pathDestinationFolder, copyFileJob,
			// TOPER_GRP);

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
				LOGGER.error("-->> processNotificationReportsByTOper -- >> Error en Padre -->> Error SQLException: ", e);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeByTransaction Padre");
			}
		}

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

	public static XMLGregorianCalendar toXMLGregorianCalendar(Date date) {
		GregorianCalendar gCalendar = new GregorianCalendar();
		gCalendar.setTime(date);
		XMLGregorianCalendar xmlCalendar = null;
		try {
			xmlCalendar = DatatypeFactory.newInstance().newXMLGregorianCalendar(gCalendar);
		} catch (DatatypeConfigurationException ex) {
			LOGGER.error("Exception: ", ex);
		}
		return xmlCalendar;
	}

	public String getErrorStatus() {
		return errorStatus;
	}

	public void setErrorStatus(String errorStatus) {
		this.errorStatus = errorStatus;
	}

	public String getFinishStatus() {
		return finishStatus;
	}

	public void setFinishStatus(String finishStatus) {
		this.finishStatus = finishStatus;
	}

	public String getPendingStatus() {
		return pendingStatus;
	}

	public void setPendingStatus(String pendingStatus) {
		this.pendingStatus = pendingStatus;
	}

}