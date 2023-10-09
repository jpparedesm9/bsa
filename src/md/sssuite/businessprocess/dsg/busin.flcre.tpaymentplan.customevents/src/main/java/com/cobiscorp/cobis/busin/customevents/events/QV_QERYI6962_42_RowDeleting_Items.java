package com.cobiscorp.cobis.busin.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.ReadLoanItemsRequest;

import com.cobiscorp.cobis.busin.model.CategoryNew;
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

public class QV_QERYI6962_42_RowDeleting_Items extends BaseEvent implements IGridRowDeleting {
	private static ILogger LOGGER = LogFactory.getLogger(QV_QERYI6962_42_RowDeleting_Items.class);

	public QV_QERYI6962_42_RowDeleting_Items(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs args) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Ingreso -> IGridRowDeleting -> QV_QERYI6962_42_RowDeleting_Items");

		DynamicRequest dynamicRequest = args.getDynamicRequest();
		DataEntity categoryNew = dynamicRequest.getEntity(CategoryNew.ENTITY_NAME);
		ReadLoanItemsRequest request=new ReadLoanItemsRequest();
		
		request.setConcept(row.get(CategoryNew.CONCEPT));//rubro
		LOGGER.logInfo("22..................CONCEPT.............."+request.getConcept());
		request.setBank(row.get(PaymentPlanHeader.IDREQUESTED).toString()); //banco
		LOGGER.logInfo("222222...............METHODOFPAYMENT..............."+request.getBank());
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse = null;
		
		try{
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
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_ROW_DELETE, e, args, LOGGER);
		}
	}
}
