package com.cobiscorp.cobis.busin.flcre.commons.services;

import cobiscorp.ecobis.account.dto.CustomerRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Outputs;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;

public class AccounManagement extends BaseEvent {

	public AccounManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	public Integer validateAmountSavingAccounts(CustomerRequest customerRequest, ICommonEventArgs args) throws Exception {

		CallServices callService = new CallServices(getServiceIntegration());
		Object object = callService.callServiceWithOutput(RequestName.INCUSTOMERREQUEST, customerRequest, ServiceId.SERVICEVALIDATEAMOUNTSAVINGACCOUNTS,
				Outputs.OUTAMOUNTVALIDATION, args);
		return object == null ? null : Integer.valueOf(String.valueOf(object));
	}

}
