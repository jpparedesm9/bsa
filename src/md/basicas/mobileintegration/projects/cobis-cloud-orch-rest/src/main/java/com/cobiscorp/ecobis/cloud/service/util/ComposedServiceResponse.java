package com.cobiscorp.ecobis.cloud.service.util;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

/**
 * @author Cesar Loachamin
 */
public interface ComposedServiceResponse {

    ServiceResponse[] getResponses();
}
