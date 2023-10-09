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
import com.cobiscorp.cloud.notificationservice.dto.report.ReportesAutoOnboardDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.TablaAmortizacionDetalleDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.TablaAmortizacionMainPDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.TablaAmortizacionSimplificadaDTO;
import com.cobiscorp.cloud.scheduler.utils.ConstantValue;
import com.cobiscorp.cloud.scheduler.utils.DigitizedDocumentProcessing;
import com.cobiscorp.cloud.scheduler.utils.ReportsGenWithoutRegistration;

public class TablaAmortizacionSimplificado extends NotificationGeneric {

	private static final Logger LOGGER = Logger.getLogger(TablaAmortizacionSimplificado.class);

	private static ReportesAutoOnboardDTO inputData;
	private static TablaAmortizacionSimplificadaDTO inforForReport;

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		LOGGER.debug("Ingresa a setParameterToJasper -->>datosEntrada:" + inputData);
		Map<String, Object> parameters = new HashMap<String, Object>();

		if (inforForReport != null) {
			TablaAmortizacionMainPDTO aMainParameters = inforForReport.getMainParameters();
			LOGGER.debug("setParameterToJasper-->>aMainParameters:" + aMainParameters);

			if (aMainParameters != null) {
				// Mapeo de Datos al jaspers inicial
				parameters.put("nombreGrupo", aMainParameters.getNombreGrupo());
				parameters.put("fechaDesembolso", aMainParameters.getFechaDesembolso());
				parameters.put("fechaLiquidacion", aMainParameters.getFechaLiquidacion());
				parameters.put("fechaContrato", aMainParameters.getFechaContrato());
				parameters.put("condusef", aMainParameters.getCondusef());
				parameters.put("pieAnio", aMainParameters.getPieAnio());
				parameters.put("numContrato", aMainParameters.getNumContrato());
				parameters.put("porCovit", "N");
				parameters.put("urlPathSantander", ConstantValue.URL_IMAGEN_TUIIO_II);
			}
		}
		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		LOGGER.debug("Ingresa a setCollection");
		List<TablaAmortizacionSimplificadaDTO> dataCollection = new ArrayList<TablaAmortizacionSimplificadaDTO>();

