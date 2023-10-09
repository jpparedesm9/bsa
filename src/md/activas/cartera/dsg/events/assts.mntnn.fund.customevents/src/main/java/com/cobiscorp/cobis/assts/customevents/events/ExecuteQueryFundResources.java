package com.cobiscorp.cobis.assts.customevents.events;

import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.ResourceResponseList;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ExecuteQueryFundResources extends BaseEvent implements
		IExecuteQuery {
	private static final ILogger LOGGER = LogFactory
			.getLogger(ExecuteQueryFundResources.class);

	public ExecuteQueryFundResources(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities,
			IExecuteQueryEventArgs args) {
		DataEntityList resourceFundList = new DataEntityList();
		try {
			FundResourcesQuery fundResourcesQuery = new FundResourcesQuery(
					getServiceIntegration());
			resourceFundList = fundResourcesQuery.searchFundResources(entities);
		} catch (Exception e) {
			LOGGER.logDebug("Error al Recuperar Fuentes de los Recursos", e);
			args.setSuccess(false);
			args.getMessageManager().showErrorMsg(
					"Error al Recuperar Fuentes de los Recursos");
		} finally {
			LOGGER.logDebug("Finish executeDataEvent in ExecuteQueryFundResources");
		}
		return resourceFundList.getDataList();
	}

}
