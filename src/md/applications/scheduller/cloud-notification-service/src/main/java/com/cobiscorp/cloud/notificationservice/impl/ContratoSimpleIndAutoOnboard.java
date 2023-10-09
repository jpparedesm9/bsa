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
import com.cobiscorp.cloud.notificationservice.dto.report.ContratoSimpleIndAutoOnboardClausulaDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.ContratoSimpleIndAutoOnboardDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.ContratoSimpleIndAutoOnboardDeclaracionDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.ContratoSimpleIndAutoOnboardDetallePrincipalDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.InfoLoanDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.ReportesAutoOnboardDTO;
import com.cobiscorp.cloud.scheduler.utils.ConstantValue;
import com.cobiscorp.cloud.scheduler.utils.DigitizedDocumentProcessing;
import com.cobiscorp.cloud.scheduler.utils.ReportsGenWithoutRegistration;

public class ContratoSimpleIndAutoOnboard extends NotificationGeneric {

	private static final Logger LOGGER = Logger.getLogger(ContratoSimpleIndAutoOnboard.class);

	private static ReportesAutoOnboardDTO inputData;
	private static ContratoSimpleIndAutoOnboardDTO inforForReport;

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		LOGGER.debug("Ingresa a setParameterToJasper -->>datosEntrada:" + inputData);
		Map<String, Object> parameters = new HashMap<String, Object>();