		return dataCollection;
	}

	/* No borrar el metdodo xmlToDTO se requiere para la clase */
	@Override
	public List<?> xmlToDTO(File inputData) {
		LOGGER.debug("Ingresa a Test xmlToDTO");
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
	public TablaAmortizacionSimplificadaDTO executeWithDTO(ReportesAutoOnboardDTO inputObject) {
		LOGGER.debug("Ingresa executeWithDTO -- objDatosEntrada:" + inputObject);

		Connection cn = null;
		CallableStatement executeSP = null;
		TablaAmortizacionSimplificadaDTO tablaAmortizacionSimplificadaDTO = new TablaAmortizacionSimplificadaDTO();

		try {

			ConfigManager ds = ConfigManager.getInstance();
			cn = DriverManager.getConnection(ds.getUrl(), ds.getUsername(), ds.getPasswod());

			String bank = inputObject.getBank();

			PreparedStatement executeSPXml = null;

			try {

				/* Parametros de Tabla de Amortizacion */
				LOGGER.debug("primera llamada al sp tabla amortizacion cabecera - sp_imp_tabla_grupo");
				String queryXmlC = "{ call cob_cartera..sp_imp_tabla_grupo(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
				executeSPXml = cn.prepareCall(queryXmlC);
				executeSPXml.setEscapeProcessing(true);
				executeSPXml.setInt(1, 0);
				executeSPXml.setDate(2, null);
				executeSPXml.setString(3, null);
				executeSPXml.setString(4, null);
				executeSPXml.setString(5, null);
				executeSPXml.setInt(6, 0);
				executeSPXml.setInt(7, 0);
				executeSPXml.setString(8, null);
				executeSPXml.setString(9, null);
				executeSPXml.setString(10, null);
				executeSPXml.setInt(11, 0);
				executeSPXml.setString(12, "C");
				executeSPXml.setString(13, bank);
				executeSPXml.setInt(14, 103);
				executeSPXml.setInt(15, 0);
				ResultSet resultCabecera = executeSPXml.executeQuery();

				LOGGER.debug("resultCabecera---getRow:" + resultCabecera.getRow());
				LOGGER.debug("resultCabecera---resultCabecera:" + resultCabecera);

				TablaAmortizacionMainPDTO aMainParameters = new TablaAmortizacionMainPDTO();
				while (resultCabecera.next()) {
					LOGGER.debug("Ingreso al while resultCabecera:" + resultCabecera.getString(7));

					aMainParameters.setNombreGrupo(resultCabecera.getString(7));
					aMainParameters.setFechaDesembolso(resultCabecera.getString(10));
					aMainParameters.setFechaLiquidacion(resultCabecera.getString(11));
					aMainParameters.setFechaContrato(resultCabecera.getString(1));
					aMainParameters.setCondusef(resultCabecera.getString(13));
					aMainParameters.setPieAnio(resultCabecera.getString(14));
					aMainParameters.setNumContrato(bank);
				}

				/* Lista de Tabla de Amortizacion */
				List<TablaAmortizacionDetalleDTO> tablaAmortizacionDetalleDTODList = new ArrayList<TablaAmortizacionDetalleDTO>();
				LOGGER.debug("primera llamada al sp tabla amortizacion detalle - sp_imp_tabla_grupo");
				String queryXmlT = "{ call cob_cartera..sp_imp_tabla_grupo(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";

				executeSPXml = cn.prepareCall(queryXmlT);
				executeSPXml.setEscapeProcessing(true);
				executeSPXml.setInt(1, 0);
				executeSPXml.setDate(2, null);
				executeSPXml.setString(3, null);
				executeSPXml.setString(4, null);
				executeSPXml.setString(5, null);
				executeSPXml.setInt(6, 0);
				executeSPXml.setInt(7, 0);
				executeSPXml.setString(8, null);
				executeSPXml.setString(9, null);
				executeSPXml.setString(10, null);
				executeSPXml.setInt(11, 0);
				executeSPXml.setString(12, "T");
				executeSPXml.setString(13, bank);
				executeSPXml.setInt(14, 103);
				executeSPXml.setInt(15, 0);

				ResultSet resultDetalle = executeSPXml.executeQuery();
				LOGGER.debug("resultTablaAmort---getRow:" + resultDetalle.getRow() + "-->>>banco: " + bank);
				LOGGER.debug("resultTablaAmort---resultTablaAmort:" + resultDetalle);

				while (resultDetalle.next()) {
					LOGGER.debug("Ingreso al while resultCabecera:" + resultDetalle.getString(2));
					TablaAmortizacionDetalleDTO tablaAmortizacionDetalleDTO = new TablaAmortizacionDetalleDTO();

					tablaAmortizacionDetalleDTO.setExpirationDate(resultDetalle.getString(2));
					tablaAmortizacionDetalleDTO.setDividend(resultDetalle.getInt(1));
					tablaAmortizacionDetalleDTO.setOrdinarInterest(resultDetalle.getDouble(5));
					tablaAmortizacionDetalleDTO.setAbonoPrincipal(resultDetalle.getDouble(4));
					tablaAmortizacionDetalleDTO.setSaldoInsoCap(resultDetalle.getDouble(3));
					tablaAmortizacionDetalleDTO.setMontoPago(resultDetalle.getDouble(8));

					tablaAmortizacionDetalleDTODList.add(tablaAmortizacionDetalleDTO);
				}

				/* Se setea todo a la clase principal */
				tablaAmortizacionSimplificadaDTO.setMainParameters(aMainParameters);
				tablaAmortizacionSimplificadaDTO.setTablaAmortizacion(tablaAmortizacionDetalleDTODList);

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
		return tablaAmortizacionSimplificadaDTO;
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

			if (inforForReport.getMainParameters() != null && inforForReport.getTablaAmortizacion() != null) {

				Collection<TablaAmortizacionSimplificadaDTO> dataCol = new ArrayList<TablaAmortizacionSimplificadaDTO>();
				TablaAmortizacionSimplificadaDTO tablaAmortizacionSimplificadaDTO = (TablaAmortizacionSimplificadaDTO) inforForReport;
				dataCol.add(tablaAmortizacionSimplificadaDTO);

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