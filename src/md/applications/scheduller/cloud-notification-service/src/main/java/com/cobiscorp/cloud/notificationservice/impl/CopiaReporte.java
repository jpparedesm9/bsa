package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.configuration.ConfigManager;
import com.cobiscorp.cloud.notificationservice.dto.report.ReporteDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.ReportesDTO;
import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

public class CopiaReporte extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(CopiaReporte.class);
	private static final String messageOk = "COPIA EXITOSA ARCHIVO REPORTE!!";
	private static ReportesDTO inforForReport;
	private String success;

	@Override
	public List<?> xmlToDTO(File inputData) {
		return null;
	}

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		return null;
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		return null;
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {
		return null;
	}

	@Override
	public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		LOGGER.debug("-->>Ingresa execute CopiaReporte");
		try {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("JobName: " + jobExecutionContext.getJobDetail().getName());
			}
			inforForReport = executeData();
			LOGGER.debug("longitud inforForReport: " + inforForReport.getReportList().size());

			for (int i = 0; i < inforForReport.getReportList().size(); i++) {
				LOGGER.debug("Ingresa for posicion: [ " + i + "]");
				LOGGER.debug("inforForReport entrada:" + inforForReport.getReportList().get(i).toString());

				CopyFileJob copyFileJob = new CopyFileJob(null, inforForReport.getReportList().get(i));
				crearCarpeta(copyFileJob, inforForReport.getReportList().get(i));
				extractInsuranceReports(copyFileJob, inforForReport.getReportList().get(i));
			}
		} catch (Exception ex) {
			LOGGER.error("Error al copiar Reporte: ", ex);
		}
	}

	private void extractInsuranceReports(CopyFileJob copyFileJob, ReporteDTO inforForReport) {
		FileExchangeResponse fileExchangeResponse = copyFileJob.copyFilesToDestinationAndHistoryandError();
		if (fileExchangeResponse.isSuccess()) {
			LOGGER.info(messageOk);
			LOGGER.debug("messageOk: " + messageOk);
			success = "A";
			executeUpdateData(inforForReport, success);
		} else {
			success = "E";
			executeUpdateData(inforForReport, success);
			throw new COBISInfrastructureRuntimeException(fileExchangeResponse.getErrorMessage());
		}
	}

	// Trae la data de la base
	public ReportesDTO executeData() {
		LOGGER.debug("Ingresa a CopiaReporte-->>executeData");

		Connection cn = null;
		CallableStatement executeSP = null;
		ReportesDTO reportesDTO = new ReportesDTO();

		try {

			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			PreparedStatement executeSPXml = null;

			try {
				/* Parametros Lista Consulta Reporte Copia */
				List<ReporteDTO> reporteDTOList = new ArrayList<ReporteDTO>();

				LOGGER.debug("llamada a cobis..sp_conciliador");
				String queryXmlC = "{ call cobis..sp_conciliador(?,?,?) }";
				executeSPXml = cn.prepareCall(queryXmlC);
				executeSPXml.setEscapeProcessing(true);
				executeSPXml.setString(1, "C");// Consulta
				executeSPXml.setString(2, "C");// Copia
				executeSPXml.setString(3, null);
				ResultSet resultReporte = executeSPXml.executeQuery();

				LOGGER.debug("resultReporte---getRow:" + resultReporte.getRow());
				LOGGER.debug("resultReporte---resultReporte:" + resultReporte);

				while (resultReporte.next()) {
					LOGGER.debug("Ingreso al while resultReporte:" + resultReporte.getString(1));
					ReporteDTO reporteDTO = new ReporteDTO();

					// Tabla Ingreso
					reporteDTO.setMnemonic(resultReporte.getString(1));
					reporteDTO.setReportNameI(resultReporte.getString(2));
					reporteDTO.setGenerationDate(resultReporte.getDate(3));
					reporteDTO.setGenProcessDate(resultReporte.getDate(4));
					reporteDTO.setUploadDate(resultReporte.getDate(5));
					reporteDTO.setCopyDate(resultReporte.getDate(6));
					reporteDTO.setStatus(resultReporte.getString(7));
					// Tabla Principal
					reporteDTO.setWorkFolderP(resultReporte.getString(8));
					reporteDTO.setSourceFolderP(resultReporte.getString(9));
					/* INFORMACION PARA SFTP */
					reporteDTO.setUsername(resultReporte.getString(10));
					reporteDTO.setPassword(resultReporte.getString(11));
					reporteDTO.setHost(resultReporte.getString(12));
					reporteDTO.setPort(resultReporte.getInt(13));
					reporteDTO.setTimeout(resultReporte.getInt(14));
					reporteDTO.setKeyPath(resultReporte.getString(15));
					reporteDTO.setAuthenticationType(resultReporte.getString(16));
					/**/
					reporteDTO.setTypeP(resultReporte.getString(17));
					// Tabla Detalle
					reporteDTO.setReportNameD(resultReporte.getString(18));
					reporteDTO.setWorkFolderD(resultReporte.getString(19));
					reporteDTO.setSourceFolderD(resultReporte.getString(20));
					reporteDTO.setDestinationFolder(resultReporte.getString(21));
					/* INFORMACION PARA CARGA */
					reporteDTO.setUploadPath(resultReporte.getString(22));
					reporteDTO.setFileNameUpload(resultReporte.getString(23));
					reporteDTO.setRemoteUploadPath(resultReporte.getString(24));
					reporteDTO.setRetryUpload(resultReporte.getString(25));
					reporteDTO.setToUploadExtract(resultReporte.getString(26));
					/* INFORMACION PARA DESCARGA */
					reporteDTO.setDownloadPath(resultReporte.getString(27));
					reporteDTO.setDownloadFilePattern(resultReporte.getString(28));
					reporteDTO.setRemoteDownloadPath(resultReporte.getString(29));
					reporteDTO.setRemoteDownloadHistoryPath(resultReporte.getString(30));
					reporteDTO.setRetryDownload(resultReporte.getString(31));
					reporteDTO.setToDownloadExtract(resultReporte.getString(32));

					reporteDTOList.add(reporteDTO);
				}

				/* Se setea todo a la clase principal */
				reportesDTO.setReportList(reporteDTOList);

				LOGGER.debug("Finaliza CopiaReporte-->>executeData");

			} catch (Exception e) {
				LOGGER.error("Exception:", e);

			} finally {

				if (executeSPXml != null) {
					executeSPXml.close();
				}
				System.gc();
			}

		} catch (Exception e) {
			LOGGER.error("ERROR CopiaReporte-->>executeData Exception -->", e);
		} finally {
			try {
				if (executeSP != null) {
					executeSP.close();
				}
				if (cn != null) {

					cn.close();

				}
			} catch (SQLException e) {
				LOGGER.error("ERROR CopiaReporte-->>executeData -- SQLException -->", e);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("finally CopiaReporte-->>executeData");
			}
		}
		return reportesDTO;
	}

	public void crearCarpeta(CopyFileJob copyFileJob, ReporteDTO inforForReport) {
		try {

			File pathDestinationFolder = new File(copyFileJob.getDestinationFolder());

			LOGGER.debug("-->>crearCarpeta ruta pathDestinationFolder:" + pathDestinationFolder);

			if (!pathDestinationFolder.exists()) {
				if (pathDestinationFolder.mkdirs()) {
					LOGGER.debug("-->>crearCarpeta-->>Directorio Creado pathDestinationFolder");
				} else {
					LOGGER.debug("-->>crearCarpeta-->>Directorio no Creado pathDestinationFolder, error");
					return;
				}
			}

		} catch (Exception e) {
			LOGGER.error("-->> crearCarpeta -- >> Error en crear directorios -->> Exception: ", e);

		}
	}

	// actualiza la data de la base
	public void executeUpdateData(ReporteDTO inforForReport, String success) {
		LOGGER.debug("Ingresa a CopiaReporte-->>executeUpdateData");

		Connection cn = null;
		CallableStatement executeSP = null;
		ReportesDTO reportesDTO = new ReportesDTO();

		try {

			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			PreparedStatement executeSPXml = null;

			try {
				/* Parametros Actualizacion Reporte Carga */
				LOGGER.debug("llamada a cobis..sp_conciliador");
				String queryXmlC = "{ call cobis..sp_conciliador(?,?,?) }";
				executeSPXml = cn.prepareCall(queryXmlC);
				executeSPXml.setEscapeProcessing(true);
				executeSPXml.setString(1, success);// A: Actualizacion, E: Error
				executeSPXml.setString(2, "C");// Copia
				executeSPXml.setString(3, inforForReport.getReportNameI());// Nombre reporte
				int resultActualizacion = executeSPXml.executeUpdate();

				LOGGER.debug("resultActualizacion---resultActualizacion:" + resultActualizacion);

				LOGGER.debug("Finaliza CopiaReporte-->>executeUpdateData");

			} catch (Exception e) {
				LOGGER.error("Exception:", e);

			} finally {

				if (executeSPXml != null) {
					executeSPXml.close();
				}
				System.gc();
			}

		} catch (Exception e) {
			LOGGER.error("ERROR CopiaReporte-->>executeUpdateData Exception -->", e);
		} finally {
			try {
				if (executeSP != null) {
					executeSP.close();
				}
				if (cn != null) {

					cn.close();

				}
			} catch (SQLException e) {
				LOGGER.error("ERROR CopiaReporte-->>executeUpdateData -- SQLException -->", e);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("finally CopiaReporte-->>executeUpdateData");
			}
		}
	}

}
