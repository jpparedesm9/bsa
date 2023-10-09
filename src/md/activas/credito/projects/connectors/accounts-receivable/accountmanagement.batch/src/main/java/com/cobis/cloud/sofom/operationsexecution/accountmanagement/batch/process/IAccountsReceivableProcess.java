package com.cobis.cloud.sofom.operationsexecution.accountmanagement.batch.process;

import java.util.Map;

import cobiscorp.ecobis.integrationengine.commons.dto.IEResponse;
import cobiscorp.ecobis.integrationengine.commons.dto.IntegrationContext;
import cobiscorp.ecobis.integrationengine.commons.exceptions.EngineFinalException;

public interface IAccountsReceivableProcess {
	/**
	 * 
	 * @param context
	 * @param mapaRes
	 * @return
	 */
	IEResponse execute(IntegrationContext context,
			Map<String, Object> mapaRes) throws EngineFinalException;
}
