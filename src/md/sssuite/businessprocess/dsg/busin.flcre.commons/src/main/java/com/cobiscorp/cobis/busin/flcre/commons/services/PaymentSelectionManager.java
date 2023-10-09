package com.cobiscorp.cobis.busin.flcre.commons.services;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountRequest;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountResponse;
import cobiscorp.ecobis.loangroup.dto.GroupRequest;
import cobiscorp.ecobis.loangroup.dto.GroupResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;


public class PaymentSelectionManager extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(PaymentSelectionManager.class);

	public PaymentSelectionManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}


	public GroupLoanAmountResponse[] searchGroupAccounts(GroupLoanAmountRequest amountRequest, ICommonEventArgs arg1) {
		logger.logDebug("Inicio Servicio searchGroupAccounts");
		CallServices callService = new CallServices(getServiceIntegration());
		return (GroupLoanAmountResponse[]) callService.callServiceWithReturnArray(RequestName.AMOUNT_REQUEST, amountRequest, ServiceId.SEARCH_AMOUNT,
				ReturnName.GROUP_AMOUNT_RESPONSE, arg1);
	}
	
	public void updateAccounts(GroupLoanAmountRequest accoutRequest, ICommonEventArgs arg1) {
		if (logger.isDebugEnabled())
			logger.logDebug("Inicio Servicio updateAccounts");

		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.AMOUNT_REQUEST, accoutRequest, ServiceId.UPDATE_AMOUNT, arg1);
	}
	
	public GroupResponse searchGroup(GroupRequest groupRequest,ICommonEventArgs eventArgs){
		CallServices callServices=new CallServices(getServiceIntegration());
		return (GroupResponse)callServices.callServiceWithReturn(RequestName.GROUP_REQUEST, groupRequest, ServiceId.SEARCH_GROUP, ReturnName.GROUP_RESPONSE, eventArgs);
	}
	
	//TODO: Cambiar la invocación
	public CustomerResponse searchCustomer(CustomerRequest customerRequest,ICommonEventArgs eventArgs){
		CallServices callServices=new CallServices(getServiceIntegration());
		return (CustomerResponse)callServices.callServiceWithReturn(RequestName.INLOANREQUEST, customerRequest, ServiceId.SERVICEREADLOANGENERALDATA, ReturnName.RETURNLOANRESPONSE, eventArgs);
	}
}
