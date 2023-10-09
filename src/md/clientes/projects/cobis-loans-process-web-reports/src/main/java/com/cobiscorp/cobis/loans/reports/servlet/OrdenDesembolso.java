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
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.OrdenDesembolsoPrincipalDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.OrdenDesembolsoPrincipalDTO;
import com.cobiscorp.cobis.loans.reports.impl.OrdenDesembolsoListIMPL;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "ordenDesembolso") })
public class OrdenDesembolso implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {

	private static final ILogger logger = LogFactory.getLogger(OrdenDesembolso.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logDebug("*****>>Inicia Lista - Orden de Desembolso Grupal");
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String bankCTS = (String) params.get(ConstantValue.Params.BANK);
		Collection<OrdenDesembolsoPrincipalDATABEAN> collection = new ArrayList<OrdenDesembolsoPrincipalDATABEAN>();
		Services services = new Services();

		try {

			logger.logDebug("*****>>Lista - Reporte Orden de Desembolso idBank:" + bankCTS);
			OrdenDesembolsoListIMPL ordenDesembolsoListIMPL = new OrdenDesembolsoListIMPL();
			OrdenDesembolsoPrincipalDATABEAN ordenDesembolsoPrincipalDATABEAN = new OrdenDesembolsoPrincipalDATABEAN();

			// Servicio
			ReportResponse[] reportResponseOrdenDesembolsoPrincipal = services.getDisbursementOrderDetail(sessionId, bankCTS, "2", 2, serviceIntegration);

			// Listas
			List<OrdenDesembolsoPrincipalDTO> ordenDesembolsoPrincipal = ordenDesembolsoListIMPL.getListOrdenDesembolsoPrincipal(reportResponseOrdenDesembolsoPrincipal, sessionId, serviceIntegration);

			// Mapeo
			ordenDesembolsoPrincipalDATABEAN.setDetallePrincipal(ordenDesembolsoPrincipal);

			// Envio a Collection
			
			collection.add(ordenDesembolsoPrincipalDATABEAN);
			

		} catch (Exception e) {
			if (logger.isDebugEnabled())
				logger.logDebug("*****>>Error Lista - Reporte Orden de Desembolso:", e);
			throw new RuntimeException(e);
		}
		return new JRBeanCollectionDataSource(collection);
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		logger.logDebug("*****>>Inicia  - Reporte Orden de Desembolso SIn contenido");
		/*try {
			String bankCTS = (String) params.get(ConstantValue.Params.BANK);
			logger.logDebug("*****>>Reporte Orden de Desembolso idBank:" + bankCTS + "--Nada de mapeo directo");
		} catch (Exception e) {
			if (logger.isDebugEnabled())
				logger.logDebug("*****>>Error - Reporte Orden de Desembolso", e);
			throw new RuntimeException(e);
		}*/
		return params;
	}

	// Envio de nombres de los reportes.
	@Override
	public String getReportLocation(Map<String, Object> parameters) {
		return getFileLocationReport(ConstantValue.JasperPath.ORDEN_DESEMBOLSO);
	}

	private String getFileLocationReport(String planPagosReportJasper) {
		return ConstantValue.JasperPath.ORDEN_DESEMBOLSO;
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
