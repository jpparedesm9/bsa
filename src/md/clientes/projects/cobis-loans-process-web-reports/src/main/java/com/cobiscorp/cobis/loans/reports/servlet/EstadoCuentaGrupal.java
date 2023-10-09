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

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.EstadoCuentaGrupalDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.EstadoCuentaGrupalDTO;
import com.cobiscorp.cobis.loans.reports.impl.EstadoCuentaGrupalListIMPL;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "estadoCuentaGrupal") })
public class EstadoCuentaGrupal implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {

	private static final ILogger logger = LogFactory.getLogger(EstadoCuentaGrupal.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logDebug("*****>>Inicia Lista - Reporte Estado Cuenta Grupal");
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String bankCTS = (String) params.get(ConstantValue.Params.BANK);
		Collection<EstadoCuentaGrupalDATABEAN> collection = new ArrayList<EstadoCuentaGrupalDATABEAN>();
		Services services = new Services();
		
		try {
			logger.logDebug("*****>>Lista - Reporte Estado Cuenta Grupal idBank:" + bankCTS);
			EstadoCuentaGrupalListIMPL estadoCuentaGrupalListIMPL = new EstadoCuentaGrupalListIMPL();
			EstadoCuentaGrupalDATABEAN estadoCuentaGrupalDATABEAN = new EstadoCuentaGrupalDATABEAN();

			// Servicio
			ReportResponse[] reportResponseCreditSummary = services.getCreditSummary(sessionId, bankCTS, serviceIntegration);
			ReportResponse[] reportResponsePaymentPlan = services.getPaymentPlan(sessionId, bankCTS, serviceIntegration);

			// Listas
			List<EstadoCuentaGrupalDTO> resumenCredito = estadoCuentaGrupalListIMPL.getListSummaryCredit(reportResponseCreditSummary, sessionId, serviceIntegration);
			List<EstadoCuentaGrupalDTO> planPagos = estadoCuentaGrupalListIMPL.getListPaymentPlan(reportResponsePaymentPlan, sessionId, serviceIntegration);

			// Mapeo
			estadoCuentaGrupalDATABEAN.setResumenCredito(resumenCredito);
			estadoCuentaGrupalDATABEAN.setPlanPagos(planPagos);

			// Envio a Collection

			collection.add(estadoCuentaGrupalDATABEAN);

		} catch (Exception e) {
			if (logger.isDebugEnabled())
				logger.logDebug("*****>>Error Lista - Reporte Estado Cuenta Grupal:", e);
			throw new RuntimeException(e);
		}
		return new JRBeanCollectionDataSource(collection);
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		logger.logDebug("*****>>Inicia  - Reporte Estado Cuenta Grupal");
		// Datos Iniciales
		initParamHeader(params);
		try {
			String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
			String bankCTS = (String) params.get(ConstantValue.Params.BANK);
			Services services = new Services();
			Method method = new Method();
			
			logger.logDebug("*****>>Reporte Estado Cuenta Grupal idBank:" + bankCTS);

			method.setPrmMain(params);// Envia los parametros del metodo method.mapValuesToParams..
			// Informacion del grupo
			ReportResponse reportResponse = services.getInformationGroup(sessionId, bankCTS, serviceIntegration);

			logger.logDebug("*****>>Reporte Estado Cuenta Grupal-->getTerm:" + reportResponse);

			if (reportResponse != null) {
				method.mapValuesToParams("idCliente", reportResponse.getCode(), 0);
				method.mapValuesToParams("igNombreGrupo", reportResponse.getGroup(), "");
				method.mapValuesToParams("igSucursal", reportResponse.getBranchOffice(), "");
				method.mapValuesToParams("igAsesor", reportResponse.getAdviser(), "");
				method.mapValuesToParams("igDestino", reportResponse.getDestination(), "");
				method.mapValuesToParams("igReunionGrupo", reportResponse.getGroupMeetings(), "");
				method.mapValuesToParams("igCiclo", reportResponse.getCycle(), 0);
				method.mapValuesToParams("igMontoPrestado", reportResponse.getAmountBorrowed(), 0.0);
				method.mapValuesToParams("igAbreviaturaMoneda", reportResponse.getCurrencyAbbreviation(), "");
				method.mapValuesToParams("igPlazo", reportResponse.getTerm(), "");
				method.mapValuesToParams("igTasaInteres", reportResponse.getInterestRate(), 0.0);
				method.mapValuesToParams("igFechaEntrega", reportResponse.getDeliverDate(), "");
			}

		} catch (Exception e) {
			if (logger.isDebugEnabled())
				logger.logDebug("*****>>Error - Reporte Estado Cuenta Grupal:", e);
			throw new RuntimeException(e);
		}
		return params;
	}

	private void initParamHeader(Map<String, Object> params) {
		params.put("idCliente", 0);
		params.put("igNombreGrupo", "");
		params.put("igSucursal", "");
		params.put("igAsesor", "");
		params.put("igDestino", "");
		params.put("igReunionGrupo", "");
		params.put("igCiclo", 0);
		params.put("igMontoPrestado", 0.0);
		params.put("igAbreviaturaMoneda", "");
		params.put("igPlazo", "");
		params.put("igTasaInteres", 0.0);
		params.put("igFechaEntrega", "");
	}

	// Envio de nombres de los reportes.
	@Override
	public String getReportLocation(Map<String, Object> parameters) {
		return getFileLocationReport(ConstantValue.JasperPath.ESTADO_CUENTA_GRUPAL);
	}

	private String getFileLocationReport(String planPagosReportJasper) {
		return ConstantValue.JasperPath.ESTADO_CUENTA_GRUPAL;
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
