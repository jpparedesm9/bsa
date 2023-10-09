package com.cobiscorp.cobis.loans.reports.servlet;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
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
import com.cobiscorp.cobis.loans.reports.impl.SolicitudCreditoGrupalIMPL;
import com.cobiscorp.cobis.loans.reports.utils.UtilFunctions;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.AdditionalDataGroupResponse;
import cobiscorp.ecobis.loangroup.dto.GroupResponse;
import cobiscorp.ecobis.loangroup.dto.LoanGroupResponse;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "solicitudCreditoGrupal") })
public class SolicitudCreditoGrupal implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {
	private static final ILogger logger = LogFactory.getLogger(SolicitudCreditoGrupal.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public Boolean controlReportGeneration(Map<String, Object> arg0) {
		return true;
	}

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logInfo("Inicia generacion de DataSource para Solicitud de Credito Grupal");
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String application = (String) params.get(ConstantValue.Params.APPLICATION);
		Collection<SolicitudCreditoGrupalDATABEAN> collection = new ArrayList<SolicitudCreditoGrupalDATABEAN>();
		Services services = new Services();
		
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("--> Solicitud de Credito Grupal - getDatasourceReport - params: " + params);
			}
		
			SolicitudCreditoGrupalDATABEAN solicitudCreditoGrupalDATABEAN = new SolicitudCreditoGrupalDATABEAN();

			MemberResponse[] membersAmount = services.getLoanGroupAmounts(sessionId, application, serviceIntegration);

			List<LoanGroupDetail> loanGroupDetail = SolicitudCreditoGrupalIMPL.getDetailList(membersAmount);
			solicitudCreditoGrupalDATABEAN.setLoanGroupDetail(loanGroupDetail);
			collection.add(solicitudCreditoGrupalDATABEAN);
			if (logger.isDebugEnabled()) {
				logger.logDebug("--> Solicitud de Credito Grupal - getDatasourceReport collection: " + collection);
			}

		} catch (Exception e) {
			logger.logError("*****>>Error - Solicitud getDataSource Credito Grupal:", e);
			throw new RuntimeException(e);
		}
		return new JRBeanCollectionDataSource(collection);
	}

	@Override
	public String getGeneratedReportFilename(Map<String, Object> arg0) {
		return REPORTING_NAME_FILTER;
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		logger.logInfo("Obtiene parametros para reporte Solicitud de Credito Grupal");	
		
		try {
			initParamHeader(params);
			if (logger.isDebugEnabled()) {
				logger.logDebug("--> Solicitud de Credito Grupal - getParamsReport - params: " + params);
			}
			String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
			String application = (String) params.get(ConstantValue.Params.APPLICATION);
			Services services = new Services();
			Method method = new Method();
			
			method.setPrmMain(params);
			if (application != null && sessionId != null) {
				Map<String, Object> response = services.getGroupLoanInformation(sessionId, application, serviceIntegration);
				LoanGroupResponse[] groupResponse = (LoanGroupResponse[]) response.get(ConstantValue.valueConstant.GROUP_INFORMATION);
				AdditionalDataGroupResponse[] additionalDataGroupResponse = (AdditionalDataGroupResponse[]) response.get(ConstantValue.valueConstant.ADDITIONAL_GROUP_INFORMATION);

				if (logger.isDebugEnabled()) {
					logger.logDebug("--> Solicitud de Credito Grupal - getParamsReport - response informacion de grupo: " + response);
				}

				if (groupResponse != null && additionalDataGroupResponse != null) {
					LoanGroupResponse loanGroup = groupResponse[0];
					AdditionalDataGroupResponse additionalData = additionalDataGroupResponse[0];

					GroupResponse groupData = services.getGroupInformation(sessionId, loanGroup.getGroupId(), serviceIntegration);

					method.mapValuesToParams("officeDesc", loanGroup.getLoanOffice(), "");
					method.mapValuesToParams("requestDate", loanGroup.getRequestDate(), "");
					method.mapValuesToParams("groupId", String.valueOf(loanGroup.getGroupId()), "");
					method.mapValuesToParams("groupName", groupData.getNameGroup(), "");
					method.mapValuesToParams("amount", Functions.getStringCurrencyFormated(loanGroup.getAmount()), "");
					method.mapValuesToParams("termType", loanGroup.getTermtype(), "");
					method.mapValuesToParams("term", loanGroup.getTerm(), "");
					method.mapValuesToParams("meetingDay", additionalData.getMeetingDay(), "");

					Calendar hour = groupData.getTime();
					if (logger.isDebugEnabled()) {
						logger.logDebug(" hour.get(Calendar.HOUR_OF_DAY) " + hour.get(Calendar.HOUR_OF_DAY));
						logger.logDebug(" hour.get(Calendar.HOUR) " + hour.get(Calendar.HOUR));
						logger.logDebug(" hour.get(Calendar.MINUTE) " + hour.get(Calendar.MINUTE));
					}

					method.mapValuesToParams("meetingHour", UtilFunctions.getHours(groupData.getTime()), "");
					if(loanGroup.getCycleByApplication()!=0){
						method.mapValuesToParams("actualCicle", String.valueOf(loanGroup.getCycleByApplication()), "");
					}else{
						method.mapValuesToParams("actualCicle", groupData.getCycleNumber(), "");
					}
					method.mapValuesToParams("disbursementDate", loanGroup.getDisbursementDate(), "");
					method.mapValuesToParams("firstPayDate", loanGroup.getFirstPayDate(), "");
					method.mapValuesToParams("hostCustomer", additionalData.getHostCustomer() != 0 ? String.valueOf(additionalData.getHostCustomer()) : null, "");
					method.mapValuesToParams("hostCustomerName", additionalData.getHostCustomerName(), "");
					method.mapValuesToParams("addressMeetting", additionalData.getAddressMeeting(), "");
					method.mapValuesToParams("meetingPhone", additionalData.getMeetingPhone(), "");
					method.mapValuesToParams("meetingCellPhone", additionalData.getMeetingCellPhone(), "");

					if (logger.isDebugEnabled()) {
						logger.logDebug("params Solicitud de Credito: " + params);
					}
				}

			}

		} catch (Exception e) {
			logger.logError("*****>>Error - Solicitud Credito Grupal:", e);
			throw new RuntimeException(e);
		}
		return params;
	}

	private void initParamHeader(Map<String, Object> params) {
		params.put("officeDesc", "");
		params.put("requestDate", "");
		params.put("groupId", "");
		params.put("groupName", "");
		params.put("amount", BigDecimal.valueOf(0.0));
		params.put("termType", "");
		params.put("term", "");
		params.put("meetingDay", "");
		params.put("meetingHour", "");
		params.put("actualCicle", "");
		params.put("disbursementDate", "");
		params.put("firstPayDate", "");
		params.put("hostCustomer", "");
		params.put("hostCustomerName", "");
		params.put("addressMeetting", "");
		params.put("meetingPhone", "");
		params.put("meetingCellPhone", "");
	}

	@Override
	public String getReportLocation(Map<String, Object> arg0) {
		return ConstantValue.JasperPath.SOLICTUD_CREDITO_GRUPAL;
	}

}
