package com.cobiscorp.cobis.busin.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountRequest;
import com.cobiscorp.cobis.busin.model.MemberGroup;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.customevents.constants.RequestName;
import com.cobiscorp.cobis.loans.customevents.constants.ServiceId;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowUpdating;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class UpdateBankCheck extends BaseEvent implements IGridRowUpdating {
	private static final ILogger LOGGER = LogFactory
			.getLogger(UpdateBankCheck.class);

	public UpdateBankCheck(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs args) {
		// TODO Auto-generated method stub
		try {
			LOGGER.logDebug("----->>>Actualizar Grupo: MOnto: "
					+ row.get(MemberGroup.AMOUNT).doubleValue());
			LOGGER.logDebug("----->>>Actualizar Grupo: Miembro: "
					+ row.get(MemberGroup.MEMBERID));
			GroupLoanAmountRequest amountRequest = new GroupLoanAmountRequest();

			amountRequest.setSolicitude(row.get(MemberGroup.CREDIT));
			amountRequest.setCustomerId(row.get(MemberGroup.MEMBERID));
			//amountRequest.setAmount(row.get(MemberGroup.AMOUNT).doubleValue());
			amountRequest.setGroupId(row.get(MemberGroup.GROUPID));
			amountRequest.setBankCheck(row.get(MemberGroup.CHECK));
			amountRequest.setMode(1);
			
			LOGGER.logDebug("----->>>Actualizar Grupo: Id del grupo: "
					+ row.get(MemberGroup.GROUPID));

			this.updateAmount(amountRequest, args);
		} catch (BusinessException be) {
			LOGGER.logError("----->>>Actualizar Grupo: -- Error al Actualizar",
					be);
			args.setSuccess(false);
			args.getMessageManager().showErrorMsg(
					"Error al Actualizar" + be.getMessage());
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.DISBURSEMENTINCOME_UPDATE_BANK, e, args, LOGGER);
		}

	}

	public void updateAmount(GroupLoanAmountRequest amountRequest,
			ICommonEventArgs arg1) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Inicio Servicio updateAmount");

		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.AMOUNT_REQUEST, amountRequest,
				ServiceId.UPDATE_AMOUNT, arg1);
	}

	/*public GroupLoanAmountResponse[] searchAmount(
			GroupLoanAmountRequest amountRequest, ICommonEventArgs arg1) {
		logger.logDebug("Inicio Servicio searchAmount");
		CallServices callService = new CallServices(getServiceIntegration());
		return (GroupLoanAmountResponse[]) callService
				.callServiceWithReturnArray(RequestName.AMOUNT_REQUEST,
						amountRequest, ServiceId.SEARCH_AMOUNT,
						ReturnName.AMOUNT_RESPONSE, arg1);
	}*/

}
