package com.cobiscorp.cobis.busin.customevents.form;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.services.QueryBureau;
import com.cobiscorp.cobis.busin.model.Aval;
import com.cobiscorp.cobis.busin.model.Context;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroExecutionResponse;

public class ExecuteQueryBureauAval extends BaseEvent implements IExecuteCommand {
	private static ILogger LOGGER = LogFactory.getLogger(ExecuteQueryBureauAval.class);

	public ExecuteQueryBureauAval(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest dynamicRequest, IExecuteCommandEventArgs iExecuteCommandEventArgs) {
		LOGGER.logDebug("Start executeCommand ");
		DataEntity aval = dynamicRequest.getEntity(Aval.ENTITY_NAME);
		int avalId = aval.get(Aval.IDCUSTOMER);
		try {
			ExecuteCommandQueryInfoCustomer commandQueryInfoCustomer = new ExecuteCommandQueryInfoCustomer(getServiceIntegration());
			if (avalId > 0) {
				LOGGER.logDebug("Queryng credit Bureay avalId " + avalId);
				mapBuro(dynamicRequest, avalId);
				commandQueryInfoCustomer.executeCommand(dynamicRequest, iExecuteCommandEventArgs);
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_BUREAU_AVAL, e, iExecuteCommandEventArgs, LOGGER);
			aval.set(Aval.CREDITBUREAU, "Error");
		}
	}

	public void mapBuro(DynamicRequest dynamicRequest, int avalID) throws Exception {
		DataEntity aval = dynamicRequest.getEntity(Aval.ENTITY_NAME);
		DataEntity originalHeader = dynamicRequest.getEntity(OriginalHeader.ENTITY_NAME);
		int instProc = originalHeader.get(OriginalHeader.APPLICATIONNUMBER);
		
		DataEntity context = dynamicRequest.getEntity(Context.ENTITY_NAME);		
		Integer channel = context.get(Context.CHANNEL);

		QueryBureau queryBureau = new QueryBureau(super.getServiceIntegration());
		BuroExecutionResponse buroAvalResponse = queryBureau.queryBureau(avalID, instProc, channel);
		System.out.println(">>>>>>>>>>buro" + buroAvalResponse.getRuleExecutionResult());
		aval.set(Aval.BCBLACKLISTS, buroAvalResponse.getRuleExecutionResult());
		//aval.set(Aval.CREDITBUREAU, String.valueOf(buroAvalResponse.getRiskScore()));
		aval.set(Aval.RISKLEVEL, buroAvalResponse.getRuleExecutionResult());
		LOGGER.logDebug("Start llama al aval");
	}

}
