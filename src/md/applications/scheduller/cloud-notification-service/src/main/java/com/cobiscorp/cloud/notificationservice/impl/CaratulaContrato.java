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
import com.cobiscorp.cloud.notificationservice.dto.report.CaratulaContratoDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.ReportesAutoOnboardDTO;
import com.cobiscorp.cloud.scheduler.utils.ConstantValue;
import com.cobiscorp.cloud.scheduler.utils.DigitizedDocumentProcessing;
import com.cobiscorp.cloud.scheduler.utils.ReportsGenWithoutRegistration;

public class CaratulaContrato extends NotificationGeneric {

	private static final Logger LOGGER = Logger.getLogger(CaratulaContrato.class);

	private static ReportesAutoOnboardDTO inputData;
	private static CaratulaContratoDTO inforForReport;

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {

		LOGGER.debug("Ingresa a setParameterToJasper -->>datosEntrada:" + inputData);
		Map<String, Object> parameters = new HashMap<String, Object>();

		if (inforForReport != null) {

			parameters.put("montoTotalPagar", inforForReport.getMontoTotalPagar());
			parameters.put("listaComisiones", inforForReport.getListaComisiones());
			parameters.put("porcentajeMora", inforForReport.getPorcentajeMora());
			parameters.put("plazoCredito", inforForReport.getPlazoCredito());
			parameters.put("descripMoneda", inforForReport.getDescripMoneda());
			parameters.put("descripPlazo", inforForReport.getDescripPlazo());
			parameters.put("gracia", inforForReport.getGracia());
			parameters.put("costoAnualTotal", inforForReport.getCostoAnualTotal());
			parameters.put("nombreComercProd", inforForReport.getNombreComercProd());
			parameters.put("costoAnualTotal", inforForReport.getCostoAnualTotal());
			parameters.put("tasaInteresAnual", inforForReport.getTasaInteresAnual());
			parameters.put("montoCredito", inforForReport.getMontoCredito());
			parameters.put("montoTotalPagar", inforForReport.getMontoTotalPagar());
			parameters.put("fechaPago", inforForReport.getFechaPago());
			parameters.put("fechaCorte", inforForReport.getFechaCorte());
			parameters.put("seguro", inforForReport.getSeguro());
			parameters.put("aseguradora", inforForReport.getAseguradora());
			parameters.put("contraAdhesion", inforForReport.getContraAdhesion());
			parameters.put("pieAnio", inforForReport.getPieAnio());
			parameters.put("porCovit", inforForReport.getPorCovit());
			

		}

		parameters.put("urlPathSantander", ConstantValue.URL_IMAGEN_TUIIOSANTANDER2);

		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		LOGGER.debug("Ingresa a setCollection");
		List<CaratulaContratoDTO> dataCollection = new ArrayList<CaratulaContratoDTO>();
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
	public CaratulaContratoDTO executeWithDTO(ReportesAutoOnboardDTO inputObject) {
		LOGGER.debug("Ingresa executeWithDTO -- objDatosEntrada:" + inputObject);

		Connection cn = null;
		CallableStatement executeSP = null;
		CaratulaContratoDTO caratulaContratoDTO = new CaratulaContratoDTO();

		try {

			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			Integer application = inputObject.getApplication();

			PreparedStatement executeSPXml = null;

			try {
				/* Parametros de Caratula Contrato */

				LOGGER.debug("llamada al sp datos caratula contrato - cob_credito..sp_datos_reportes_miembro");
				String queryXmlC = "{ call cob_credito..sp_datos_reportes_miembro(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
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
				executeSPXml.setString(14, "Q2");// operacion
				executeSPXml.setInt(15, application);// tramite
				executeSPXml.setInt(16, 103);// formato fecha

				ResultSet resultReporte = executeSPXml.executeQuery();

				LOGGER.debug("resultReporte---getRow:" + resultReporte.getRow());
				LOGGER.debug("resultReporte---resultReporte:" + resultReporte);

				while (resultReporte.next()) {
					LOGGER.debug("Ingreso al while resultReporte:" + resultReporte.getString(2));

					caratulaContratoDTO.setCostoAnualTotal(resultReporte.getString(1));
					caratulaContratoDTO.setTasaInteresAnual(resultReporte.getString(2));
					caratulaContratoDTO.setMontoCredito(resultReporte.getString(3));
					caratulaContratoDTO.setMontoTotalPagar(resultReporte.getString(4));
					caratulaContratoDTO.setListaComisiones(resultReporte.getString(5));
					caratulaContratoDTO.setPorcentajeMora(Double.parseDouble(resultReporte.getString(6)));
					caratulaContratoDTO.setPlazoCredito(resultReporte.getString(7));
					caratulaContratoDTO.setDescripMoneda(resultReporte.getString(8));
					caratulaContratoDTO.setDescripPlazo(resultReporte.getString(9));
					caratulaContratoDTO.setFechaPago(resultReporte.getString(10));
					caratulaContratoDTO.setFechaCorte(resultReporte.getString(11));
					caratulaContratoDTO.setDesplazamiento(Integer.parseInt(resultReporte.getString(12)));
					caratulaContratoDTO.setGracia(resultReporte.getString(12));
					caratulaContratoDTO.setFechaLiquida(resultReporte.getString(13));
					caratulaContratoDTO.setNombreComercProd(resultReporte.getString(15));
					

				}
				
				
				LOGGER.debug("llamada al sp parametros caratula contrato - cob_credito..sp_datos_reportes_miembro");
				String queryXmlP = "{ call cob_credito..sp_datos_reportes_miembro(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
				executeSPXml = cn.prepareCall(queryXmlP);
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
				executeSPXml.setString(14, "Q4");// operacion
				executeSPXml.setInt(15, application);// tramite
				executeSPXml.setInt(16, 103);// formato fecha

				ResultSet resultReporteP = executeSPXml.executeQuery();

				LOGGER.debug("resultReporteP---getRow:" + resultReporteP.getRow());
				LOGGER.debug("resultReporteP---resultReporteP:" + resultReporteP);

				while (resultReporteP.next()) {
					LOGGER.debug("Ingreso al while resultReporteP:" + resultReporteP.getString(1));

					
					
					StringBuilder aseguradoraS = new StringBuilder();
					String seguroS = "";
					String aseguradora_pt1 = resultReporteP.getString(1);
					String aseguradora_pt2 = resultReporteP.getString(2);

					if (aseguradora_pt1 != null) {
						aseguradoraS.append(aseguradora_pt1);
					}

					if (aseguradora_pt2 != null) {
						aseguradoraS.append(aseguradora_pt2);
					}
					
					
					String porCovit = resultReporteP.getString(3);
									
					if (porCovit != null) {
						
						caratulaContratoDTO.setPorCovit(porCovit);	
					}

					
					if("S".equals(porCovit)) {
						caratulaContratoDTO.setAseguradora(aseguradoraS.toString());
					}else {
						caratulaContratoDTO.setAseguradora("");
					}
							
					

					
					// Pie de pagina -- PIE PERIODO REPORTES en SolicitudCreditoRevolventeIMPL, ContratoCreditoinclusion, 
					String pieAnio = resultReporteP.getString(8);
					if (pieAnio != null) {
						caratulaContratoDTO.setPieAnio(pieAnio);
					}

				

					// Cabecera RECA - Pie de pagina condusef -- este parametro tambien se usa en ContratoInclusionIndividual - ContratoInclusion
					String seguro = resultReporteP.getString(4);
					String seguro2 = resultReporteP.getString(5);
					if (seguro != null) {
						seguroS = seguro;
					}
					if (seguro2 != null) {
						seguroS = seguroS + seguro2;
					}
					
					if("S".equals(porCovit)) {
						caratulaContratoDTO.setSeguro(seguroS);

					}else {
						caratulaContratoDTO.setSeguro("(Obligatorio)");
					}
										
							
					
					if (caratulaContratoDTO.getDesplazamiento() > 0) {
						caratulaContratoDTO.setContraAdhesion(resultReporteP.getString(6));

					} else {
						caratulaContratoDTO.setContraAdhesion(resultReporteP.getString(7));

					}

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

		return caratulaContratoDTO;
	}

	public void executeByTransaction(JobExecutionContext arg0, Map<String, Object> param,
			String filePathNameReportGenerate, String jasperFileName) {
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

			LOGGER.debug("-->>executeByTransaction-->>datosReporte::" + inforForReport
					+ "-->>filePathNameReportGenerate:" + filePathNameReportGenerate);

			if (inforForReport != null) {

				Collection<CaratulaContratoDTO> dataCol = new ArrayList<CaratulaContratoDTO>();
				CaratulaContratoDTO contratoGrupalDTO = (CaratulaContratoDTO) inforForReport;
				dataCol.add(contratoGrupalDTO);

				DigitizedDocumentProcessing update = new DigitizedDocumentProcessing();

				if (ReportsGenWithoutRegistration.generateReport(filePathNameReportGenerate, null, param,
						jasperFileName, dataCol)) {
					update.executeNotification(cn, executeSP, "U", customerCode, "T", documentCode, bank,
							filePathNameReportGenerate, 2, null); // TERMINADO
				} else {
					update.executeNotification(cn, executeSP, "U", customerCode, "E", documentCode, bank,
							filePathNameReportGenerate, 2, null);// ERROR
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

	public void execute(Object inputDto, JobExecutionContext arg0, String filePathNameReportGenerate,
			String jasperFileName) throws JobExecutionException {
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
