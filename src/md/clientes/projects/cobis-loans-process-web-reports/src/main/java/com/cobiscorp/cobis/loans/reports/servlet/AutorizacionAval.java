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
import cobiscorp.ecobis.loanprocess.dto.LoanCustomerResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.AutorizacionAvalDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.MemberDTO;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "formatAutorizacionAvalInd") })
public class AutorizacionAval implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {

	private static final ILogger logger = LogFactory.getLogger(AutorizacionAval.class);

	private static final String NOMBRE_CLIENTE = "nombresMiembro";

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public Boolean controlReportGeneration(Map<String, Object> aParams) {
		return true;
	}

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> aParams) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("*****>>Inicia Lista - Reporte AutorizacionAval");
		}
		String wSessionId = (String) aParams.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String wApplicationCode = (String) aParams.get(ConstantValue.Params.APPLICATION);
		try {
			if (wSessionId != null && wApplicationCode != null) {
				AutorizacionAvalDATABEAN wAutorizacionAvalDATABEANDATABEAN = new AutorizacionAvalDATABEAN();
				List<MemberDTO> listaMiembros = new ArrayList<MemberDTO>();
				wAutorizacionAvalDATABEANDATABEAN.setListaMiembros(listaMiembros);
				Collection<AutorizacionAvalDATABEAN> collection = new ArrayList<AutorizacionAvalDATABEAN>();
				collection.add(wAutorizacionAvalDATABEANDATABEAN);
				return new JRBeanCollectionDataSource(collection);
			}
		} catch (Exception e) {
			if (logger.isDebugEnabled())
				logger.logDebug("*****>>Error Lista - AutorizacionAval - getDatasourceReport", e);
			throw new RuntimeException(e);
		}
		return null;
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> aParams) {
		initParamHeader(aParams);
		if (logger.isDebugEnabled()) {
			logger.logDebug("*****>>RPT AutorizacionAval - getParamsReport - INI");
		}
		try {
			String wSessionId = (String) aParams.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
			String wUser = (String) ((Map) aParams.get(ICOBISReportResourcesService.SESSION_CONTEXT_MAP)).get(ICOBISReportResourcesService.USER_CONTEXT_USER);
			String wApplication = (String) aParams.get(ConstantValue.Params.APPLICATION);
			String wDebtorType = ConstantValue.DebtorType.ENDORSEMENT;
			Services services = new Services();
			Method method = new Method();
			
			method.setPrmMain(aParams);
			if (logger.isDebugEnabled()) {
				logger.logDebug("getParamsReport - sessionId= " + wSessionId);
				logger.logDebug("getParamsReport - user= " + wUser);
				logger.logDebug("getParamsReport - applicationCode= " + wApplication);
			}

			if (wApplication != null && wSessionId != null) {
				Map<String, Object> wCustomerDataInfMap = services.getCustomerData(wSessionId, wApplication, wDebtorType, serviceIntegration);
				LoanCustomerResponse[] wCustomerInfResponse = (LoanCustomerResponse[]) wCustomerDataInfMap.get(ConstantValue.valueConstant.CUSTOMER_INFORMATION);

				if (logger.isDebugEnabled()) {
					logger.logDebug("getParamsReport - INI - " + ConstantValue.valueConstant.CUSTOMER_INFORMATION);
				}
				if (wCustomerInfResponse != null) {
					if (wCustomerInfResponse.length > 0) {
						LoanCustomerResponse wCustomerInfor = wCustomerInfResponse[0];
						if (logger.isDebugEnabled()) {
							logger.logDebug("getParamsReport - response Commissions: " + wCustomerInfor.getCustomerName());
						}
						method.mapValuesToParams(NOMBRE_CLIENTE, wCustomerInfor.getCustomerName(), "");
					}
				}
			}
		} catch (Exception e) {
			logger.logError("*****>>Error - AutorizacionAval:", e);
			throw new RuntimeException(e);
		}
		return aParams;
	}

	@Override
	public String getGeneratedReportFilename(Map<String, Object> aParams) {
		return REPORTING_NAME_FILTER;
	}

	@Override
	public String getReportLocation(Map<String, Object> aParams) {
		return getFileLocationReport(ConstantValue.JasperPath.AUTORIZACION_AVAL_IND);
	}

	private String getFileLocationReport(String aPagoRecurrenteReportJasper) {
		return ConstantValue.JasperPath.AUTORIZACION_AVAL_IND;
	}

	private void initParamHeader(Map<String, Object> aParams) {
		aParams.put(NOMBRE_CLIENTE, "");
	}
}
