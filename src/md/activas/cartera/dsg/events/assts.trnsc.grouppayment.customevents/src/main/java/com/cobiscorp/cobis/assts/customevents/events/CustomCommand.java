package com.cobiscorp.cobis.assts.customevents.events;

import java.math.BigDecimal;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assts.model.GroupPaymenInfo;
import com.cobiscorp.cobis.assts.model.GroupPaymentFilter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class CustomCommand extends BaseEvent implements IExecuteCommand {

	private static final ILogger logger = LogFactory.getLogger(CustomCommand.class);

	public CustomCommand(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs arg1) {
		clearDataGroupPaymentInfo(entities);
		readGroupInfo(entities, arg1);
	}

	public void readGroupInfo(DynamicRequest entities, IExecuteCommandEventArgs arg1) {
		DataEntity groupPaymentInfo = entities.getEntity(GroupPaymenInfo.ENTITY_NAME);
		DataEntity groupPaymentFilter = entities.getEntity(GroupPaymentFilter.ENTITY_NAME);
		// Id de Servicio
		String serviceId = "Loan.GroupPaymentManagement.ReadGroupInfo";
		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		cobiscorp.ecobis.assets.cloud.dto.GroupPaymentRequest requestInGroupPaymentRequest = new cobiscorp.ecobis.assets.cloud.dto.GroupPaymentRequest();

		requestInGroupPaymentRequest.setGroup(Integer.valueOf(groupPaymentFilter.get(GroupPaymentFilter.GROUP)));

		// Invocación de servicio
		serviceRequest.addValue("inGroupPaymentRequest", requestInGroupPaymentRequest);

		// Ejecución de servicio
		ServiceResponse response = this.execute(logger, serviceId, serviceRequest);
		if (response.isResult()) {
			ServiceResponseTO result = (ServiceResponseTO) response.getData();
			if (result.isSuccess()) {
				cobiscorp.ecobis.assets.cloud.dto.GroupInfoResponse groupInfoResponse = (cobiscorp.ecobis.assets.cloud.dto.GroupInfoResponse) result
						.getValue("returnGroupInfoResponse");
				groupPaymentInfo.set(GroupPaymenInfo.COLLATERALBALANCE, groupInfoResponse.getCollateralBalance());
				groupPaymentInfo.set(GroupPaymenInfo.GROUPNAME, groupInfoResponse.getGroupName());
				groupPaymentInfo.set(GroupPaymenInfo.TOTALAMOUNT, groupInfoResponse.getTotalAmount());
				groupPaymentInfo.set(GroupPaymenInfo.VALUEAMOUNTUSEGUARANTEE,
						getValueAmount(groupInfoResponse.getTotalAmount(), groupInfoResponse.getCollateralBalance()));
				arg1.setSuccess(true);
			} else {
				arg1.setSuccess(false);
				GeneralFunction.handleResponse(arg1, response, null);
			}
		}

	}

	public BigDecimal getValueAmount(BigDecimal totalAmount, BigDecimal collateralBalance) {
		if (totalAmount.compareTo(collateralBalance) <= 0) {
			return totalAmount;
		}
		return collateralBalance;
	}

	public void clearDataGroupPaymentInfo(DynamicRequest entities) {
		DataEntity groupPaymentInfo = entities.getEntity(GroupPaymenInfo.ENTITY_NAME);
		groupPaymentInfo.set(GroupPaymenInfo.COLLATERALBALANCE, new BigDecimal(0));
		groupPaymentInfo.set(GroupPaymenInfo.GROUPNAME, "");
		groupPaymentInfo.set(GroupPaymenInfo.TOTALAMOUNT, new BigDecimal(0));
		groupPaymentInfo.set(GroupPaymenInfo.VALUEAMOUNTUSEGUARANTEE, new BigDecimal(0));
	}

}
