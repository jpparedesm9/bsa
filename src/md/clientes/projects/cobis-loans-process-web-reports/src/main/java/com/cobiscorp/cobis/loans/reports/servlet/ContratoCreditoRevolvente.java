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
import cobiscorp.ecobis.loanprocess.dto.LoanInfoApplicationResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Functions;
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.ContratoCreditoRevolventePrincipalDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoRevolventeClausulaDTO;
import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoRevolventeDetallePrincipalDTO;
import com.cobiscorp.cobis.loans.reports.impl.ContratoCreditoRevolventeListIMPL;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "contratoCreditoRevolvente") })
public class ContratoCreditoRevolvente implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {

	private static final ILogger logger = LogFactory.getLogger(ContratoCreditoRevolvente.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logError("*****>>Inicia - Sub Reporte - ContratoCreditoRevolvente Detalle");
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String application = (String) params.get(ConstantValue.Params.APPLICATION);
		int applicationIn = 0;
		applicationIn = Integer.parseInt(application);
		Collection<ContratoCreditoRevolventePrincipalDATABEAN> collection = new ArrayList<ContratoCreditoRevolventePrincipalDATABEAN>();
		Services services = new Services();
		logger.logError("*****>>Sub Reporte - ContratoCreditoRevolvente idTramite:" + applicationIn);

		try {

			// Contiene la Lista
			ContratoCreditoRevolventePrincipalDATABEAN cciPrincipalDATABEAN = new ContratoCreditoRevolventePrincipalDATABEAN();

			ContratoCreditoRevolventeListIMPL cciListIMPL = new ContratoCreditoRevolventeListIMPL();

			// Contiene la Lista de detalle
			List<ContratoCreditoRevolventeDetallePrincipalDTO> cciDetallePrincipalDTO = new ArrayList<ContratoCreditoRevolventeDetallePrincipalDTO>();
			logger.logError("*****>>Reporte - ContratoCreditoRevolvente idTramite:" + applicationIn);

			LoanInfoApplicationResponse[] reportResponseList = services.getApplicationInfo(sessionId, 'E', applicationIn, 0, serviceIntegration);

			cciDetallePrincipalDTO = cciListIMPL.getDetallePrincipal(reportResponseList, sessionId, serviceIntegration);

			// InformacionPrevia
			List<ContratoCreditoRevolventeClausulaDTO> infoPrevia = new ArrayList<ContratoCreditoRevolventeClausulaDTO>();
			infoPrevia = cciListIMPL.getClausula(sessionId, serviceIntegration); //Solo para que se visualice el texto
			cciPrincipalDATABEAN.setContratoCreditoRevolventeInfoPrevia(infoPrevia);

			// Contrato
			cciPrincipalDATABEAN.setContratoCreditoRevolventeDetallePrincipal(cciDetallePrincipalDTO);

			// Clausula
			List<ContratoCreditoRevolventeClausulaDTO> clausula = new ArrayList<ContratoCreditoRevolventeClausulaDTO>();
			clausula = cciListIMPL.getClausula(sessionId, serviceIntegration); //Solo para que se visualice el texto
			cciPrincipalDATABEAN.setContratoCreditoRevolventeClausula(clausula);

			// AnexoLegal
			List<ContratoCreditoRevolventeClausulaDTO> anexoLegal = new ArrayList<ContratoCreditoRevolventeClausulaDTO>();
			anexoLegal = cciListIMPL.getClausula(sessionId, serviceIntegration); //Solo para que se visualice el texto
			cciPrincipalDATABEAN.setContratoCreditoRevolventeAnexoLegal(anexoLegal);
			
			// Se anade al jaspers
			collection.add(cciPrincipalDATABEAN);

		} catch (Exception e) {
			logger.logError("*****>>Error - Reporte - ContratoCreditoRevolvente Detalle", e);
			throw new RuntimeException(e);
		}
		return new JRBeanCollectionDataSource(collection);
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		logger.logError("*****>>Inicia - Reporte - ContratoCreditoRevolvente");
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String application = (String) params.get(ConstantValue.Params.APPLICATION);
		int applicationIn = 0;
		applicationIn = Integer.parseInt(application);
		Services services = new Services();
		Method method = new Method();
		method.setPrmMain(params);

		params.put("urlPathSantander", ConstantValue.Params.URLIMAG);
		params.put("firmaNF1CCI", ConstantValue.Params.URLIMAG_firmaNF1CCI);
		params.put("firmaNF2CCI", ConstantValue.Params.URLIMAG_firmaNF2CCI);
		params.put("firmaNB1CCI", ConstantValue.Params.URLIMAG_firmaNB1CCI);
		params.put("firmaNB2CCI", ConstantValue.Params.URLIMAG_firmaNB2CCI);

		String condusef = "14795-440-030864/03-04067-0919";
		
		LoanInfoApplicationResponse[] reportResponseList = services.getApplicationInfo(sessionId, 'E', applicationIn, 0, serviceIntegration);
		if (reportResponseList != null) {
			for (int i = 0; i < reportResponseList.length; i++) {
				condusef = reportResponseList[i].getRegNumber();
				method.mapValuesToParams("condusef", condusef, "");
				String valor = Functions.StringNumerDecimal(reportResponseList[i].getAmount().toString());				
				method.mapValuesToParams("clauMonto", valor, "0.00");
			}
		}
		
		// Pie de Pagina
		String pieAnio = "(032019)";
		ParameterResponse pieAnioParam = services.getParameter(4, "PPREPA", Mnemonic.MODULE, serviceIntegration, sessionId);
		if (pieAnioParam != null) {
			pieAnio = pieAnioParam.getParameterValue();
		}
		method.mapValuesToParams("pieAnio", pieAnio, "");
		
		ParameterResponse param = services.getParameter(4, "PSOLCR", "CRE", serviceIntegration, sessionId);
		if (logger.isDebugEnabled()) {
			logger.logDebug("Parametro pie: " + param.getParameterValue());
		}
		method.mapValuesToParams("footParam",param.getParameterValue(), "");
		
		ParameterResponse param2 = services.getParameter(4, "PCRLCR", "CRE", serviceIntegration, sessionId);
		if (logger.isDebugEnabled()) {
			logger.logDebug("Parametro pie footParamCr: " + param2.getParameterValue());
		}
		method.mapValuesToParams("footParamCr",param2.getParameterValue(), "");

		return params;
	}

	// Envio de nombres de los reportes.
	@Override
	public String getReportLocation(Map<String, Object> parameters) {
		return getFileLocationReport(ConstantValue.JasperPath.CONTRATO_CREDITO_REVOLVENTE);
	}

	private String getFileLocationReport(String planPagosReportJasper) {
		return ConstantValue.JasperPath.CONTRATO_CREDITO_REVOLVENTE;
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
