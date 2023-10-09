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
import com.cobiscorp.cobis.loans.reports.commons.Functions;
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.SolicitudCreditoGrupalDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.LoanGroupDetail;
import com.cobiscorp.designer.api.util.ServerParamUtil;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loanprocess.dto.LoanCustomerResponse;
import cobiscorp.ecobis.loanprocess.dto.LoanInfResponse;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "pagareIndividual") })
public class PagareIndividual implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {
	private static final ILogger logger = LogFactory.getLogger(PagareIndividual.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public Boolean controlReportGeneration(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> arg0) {
		Collection<SolicitudCreditoGrupalDATABEAN> collection = new ArrayList<SolicitudCreditoGrupalDATABEAN>();
		try {
			SolicitudCreditoGrupalDATABEAN solicitudCreditoGrupalDATABEAN = new SolicitudCreditoGrupalDATABEAN();

			List<LoanGroupDetail> grp = new ArrayList<LoanGroupDetail>();
			solicitudCreditoGrupalDATABEAN.setLoanGroupDetail(grp);
			collection.add(solicitudCreditoGrupalDATABEAN);
		} catch (Exception e) {
			logger.logError("Error en PAGARE: ", e);
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
		logger.logInfo("Obtiene parametros para reporte PAGARE");
		Method method = new Method();
		Services services = new Services();
		
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("-->params: " + params);
			}
			String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
			String application = (String) params.get(ConstantValue.Params.APPLICATION);

			method.setPrmMain(params);
			if (application != null && sessionId != null) {
				LoanInfResponse loanData = services.getLoanData(sessionId, application, serviceIntegration);
				Map<String, Object> responseDebtor = services.getCustomerData(sessionId, application, ConstantValue.DebtorType.DEBTOR, serviceIntegration);
				Map<String, Object> responseEndorsement = services.getCustomerData(sessionId, application, ConstantValue.DebtorType.ENDORSEMENT, serviceIntegration);

				LoanCustomerResponse[] personalDataL = (LoanCustomerResponse[]) responseDebtor.get(ConstantValue.valueConstant.CUSTOMER_INFORMATION);
				LoanCustomerResponse[] personalEndorsementDataL = (LoanCustomerResponse[]) responseEndorsement.get(ConstantValue.valueConstant.CUSTOMER_INFORMATION);

				LoanCustomerResponse personalEndorsementData = null;
				LoanCustomerResponse personalData = personalDataL[0];
				if (personalEndorsementDataL.length > 0) {
					personalEndorsementData = personalEndorsementDataL[0];
				}

				method.mapValuesToParams("idApplication", loanData.getOperationId(), "");
				method.mapValuesToParams("customerName", personalData.getCustomerName(), "");
				method.mapValuesToParams("bankAddress", loanData.getBankAddress(), "");
				method.mapValuesToParams("bankCP", loanData.getBankCP(), "");
				method.mapValuesToParams("amount", loanData.getAmount().toString(), "");
				method.mapValuesToParams("term", String.valueOf(loanData.getTerm()), "");
				method.mapValuesToParams("termType", loanData.getTermType(), "");
				method.mapValuesToParams("weekPay", loanData.getWeekPay().toString(), "");
				method.mapValuesToParams("finalAmount", loanData.getTotalAmount().toString(), "");
				method.mapValuesToParams("interest", loanData.getInterest().toString(), "");
				method.mapValuesToParams("overInterest", loanData.getInterest().toString(), "");
				method.mapValuesToParams("date", Functions.changeStringDateFormat(ServerParamUtil.getProcessDate(), ConstantValue.valueConstant.DF_MMDDYYYY, ConstantValue.valueConstant.DF_DDMMYYYY), "");
				method.mapValuesToParams("firstDate", loanData.getFirstPay(), "");
				if (personalEndorsementData != null) {
					method.mapValuesToParams("endorsementName", personalEndorsementData.getCustomerName(), "");
				} else {
					method.mapValuesToParams("endorsementName", "", "");
				}

				if (logger.isDebugEnabled()) {
					logger.logDebug("params PAGARE: " + params);
				}

			}

		} catch (Exception e) {
			logger.logError("*****>>Error - Contrato de Inclusion:", e);
			throw new RuntimeException(e);
		}
		return params;
	}

	@Override
	public String getReportLocation(Map<String, Object> arg0) {
		// TODO Auto-generated method stub
		return ConstantValue.JasperPath.PAGARE_INDIVIDUAL;
	}
}
