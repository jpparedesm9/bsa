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
import cobiscorp.ecobis.loangroup.dto.GroupLoanInfResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dataBean.FormatoPagareGrupalDATABEAN;
import com.cobiscorp.cobis.loans.reports.dto.MemberDTO;
import com.cobiscorp.cobis.loans.reports.impl.FormatoPagareGrupalListIMPL;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"), @Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "formatPagareMain") })
public class FormatoPagareGrupal implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {

	private static final ILogger logger = LogFactory.getLogger(FormatoPagareGrupal.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public Boolean controlReportGeneration(Map<String, Object> param) {
		return true;
	}

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("*****>>Inicia Lista - Reporte FormatoPagareGrupal");
		}
		String wSessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String wApplication = (String) params.get(ConstantValue.Params.APPLICATION);
		Services services = new Services();
		try {
			if (wSessionId != null && wApplication != null) {
				FormatoPagareGrupalDATABEAN formatoPagareGrupalDATABEAN = new FormatoPagareGrupalDATABEAN();

				GroupLoanInfResponse[] wGrpLoanInfResponseList = services.getPromissoryNoteInf(wSessionId, wApplication, serviceIntegration);
				List<MemberDTO> listaMiembros = FormatoPagareGrupalListIMPL.getAllGroupMembers(wGrpLoanInfResponseList, wSessionId, serviceIntegration, services);

				if (logger.isDebugEnabled()) {
					logger.logDebug("*****>>Inicia Lista - RPT - getDatasourceReport");
				}

				formatoPagareGrupalDATABEAN.setListaMiembros(listaMiembros);
				Collection<FormatoPagareGrupalDATABEAN> collection = new ArrayList<FormatoPagareGrupalDATABEAN>();
				collection.add(formatoPagareGrupalDATABEAN);
				return new JRBeanCollectionDataSource(collection);
			}

		} catch (Exception e) {
			if (logger.isDebugEnabled())
				logger.logDebug("*****>>Error Lista - FormatoPagareGrupal - getDatasourceReport", e);
			throw new RuntimeException(e);

		}
		return null;
	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("*****>>Inicia - Reporte FormatoPagareGrupal");
		}
		try {
			String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
			@SuppressWarnings("rawtypes")
			String user = (String) ((Map) params.get(ICOBISReportResourcesService.SESSION_CONTEXT_MAP)).get(ICOBISReportResourcesService.USER_CONTEXT_USER);

			@SuppressWarnings("rawtypes")
			String applicationCode = (String) params.get(ConstantValue.Params.APPLICATION);
			if (logger.isDebugEnabled()) {
				logger.logDebug("*****>>Inicia - Reporte FormatoPagareGrupal - applicationCode= " + applicationCode);
				logger.logDebug("*****>>Inicia - Reporte FormatoPagareGrupal - user= " + user);
			}
			
			Method method = new Method();
			
			initParamHeader(params);
			method.setPrmMain(params);
		} catch (Exception e) {
			if (logger.isDebugEnabled())
				logger.logDebug("*****>>Error - Reporte FormatoPagareGrupal - getParamsReport", e);
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
		return getFileLocationReport(ConstantValue.JasperPath.FORMATO_PAGARE_MAIN);
	}

	private String getFileLocationReport(String pagoRecurrenteReportJasper) {
		return ConstantValue.JasperPath.FORMATO_PAGARE_MAIN;
	}

	private void initParamHeader(Map<String, Object> params) {
		params.put("nombresMiembro", "");
	}
}
