package com.cobiscorp.cobis.assts.customevents.events;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.DetailRejectedDispersions;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

import cobiscorp.ecobis.assets.cloud.dto.RejectedDispersionsRequest;
import cobiscorp.ecobis.assets.cloud.dto.RejectedDispersionsResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class QueryDispersionsRejected extends BaseEvent implements IExecuteQuery {

	private static final ILogger LOGGER = LogFactory.getLogger(QueryDispersionsRejected.class);

	public QueryDispersionsRejected(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, IExecuteQueryEventArgs arg1) {

		LOGGER.logDebug(">>>>>Inicia QueryDispersionsRejected");
		DataEntityList resultDataEntityList = new DataEntityList();

		try {
			ServiceRequestTO serviceRequestTo = new ServiceRequestTO();
			RejectedDispersionsRequest rejectedDispersionsRequest = new RejectedDispersionsRequest();

			LOGGER.logDebug("data DispersionsRejected: " + entities.getData().toString());
			LOGGER.logDebug("args Parameters: " + arg1.getParameters().getCustomParameters());
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			LOGGER.logDebug("args CustomerCode: " + arg1.getParameters().getCustomParameters().get("customerCode"));
			LOGGER.logDebug("args GroupCode: " + arg1.getParameters().getCustomParameters().get("groupCode"));
			LOGGER.logDebug("args startDate: " + (Date) arg1.getParameters().getCustomParameters().get("startDate"));
			LOGGER.logDebug("args startDate Calendar: " + GeneralFunction
					.convertDateToCalendar((Date) arg1.getParameters().getCustomParameters().get("startDate")));

			rejectedDispersionsRequest.setOperation('S');

			if (arg1.getParameters().getCustomParameters().get("customerCode") != null
					&& arg1.getParameters().getCustomParameters().get("customerCode") != "") {
				rejectedDispersionsRequest.setCustomerCode(Integer
						.valueOf((String) arg1.getParameters().getCustomParameters().get("customerCode").toString()));
			}
			if (arg1.getParameters().getCustomParameters().get("groupCode") != null
					&& arg1.getParameters().getCustomParameters().get("groupCode") != "") {
				rejectedDispersionsRequest.setGroupCode(Integer
						.valueOf((String) arg1.getParameters().getCustomParameters().get("groupCode").toString()));
			}
			//if (arg1.getParameters().getCustomParameters().get("action") != null
			//		&& arg1.getParameters().getCustomParameters().get("action") != "") {
				rejectedDispersionsRequest
						.setAction(Integer
								.valueOf(arg1.getParameters().getCustomParameters().get("action").toString()));
			//}
			if (arg1.getParameters().getCustomParameters().get("account") != null
					|| arg1.getParameters().getCustomParameters().get("account") != "") {
				rejectedDispersionsRequest
						.setAccount((String) arg1.getParameters().getCustomParameters().get("account"));
			}
			if (arg1.getParameters().getCustomParameters().get("startDate") != null) {
				rejectedDispersionsRequest
						.setStartDate(sdf.format(arg1.getParameters().getCustomParameters().get("startDate")));
			}
			if (arg1.getParameters().getCustomParameters().get("endDate") != null) {
				rejectedDispersionsRequest
						.setEndDate(sdf.format(arg1.getParameters().getCustomParameters().get("endDate")));
			}
			if (arg1.getParameters().getCustomParameters().get("type") != null
					&& arg1.getParameters().getCustomParameters().get("type") != "") {
				rejectedDispersionsRequest.setType((String) arg1.getParameters().getCustomParameters().get("type"));
			}

			serviceRequestTo.addValue(Parameter.DISPERSIONS_REQUEST, rejectedDispersionsRequest);
			ServiceResponse response = execute(LOGGER, Parameter.SEARCHDISPERSIONS, serviceRequestTo);

			if (response.isResult()) {
				ServiceResponseTO serviceResponseTo = (ServiceResponseTO) response.getData();

				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug(">>>>>>>>> resultado serviceResponseTo:" + serviceResponseTo);
				}
				RejectedDispersionsResponse[] detailRejectedDispersionsQuery = (RejectedDispersionsResponse[]) serviceResponseTo
						.getValue(Parameter.DISPERSIONS_RESPONSE);

				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug(">>>>>>>>> resultado conditionStandards:" + detailRejectedDispersionsQuery);
				}

				if (detailRejectedDispersionsQuery != null) {

					for (RejectedDispersionsResponse data : detailRejectedDispersionsQuery) {
						DataEntity detailRejectedDispersionsResult = new DataEntity();
						Date dateTmp = null;
						SimpleDateFormat formatDate = new SimpleDateFormat("dd/MM/yyyy");

						detailRejectedDispersionsResult.set(DetailRejectedDispersions.CUSTOMERCODE,
								String.valueOf(data.getCustomerCode()));

						if (data.getDate() != null) {
							dateTmp = formatDate.parse(data.getDate());
						}

						detailRejectedDispersionsResult.set(DetailRejectedDispersions.DATE, dateTmp);
						detailRejectedDispersionsResult.set(DetailRejectedDispersions.CUSTOMERNAMES,
								String.valueOf(data.getNameSurname()));
						detailRejectedDispersionsResult.set(DetailRejectedDispersions.BUC, data.getBuc());
						detailRejectedDispersionsResult.set(DetailRejectedDispersions.DISPERSIONTYPE, data.getType());
						detailRejectedDispersionsResult.set(DetailRejectedDispersions.ACCOUNT, data.getAccount());
						detailRejectedDispersionsResult.set(DetailRejectedDispersions.CAUSAL, data.getCause());
						detailRejectedDispersionsResult.set(DetailRejectedDispersions.GROUPCODE,
								String.valueOf(data.getGroupCode()));
						detailRejectedDispersionsResult.set(DetailRejectedDispersions.GROUPNAME, data.getGroupName());
						detailRejectedDispersionsResult.set(DetailRejectedDispersions.VALUEDISPERSION, data.getValue());
						detailRejectedDispersionsResult.set(DetailRejectedDispersions.ACTION,
								String.valueOf(data.getAction()));
						detailRejectedDispersionsResult.set(DetailRejectedDispersions.DATETIMEACTION,
								data.getActionDate());
						detailRejectedDispersionsResult.set(DetailRejectedDispersions.USER, data.getUser());
						detailRejectedDispersionsResult.set(DetailRejectedDispersions.CONSECUTIVE,
								data.getConsecutive());
						detailRejectedDispersionsResult.set(DetailRejectedDispersions.LINE, data.getLine());
						detailRejectedDispersionsResult.set(DetailRejectedDispersions.BANK, data.getBank());

						resultDataEntityList.add(detailRejectedDispersionsResult);
					}
				}
				arg1.setSuccess(true);
				return resultDataEntityList.getDataList();
			} else {
				arg1.setSuccess(false);
				if (response.getMessages() != null) {
					arg1.getMessageManager().showErrorMsg(getSpsMessages(response.getMessages()));
				}
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Assets.SEARCH_PRECANCELATION, e, arg1, LOGGER);
		}

		return resultDataEntityList;
	}

	public String getSpsMessages(List<Message> messages) {
		if (messages != null) {
			String messagesString = Parameter.EMPTY_VALUE;
			for (Message message : messages) {
				messagesString = messagesString.concat(" ").concat(message.getMessage());
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(" MENSAJES: " + messagesString);
			}
			return messagesString.substring(7);
		}
		return null;
	}

}