		if (inforForReport != null) {
			InfoLoanDTO parametros = inforForReport.getInfoLoanDTO();
			LOGGER.debug("setParameterToJasper-->>parametros:" + parametros);

			if (parametros != null) {
				// Mapeo de Datos al jaspers
				parameters.put("condusef", parametros.getCondusef());
				parameters.put("footParam", parametros.getFooter());

				parameters.put("urlPathSantander", ConstantValue.URL_IMAGEN_TUIIO_II);
			}
		}
		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		LOGGER.debug("Ingresa a setCollection");
		List<ContratoSimpleIndAutoOnboardDTO> dataCollection = new ArrayList<ContratoSimpleIndAutoOnboardDTO>();
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
	public ContratoSimpleIndAutoOnboardDTO executeWithDTO(ReportesAutoOnboardDTO inputObject) {
		LOGGER.debug("Ingresa executeWithDTO -- objDatosEntrada:" + inputObject);

		Connection cn = null;
		CallableStatement executeSP = null;
		ContratoSimpleIndAutoOnboardDTO contratoSimpleIndAutoOnboardDTO = new ContratoSimpleIndAutoOnboardDTO();

		try {

			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			Integer application = inputObject.getApplication();

			PreparedStatement executeSPXml = null;

			try {
				/* Parametros de Contrato */
				LOGGER.debug("llamada al sp datos contrato - cob_credito..sp_datos_credito");
				String queryXmlC = "{ call cob_credito..sp_datos_credito(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
				executeSPXml = cn.prepareCall(queryXmlC);
				executeSPXml.setEscapeProcessing(true);
				executeSPXml.setInt(1, 0);
				executeSPXml.setInt(2, 0);
				executeSPXml.setInt(3, 0);
				executeSPXml.setInt(4, 0);
				executeSPXml.setString(5, null);
				executeSPXml.setDate(6, null);
				executeSPXml.setString(7, null);
				executeSPXml.setString(8, "N");
				executeSPXml.setString(9, null);
				executeSPXml.setString(10, null);
				executeSPXml.setString(11, null);
				executeSPXml.setString(12, null);
				executeSPXml.setInt(13, 0);
				executeSPXml.setString(14, "T");// operacion
				executeSPXml.setInt(15, application);// tramite
				executeSPXml.setInt(16, 103);// formato fecha
				executeSPXml.setString(17, "D");

				ResultSet resultContrato = executeSPXml.executeQuery();

				LOGGER.debug("resultContrato---getRow:" + resultContrato.getRow());
				LOGGER.debug("resultContrato---resultContrato:" + resultContrato);

				InfoLoanDTO infoLoanContratoDTO = new InfoLoanDTO();

				while (resultContrato.next()) {
					LOGGER.debug("Ingreso al while resultCabecera:" + resultContrato.getString(27));
					infoLoanContratoDTO.setCondusef(resultContrato.getString(27));
					infoLoanContratoDTO.setFooter(resultContrato.getString(28));
				}

				/* Lista Informacion Previa */
				List<ContratoSimpleIndAutoOnboardClausulaDTO> contratoSimpleIndAutoOnboardInfoPreviaDTOList = new ArrayList<ContratoSimpleIndAutoOnboardClausulaDTO>();
				LOGGER.debug("llamada Informacion Previa");
				ContratoSimpleIndAutoOnboardClausulaDTO infoprevia = new ContratoSimpleIndAutoOnboardClausulaDTO();
				infoprevia.setCampo(".");
				contratoSimpleIndAutoOnboardInfoPreviaDTOList.add(infoprevia);

				/* Lista AnexoLegal */
				List<ContratoSimpleIndAutoOnboardClausulaDTO> contratoSimpleIndAutoOnboardAnexoLegalDTOList = new ArrayList<ContratoSimpleIndAutoOnboardClausulaDTO>();
				LOGGER.debug("llamada AnexoLegal");
				ContratoSimpleIndAutoOnboardClausulaDTO anexoLegal = new ContratoSimpleIndAutoOnboardClausulaDTO();
				anexoLegal.setCampo(".");
				contratoSimpleIndAutoOnboardAnexoLegalDTOList.add(anexoLegal);

				/* Detalle Principal */
				List<ContratoSimpleIndAutoOnboardDetallePrincipalDTO> contratoSimpleIndAutoOnboardDetallePrincipalDTOList = new ArrayList<ContratoSimpleIndAutoOnboardDetallePrincipalDTO>();
				LOGGER.debug("llamada Detalle Principal");
				ContratoSimpleIndAutoOnboardDetallePrincipalDTO cciDetallePrincipalDTO = new ContratoSimpleIndAutoOnboardDetallePrincipalDTO();

				// clausula
				List<ContratoSimpleIndAutoOnboardClausulaDTO> contratoSimpleIndAutoOnboardClausulaDTOList = new ArrayList<ContratoSimpleIndAutoOnboardClausulaDTO>();
				LOGGER.debug("llamada Clausula en Detalle Principal");
				ContratoSimpleIndAutoOnboardClausulaDTO clausula = new ContratoSimpleIndAutoOnboardClausulaDTO();
				clausula.setCampo(".");
				contratoSimpleIndAutoOnboardClausulaDTOList.add(clausula);
				cciDetallePrincipalDTO.setContratoCreditoInclusionClausula(contratoSimpleIndAutoOnboardClausulaDTOList);

				// declaracion
				List<ContratoSimpleIndAutoOnboardDeclaracionDTO> contratoSimpleIndAutoOnboardDeclaracionDTOList = new ArrayList<ContratoSimpleIndAutoOnboardDeclaracionDTO>();
				LOGGER.debug("llamada Declaracion en Detalle Principal");
				ContratoSimpleIndAutoOnboardDeclaracionDTO declaracion = new ContratoSimpleIndAutoOnboardDeclaracionDTO();
				declaracion.setCondusef(infoLoanContratoDTO.getCondusef());
				contratoSimpleIndAutoOnboardDeclaracionDTOList.add(declaracion);
				cciDetallePrincipalDTO.setContratoCreditoInclusionDeclaracion(contratoSimpleIndAutoOnboardDeclaracionDTOList);

				contratoSimpleIndAutoOnboardDetallePrincipalDTOList.add(cciDetallePrincipalDTO);

				/* Se setea todo a la clase principal */
				contratoSimpleIndAutoOnboardDTO.setInfoLoanDTO(infoLoanContratoDTO);
				contratoSimpleIndAutoOnboardDTO.setContratoCreditoInclusionIndividualInfoPrevia(contratoSimpleIndAutoOnboardInfoPreviaDTOList);
				contratoSimpleIndAutoOnboardDTO.setContratoCreditoInclusionIndividualAnexoLegal(contratoSimpleIndAutoOnboardAnexoLegalDTOList);
				contratoSimpleIndAutoOnboardDTO.setContratoCreditoInclusionIndividualDetallePrincipal(contratoSimpleIndAutoOnboardDetallePrincipalDTOList);

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
		return contratoSimpleIndAutoOnboardDTO;
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

			if (inforForReport.getInfoLoanDTO() != null && inforForReport.getContratoCreditoInclusionIndividualInfoPrevia() != null
					&& inforForReport.getContratoCreditoInclusionIndividualAnexoLegal() != null && inforForReport.getContratoCreditoInclusionIndividualDetallePrincipal() != null) {

				Collection<ContratoSimpleIndAutoOnboardDTO> dataCol = new ArrayList<ContratoSimpleIndAutoOnboardDTO>();
				ContratoSimpleIndAutoOnboardDTO contratoSimpleIndAutoOnboardDTO = (ContratoSimpleIndAutoOnboardDTO) inforForReport;
				dataCol.add(contratoSimpleIndAutoOnboardDTO);

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