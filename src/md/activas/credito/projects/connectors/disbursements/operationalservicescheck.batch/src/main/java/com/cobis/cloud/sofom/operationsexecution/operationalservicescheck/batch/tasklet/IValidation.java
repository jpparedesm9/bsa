package com.cobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.tasklet;

import cobiscorp.ecobis.integrationengine.commons.dto.BatchResponse;
import cobiscorp.ecobis.integrationengine.commons.exceptions.EngineProcessRowException;
import com.cobiscorp.cobisv.commons.context.Context;

public interface IValidation {
    BatchResponse execute(Context context, String fileName,
                          String header)
            throws EngineProcessRowException;
}
