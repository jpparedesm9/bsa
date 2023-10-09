package com.cobiscorp.cobis.loans.commons.loansgroup.services;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.loansgroup.commons.constants.Outputs;
import com.cobiscorp.cobis.loans.loansgroup.commons.constants.RequestName;
import com.cobiscorp.cobis.loans.loansgroup.commons.constants.ReturnName;
import com.cobiscorp.cobis.loans.loansgroup.commons.constants.ServiceId;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountRequest;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountResponse;
import cobiscorp.ecobis.loangroup.dto.MemberResponseRenovation;

public class AmountManager extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(AmountManager.class);

	public AmountManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public GroupLoanAmountResponse[] searchAmount(GroupLoanAmountRequest amountRequest, ICommonEventArgs arg1) {
		LOGGER.logDebug("Inicio Servicio searchAmount");
		CallServices callService = new CallServices(getServiceIntegration());
		return (GroupLoanAmountResponse[]) callService.callServiceWithReturnArray(RequestName.AMOUNT_REQUEST, amountRequest, ServiceId.SEARCH_AMOUNT, ReturnName.AMOUNT_RESPONSE,
				arg1);
	}

	public MemberResponseRenovation[] searchAmountRenovation(GroupLoanAmountRequest amountRequest, ICommonEventArgs arg1) {
		LOGGER.logDebug("Inicio Servicio searchAmountRenovation");
		CallServices callService = new CallServices(getServiceIntegration());
		return (MemberResponseRenovation[]) callService.callServiceWithReturnArray(RequestName.AMOUNT_REQUEST, amountRequest, ServiceId.SEARCH_AMOUNT_RENOVATION,
				ReturnName.AMOUNT_RESPONSE_RENOVATION, arg1);
	}

	public void calcAmount(GroupLoanAmountRequest amountRequest, ICommonEventArgs arg1) throws BusinessException {
		LOGGER.logDebug("Inicio Servicio calcAmount");
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.AMOUNT_REQUEST, amountRequest, ServiceId.CALC_AMOUNT, arg1);

	}

	public String updateAmount(GroupLoanAmountRequest amountRequest, int mode, ICommonEventArgs arg1, BehaviorOption options) {
		LOGGER.logDebug("Inicio Servicio updateAmount - modo:" + mode);
		amountRequest.setMode(mode);

		CallServices callService = new CallServices(getServiceIntegration());
		Object object = callService.callServiceWithOutput(RequestName.AMOUNT_REQUEST, amountRequest, ServiceId.UPDATE_AMOUNT, Outputs.AMOUNTMSG1, arg1);
		return (String) (object == null ? null : object);

		/*
		 * ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		 * serviceRequestApplicationTO.addValue(RequestName.AMOUNT_REQUEST,
		 * amountRequest); ServiceResponse serviceResponse =
		 * execute(getServiceIntegration(), LOGGER, ServiceId.UPDATE_AMOUNT,
		 * serviceRequestApplicationTO); if (serviceResponse.isResult()) { return
		 * serviceResponse.isResult(); } else { MessageManagement.show(serviceResponse,
		 * arg1, options); } return false;
		 */
	}

}
