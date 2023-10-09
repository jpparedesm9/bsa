package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.configuration.ConfigManager;
import com.cobiscorp.cloud.notificationservice.dto.report.AsistenciaFunerariaDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.AsistenciaFunerariaDetalleDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.ReportesAutoOnboardDTO;
import com.cobiscorp.cloud.scheduler.utils.ConstantValue;
import com.cobiscorp.cloud.scheduler.utils.DigitizedDocumentProcessing;
import com.cobiscorp.cloud.scheduler.utils.ReportsGenWithoutRegistration;

public class AsistenciaFunerariaSimplificado extends NotificationGeneric {

	private static final Logger LOGGER = Logger.getLogger(AsistenciaFunerariaSimplificado.class);

	private static ReportesAutoOnboardDTO inputData;
	private static AsistenciaFunerariaDTO inforForReport;

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		LOGGER.debug("Ingresa a setParameterToJasper -->>datosEntrada:" + inputData);
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("urlPathSantander", ConstantValue.URL_IMAGEN_TUIIOSANTANDER2);
		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		LOGGER.debug("Ingresa a setCollection");
		List<AsistenciaFunerariaDetalleDTO> dataCollection = new ArrayList<AsistenciaFunerariaDetalleDTO>();

		return dataCollection;
	}

	/* No borrar el metdodo xmlToDTO se requiere para la clase */
	@Override
	public List<?> xmlToDTO(File inputData) {
		LOGGER.debug("Ingresa a xmlToDTO");
		return null;
	}

	/* No borrar el metdodo setParameterToSendMail se requiere para la clase */
	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {
		LOGGER.debug("Ingresa a setParameterToSendMail");
		Map<String, Object> parameters = new HashMap<String, Object>();

		return parameters;
	}

	public AsistenciaFunerariaDTO executeWithDTO(ReportesAutoOnboardDTO inputObject) {
		LOGGER.debug("Ingresa executeWithDTO -- objDatosEntrada:" + inputObject);

		Connection cn = null;
		CallableStatement executeSP = null;
		AsistenciaFunerariaDTO asistenciaFunerariaDTO = new AsistenciaFunerariaDTO();

		try {

			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			Integer tramite = inputObject.getApplication();
			Integer cliente = inputObject.getCustomerId();

			PreparedStatement executeSPXml = null;

			try {

				/* Lista SubReporte Asistencia Funeraria */
				List<AsistenciaFunerariaDetalleDTO> asistenciaFunerariaDetalleDTOList = new ArrayList<AsistenciaFunerariaDetalleDTO>();
				LOGGER.debug("llamada al sp reporte asistencia funeraria - cobis..sp_reporte_consentimiento");
				String queryXmlR = "{ call cobis..sp_reporte_consentimiento(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
				executeSPXml = cn.prepareCall(queryXmlR);
				executeSPXml.setEscapeProcessing(true);
				executeSPXml.setInt(1, 0);
				executeSPXml.setString(2, null);
				executeSPXml.setString(3, null);
				executeSPXml.setDate(4, null);
				executeSPXml.setInt(5, 0);
				executeSPXml.setString(6, null);
				executeSPXml.setString(7, null);
				executeSPXml.setString(8, null);
				executeSPXml.setInt(9, 0);
				executeSPXml.setInt(10, 0);
				executeSPXml.setString(11, null);
				executeSPXml.setInt(12, 0);
				executeSPXml.setInt(13, 0);
				executeSPXml.setString(14, null);
				executeSPXml.setString(15, null);
				executeSPXml.setString(16, null);
				executeSPXml.setString(17, null);
				executeSPXml.setString(18, null);
				executeSPXml.setInt(19, 1718);// transaccion
				executeSPXml.setInt(20, 0);
				executeSPXml.setInt(21, tramite);// tramite
				executeSPXml.setString(22, "A");// operacion
				executeSPXml.setString(23, "CEASFU");// nemonico reporte
				executeSPXml.setInt(24, cliente);// cliente

				ResultSet resultReporte = executeSPXml.executeQuery();

				LOGGER.debug("resultReporte---getRow:" + resultReporte.getRow());
				LOGGER.debug("resultReporte---resultReporte:" + resultReporte);

				AsistenciaFunerariaDetalleDTO asistenciaFunerariaDetalleDTO = new AsistenciaFunerariaDetalleDTO();

				while (resultReporte.next()) {
					LOGGER.debug("Ingreso al while resultReporte:" + resultReporte.getString(2));

					asistenciaFunerariaDetalleDTO.setName(resultReporte.getString(3));
					asistenciaFunerariaDetalleDTO.setRfc(resultReporte.getString(6));
					asistenciaFunerariaDetalleDTO.setCertificateNumber(resultReporte.getString(2));

					asistenciaFunerariaDetalleDTOList.add(asistenciaFunerariaDetalleDTO);
				}

				/* Se setea todo a la clase principal */
				asistenciaFunerariaDTO.setAsistenciaFunerariaDetalle(asistenciaFunerariaDetalleDTOList);

				LOGGER.debug("Finaliza executeWithDTO");

			} catch (Exception e) {
				LOGGER.error("Exception:", e);

			} finally {

				if (executeSPXml != null) {
					executeSPXml.close();
				}
				System.gc();
			}

		} catch (Exception e) {
			LOGGER.error("ERROR executeWithDTO Exception -->", e);
		} finally {
			try {
				if (executeSP != null) {
					executeSP.close();
				}
				if (cn != null) {

					cn.close();

				}
			} catch (SQLException e) {
				LOGGER.error("ERROR executeWithDTO -- SQLException -->", e);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("finally executeWithDTO");
			}
		}
		return asistenciaFunerariaDTO;

	}

	public void executeByTransaction(JobExecutionContext arg0, Map<String, Object> param, String filePathNameReportGenerate, String jasperFileName) {
		Connection cn = null;
		CallableStatement executeSP = null;
		String namePdf = null;

		try {
			LOGGER.debug("Ingreso executeByTransaction -->>datosEntrada: " + inputData);
			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			String documentCode = inputData.getDocumentCode();
			Integer customerCode = inputData.getCustomerId();
			String bank = inputData.getBank();

			LOGGER.debug("-->>executeByTransaction-->>datosReporte::" + inforForReport + "-->>filePathNameReportGenerate:" + filePathNameReportGenerate);

			if (inforForReport.getAsistenciaFunerariaDetalle() != null) {

				Collection<AsistenciaFunerariaDTO> dataCol = new ArrayList<AsistenciaFunerariaDTO>();
				AsistenciaFunerariaDTO asistenciaFunerariaDTO = (AsistenciaFunerariaDTO) inforForReport;
				dataCol.add(asistenciaFunerariaDTO);

				DigitizedDocumentProcessing update = new DigitizedDocumentProcessing();

				if (ReportsGenWithoutRegistration.generateReport(filePathNameReportGenerate, null, param, jasperFileName, dataCol)) {
					update.executeNotification(cn, executeSP, "U", customerCode, "T", documentCode, bank, filePathNameReportGenerate, 2, null); // TERMINADO
				} else {
					update.executeNotification(cn, executeSP, "U", customerCode, "E", documentCode, bank, filePathNameReportGenerate, 2, null);// ERROR
				}

				LOGGER.debug("-->>executeByTransaction1 -- Ruta y nombre:" + namePdf);
				LOGGER.debug("-->>Finaliza executeByTransaction");
			}

		} catch (Exception e) {
			LOGGER.error("-->>ERROR executeByTransaction -->", e);
		} finally {
			try {
				if (executeSP != null) {
					executeSP.close();
				}
				if (cn != null) {
					cn.close();
				}
			} catch (SQLException e) {
				LOGGER.error("-->>SQLException -->", e);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("-->>finally executeByTransaction");
			}
		}

	}

	public void execute(Object inputDto, JobExecutionContext arg0, String filePathNameReportGenerate, String jasperFileName) throws JobExecutionException {
		LOGGER.debug("-->>Ingresa a execute");
		try {
			inputData = (ReportesAutoOnboardDTO) inputDto;
			inforForReport = executeWithDTO(inputData);

			Map<String, Object> param = setParameterToJasper(inputDto);

			executeByTransaction(arg0, param, filePathNameReportGenerate, jasperFileName);

		} catch (Exception ex) {
			LOGGER.error("-->>Exception en execute: ", ex);
		}
	}
}
