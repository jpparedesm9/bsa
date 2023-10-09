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
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.ReglamentoInternoDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.ReglamentDTO;
import com.cobiscorp.cobis.loans.reports.impl.ReglamentoInternoIMPL;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.AdditionalDataGroupResponse;
import cobiscorp.ecobis.loangroup.dto.GroupResponse;
import cobiscorp.ecobis.loangroup.dto.LoanGroupResponse;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "reglamentoInterno") })
public class ReglamentoInterno implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {
	private static final ILogger logger = LogFactory.getLogger(ReglamentoInterno.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public Boolean controlReportGeneration(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logInfo("Inicia generacion de DataSource para Reglamento Interno");
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String application = (String) params.get(ConstantValue.Params.APPLICATION);
		Collection<ReglamentoInternoDATABEAN> collection = new ArrayList<ReglamentoInternoDATABEAN>();
		Services services = new Services();
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("-->params getDatasourceReport: " + params);
			}
			Integer applicationInt = Integer.parseInt(application);
			ReglamentoInternoDATABEAN reglamentoInternoDATABEAN = new ReglamentoInternoDATABEAN();
			Map<String, Object> response = services.getGroupLoanInformation(sessionId, application, serviceIntegration);
			LoanGroupResponse[] groupResponse = (LoanGroupResponse[]) response.get(ConstantValue.valueConstant.GROUP_INFORMATION);
			AdditionalDataGroupResponse[] additionalDataGroupResponse = (AdditionalDataGroupResponse[]) response.get(ConstantValue.valueConstant.ADDITIONAL_GROUP_INFORMATION);
			LoanGroupResponse loanGroup = groupResponse[0];

			MemberResponse[] members = services.getGroupMembers(sessionId, loanGroup.getGroupId(),applicationInt, 4, serviceIntegration);
			MemberResponse[] membersAmount = services.getLoanGroupAmounts(sessionId, application, serviceIntegration);

			GroupResponse groupDataResponse = services.getGroupInformation(sessionId, loanGroup.getGroupId(), serviceIntegration);

			List<ReglamentDTO> reglamentData = ReglamentoInternoIMPL.getReglamentList(members, membersAmount, loanGroup, additionalDataGroupResponse[0], groupDataResponse, serviceIntegration, sessionId);
			reglamentoInternoDATABEAN.setReglamentData(reglamentData);
			collection.add(reglamentoInternoDATABEAN);
			
		} catch (Exception e) {
			logger.logError("*****>>Error - Solicitud getDataSource Reglamento Interno:", e);
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
		// TODO Auto-generated method stub
		return params;
	}

	@Override
	public String getReportLocation(Map<String, Object> arg0) {
		return ConstantValue.JasperPath.REGLAMENTO_INTERNO;
	}

}
