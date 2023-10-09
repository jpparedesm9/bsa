package com.cobiscorp.ecobis.cloud.service.integration;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.extractValue;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.OfficeGeoRequest;
import cobiscorp.ecobis.systemconfiguration.dto.OfficeGeoResponse;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.util.RestServiceBase;

/**
 * @author Cesar Loachamin
 */
public class OfficeIntegrationService extends RestServiceBase {

	//private final ILogger LOGGER = LogFactory.getLogger(OfficeIntegrationService.class);

	public OfficeIntegrationService(ICTSServiceIntegration integration) {
		super(integration);
	}

	public OfficeGeoResponse searchOfficeGeoReference(String officerLogin, int filialId) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		OfficeGeoRequest request = new OfficeGeoRequest();
		request.setOfficerLogin(officerLogin);
		request.setFilialId(filialId);
		requestTo.addValue("inOfficeGeoRequest", request);
		ServiceResponse response = execute("SystemConfiguration.OfficeManagement.SearchOfficeGeoreference", requestTo);
		return extractValue(response, "returnOfficeGeoResponse", OfficeGeoResponse.class);
	}
}
