package com.cobiscorp.cobis.busin.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.LoanRequest;

import com.cobiscorp.cobis.busin.model.DisbursementDetail;
import com.cobiscorp.cobis.busin.model.LoanHeader;
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

public class QV_TSRSE1342_26_RowDeleting extends BaseEvent implements IGridRowDeleting {
	private final static String INLOANREQUEST = "inLoanRequest";
	private final static String SERVICEREMOVEDISBURSEMENT = "Loan.LoanMaintenance.removeDisbursementForm";
	private static ILogger LOGGER = LogFactory.getLogger(QV_TSRSE1342_26_RowDeleting.class);

	public QV_TSRSE1342_26_RowDeleting(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs args) {
		try{
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Ingreso GridRowDeleting -> QV_ERPLI1480_97_RowSelecting");

			String taskId = args.getParameters().getTaskId();
			if (taskId.equals("T_FLCRE_76_SDEEF25")) {
				this.taskdisbursementform(row, args);
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.DISBURSEMENT_ROW_DELETING, e, args, LOGGER);
		}
		
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Salida GridRowDeleting -> QV_ERPLI1480_97_RowSelecting");
	}

	private void taskdisbursementform(DataEntity row, IGridRowActionEventArgs args) {
		DynamicRequest request = args.getDynamicRequest();
		DataEntity loanHeader = request.getEntity(LoanHeader.ENTITY_NAME);

		LoanRequest loanRequest = new LoanRequest();
		loanRequest.setSecuential(row.get(DisbursementDetail.SEQUENTIAL));
		loanRequest.setDisbursement(row.get(DisbursementDetail.DISBURSEMENTID));
		loanRequest.setRoyalBank(loanHeader.get(LoanHeader.OPERATIONBANCK));
		loanRequest.setShellbank(loanHeader.get(LoanHeader.OPERATIONBANCK));
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse = null;
		LOGGER.logDebug(":>:>disbursement Row:>:>"+row.getData());

		serviceRequestTO.getData().put(INLOANREQUEST, loanRequest);

		serviceResponse = execute(getServiceIntegration(), LOGGER, SERVICEREMOVEDISBURSEMENT, serviceRequestTO);

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
	}

}
