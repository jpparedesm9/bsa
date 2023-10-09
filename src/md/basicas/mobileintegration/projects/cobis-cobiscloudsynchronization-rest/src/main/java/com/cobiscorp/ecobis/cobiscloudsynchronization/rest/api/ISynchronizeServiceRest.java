package com.cobiscorp.ecobis.cobiscloudsynchronization.rest.api;

import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.services.GetDataSynchronizeRequest;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.services.UpdateDataSynchronizeRequest;

public interface ISynchronizeServiceRest {
    com.cobiscorp.cobis.web.services.commons.model.ServiceResponse getDataToSynchronize(
            GetDataSynchronizeRequest request
    );

    com.cobiscorp.cobis.web.services.commons.model.ServiceResponse updateDataToSynchronize(
            UpdateDataSynchronizeRequest request
    );

    com.cobiscorp.cobis.web.services.commons.model.ServiceResponse getEntitiesData(
            String entity, int idSync, int page, int perPage
    );
}
