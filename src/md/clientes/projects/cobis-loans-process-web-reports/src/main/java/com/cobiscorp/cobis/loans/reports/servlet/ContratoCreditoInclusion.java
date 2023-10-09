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
import com.cobiscorp.cobis.loans.reports.dataBean.ContratoCreditoInclusionPrincipalDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoInclusionDetallePrincipalDTO;
import com.cobiscorp.cobis.loans.reports.impl.ContratoCreditoInclusionListIMPL;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"),
		@Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "contratoCreditoInclusion") })
public class ContratoCreditoInclusion implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {

	private static final ILogger logger = LogFactory.getLogger(ContratoCreditoInclusion.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logError("*****>>Inicia - Sub Reporte - ContratoCreditoInclusion Detalle");
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String application = (String) params.get(ConstantValue.Params.APPLICATION);
		LoanInfResponse loanData = null;
		Integer applicationIn = 0;
		applicationIn = Integer.parseInt(application);
		String bankCTS = "";
		Collection<ContratoCreditoInclusionPrincipalDATABEAN> collection = new ArrayList<ContratoCreditoInclusionPrincipalDATABEAN>();
		Services services = new Services();
		logger.logError("*****>>Sub Reporte - ContratoCreditoInclusion idTramite:" + applicationIn);

		try {
			// Contiene la Lista
			ContratoCreditoInclusionPrincipalDATABEAN cciPrincipalDATABEAN = new ContratoCreditoInclusionPrincipalDATABEAN();
			ContratoCreditoInclusionListIMPL cciListIMPL = new ContratoCreditoInclusionListIMPL();

			// Contiene la Lista de detalle
			List<ContratoCreditoInclusionDetallePrincipalDTO> cciDetallePrincipalDTO = new ArrayList<ContratoCreditoInclusionDetallePrincipalDTO>();
			logger.logError("*****>>Reporte - ContratoCreditoInclusion idTramite:" + applicationIn);

			// Para obtener la lista
			if (application == null) {
				logger.logDebug(" *****>>Sub Reporte - ContratoCreditoInclusion: No se pudo obtener el tramite");
				return new JRBeanCollectionDataSource(collection);
			} else {
				loanData = services.getLoanData(sessionId, application, serviceIntegration);
				bankCTS = loanData.getOperationId();
			}
			logger.logDebug(" *****>>Sub Reporte - ContratoCreditoInclusion - bankCTS: " + bankCTS);

			ReportResponse[] reportResponseListBanco = services.getDisbursementOrderDetail(sessionId, bankCTS, "2", 2, serviceIntegration);

			cciDetallePrincipalDTO = cciListIMPL.getDetallePrincipal(reportResponseListBanco, loanData, sessionId, serviceIntegration);

			// Envio al reporte
			cciPrincipalDATABEAN.setContratoCreditoInclusionDetallePrincipal(cciDetallePrincipalDTO);

			// Se anade al jaspers
			collection.add(cciPrincipalDATABEAN);

		} catch (Exception e) {
			logger.logError("*****>>Error - Reporte - ContratoCreditoInclusion Detalle", e);
			throw new RuntimeException(e);
		}
		return new JRBeanCollectionDataSource(collection);
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		logger.logError("*****>>Inicia - Reporte - ContratoCreditoInclusion");
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String application = (String) params.get(ConstantValue.Params.APPLICATION);
		LoanInfResponse loanData = new LoanInfResponse();
		logger.logInfo("SRO application: " + application);
		Services services = new Services();
		Method method = new Method();
		method.setPrmMain(params);

		if (application == null) {
			logger.logDebug(" *****>>Sub Reporte - ContratoCreditoInclusion: No se pudo obtener el tramite");
			return params;
		} else {
			loanData = services.getLoanData(sessionId, application, serviceIntegration);
		}

		logger.logInfo("PMO displacement ContratoCreditoInclusion " + loanData.getDisplacement());
		int gracia = loanData.getDisplacement() == null ? 0 : Integer.valueOf(loanData.getDisplacement());
		logger.logInfo("PMO gracia ContratoCreditoInclusion " + gracia);
		logger.logInfo("URLIMAGE:" + ConstantValue.Params.URLIMAG);

		params.put("urlPathSantander", ConstantValue.Params.URLIMAG);
		params.put("firmaNF1CCI", ConstantValue.Params.URLIMAG_firmaNF1CCI);
		params.put("firmaNF2CCI", ConstantValue.Params.URLIMAG_firmaNF2CCI);
		params.put("firmaNB1CCI", ConstantValue.Params.URLIMAG_firmaNB1CCI);
		params.put("firmaNB2CCI", ConstantValue.Params.URLIMAG_firmaNB2CCI);

		// Cabecera RECA - Pie de pagina condusef -- este parametro tambien se usa en
		// TablaAmortizacion
		String paramRECA = "";

		if (gracia > 0) {
			paramRECA = "RDRECA";
		} else {
			paramRECA = "RECASG";
		}

		logger.logInfo("PMO paramRECA ContratoCreditoInclusion " + paramRECA);
		ParameterResponse reca = services.getParameter(4, paramRECA, Mnemonic.MODULE, serviceIntegration, sessionId);
		logger.logInfo("PMO reca ContratoCreditoInclusion " + reca);
		method.mapValuesToParams("condusef", reca.getParameterValue(), "");

		// reportes - activa por covit
		ParameterResponse porCovit = services.getParameter(4, "DESCUO", Mnemonic.MODULECCA, serviceIntegration, sessionId);
		method.mapValuesToParams("porCovit", "N", "");
		if (porCovit != null) {
			// porCovit = S (muestra reporte por covit) o N (muestra el anterior reporte)
			method.mapValuesToParams("porCovit", porCovit.getParameterValue().trim(), "");
		}

		// Pie de pagina -- PIE PERIODO REPORTES en SolicitudCreditoRevolventeIMPL,
		// CaratulaCreditoRevolvente
		ParameterResponse pieAnio = services.getParameter(4, "PPREPA", Mnemonic.MODULE, serviceIntegration, sessionId);
		if (pieAnio != null) {
			method.mapValuesToParams("pieAnio", pieAnio.getParameterValue(), "");
		}

		return params;
	}

	// Envio de nombres de los reportes.
	@Override
	public String getReportLocation(Map<String, Object> parameters) {
		return getFileLocationReport(ConstantValue.JasperPath.CONTRATO_CREDITO_INCLUSION);
	}

	private String getFileLocationReport(String planPagosReportJasper) {
		return ConstantValue.JasperPath.CONTRATO_CREDITO_INCLUSION;
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
