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
import cobiscorp.ecobis.loangroup.dto.LoanGroupResponse;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.AvisoPrivacidadMiembrosDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.MemberDTO;
import com.cobiscorp.cobis.loans.reports.impl.AvisoPrivacidadListIMPL;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "avisoAdvertenciaGrupal") })
public class AvisoPrivacidadMiembros implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {

	private static final ILogger logger = LogFactory.getLogger(AvisoPrivacidadMiembros.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public Boolean controlReportGeneration(Map<String, Object> param) {
		return true;
	}

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("*****>>Inicia Lista - Reporte AvisoPrivacidadMiembros");
		}
		String wSessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String wApplicationCode = (String) params.get(ConstantValue.Params.APPLICATION);
		Services services = new Services();
		try {
			if (wSessionId != null && wApplicationCode != null) {
				Integer applicationInt = Integer.parseInt(wApplicationCode);
				AvisoPrivacidadMiembrosDATABEAN avisoPrivacidadMiembrosDATABEAN = new AvisoPrivacidadMiembrosDATABEAN();

				Map<String, Object> response = services.getGroupLoanInformation(wSessionId, wApplicationCode, serviceIntegration);
				LoanGroupResponse[] groupInfResponses = (LoanGroupResponse[]) response.get(ConstantValue.valueConstant.GROUP_INFORMATION);
				LoanGroupResponse loanGroupInf = groupInfResponses[0];

				MemberResponse[] membersResponse = services.getGroupMembers(wSessionId, loanGroupInf.getGroupId(), applicationInt, 4, serviceIntegration);
				List<MemberDTO> listaMiembros = AvisoPrivacidadListIMPL.getAllGroupMembers(membersResponse, wSessionId, serviceIntegration);

				avisoPrivacidadMiembrosDATABEAN.setListaMiembros(listaMiembros);
				Collection<AvisoPrivacidadMiembrosDATABEAN> collection = new ArrayList<AvisoPrivacidadMiembrosDATABEAN>();
				collection.add(avisoPrivacidadMiembrosDATABEAN);
				return new JRBeanCollectionDataSource(collection);
			}

		} catch (Exception e) {
			if (logger.isDebugEnabled())
				logger.logDebug("*****>>Error Lista - AvisoPrivacidadMiembros - getDatasourceReport", e);
			throw new RuntimeException(e);
			
		}
		return null;
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("*****>>Inicia - Reporte AvisoPrivacidadMiembros");
		}
		try {
			String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
			@SuppressWarnings("rawtypes")
			String user = (String) ((Map) params.get(ICOBISReportResourcesService.SESSION_CONTEXT_MAP)).get(ICOBISReportResourcesService.USER_CONTEXT_USER);

			@SuppressWarnings("rawtypes")
			String applicationCode = (String) params.get(ConstantValue.Params.APPLICATION);
			if (logger.isDebugEnabled()) {
				logger.logDebug("*****>>Inicia - Reporte AvisoPrivacidadMiembros - applicationCode= "+applicationCode);
				logger.logDebug("*****>>Inicia - Reporte AvisoPrivacidadMiembros - user= "+user);
			}
			
			Method method = new Method();
			
			initParamHeader(params);
			method.setPrmMain(params);
		} catch (Exception e) {
			if (logger.isDebugEnabled())
				logger.logDebug("*****>>Error - Reporte AvisoPrivacidadMiembros - getParamsReport", e);
			throw new RuntimeException(e);
		}
		return params;
	}

	@Override
	public String getGeneratedReportFilename(Map<String, Object> params) {
		return REPORTING_NAME_FILTER;
	}

	@Override
	public String getReportLocation(Map<String, Object> parameters) {
		return getFileLocationReport(ConstantValue.JasperPath.AVISO_PRIVACIDAD_MAIN);
	}

	private String getFileLocationReport(String pagoRecurrenteReportJasper) {
		return ConstantValue.JasperPath.AVISO_PRIVACIDAD_MAIN;
	}

	private void initParamHeader(Map<String, Object> params) {
		params.put("nombresMiembro", "");
	}
}
