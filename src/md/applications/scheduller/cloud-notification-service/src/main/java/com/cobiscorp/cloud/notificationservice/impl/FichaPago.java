package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.math.BigDecimal;
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
import com.cobiscorp.cloud.notificationservice.dto.report.FichaDePagoDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.FichaDePagoMainPDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.FichaDePagoSubDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.ReportesAutoOnboardDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.TAmortSimpleIndAutoOnboardDTO;
import com.cobiscorp.cloud.scheduler.utils.BarCodeGenerator;
import com.cobiscorp.cloud.scheduler.utils.DigitizedDocumentProcessing;
import com.cobiscorp.cloud.scheduler.utils.ReportsGenWithoutRegistration;

public class FichaPago extends NotificationGeneric {

	private static final Logger LOGGER = Logger.getLogger(FichaPago.class);

	private static ReportesAutoOnboardDTO inputData;
	private static FichaDePagoDTO inforForReport;

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		LOGGER.debug("Ingresa a setParameterToJasper -->>datosEntrada:" + inputData);
		Map<String, Object> parameters = new HashMap<String, Object>();

		if (inforForReport != null) {
			FichaDePagoMainPDTO aMainParameters = inforForReport.getMainParameters();
			LOGGER.debug("setParameterToJasper-->>aMainParameters:" + aMainParameters);

			if (aMainParameters != null) {
				// Mapeo de Datos al jaspers inicial
				parameters.put("FECINICIOCREDITO", aMainParameters.getFECINICIOCREDITO());
				parameters.put("NOMBRECLIENTE", aMainParameters.getNOMBRECLIENTE());
				parameters.put("FECVIGENCIA", aMainParameters.getFECVIGENCIA());
				parameters.put("MONTOPAGO", aMainParameters.getMONTOPAGO());
				parameters.put("SUCURSAL", aMainParameters.getSUCURSAL());
				parameters.put("NOPAGO", aMainParameters.getNOPAGO());
				parameters.put("PIEPAGINA", aMainParameters.getPIEPAGINA());
			}
		}
		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		LOGGER.debug("Ingresa a setCollection");
		List<TAmortSimpleIndAutoOnboardDTO> dataCollection = new ArrayList<TAmortSimpleIndAutoOnboardDTO>();
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
	public FichaDePagoDTO executeWithDTO(ReportesAutoOnboardDTO inputObject) {
		LOGGER.debug("Ingresa executeWithDTO -- objDatosEntrada:" + inputObject);

		Connection cn = null;
		CallableStatement executeSP = null;
		FichaDePagoDTO fichaDePagoDTO = new FichaDePagoDTO();

		try {

			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			String bank = inputObject.getBank();

			PreparedStatement executeSPXml = null;

			try {

				//Ingresa Datos a las tablas
				LOGGER.debug("llamada al sp sp_gen_ficha_pago con el numero de banco: " + bank);
				String queryXmlI = "{ call cob_cartera..sp_gen_ficha_pago(?,?) }";
				executeSPXml = cn.prepareCall(queryXmlI);
				executeSPXml.setEscapeProcessing(true);
				executeSPXml.setString(1, bank);
				executeSPXml.setString(2, "I");
				executeSPXml.execute();
								
				// Consulta de las tablas
				LOGGER.debug("llamada al sp sp_gen_ficha_pago con el numero de banco: " + bank);
				String queryXmlC = "{ call cob_cartera..sp_gen_ficha_pago(?,?) }";
				executeSPXml = cn.prepareCall(queryXmlC);
				executeSPXml.setEscapeProcessing(true);
				executeSPXml.setString(1, bank);
				executeSPXml.setString(2, "Q");
				ResultSet result = executeSPXml.executeQuery();

				LOGGER.debug("resultCabecera---resultCabecera:" + result);
				LOGGER.debug("resultCabecera---getRow:" + result.getRow());

				FichaDePagoMainPDTO aMainParameters = new FichaDePagoMainPDTO();

				while (result.next()) {
					LOGGER.debug("Ingreso al while resultCabecera:" + result.getString(7));
					aMainParameters.setFECINICIOCREDITO(result.getDate(1));
					aMainParameters.setNOMBRECLIENTE(result.getString(2));
					aMainParameters.setFECVIGENCIA(result.getDate(3));
					aMainParameters.setNOPAGO(result.getInt(4));
					aMainParameters.setMONTOPAGO(new BigDecimal(result.getString(5)));
					aMainParameters.setSUCURSAL(result.getString(6));
				}

				ResultSet resultReferencias = executeSPXml.executeQuery();
				LOGGER.debug("resultFichaDePago---getRow:" + resultReferencias.getRow() + "-->>>banco: " + bank);
				LOGGER.debug("resultFichaDePago---resultFichaDePago:" + resultReferencias);

				List<FichaDePagoSubDTO> referencias = new ArrayList<FichaDePagoSubDTO>();
				BarCodeGenerator barCodeGenerator = new BarCodeGenerator();
				while (resultReferencias.next()) {
					LOGGER.debug("Ingreso al while resultCabecera:" + resultReferencias.getString(2));
					FichaDePagoSubDTO aFichaDePago = new FichaDePagoSubDTO();

					aFichaDePago.setInstitucion(resultReferencias.getString(7));
					aFichaDePago.setReferencia(resultReferencias.getString(8));
					aFichaDePago.setNroConvenio(resultReferencias.getString(9));
					aFichaDePago.setBarCode(barCodeGenerator.createBarCode128(resultReferencias.getString(8), aMainParameters.getSUCURSAL(), resultReferencias.getString(7)));
					referencias.add(aFichaDePago);
				}
				
				// Consulta de las tablas pie de pagina
				LOGGER.debug("inicia cob_cartera..sp_pie_pagina_notificacion");
				String query = "{ call cob_cartera..sp_pie_pagina_notificacion() }";
				executeSP = cn.prepareCall(query);
				executeSP.execute();

				ResultSet resultP = executeSP.getResultSet();
				
				StringBuilder piePagina = new StringBuilder();
				
				if (resultP != null) {
					while (resultP.next()) {
						piePagina.append(resultP.getString(1));
						piePagina.append("\n");
					}
					aMainParameters.setPIEPAGINA(piePagina.toString());
				}
				
				/* Se setea todo a la clase principal */
				fichaDePagoDTO.setMainParameters(aMainParameters);
				fichaDePagoDTO.setReferencias(referencias);

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
		return fichaDePagoDTO;
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

			if (inforForReport.getMainParameters() != null && inforForReport.getReferencias() != null) {

				Collection<FichaDePagoDTO> dataCol = new ArrayList<FichaDePagoDTO>();
				FichaDePagoDTO fichaDePagoDTO = (FichaDePagoDTO) inforForReport;
				dataCol.add(fichaDePagoDTO);

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