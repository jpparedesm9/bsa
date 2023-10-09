package com.cobiscorp.cobis.loans.customevents.events;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.commons.loansgroup.services.QueryBureau;
import com.cobiscorp.cobis.loans.loansgroup.commons.constants.Constants;
import com.cobiscorp.cobis.loans.model.Amount;
import com.cobiscorp.cobis.loans.model.Context;
import com.cobiscorp.cobis.loans.model.Credit;
import com.cobiscorp.cobis.loans.model.Group;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.busin.model.CustomerDto;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroExecutionResponse;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

public class VA_VABUTTONAICSAKZ_975190_Execute extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(VA_VABUTTONAICSAKZ_975190_Execute.class);

	public VA_VABUTTONAICSAKZ_975190_Execute(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest dynamicRequest, IExecuteCommandEventArgs arg1) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Ingreso executeCommand VA_VABUTTONAICSAKZ_975190_Execute");
		}

		try {
			String error = null;

			DataEntity groupEntity = dynamicRequest.getEntity(Group.ENTITY_NAME);
			DataEntityList amountEntityList = dynamicRequest.getEntityList(Amount.ENTITY_NAME);
			DataEntity contextEntity = dynamicRequest.getEntity(Context.ENTITY_NAME);
			
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("GroupId " + groupEntity.get(Group.CODE));
			}

			Integer channel = null;
			channel = contextEntity.get(Context.CHANNEL);
			List<CustomerDto> clients = new ArrayList<CustomerDto>();

			for (DataEntity d : amountEntityList) {
				clients.add(new CustomerDto(d.get(Amount.MEMBERID), d.get(Amount.MEMBERNAME), d.get(Amount.CHECKRENAPO)));
			}

			CatalogManagement catalogManagement = new CatalogManagement(getServiceIntegration());
			ParameterResponse parameterDto = catalogManagement.getParameter(4, "RENAPO", "CLI", arg1, new BehaviorOption(false, false));
			String renapo = Constants.RENAPO_INACTIVE;
			if (parameterDto != null && parameterDto.getParameterValue() != null) {
				renapo = parameterDto.getParameterValue().trim();
			}

			QueryBureau queryBureau = new QueryBureau(this.getServiceIntegration());

			DataEntity credit = dynamicRequest.getEntity(Credit.ENTITY_NAME);
			int instProc = credit.get(Credit.APPLICATIONNUMBER);

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("VA_VABUTTONAICSAKZ_975190_Execute>>executeCommand>>instProc: " + instProc);
			}

			List<BuroExecutionResponse> buroExecutionResponseList = queryBureau.excuteQueryBureauForGroup(groupEntity.get(Group.CODE), clients, renapo, instProc, channel);

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("buroExecutionResponseList " + buroExecutionResponseList);
			}

			boolean found = false;

			if (buroExecutionResponseList != null) {
				found = false;
				for (DataEntity d : amountEntityList) {
					for (BuroExecutionResponse br : buroExecutionResponseList) {
						if (d.get(Amount.MEMBERID).equals(br.getClientId())) {
							// d.set(Amount.CREDITBUREAU, String.valueOf(br.getRiskScore()));
							d.set(Amount.RISKLEVEL, br.getRuleExecutionResult());
							found = true;
							if (br.getRuleExecutionResult() == "F") {
								error = error + ", " + br.getClientId();
							}
							break;
						}
					}
					if (!found) {
						d.set(Amount.CREDITBUREAU, "Error");
						d.set(Amount.RISKLEVEL, "");
					}
				}
			}

			if (error != null) {
				error = "Prospecto rechazado por deterioro crediticio" + error;
				LOGGER.logDebug("El error es: " + error);
				arg1.getMessageManager().showInfoMsg(error);
			}

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Clients.SEARCH_BURO, e, arg1, LOGGER);
		}
	}
}
