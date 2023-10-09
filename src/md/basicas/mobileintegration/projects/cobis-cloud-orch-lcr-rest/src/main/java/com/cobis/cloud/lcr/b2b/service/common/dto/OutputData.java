package com.cobis.cloud.lcr.b2b.service.common.dto;

import org.codehaus.jackson.annotate.JsonIgnore;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

public interface OutputData {

    @JsonIgnore
    ServiceResponse[] getResponses();
}
