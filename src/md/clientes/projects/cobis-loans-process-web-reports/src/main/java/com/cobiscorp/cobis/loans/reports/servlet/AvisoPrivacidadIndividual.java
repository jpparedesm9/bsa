package com.cobiscorp.cobis.loans.reports.servlet;

import java.util.ArrayList;
import java.util.Collection;
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
import com.cobiscorp.cobis.loans.reports.dto.MemberDTO;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loanprocess.dto.LoanCustomerResponse;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "avisoPrivacidadIndividual") })

public class AvisoPrivacidadIndividual implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {
	private static final ILogger logger = LogFactory.getLogger(AvisoPrivacidadIndividual.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public Boolean controlReportGeneration(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logInfo("Inicia generacion de DataSource para Aviso de Privacidad");
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String application = (String) params.get(ConstantValue.Params.APPLICATION);
		Collection<MemberDTO> collection = new ArrayList<MemberDTO>();
		Services services = new Services();
		
		try {

			Map<String, Object> responseDebtor = services.getCustomerData(sessionId, application, ConstantValue.DebtorType.DEBTOR, serviceIntegration);
			LoanCustomerResponse[] personalDataL = (LoanCustomerResponse[]) responseDebtor.get(ConstantValue.valueConstant.CUSTOMER_INFORMATION);
			LoanCustomerResponse personalData = personalDataL[0];

			MemberDTO customer = new MemberDTO();
			customer.setNombresMiembro(personalData.getCustomerName());
			collection.add(customer);
			if (logger.isDebugEnabled()) {
				logger.logDebug("-> collection: " + collection);
			}
		} catch (Exception e) {
			logger.logError("*****>>Error - Solicitud getDataSource Credito Individual:", e);
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
		// TODO Auto-generated method stub
		return ConstantValue.JasperPath.AVISO_PRIVACIDAD_GRUPAL;
	}

}
