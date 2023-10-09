package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.configuration.ConfigManager;
import com.cobiscorp.cloud.notificationservice.dto.report.InfoLoanDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.ReportesAutoOnboardDTO;
import com.cobiscorp.cloud.scheduler.utils.ConstantValue;
import com.cobiscorp.cloud.scheduler.utils.DigitizedDocumentProcessing;
import com.cobiscorp.cloud.scheduler.utils.ReportsGenWithoutRegistration;
import com.cobiscorp.cloud.scheduler.utils.Util;

public class CaratulaSimpleIndAutoOnboard extends NotificationGeneric {

	private static final Logger LOGGER = Logger.getLogger(CaratulaSimpleIndAutoOnboard.class);

	private static ReportesAutoOnboardDTO inputData;
	private static InfoLoanDTO inforForReport;

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		LOGGER.debug("Ingresa a setParameterToJasper -->>datosEntrada:" + inputData);
		Map<String, Object> parameters = new HashMap<String, Object>();

		if (inforForReport != null) {
			LOGGER.debug("setParameterToJasper-->>caratula:" + inforForReport);

			// Mapeo de Datos al jasper
			parameters.put("costoAnualTotal", inforForReport.getTotalAnnualCost() != null ? inforForReport.getTotalAnnualCost().toString() : "");
			parameters.put("tasaInteresAnual", inforForReport.getAnnualInterestRate() != null ? inforForReport.getAnnualInterestRate().toString() : "");
			parameters.put("montoCredito", inforForReport.getCreditAmountDouble() != null ? Util.getStringCurrencyFormated(inforForReport.getCreditAmountDouble()) : "");
			parameters.put("montoTotalPagar",
					inforForReport.getTotalAmountPayableDouble() != null ? Util.getStringCurrencyFormated(inforForReport.getTotalAmountPayableDouble()) : "");
			parameters.put("listaComisiones", inforForReport.getCommissions() != null ? inforForReport.getCommissions() : "");
			parameters.put("porcentajeMora", inforForReport.getPercentageForDelay() != null ? inforForReport.getPercentageForDelay() : "");
			parameters.put("plazoCredito", inforForReport.getCrediTimeLimit() != null ? inforForReport.getCrediTimeLimit() : "");
			parameters.put("descripMoneda", inforForReport.getCurrencyDesc() != null ? inforForReport.getCurrencyDesc() : "");
			parameters.put("descripPlazo", inforForReport.getTimeLimitDesc() != null ? inforForReport.getTimeLimitDesc() : "");
			parameters.put("fechaLiquida", inforForReport.getDueDate() != null ? Util.fechaN(inforForReport.getDueDate()) : "");
			parameters.put("fechaPago", inforForReport.getPaymentDate() != null ? inforForReport.getPaymentDate() : "");
			parameters.put("fechaCorte", inforForReport.getProcessDate() != null ? inforForReport.getProcessDate() : "");
			parameters.put("seguro", "Obligatorio");

			String aseguradoraS = "";
			String aseguradoraPt1 = inforForReport.getInsurance1() != null ? inforForReport.getInsurance1() : "";
			String aseguradoraPt2 = inforForReport.getInsurance2() != null ? inforForReport.getInsurance2() : "";
			if (!"".equals(aseguradoraPt1)) {
				aseguradoraS = aseguradoraPt1;
			}
			if (!"".equals(aseguradoraPt2)) {
				aseguradoraS = aseguradoraS + aseguradoraPt2;
			}
			parameters.put("aseguradora", aseguradoraS);

			parameters.put("contraAdhesion", inforForReport.getCondusef() != null ? inforForReport.getCondusef() : "");
			parameters.put("footParam", inforForReport.getFooter() != null ? inforForReport.getFooter() : "");

			parameters.put("urlPathSantander", ConstantValue.URL_IMAGEN_TUIIO_II);

		}
		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		LOGGER.debug("Ingresa a setCollection");
		List<InfoLoanDTO> dataCollection = new ArrayList<InfoLoanDTO>();
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
	public InfoLoanDTO executeWithDTO(ReportesAutoOnboardDTO inputObject) {
		LOGGER.debug("Ingresa executeWithDTO -- objDatosEntrada:" + inputObject);

		Connection cn = null;
		CallableStatement executeSP = null;
		InfoLoanDTO infoLoanCaratulaDTO = new InfoLoanDTO();

		try {

			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			Integer application = inputObject.getApplication();

			PreparedStatement executeSPXml = null;

			try {

				/* Parametros de Caratula */
				LOGGER.debug("llamada al sp datos caratula - cob_credito..sp_datos_credito");
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
				executeSPXml.setString(14, "Q");// operacion
				executeSPXml.setInt(15, application);// tramite
				executeSPXml.setInt(16, 103);// formato fecha
				executeSPXml.setString(17, "D");

				ResultSet resultCaratula = executeSPXml.executeQuery();

				LOGGER.debug("resultCaratula---getRow:" + resultCaratula.getRow());
				LOGGER.debug("resultCaratula---resultCaratula:" + resultCaratula);

				// InfoLoanDTO infoLoanCaratulaDTO = new InfoLoanDTO();

				while (resultCaratula.next()) {
					LOGGER.debug("Ingreso al while resultCabecera:" + resultCaratula.getString(7));
					infoLoanCaratulaDTO.setTotalAnnualCost(resultCaratula.getDouble(1));
					infoLoanCaratulaDTO.setAnnualInterestRate(resultCaratula.getDouble(2));
					infoLoanCaratulaDTO.setCreditAmountDouble(resultCaratula.getDouble(3));
					infoLoanCaratulaDTO.setTotalAmountPayableDouble(resultCaratula.getDouble(4));
					infoLoanCaratulaDTO.setCommissions(resultCaratula.getString(5));
					infoLoanCaratulaDTO.setPercentageForDelay(resultCaratula.getDouble(6));
					infoLoanCaratulaDTO.setCrediTimeLimit(resultCaratula.getString(7));
					infoLoanCaratulaDTO.setCurrencyDesc(resultCaratula.getString(8));
					infoLoanCaratulaDTO.setTimeLimitDesc(resultCaratula.getString(9));

					Calendar cal = Calendar.getInstance();
					cal.setTime(resultCaratula.getDate(10, null));
					infoLoanCaratulaDTO.setDueDate(cal);

					infoLoanCaratulaDTO.setPaymentDate(resultCaratula.getString(11));
					infoLoanCaratulaDTO.setProcessDate(resultCaratula.getString(12));

					infoLoanCaratulaDTO.setInsurance1(resultCaratula.getString(13));
					infoLoanCaratulaDTO.setInsurance2(resultCaratula.getString(14));
					infoLoanCaratulaDTO.setCondusef(resultCaratula.getString(15));
					infoLoanCaratulaDTO.setFooter(resultCaratula.getString(16));
				}

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
		return infoLoanCaratulaDTO;
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

			if (inforForReport != null) {

				Collection<InfoLoanDTO> dataCol = new ArrayList<InfoLoanDTO>();
				InfoLoanDTO caratulaAutoOnboardDTO = (InfoLoanDTO) inforForReport;
				dataCol.add(caratulaAutoOnboardDTO);

				DigitizedDocumentProcessing update = new DigitizedDocumentProcessing();

				if (ReportsGenWithoutRegistration.generateReport(filePathNameReportGenerate, null, param, jasperFileName, dataCol)) {
					update.executeNotification(cn, executeSP, "U", customerCode, "T", documentCode, bank, filePathNameReportGenerate, 2,null); // TERMINADO
				} else {
					update.executeNotification(cn, executeSP, "U", customerCode, "E", documentCode, bank, filePathNameReportGenerate, 2,null);// ERROR
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