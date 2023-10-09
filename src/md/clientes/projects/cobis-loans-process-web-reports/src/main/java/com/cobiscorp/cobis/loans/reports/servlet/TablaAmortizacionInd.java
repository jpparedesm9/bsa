package com.cobiscorp.cobis.loans.reports.servlet;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.TablaAmortizationIndDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.TablaAmortizacionIndDetalleDTO;
import com.cobiscorp.cobis.loans.reports.impl.DataBeanTablaAmortizationIndListIMPL;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ReportResponse;
import cobiscorp.ecobis.loanprocess.dto.LoanInfResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"),
		@Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "tablaAmortizacionSimpleIndAutoOnboard") })
public class TablaAmortizacionInd implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {
	private static final ILogger logger = LogFactory.getLogger(TablaAmortizacionInd.class);
	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logDebug("*****---Inicio Lista de Reporte Tabla De Amortizacion IND");
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String bankCTS = (String) params.get(ConstantValue.Params.BANK);
		String application = (String) params.get(ConstantValue.Params.APPLICATION);
		Services services = new Services();

		TablaAmortizationIndDATABEAN tablaAmortizacionDetalleDTO = new TablaAmortizationIndDATABEAN();

		Collection<TablaAmortizationIndDATABEAN> collection = new ArrayList<TablaAmortizationIndDATABEAN>();

		try {
			if (application != null) {
				LoanInfResponse loanData = services.getLoanData(sessionId, application, serviceIntegration);
				bankCTS = loanData.getOperationId();
			}
			logger.logDebug(" *****--- NUM BANK EN SUB REPORTE-bankCTS: " + bankCTS);

			// Con el modo dos trae la informacion dependiendo si la operacion es grupal o
			// individual
			ReportResponse[] reportResponsePrincipal = services.getDisbursementOrderDetail(sessionId, bankCTS, "2", 2, serviceIntegration);
			// inicia Mapeo
			if (reportResponsePrincipal != null) {
				for (int i = 0; i < reportResponsePrincipal.length; i++) {
					logger.logDebug("----->>>Inicio metodo --getDataBeanListContenidoInd -- refTablaAmortizacionP[i].getBank():" + reportResponsePrincipal[i].getBank());
					// Tabla
					List<TablaAmortizacionIndDetalleDTO> tablaAmortizacionIndDTO = new ArrayList<TablaAmortizacionIndDetalleDTO>();
					ReportResponse[] reportResponseHeaderDetail = services.getAmortizationTableDetail(sessionId, reportResponsePrincipal[i].getBank(), serviceIntegration);
					tablaAmortizacionIndDTO = DataBeanTablaAmortizationIndListIMPL.getDataBeanList(reportResponseHeaderDetail);
					tablaAmortizacionDetalleDTO.setTablaAmortizacion(tablaAmortizacionIndDTO);
				}
			} else {
				tablaAmortizacionDetalleDTO = DataBeanTablaAmortizationIndListIMPL.dataContenido();
			}
			collection.add(tablaAmortizacionDetalleDTO);

		} catch (Exception e) {
			logger.logError("Error en lista de Items de amoritización IND: ", e);
			throw new RuntimeException(e);
		}
		return new JRBeanCollectionDataSource(collection);

	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {

		String bankCTS = (String) params.get(ConstantValue.Params.BANK);
		String periodicity = "";
		String application = (String) params.get(ConstantValue.Params.APPLICATION);
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		Method method = new Method();
		Services services = new Services();

		try {
			method.setPrmMain(params);
			params.put("urlPathSantander", ConstantValue.Params.URLIMAG);

			if (application != null) {
				LoanInfResponse loanData = services.getLoanData(sessionId, application, serviceIntegration);
				bankCTS = loanData.getOperationId();
				periodicity = loanData.getTermType();
			}

			logger.logDebug("Reporte Tabla de Amortizacion IND- Principal - application: " + application);
			logger.logDebug("Reporte Tabla de Amortizacion IND- Principal - bankCTS: " + bankCTS);

			// Con el modo dos trae la informacion dependiendo si la operacion es grupal o
			// individual

			ReportResponse reportResponseHeader = services.getAmortizationTableHeader(sessionId, bankCTS, serviceIntegration);

			logger.logDebug("Nuevo*********************: " + bankCTS);

			if (reportResponseHeader != null) {
				logger.logDebug("Reporte Tabla de Amortizacion IND- Principal - reportResponseHeader.getGroup(): " + reportResponseHeader.getGroup());
				method.mapValuesToParams("clienteNombre", reportResponseHeader.getGroup(), "");
				method.mapValuesToParams("fechaSistema", reportResponseHeader.getDate(), "");
				method.mapValuesToParams("fechaDesembolso", reportResponseHeader.getDisbursementDate(), "");
				method.mapValuesToParams("fechaLiquidacion", reportResponseHeader.getLiquidationDate(), "");
			}

			method.mapValuesToParams("numeroTramite", bankCTS, "");
			method.mapValuesToParams("periodicidad", periodicity, "");

			// texto condusef -- este parametro tambien se usa en Caratula Contrato Credito
			String condusef = "";
			//ParameterResponse recaParrafo = services.getParameter(4, "RDRECA", Mnemonic.MODULE, serviceIntegration, sessionId);
			ParameterResponse recaParrafo = services.getParameter(4, "CRSIAO", Mnemonic.MODULE, serviceIntegration, sessionId); //caso185412 igual al de onboarding
			logger.logInfo("paramRECAParrafo ContratoCreditoInclusion " + recaParrafo);
			if (recaParrafo != null) {
				condusef = recaParrafo.getParameterValue();
			}
			method.mapValuesToParams("condusef", condusef, "");

			String footParam = "";
			//ParameterResponse foot = services.getParameter(4, "REPCRI", Mnemonic.MODULE, serviceIntegration, sessionId);
			ParameterResponse foot = services.getParameter(4, "PCTSIO", Mnemonic.MODULE, serviceIntegration, sessionId); //caso185412 igual al de onboarding			
			logger.logInfo("footParam ContratoCreditoInclusionIndividual " + foot.getParameterValue());
			if (foot != null) {
				footParam = foot.getParameterValue();
			}
			method.mapValuesToParams("footParam", footParam, "");

		} catch (Exception e) {
			logger.logError("Error reporte Principal Tabla Amortizacion Ind: ", e);
			throw new RuntimeException(e);
		}
		return params;
	}

	@Override
	public String getReportLocation(Map<String, Object> parameters) {
		return getFileLocationReport(ConstantValue.JasperPath.TABLA_AMORTIZACION_IND_ONB);
	}

	private String getFileLocationReport(String planPagosReportJasper) {
		return ConstantValue.JasperPath.TABLA_AMORTIZACION_IND_ONB;
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
