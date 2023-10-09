package com.cobiscorp.ecobis.cloud.service.integration;

import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.business.commons.platform.utils.Outputs;
import com.cobiscorp.ecobis.business.commons.platform.utils.ServiceId;
import com.cobiscorp.ecobis.cloud.service.util.RestServiceBase;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.EquivalenceRequest;

public class EquivalencesService extends RestServiceBase {

	private final ILogger LOGGER = LogFactory.getLogger(EquivalencesService.class);

	private static final String CATALOG_CURP = "ENT_CURP";

	public EquivalencesService(ICTSServiceIntegration integration) {
		super(integration);
	}

	public String getBirthPlaceEquivalence(String birthPlace) throws BusinessException {

		String equivalence = null;
		EquivalenceRequest equivalenceRequest = new EquivalenceRequest();
		equivalenceRequest.setCatalog1(CATALOG_CURP);
		equivalenceRequest.setEquivalence(birthPlace);
		equivalenceRequest.setMode(3);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue("inEquivalenceRequest", equivalenceRequest);

		ServiceResponse serviceResponseEquiv = this.execute(ServiceId.QUERY_EQUIVALENCES, serviceRequestTO);

		if (serviceResponseEquiv == null) {
			LOGGER.logError("Eror al consultar equivalencias");
			throw new BusinessException(601321);
		} else {
			if (serviceResponseEquiv.isResult()) {
				ServiceResponseTO dataResponse = (ServiceResponseTO) serviceResponseEquiv.getData();

				Map<String, Object> output = (Map<String, Object>) dataResponse.getData().get(Outputs.OUTPUT);
				if (output != null) {
					equivalence = output.get(Outputs.OUT_VALOR_EQUIV) == null ? "" : (String) output.get(Outputs.OUT_VALOR_EQUIV);
					LOGGER.logDebug("Equivalencia >>" + equivalence);
				}
			} else {
				LOGGER.logError("No se encontraron equivalencias");
				throw new BusinessException(601321);
			}
		}
		return equivalence;
	}

}
