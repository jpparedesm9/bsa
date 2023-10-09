package com.cobiscorp.ecobis.cloud.service.dto.common;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import org.codehaus.jackson.annotate.JsonIgnore;

public interface OutputData {

    @JsonIgnore
    ServiceResponse[] getResponses();
}
