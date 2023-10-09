package com.cobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.process;

import cobiscorp.ecobis.integrationengine.commons.dto.IEResponse;
import cobiscorp.ecobis.integrationengine.commons.dto.IntegrationContext;
import cobiscorp.ecobis.integrationengine.commons.exceptions.EngineFinalException;

import java.util.Map;

public interface IDisbursementCheckProcess {
    IEResponse execute(IntegrationContext context,
                       Map<String, Object> mapaRes) throws EngineFinalException;
}
