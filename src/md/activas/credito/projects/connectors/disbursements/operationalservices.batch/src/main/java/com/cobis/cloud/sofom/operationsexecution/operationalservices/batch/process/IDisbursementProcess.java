package com.cobis.cloud.sofom.operationsexecution.operationalservices.batch.process;

import java.util.Map;

import cobiscorp.ecobis.integrationengine.commons.dto.IEResponse;
import cobiscorp.ecobis.integrationengine.commons.dto.IntegrationContext;
import cobiscorp.ecobis.integrationengine.commons.exceptions.EngineFinalException;

public interface IDisbursementProcess {
	/**
	 * 
	 * @param context
	 * @param mapaRes
	 * @return
	 */
	IEResponse execute(IntegrationContext context,
			Map<String, Object> mapaRes) throws EngineFinalException;
}
