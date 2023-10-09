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
import com.cobiscorp.cloud.scheduler.utils.UploadFileJob;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

public class CargaReporte extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(CargaReporte.class);
	private static final String messageOk = "CARGA EXITOSA ARCHIVO REPORTE!!";
	private static final String suprimError = "COBISInfrastructureRuntimeException:";
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
		LOGGER.debug("-->>Ingresa execute CargaReporte");
		try {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("JobName: " + jobExecutionContext.getJobDetail().getName());
			}
			inforForReport = executeData();
			LOGGER.debug("longitud inforForReport: " + inforForReport.getReportList().size());

			for (int i = 0; i < inforForReport.getReportList().size(); i++) {
				LOGGER.debug("Ingresa for posicion: [" + i + "]");
				LOGGER.debug("inforForReport entrada:" + inforForReport.getReportList().get(i).toString());

				cargarArchivos(inforForReport.getReportList().get(i));
			}

		} catch (Exception ex) {
			LOGGER.error("Error al ejecutar Carga Reporte", ex);
		}
	}

	private void cargarArchivos(ReporteDTO inforForReport) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Inicia CargaReporte-->>cargarArchivos");
		}
		FileExchangeResponse fileExchangeResponse;
		UploadFileJob uploadFileJob = new UploadFileJob(null);
		fileExchangeResponse = uploadFileJob.getConfigurationR(inforForReport);

		if (fileExchangeResponse.isSuccess()) {
			Integer retry = 1;
			String errorSend = null;
			LOGGER.debug("retry: " + retry + " -> retryUpload: " + uploadFileJob.getRetryUpload());
			while (retry <= uploadFileJob.getRetryUpload()) {
				LOGGER.debug("Intento de carga de Reporte #" + retry);
				try {
					if (fileExchangeResponse.isSuccess()) {
						Integer index = inforForReport.getFileNameUpload().indexOf("?");
						if (index != -1) {
						uploadFileJob.uploadFiles(this.toString());
						} else {
							uploadFileJob.uploadFilesR(this.toString());
						}

						break;
					}
				} catch (Exception e) {
					LOGGER.error("Intento de carga reporte #" + retry + " fallido.");
					if (retry == uploadFileJob.getRetryUpload()) {
						LOGGER.debug("Error al intentar uploadFiles: " + e.toString());
						success = "E";
						executeUpdateData(inforForReport, success);
						errorSend = e.toString().substring(e.toString().indexOf(suprimError) + suprimError.length(), e.toString().length());
						throw new COBISInfrastructureRuntimeException(errorSend);
					}
				}
				retry++;
			}
		}
		if (fileExchangeResponse.isSuccess()) {
			LOGGER.info(messageOk);
			success = "A";
			executeUpdateData(inforForReport, success);
		} else {
			throw new COBISInfrastructureRuntimeException(fileExchangeResponse.getErrorMessage());
		}
	}

	// Trae la data de la base
	public ReportesDTO executeData() {
		LOGGER.debug("Ingresa a CargaReporte-->>executeData");

		Connection cn = null;
		CallableStatement executeSP = null;
		ReportesDTO reportesDTO = new ReportesDTO();

		try {

			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			PreparedStatement executeSPXml = null;

			try {
				/* Parametros Lista Consulta Reporte Carga */
				List<ReporteDTO> reporteDTOList = new ArrayList<ReporteDTO>();

				LOGGER.debug("llamada a cobis..sp_conciliador");
				String queryXmlC = "{ call cobis..sp_conciliador(?,?,?) }";
				executeSPXml = cn.prepareCall(queryXmlC);
				executeSPXml.setEscapeProcessing(true);
				executeSPXml.setString(1, "C");// Consulta
				executeSPXml.setString(2, "U");// Carga
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

				LOGGER.debug("Finaliza CargaReporte-->>executeData");

			} catch (Exception e) {
				LOGGER.error("Exception:", e);

			} finally {

				if (executeSPXml != null) {
					executeSPXml.close();
				}
				System.gc();
			}

		} catch (Exception e) {
			LOGGER.error("ERROR CargaReporte-->>executeData Exception -->", e);
		} finally {
			try {
				if (executeSP != null) {
					executeSP.close();
				}
				if (cn != null) {

					cn.close();

				}
			} catch (SQLException e) {
				LOGGER.error("ERROR CargaReporte-->>executeData -- SQLException -->", e);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("finally CargaReporte-->>executeData");
			}
		}
		return reportesDTO;
	}

	// actualiza la data de la base
	public void executeUpdateData(ReporteDTO inforForReport, String success) {
		LOGGER.debug("Ingresa a CargaReporte-->>executeUpdateData");

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
				executeSPXml.setString(2, "U");// Carga
				executeSPXml.setString(3, inforForReport.getReportNameI());// Nombre reporte
				int resultActualizacion = executeSPXml.executeUpdate();

				LOGGER.debug("resultActualizacion---resultActualizacion:" + resultActualizacion);

				LOGGER.debug("Finaliza CargaReporte-->>executeUpdateData");

			} catch (Exception e) {
				LOGGER.error("Exception:", e);

			} finally {

				if (executeSPXml != null) {
					executeSPXml.close();
				}
				System.gc();
			}

		} catch (Exception e) {
			LOGGER.error("ERROR CargaReporte-->>executeUpdateData Exception -->", e);
		} finally {
			try {
				if (executeSP != null) {
					executeSP.close();
				}
				if (cn != null) {

					cn.close();

				}
			} catch (SQLException e) {
				LOGGER.error("ERROR CargaReporte-->>executeUpdateData -- SQLException -->", e);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("finally CargaReporte-->>executeUpdateData");
			}
		}
	}

}
