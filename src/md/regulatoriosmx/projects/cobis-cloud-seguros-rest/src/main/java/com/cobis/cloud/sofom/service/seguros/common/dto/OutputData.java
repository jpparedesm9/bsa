package com.cobis.cloud.sofom.service.seguros.common.dto;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import org.codehaus.jackson.annotate.JsonIgnore;

public interface OutputData {

    @JsonIgnore
    ServiceResponse[] getResponses();
}
