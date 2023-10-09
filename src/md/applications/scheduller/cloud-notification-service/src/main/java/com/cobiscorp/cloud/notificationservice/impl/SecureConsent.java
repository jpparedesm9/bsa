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
import com.cobiscorp.cloud.notificationservice.dto.report.BenefitsDeclareDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.BenefitsInformationTableDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.ConsentOfSegurityDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.ConsentSecurityBasicDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.InformationHeadLineDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.ReportesAutoOnboardDTO;
import com.cobiscorp.cloud.scheduler.utils.ConstantValue;
import com.cobiscorp.cloud.scheduler.utils.DigitizedDocumentProcessing;
import com.cobiscorp.cloud.scheduler.utils.ReportsGenWithoutRegistration;

public class SecureConsent extends NotificationGeneric {

	private static final Logger LOGGER = Logger.getLogger(SecureConsent.class);

	private static ReportesAutoOnboardDTO inputData;
	private static ConsentSecurityBasicDTO inforForReport;

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
		List<ConsentSecurityBasicDTO> dataCollection = new ArrayList<ConsentSecurityBasicDTO>();
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
	public ConsentSecurityBasicDTO executeWithDTO(ReportesAutoOnboardDTO inputObject) {
		LOGGER.debug("Ingresa executeWithDTO -- objDatosEntrada:" + inputObject);

		Connection cn = null;
		CallableStatement executeSP = null;
		ConsentSecurityBasicDTO clientOfSecurityBasic = new ConsentSecurityBasicDTO();

		try {

			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			Integer customerId = inputObject.getCustomerId();
			Integer application = inputObject.getApplication();
			String name = "";

			PreparedStatement executeSPXml = null;

			try {
				/* Parametros de Asistencia Medica */
				List<InformationHeadLineDTO> listInformationHeadLine = new ArrayList<InformationHeadLineDTO>();
				LOGGER.debug("llamada al sp asistencia medica - cob_cartera..sp_conse_seguro");
				String queryXmlC = "{ call cob_cartera..sp_conse_seguro(?,?,?,?,?,?,?,?,?,?,?,?,?) }";
				executeSPXml = cn.prepareCall(queryXmlC);
				executeSPXml.setEscapeProcessing(true);
				executeSPXml.setInt(1, 0);
				executeSPXml.setInt(2, 0);
				executeSPXml.setString(3, null);
				executeSPXml.setString(4, null);
				executeSPXml.setString(5, null);
				executeSPXml.setDate(6, null);
				executeSPXml.setInt(7, 0);
				executeSPXml.setInt(8, 0);
				executeSPXml.setString(9, null);
				executeSPXml.setString(10, null);
				executeSPXml.setInt(11, customerId);// cliente
				executeSPXml.setString(12, "I");// operacion
				executeSPXml.setString(13, String.valueOf(application));// tramite

				ResultSet resultAsistencia = executeSPXml.executeQuery();

				LOGGER.debug("resultAsistencia---getRow:" + resultAsistencia.getRow());
				LOGGER.debug("resultAsistencia---resultAsistencia:" + resultAsistencia);

				InformationHeadLineDTO headLineDTO = new InformationHeadLineDTO();

				while (resultAsistencia.next()) {
					LOGGER.debug("Ingreso al while resultAsistencia:" + resultAsistencia.getString(1));
					name = name + " " + resultAsistencia.getString(1);
					headLineDTO.setFullName(resultAsistencia.getString(1));
					headLineDTO.setBirthDate(resultAsistencia.getString(2));

					listInformationHeadLine.add(headLineDTO);
				}

				// consulta de declaracion de beneficios
				List<BenefitsDeclareDTO> listBenefitsDeclare = new ArrayList<BenefitsDeclareDTO>();
				LOGGER.debug("llamada Declaracion Beneficios");
				BenefitsDeclareDTO benefitsDeclareDTO = new BenefitsDeclareDTO();
				listBenefitsDeclare.add(benefitsDeclareDTO);

				// informacion de cobertura
				List<BenefitsInformationTableDTO> listBenefitsInformationTable = new ArrayList<BenefitsInformationTableDTO>();
				LOGGER.debug("llamada Informacion de Cobertura");
				BenefitsInformationTableDTO benefitsInformationTableDTO = new BenefitsInformationTableDTO();
				listBenefitsInformationTable.add(benefitsInformationTableDTO);

				// almaceno datos del cliente
				ConsentOfSegurityDTO consentOfSegurityDTO = new ConsentOfSegurityDTO();
				consentOfSegurityDTO.setListInformationHeadLine(listInformationHeadLine);
				consentOfSegurityDTO.setListBenefitsDeclare(listBenefitsDeclare);
				consentOfSegurityDTO.setListBenefitsInformationTable(listBenefitsInformationTable);
				consentOfSegurityDTO.setFullNameP(name);

				List<ConsentOfSegurityDTO> listClientReport = new ArrayList<ConsentOfSegurityDTO>();
				listClientReport.add(consentOfSegurityDTO);

				/* Se setea todo a la clase principal */
				clientOfSecurityBasic.setListConsentSecurityBasic(listClientReport);

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
		return clientOfSecurityBasic;
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

			if (inforForReport.getListConsentSecurityBasic() != null) {

				Collection<ConsentSecurityBasicDTO> dataCol = new ArrayList<ConsentSecurityBasicDTO>();
				ConsentSecurityBasicDTO consentSecurityBasicDTO = (ConsentSecurityBasicDTO) inforForReport;
				dataCol.add(consentSecurityBasicDTO);

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