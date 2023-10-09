package com.cobiscorp.cobis.busin.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsRequest;

import com.cobiscorp.cobis.busin.model.Category;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IGridRowDeleting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class QV_UYCTE6570_70_RowDeleting_Items extends BaseEvent implements IGridRowDeleting {
	private static ILogger LOGGER = LogFactory.getLogger(QV_UYCTE6570_70_RowDeleting_Items.class);

	public QV_UYCTE6570_70_RowDeleting_Items(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs args) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Ingreso -> IGridRowDeleting -> QV_UYCTE6570_70_RowDeleting_Items");
		try{
			DynamicRequest dynamicRequest = args.getDynamicRequest();
			DataEntity paymentPlanHeader = dynamicRequest.getEntity(PaymentPlanHeader.ENTITY_NAME);

			LOGGER.logDebug("paymentPlanHeader:" + paymentPlanHeader);
			LOGGER.logDebug("paymentPlanHeader request:" + paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED));
			ReadLoanItemsRequest request = new ReadLoanItemsRequest();

			request.setConcept(row.get(Category.CONCEPT));// rubro
			LOGGER.logInfo("..................CONCEPT.............." + request.getConcept());
			request.setBank(paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED) == null ? null : String.valueOf(paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED)));
			LOGGER.logInfo("...............BANK..............." + request.getBank());
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			ServiceResponse serviceResponse = null;

			serviceRequestTO.getData().put("inReadLoanItemsRequest", request);

			serviceResponse = execute(getServiceIntegration(), LOGGER, "Loan.SearchLoanItems.DeleteItems", serviceRequestTO);

			if (serviceResponse.isResult()) {
				args.getMessageManager().showSuccessMsg("DSGNR.SYS_DSGNR_LBLEXECOK_00003");
				args.setSuccess(true);
				return;
			} else {
				List<Message> errorMessage = new ArrayList<Message>();
				args.setSuccess(false);
				errorMessage = serviceResponse.getMessages();
				for (Message message : errorMessage) {
					args.getMessageManager().showErrorMsg(message.getMessage() + "/n");
				}
				return;
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_CHANGE_APROVED, e, args, LOGGER);
		}
	}
}
