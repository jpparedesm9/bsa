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
import com.cobiscorp.cobis.loans.reports.dataBean.EstadoCuentaConsolidadoDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.EstadoCuentaConsolidadoDTO;
import com.cobiscorp.cobis.loans.reports.impl.EstadoCuentaConsolidadoListIMPL;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "estadoCuentaConsolidado") })
public class EstadoCuentaConsolidado implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {

	private static final ILogger logger = LogFactory.getLogger(EstadoCuentaConsolidado.class);
	


	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logDebug("*****>>Inicia Lista - Reporte EstadoCuentaConsolidado");
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String bankCTS = (String) params.get(ConstantValue.Params.BANK);
		Collection<EstadoCuentaConsolidadoDATABEAN> collection = new ArrayList<EstadoCuentaConsolidadoDATABEAN>();
		Services services = new Services();
		
		try {
			logger.logDebug("*****>>Lista - Reporte EstadoCuentaConsolidado idBank:" + bankCTS);
			EstadoCuentaConsolidadoListIMPL estadoCuentaConsolidadoListIMPL = new EstadoCuentaConsolidadoListIMPL();
			EstadoCuentaConsolidadoDATABEAN estadoCuentaConsolidadoDATABEAN = new EstadoCuentaConsolidadoDATABEAN();

			// Servicio
			ReportResponse[] reportResponse = services.getAccountStatusConsolidatedDetail(sessionId, bankCTS, serviceIntegration);

			// Listas
			List<EstadoCuentaConsolidadoDTO> detail = estadoCuentaConsolidadoListIMPL.getDetail(reportResponse, sessionId, serviceIntegration);

			// Mapeo
			estadoCuentaConsolidadoDATABEAN.setDetalle(detail);

			// Envio a Collection
			
			collection.add(estadoCuentaConsolidadoDATABEAN);
			

		} catch (Exception e) {
			if (logger.isDebugEnabled())
				logger.logDebug("*****>>Error Lista - EstadoCuentaConsolidado", e);
			throw new RuntimeException(e);
		}
		return new JRBeanCollectionDataSource(collection);
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		logger.logDebug("*****>>Inicia  - Reporte EstadoCuentaConsolidado");
		try {
			String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
			@SuppressWarnings("rawtypes")
			String user = (String) ((Map) params.get(ICOBISReportResourcesService.SESSION_CONTEXT_MAP)).get(ICOBISReportResourcesService.USER_CONTEXT_USER);

			@SuppressWarnings("rawtypes")
			String bankCTS = (String) params.get(ConstantValue.Params.BANK);

			Services services = new Services();
			Method method = new Method();
			
			logger.logDebug("*****>>Reporte EstadoCuentaConsolidado idBank:" + bankCTS);
			// Datos Iniciales
			initParamHeader(params);

			method.setPrmMain(params);// Envia los parametros del metodo method.mapValuesToParams..

			// Informacion del grupo
			ReportResponse reportResponse = services.getAccountStatusConsolidatedHeader(sessionId, bankCTS, serviceIntegration);

			logger.logDebug("*****>>Reporte EstadoCuentaConsolidado ruc:" + reportResponse.getRuc());

			if (reportResponse != null) {
				method.mapValuesToParams("numRuc", reportResponse.getRuc(), "");
				method.mapValuesToParams("fechaCabecera", reportResponse.getDate(), "");
				method.mapValuesToParams("igCodigoGrupo", reportResponse.getGroupId(), 0);
				method.mapValuesToParams("igNombreGrupo", reportResponse.getGroup(), "");
				method.mapValuesToParams("igFondo", reportResponse.getResourceFunds(), "");
				method.mapValuesToParams("igDiaReunion", reportResponse.getMeetingDay(), "");
				method.mapValuesToParams("igHoraReunion", reportResponse.getMeetingTime(), "");
				method.mapValuesToParams("igDireccion", reportResponse.getMeetingPlace(), "");
				
				method.mapValuesToParams("eccCiclo", reportResponse.getCycle(), 0);
				method.mapValuesToParams("eccSucursal", reportResponse.getBranchOffice(), "");
				method.mapValuesToParams("eccAsesor", reportResponse.getAdviser(), "");
				method.mapValuesToParams("eccDestino", reportResponse.getDestination(), "");				
				method.mapValuesToParams("eccMontoPrestado", reportResponse.getAmountBorrowed(), 0.0);
				method.mapValuesToParams("eccAbreviaturaMoneda", reportResponse.getCurrencyAbbreviation(),"");
				method.mapValuesToParams("eccTasaInteres", reportResponse.getInterestRate(), 0.0);
				method.mapValuesToParams("eccPlazo", reportResponse.getTerm(), "");
				method.mapValuesToParams("eccFechaDesembolso", reportResponse.getDisbursementDate(), "");
				
			}

		} catch (Exception e) {
			if (logger.isDebugEnabled())
				logger.logDebug("*****>>Error - Reporte EstadoCuentaConsolidado" , e);
			throw new RuntimeException(e);
		}
		return params;
	}

	private void initParamHeader(Map<String, Object> params) {
		params.put("numRuc", "");
		params.put("fechaCabecera", "");
		params.put("igCodigoGrupo", 0);
		params.put("igNombreGrupo", "");
		params.put("igFondo", "");
		params.put("igDiaReunion", "");
		params.put("igHoraReunion", "");
		params.put("igDireccion", "");		
		params.put("eccCiclo", 0);
		params.put("eccSucursal", "");
		params.put("eccAsesor", "");
		params.put("eccDestino", "");
		params.put("eccMontoPrestado", 0.0);
		params.put("eccAbreviaturaMoneda", "");		
		params.put("eccTasaInteres", 0.0);
		params.put("eccPlazo", "");
		params.put("eccFechaDesembolso", "");
		
	}

	// Envio de nombres de los reportes.
	@Override
	public String getReportLocation(Map<String, Object> parameters) {
		return getFileLocationReport(ConstantValue.JasperPath.ESTADO_CUENTA_CONSOLIDADO);
	}

	private String getFileLocationReport(String planPagosReportJasper) {
		return ConstantValue.JasperPath.ESTADO_CUENTA_CONSOLIDADO;
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
