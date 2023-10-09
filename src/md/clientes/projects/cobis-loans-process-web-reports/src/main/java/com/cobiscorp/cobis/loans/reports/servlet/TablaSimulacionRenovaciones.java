package com.cobiscorp.cobis.loans.reports.servlet;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.TablaSimulacionDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.TablaSimulacionDetalleDTO;
import com.cobiscorp.cobis.loans.reports.impl.DataBeanTablaSimulacionListIMPL;
import com.cobiscorp.cobis.loans.reports.utils.UtilFunctions;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.SimulationCreditRenovatioHeaderResponse;
import cobiscorp.ecobis.loangroup.dto.SimulationCreditRenovatioResponse;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"),
		@Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "tablaSimulacion") })
public class TablaSimulacionRenovaciones implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {
	private static final ILogger logger = LogFactory.getLogger(TablaSimulacionRenovaciones.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logDebug("*****---Inicio Lista de Reporte Tabla De Simulación---*****");
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String amountRequested = (String) params.get(ConstantValue.Params.AMOUNT_REQUESTED);
		String termRequested = (String) params.get(ConstantValue.Params.TERM_REQUESTED);
		String nameRequested = (String) params.get(ConstantValue.Params.NAME_REQUESTED);
		String fechaRequested = String.valueOf((new Date()));
		Services services = new Services();

		TablaSimulacionDATABEAN tablaSimulacionDetalleDTO = new TablaSimulacionDATABEAN();

		Collection<TablaSimulacionDATABEAN> collection = new ArrayList<TablaSimulacionDATABEAN>();

		try {

			SimulationCreditRenovatioResponse[] simulationResponse = services.getSimulationRenovationData(sessionId, amountRequested, termRequested, serviceIntegration);

			if (simulationResponse != null) {

				List<TablaSimulacionDetalleDTO> tablaSimulacionDTO = new ArrayList<TablaSimulacionDetalleDTO>();
				tablaSimulacionDTO = DataBeanTablaSimulacionListIMPL.getDataBeanList(simulationResponse);
				tablaSimulacionDetalleDTO.setTablaSimulacion(tablaSimulacionDTO);

			}
			collection.add(tablaSimulacionDetalleDTO);

		} catch (Exception e) {
			logger.logError("Error al obtener el listado de Items de simulación: ", e);
			throw new RuntimeException(e);
		}

		logger.logDebug("*****---Finaliza Lista de Reporte Tabla De Simulación---*****");

		return new JRBeanCollectionDataSource(collection);

	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {

		logger.logDebug("*****--- Inicio obtención de parametros getParamsReport() ---*****");

		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String amountRequested = (String) params.get(ConstantValue.Params.AMOUNT_REQUESTED);
		String termRequested = (String) params.get(ConstantValue.Params.TERM_REQUESTED);
		String nameRequested = (String) params.get(ConstantValue.Params.NAME_REQUESTED);
		String fechaRequested = UtilFunctions.getDateFormater(new Date());
		Services services = new Services();
		Method method = new Method();

		logger.logDebug("Parametros obtenidos: " + amountRequested);
		logger.logDebug("Parametros obtenidos: " + termRequested);
		logger.logDebug("Parametros obtenidos: " + nameRequested);
		logger.logDebug("Parametros obtenidos: " + fechaRequested);
		logger.logDebug("Parametros obtenidos: " + sessionId);

		try {
			
			method.setPrmMain(params);

			method.mapValuesToParams("montoSolicitado", Double.parseDouble(amountRequested), "");
			method.mapValuesToParams("plazo", termRequested, "");
			method.mapValuesToParams("nombreCliente", nameRequested, "");
			method.mapValuesToParams("fechaCreacion", fechaRequested, "");
			
			// Carga del sg
			SimulationCreditRenovatioHeaderResponse[] simulationResponseHead = services.getSimulationRenovationDataHeader(sessionId, amountRequested, termRequested, serviceIntegration);
			
			if(simulationResponseHead != null) {
				
				method.mapValuesToParams("fechaDep", simulationResponseHead[0].getFechaDisp(), "");
				method.mapValuesToParams("fechaLiqui", simulationResponseHead[0].getFechaLiqui(), "");
				method.mapValuesToParams("cat", simulationResponseHead[0].getCat(), "");
				method.mapValuesToParams("tasaInteres", simulationResponseHead[0].getTasaInt(), "");

			}
			
		} catch (Exception e) {
			logger.logError("Error reporte Principal Tabla Amortizacion Ind: ", e);
			throw new RuntimeException(e);
		}
		params.put("urlPathSantander", ConstantValue.Params.URLIMAG);

		logger.logDebug("*****--- Finaliza obtención de parametros getParamsReport() ---*****");
		return params;
	}

	@Override
	public String getReportLocation(Map<String, Object> parameters) {
		return getFileLocationReport(ConstantValue.JasperPath.TABLA_SIMULACION);
	}

	private String getFileLocationReport(String planPagosReportJasper) {
		return ConstantValue.JasperPath.TABLA_SIMULACION;
	}

	@Override
	public String getGeneratedReportFilename(Map<String, Object> arg0) {
		return REPORTING_NAME_FILTER;
	}

	// Seguridad para presentar el reporte
	@Override
	public Boolean controlReportGeneration(Map<String, Object> arg0) {
		return true;
	}
}
