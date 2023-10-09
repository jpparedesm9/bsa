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
import com.cobiscorp.cloud.notificationservice.dto.report.CertConsentimientoZurichAutoOnboardDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.CertConsentimientoZurichAutoOnboardSubDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.ReportesAutoOnboardDTO;
import com.cobiscorp.cloud.scheduler.utils.DigitizedDocumentProcessing;
import com.cobiscorp.cloud.scheduler.utils.ReportsGenWithoutRegistration;

public class CertificadoConsentimientoZurich extends NotificationGeneric {

	private static final Logger LOGGER = Logger.getLogger(CertificadoConsentimientoZurich.class);

	private static ReportesAutoOnboardDTO inputData;
	private static CertConsentimientoZurichAutoOnboardDTO inforForReport;

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		LOGGER.debug("Ingresa a setParameterToJasper -->>datosEntrada:" + inputData);
		Map<String, Object> parameters = new HashMap<String, Object>();
		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		LOGGER.debug("Ingresa a setCollection");
		List<CertConsentimientoZurichAutoOnboardDTO> dataCollection = new ArrayList<CertConsentimientoZurichAutoOnboardDTO>();
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

	// Trae la data de la base
	public CertConsentimientoZurichAutoOnboardDTO executeWithDTO(ReportesAutoOnboardDTO inputObject) {
		LOGGER.debug("Ingresa executeWithDTO -- objDatosEntrada:" + inputObject);

		Connection cn = null;
		CallableStatement executeSP = null;
		CertConsentimientoZurichAutoOnboardDTO certConsentimientoZurichAutoOnboardDTO = new CertConsentimientoZurichAutoOnboardDTO();

		try {

			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			Integer clientId = inputObject.getCustomerId();
			Integer application = inputObject.getApplication();

			PreparedStatement executeSPXml = null;

			try {
				/* Llenado Lista SubReporte Consentimiento */
				LOGGER.debug("llamada al sp reporte consentimiento llenado- cob_cartera..sp_onboard_cons_seguro_zurich");
				String queryXmlR = "{ call cob_cartera..sp_onboard_cons_seguro_zurich(?,?,?) }";
				executeSPXml = cn.prepareCall(queryXmlR);
				executeSPXml.setEscapeProcessing(true);
				executeSPXml.setInt(1, clientId); // cliente
				executeSPXml.setInt(2, application);// tramite
				executeSPXml.setString(3, "L");// operacion

				int resultLlenado = executeSPXml.executeUpdate();

				LOGGER.debug("resultLlenado---resultLlenado:" + resultLlenado);

				/* Consulta Lista SubReporte Consentimiento */
				List<CertConsentimientoZurichAutoOnboardSubDTO> certConsentimientoZurichAutoOnboardSubDTOList = new ArrayList<CertConsentimientoZurichAutoOnboardSubDTO>();
				LOGGER.debug("llamada al sp reporte consentimiento consulta- cob_cartera..sp_onboard_cons_seguro_zurich");
				String queryXmlQ = "{ call cob_cartera..sp_onboard_cons_seguro_zurich(?,?,?) }";
				executeSPXml = cn.prepareCall(queryXmlQ);
				executeSPXml.setEscapeProcessing(true);
				executeSPXml.setInt(1, clientId); // cliente
				executeSPXml.setInt(2, application);// tramite
				executeSPXml.setString(3, "C");// operacion

				ResultSet resultReporte = executeSPXml.executeQuery();

				LOGGER.debug("resultReporte---getRow:" + resultReporte.getRow());
				LOGGER.debug("resultReporte---resultReporte:" + resultReporte);

				CertConsentimientoZurichAutoOnboardSubDTO certConsentimientoZurichAutoOnboardSubDTO = new CertConsentimientoZurichAutoOnboardSubDTO();

				while (resultReporte.next()) {
					LOGGER.debug("Ingreso al while resultReporte:" + resultReporte.getString(1));

					certConsentimientoZurichAutoOnboardSubDTO.setNombre(resultReporte.getString(1));
					certConsentimientoZurichAutoOnboardSubDTO.setRfc(resultReporte.getString(2));
					certConsentimientoZurichAutoOnboardSubDTO.setFechanac(resultReporte.getString(3));
					certConsentimientoZurichAutoOnboardSubDTO.setDomicilio(resultReporte.getString(4));
					certConsentimientoZurichAutoOnboardSubDTO.setColonia(resultReporte.getString(5));
					certConsentimientoZurichAutoOnboardSubDTO.setCp(resultReporte.getString(6));
					certConsentimientoZurichAutoOnboardSubDTO.setEmail(resultReporte.getString(7));
					certConsentimientoZurichAutoOnboardSubDTO.setCertificado(resultReporte.getString(8));
					certConsentimientoZurichAutoOnboardSubDTO.setFechaini(resultReporte.getString(9));
					certConsentimientoZurichAutoOnboardSubDTO.setFechafin(resultReporte.getString(10));
					certConsentimientoZurichAutoOnboardSubDTO.setPoliza(resultReporte.getString(11));
					certConsentimientoZurichAutoOnboardSubDTO.setContratante(resultReporte.getString(12));
					certConsentimientoZurichAutoOnboardSubDTO.setRfccontratante(resultReporte.getString(13));
					certConsentimientoZurichAutoOnboardSubDTO.setCliente(resultReporte.getInt(14));
					certConsentimientoZurichAutoOnboardSubDTO.setPrimaneta(resultReporte.getDouble(15));
					certConsentimientoZurichAutoOnboardSubDTO.setDerechopoliza(resultReporte.getDouble(16));
					certConsentimientoZurichAutoOnboardSubDTO.setRecargopago(resultReporte.getDouble(17));
					certConsentimientoZurichAutoOnboardSubDTO.setPrimatotal(resultReporte.getDouble(18));
					certConsentimientoZurichAutoOnboardSubDTO.setRazonsocial(resultReporte.getString(19));
					certConsentimientoZurichAutoOnboardSubDTO.setFechaemi(resultReporte.getString(20));

					certConsentimientoZurichAutoOnboardSubDTOList.add(certConsentimientoZurichAutoOnboardSubDTO);
				}

				/* Se setea todo a la clase principal */
				certConsentimientoZurichAutoOnboardDTO.setListaZurich(certConsentimientoZurichAutoOnboardSubDTOList);

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
		return certConsentimientoZurichAutoOnboardDTO;
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

			if (inforForReport.getListaZurich() != null) {

				Collection<CertConsentimientoZurichAutoOnboardDTO> dataCol = new ArrayList<CertConsentimientoZurichAutoOnboardDTO>();
				CertConsentimientoZurichAutoOnboardDTO certConsentimientoZurichAutoOnboardDTO = (CertConsentimientoZurichAutoOnboardDTO) inforForReport;
				dataCol.add(certConsentimientoZurichAutoOnboardDTO);

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