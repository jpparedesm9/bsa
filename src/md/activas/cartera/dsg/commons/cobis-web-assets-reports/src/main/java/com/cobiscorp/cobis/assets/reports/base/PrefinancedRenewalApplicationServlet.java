package com.cobiscorp.cobis.assets.reports.base;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.assets.reports.dto.PreFilledApplicationContentDTO;
import com.cobiscorp.cobis.assets.reports.dto.PreFilledApplicationDTO;
import com.cobiscorp.cobis.assets.reports.impl.PreFilledApplicationIMPL;
import com.cobiscorp.cobis.assets.reports.service.PreFilledApplicationService;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.reporting.api.ICOBISReportResourcesService;

import cobiscorp.ecobis.assets.cloud.dto.PreFilledApplicationRequest;
import cobiscorp.ecobis.assets.cloud.dto.PreFilledApplicationResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Component
@Service({ ICOBISReportResourcesService.class })
@Properties({ @Property(name = ICOBISReportResourcesService.REPORTING_MODULE_FILTER, value = "cartera"),
		@Property(name = ICOBISReportResourcesService.REPORTING_NAME_FILTER, value = "solicitudCreditoRenovFinanPrellenada") })
public class PrefinancedRenewalApplicationServlet implements ICOBISReportResourcesService<JRBeanCollectionDataSource> {

	private static final ILogger logger = LogFactory.getLogger(PrefinancedRenewalApplicationServlet.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public JRBeanCollectionDataSource getDatasourceReport(Map<String, Object> params) {
		logger.logError("----->>>> Reporte Solicitud Credito Grupal Renovacion Inicio Listado");
		String customerId = (String) params.get(ConstantValue.CLIENTID);
		String sessionId = (String) params.get(ICOBISReportResourcesService.COBIS_SESSION_ID);
		String isGroup = (String) params.get(ConstantValue.IS_GRUOP);
		String isRenovation = (String) params.get(ConstantValue.IS_RENOVATION);
		int tramite = Integer.parseInt((String) params.get(ConstantValue.ID_TRAMITE));

		params.put("REPORT_LOCALE", new Locale("en", "US"));// aparece como 122,345.56
		Integer customerIdInt = Integer.valueOf(customerId);

		List<PreFilledApplicationDTO> collection = new ArrayList<PreFilledApplicationDTO>();	
		PreFilledApplicationIMPL preFilledApplicationIMPL = new PreFilledApplicationIMPL();

		PreFilledApplicationService preFilledApplicationService = new PreFilledApplicationService(); 
		PreFilledApplicationRequest preFilledApplicationRequest = new PreFilledApplicationRequest();
		
		try {		
			preFilledApplicationRequest.setCustomer(customerIdInt);
			preFilledApplicationRequest.setDateFormat(103);
			preFilledApplicationRequest.setIsAGroup(isGroup.charAt(0));
			preFilledApplicationRequest.setIsItaRenovation('S');
			//preFilledApplicationRequest.setMode(mode);
			preFilledApplicationRequest.setOperation('S');
			preFilledApplicationRequest.setProcess(tramite);
					
			
			PreFilledApplicationResponse[] PreFilledApplicationResponse = preFilledApplicationService.searchPreFilledApplication(preFilledApplicationRequest, serviceIntegration);
			
			List<PreFilledApplicationContentDTO> preFilledApplicationContentDTOList = new ArrayList<PreFilledApplicationContentDTO>();

			preFilledApplicationContentDTOList = preFilledApplicationIMPL.getContenido(PreFilledApplicationResponse, serviceIntegration);

			PreFilledApplicationDTO preFilledApplicationDTO = new PreFilledApplicationDTO();
			preFilledApplicationDTO.setContenido(preFilledApplicationContentDTOList);
			collection.add(preFilledApplicationDTO);

		} catch (Exception e) {
			logger.logError("------>>> Reporte Solicitud Credito Grupal Renovacion Fin Listado:", e);
			throw new RuntimeException(e);
		}
		
		return new JRBeanCollectionDataSource(collection, false);

	}

	@Override
	public Map<String, Object> getParamsReport(Map<String, Object> params) {
		logger.logDebug("----->>>> Reporte Solicitud Credito Grupal Renovacion Inicio");

		try {
			params.put("REPORT_LOCALE", new Locale("en", "US"));// aparece como 122,345.56
			params.put("urlPathSantander", ConstantValue.URL_IMAGEN_TUIIO2);
		} catch (Exception e) {
			logger.logDebug("----->>>> Classs PrefinancedRenewalApplicationServlet:", e);
			throw new RuntimeException("----->>>> Classs PrefinancedRenewalApplicationServlet", e);
		}

		return params;
	}

	@Override
	public String getReportLocation(Map<String, Object> parameters) {
		return getFileLocationReport(ConstantValue.PREFINANCED_RENEWAL_APPLICATION);
	}

	private String getFileLocationReport(String planPagosReportJasper) {
		return ConstantValue.PREFINANCED_RENEWAL_APPLICATION;
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

	public ICTSServiceIntegration getServiceIntegration() {
		return serviceIntegration;
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

}
