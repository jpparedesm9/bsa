package com.cobiscorp.cobis.loans.reports.servlet;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ReportResponse;
import cobiscorp.ecobis.loanprocess.dto.LoanInfResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.TablaAmortizationDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.TablaAmortizacionDetalleDTO;
import com.cobiscorp.cobis.loans.reports.impl.DataBeanTablaAmortizationListIMPL;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"),
		@Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "tablaAmortizacion") })
public class TablaAmortizacion implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {
	private static final ILogger logger = LogFactory.getLogger(TablaAmortizacion.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logDebug("*****---Inicio Lista de Reporte Tabla De Amortizacion GRUP");
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String bankCTS = (String) params.get(ConstantValue.Params.BANK);
		String application = (String) params.get(ConstantValue.Params.APPLICATION);
		Services services = new Services();

		TablaAmortizationDATABEAN tablaAmortizacionDetalleDTO = new TablaAmortizationDATABEAN();

		Collection<TablaAmortizationDATABEAN> collection = new ArrayList<TablaAmortizationDATABEAN>();

		try {
			if (application != null) {
				LoanInfResponse loanData = services.getLoanData(sessionId, application, serviceIntegration);
				bankCTS = loanData.getOperationId();
			}
			logger.logDebug(" *****--- NUM BANK EN SUB REPORTE-bankCTS: " + bankCTS);
			// Con el modo dos trae la informacion dependiendo si la operacion es grupal o individual
			ReportResponse[] reportResponsePrincipal = services.getDisbursementOrderDetail(sessionId, bankCTS, "2", 2, serviceIntegration);
			// inicia Mapeo
			if (reportResponsePrincipal != null) {
				// Tabla
				List<TablaAmortizacionDetalleDTO> tablaAmortizacionIndDTO = new ArrayList<TablaAmortizacionDetalleDTO>();
				ReportResponse[] reportResponseHeaderDetail = services.getAmortizationTableDetail(sessionId, bankCTS, serviceIntegration);
				tablaAmortizacionIndDTO = DataBeanTablaAmortizationListIMPL.getDataBeanList(reportResponseHeaderDetail);
				tablaAmortizacionDetalleDTO.setTablaAmortizacion(tablaAmortizacionIndDTO);

			} else {
				tablaAmortizacionDetalleDTO = DataBeanTablaAmortizationListIMPL.dataContenido();
			}
			collection.add(tablaAmortizacionDetalleDTO);

		} catch (Exception e) {
			logger.logError("Error en lista de Items de amoritización GRUP: ", e);
			throw new RuntimeException(e);
		}
		return new JRBeanCollectionDataSource(collection);

	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {

		String bankCTS = (String) params.get(ConstantValue.Params.BANK);
		String application = (String) params.get(ConstantValue.Params.APPLICATION);
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		Services services = new Services();
		Method method = new Method();
		logger.logDebug("Reporte Tabla de Amortizacion - Principal - application: " + application);
		logger.logDebug("Reporte Tabla de Amortizacion - Principal - bankCTS: " + bankCTS);

		try {
			method.setPrmMain(params);
			if (application != null) {
				LoanInfResponse loanData = services.getLoanData(sessionId, application, serviceIntegration);
				bankCTS = loanData.getOperationId();
			}

			logger.logDebug("Reporte Tabla de Amortizacion GRUP- Principal - application: " + application);
			logger.logDebug("Reporte Tabla de Amortizacion GRUP- Principal - bankCTS: " + bankCTS);

			// Con el modo dos trae la informacion dependiendo si la operacion es grupal o individual

			ReportResponse reportResponseHeader = services.getAmortizationTableHeader(sessionId, bankCTS, serviceIntegration);

			if (reportResponseHeader != null) {
				method.mapValuesToParams("nombreGrupo", reportResponseHeader.getGroup(), "");
				method.mapValuesToParams("fechaDesembolso", reportResponseHeader.getDisbursementDate(), "");
				method.mapValuesToParams("fechaLiquidacion", reportResponseHeader.getLiquidationDate(), "");
			}

			// Cabecera RECA - Pie de pagina condusef -- este parametro tambien se usa en ContratoInclusionIndividual
			String paramRECA = "";
			int gracia = reportResponseHeader.getDisplacement() == null ? 0 : Integer.valueOf(reportResponseHeader.getDisplacement());
			logger.logInfo("PMO displacement tabla amortizacion " + reportResponseHeader.getDisplacement());

			logger.logInfo("PMO gracia amortizacion " + gracia);
			
			if (gracia > 0) {
				paramRECA = "RDRECA";
			} else {
				paramRECA = "RECASG";
			}

			logger.logInfo("PMO paramRECA amortizacion" + paramRECA);

			ParameterResponse reca = services.getParameter(4, paramRECA, Mnemonic.MODULE, serviceIntegration, sessionId);
			logger.logInfo("PMO reca amortizacion " + reca);
			method.mapValuesToParams("condusef", reca.getParameterValue(), "");

			// Titulo y cabecera
			ParameterResponse porCovit = services.getParameter(4, "DESCUO", Mnemonic.MODULECCA, serviceIntegration, sessionId);
			method.mapValuesToParams("porCovit", "N", "");
			logger.logError("----------------->>>>>>>>>>>>" + porCovit.getParameterValue());
			if (porCovit != null) {
				// porCovit = S (muestra titulo por covit) o N (muestra titulo normal)
				method.mapValuesToParams("porCovit", porCovit.getParameterValue().trim(), "");
			}

			// Pie de pagina -- PIE PERIODO REPORTES en SolicitudCreditoRevolventeIMPL, CaratulaCreditoRevolvente.java,
			ParameterResponse pieAnio = services.getParameter(4, "PPREPA", Mnemonic.MODULE, serviceIntegration, sessionId);
			if (pieAnio != null) {
				method.mapValuesToParams("pieAnio", pieAnio.getParameterValue(), "");
			}

			method.mapValuesToParams("numContrato", bankCTS, "");

		} catch (Exception e) {
			logger.logError("Error reporte Principal Tabla Amortizacion Ind: ", e);
			throw new RuntimeException(e);
		}
		params.put("urlPathSantander", ConstantValue.Params.URLIMAG);

		return params;
	}

	@Override
	public String getReportLocation(Map<String, Object> parameters) {
		return getFileLocationReport(ConstantValue.JasperPath.TABLA_AMORTIZACION);
	}

	private String getFileLocationReport(String planPagosReportJasper) {
		return ConstantValue.JasperPath.TABLA_AMORTIZACION;
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
