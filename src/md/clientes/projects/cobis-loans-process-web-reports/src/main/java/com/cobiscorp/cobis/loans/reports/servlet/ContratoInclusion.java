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

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.ContratoInclusionDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.ContratoInclusionDTO;
import com.cobiscorp.cobis.loans.reports.impl.ContratoInclusionIMPL;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.AdditionalDataGroupResponse;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "contratoInclusion") })
public class ContratoInclusion implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {
	private static final ILogger logger = LogFactory.getLogger(ContratoInclusion.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public Boolean controlReportGeneration(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		Collection<ContratoInclusionDATABEAN> collection = new ArrayList<ContratoInclusionDATABEAN>();
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("-->params: " + params);
			}
			String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
			String application = (String) params.get(ConstantValue.Params.APPLICATION);
			Services services = new Services();
			Method method = new Method();
			
			method.setPrmMain(params);
			if (application != null && sessionId != null) {
				Map<String, Object> response = services.getGroupLoanInformation(sessionId, application, serviceIntegration);
				MemberResponse[] members=services.getLoanGroupAmounts(sessionId, application, serviceIntegration);
				AdditionalDataGroupResponse[] additionalDataGroupResponse = (AdditionalDataGroupResponse[]) response.get(ConstantValue.valueConstant.ADDITIONAL_GROUP_INFORMATION);

				List<ContratoInclusionDTO> contratData=ContratoInclusionIMPL.getContratList(members, additionalDataGroupResponse);
				ContratoInclusionDATABEAN contratoInclusionDATABEAN = new ContratoInclusionDATABEAN();				
				contratoInclusionDATABEAN.setContratData(contratData);
				collection.add(contratoInclusionDATABEAN);
			}
		} catch (Exception e) {
			logger.logError("Error en Contrato Inclusion: ", e);
			throw new RuntimeException(e);
		}
		return new JRBeanCollectionDataSource(collection);
	}

	@Override
	public String getGeneratedReportFilename(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		return REPORTING_NAME_FILTER;
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		logger.logInfo("Obtiene parametros para reporte Solicitud de Credito Grupal");

		/*try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("-->params: " + params);
			}
			String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
			String application = (String) params.get(ConstantValue.Params.APPLICATION);

			method.setPrmMain(params);
			if (application != null && sessionId != null) {
				Map<String, Object> response = services.getGroupLoanInformation(sessionId, application, serviceIntegration);
				AdditionalDataGroupResponse[] additionalDataGroupResponse = (AdditionalDataGroupResponse[]) response.get(ConstantValue.valueConstant.ADDITIONAL_GROUP_INFORMATION);

				if (logger.isDebugEnabled()) {
					logger.logDebug("response informacion de grupo: " + response);
				}
				if (additionalDataGroupResponse != null) {

					AdditionalDataGroupResponse additionalData = additionalDataGroupResponse[0];
					if (logger.isDebugEnabled()) {
						logger.logDebug("additionalData.getHostCustomerName " + additionalData.getHostCustomerName());
						logger.logDebug("additionalData.getMeetingDay " + additionalData.getMeetingDay());
						logger.logDebug("additionalData.getCity " + additionalData.getCity());
						logger.logDebug("additionalData.getOfficeAddress " + additionalData.getOfficeAddress());
					}

					method.mapValuesToParams("officeAddress", additionalData.getOfficeAddress(), "");
					method.mapValuesToParams("city", additionalData.getCity(), "");
					method.mapValuesToParams("date", Functions.changeStringDateFormat(ServerParamUtil.getProcessDate(), ConstantValue.valueConstant.DF_MMDDYYYY, ConstantValue.valueConstant.DF_DDMMYYYY), "");
					method.mapValuesToParams("representative", additionalData.getRepresentative(), "");

					if (logger.isDebugEnabled()) {
						logger.logDebug("params Solicitud de Credito: " + params);
					}
				}

			}

		} catch (Exception e) {
			logger.logError("*****>>Error - Contrato de Inclusion:", e);
		}*/
		return params;
	}

	@Override
	public String getReportLocation(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		return ConstantValue.JasperPath.CONTRATO_INCLUSION_GRUPAL;
	}
}
