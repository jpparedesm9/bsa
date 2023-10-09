package com.cobiscorp.cobis.assts.customevents.events;

import java.util.List;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class GroupPaymentQuery extends BaseEvent implements IExecuteQuery {

	private static final ILogger logger = LogFactory.getLogger(GroupPaymentQuery.class);

	public GroupPaymentQuery(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, IExecuteQueryEventArgs arg1) {
		return searchGroupDebts(entities, arg1);
	}

	public List<?> searchGroupDebts(DynamicRequest entities, IExecuteQueryEventArgs arg1) {
		DataEntityList groupPaymentResponseEntityList = new DataEntityList();

		if (logger.isDebugEnabled()) {
			logger.logDebug("SearchGroupDebts Filter group >>> " + entities.getData().get("groupId"));
		}

		Integer groupId = null;
		// Id de Servicio
		String serviceId = "Loan.GroupPaymentManagement.SearchGroupDebts";

		ServiceRequestTO serviceRequest = new ServiceRequestTO();

		cobiscorp.ecobis.assets.cloud.dto.GroupPaymentRequest requestInGroupPaymentRequest = new cobiscorp.ecobis.assets.cloud.dto.GroupPaymentRequest();

		if (entities.getData().get("groupId") != null && entities.getData().get("groupId") != "") {
			groupId = Integer.valueOf(entities.getData().get("groupId").toString());
		}
		requestInGroupPaymentRequest.setGroup(groupId);

		// Invocación de servicio
		serviceRequest.addValue("inGroupPaymentRequest", requestInGroupPaymentRequest);

		// Ejecución de servicio
		ServiceResponse response = this.execute(logger, serviceId, serviceRequest);

		// Mapeo de respuesta
		if (response.isResult()) {
			ServiceResponseTO result = (ServiceResponseTO) response.getData();
			if (result.isSuccess()) {
				cobiscorp.ecobis.assets.cloud.dto.GroupPaymentResponse[] groupPaymentResponseList = (cobiscorp.ecobis.assets.cloud.dto.GroupPaymentResponse[]) result
						.getValue("returnGroupPaymentResponse");

				for (cobiscorp.ecobis.assets.cloud.dto.GroupPaymentResponse groupPaymentResponseDTO : groupPaymentResponseList) {
					DataEntity groupPaymentResponseEntity = new DataEntity();
					groupPaymentResponseEntity.set(com.cobiscorp.cobis.assts.model.GroupPayment.ROL,
							groupPaymentResponseDTO.getRole());
					groupPaymentResponseEntity.set(com.cobiscorp.cobis.assts.model.GroupPayment.COLLATERALBALANCE,
							groupPaymentResponseDTO.getCollateralBalance());
					groupPaymentResponseEntity.set(com.cobiscorp.cobis.assts.model.GroupPayment.EXPIREDQUOTAS,
							groupPaymentResponseDTO.getExpiredQuotas());
					groupPaymentResponseEntity.set(com.cobiscorp.cobis.assts.model.GroupPayment.CUSTOMERNAME,
							groupPaymentResponseDTO.getCustomerName());
					groupPaymentResponseEntity.set(com.cobiscorp.cobis.assts.model.GroupPayment.EXPIREDAMOUNT,
							groupPaymentResponseDTO.getExpiredAmount());
					groupPaymentResponseEntity.set(com.cobiscorp.cobis.assts.model.GroupPayment.BANK,
							groupPaymentResponseDTO.getBank());

					groupPaymentResponseEntityList.add(groupPaymentResponseEntity);

				}

			} else {
				arg1.setSuccess(false);
				GeneralFunction.handleResponse(arg1, response, null);
			}
		}
		arg1.setSuccess(true);
		return groupPaymentResponseEntityList.getDataList();
	}

}
