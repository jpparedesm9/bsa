package com.cobiscorp.cobis.bmtrc.customevents.manager;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.BehaviorOption;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;
import com.cobiscorp.ecobis.business.commons.platform.utils.Outputs;
import com.cobiscorp.ecobis.business.commons.platform.utils.RequestName;
import com.cobiscorp.ecobis.business.commons.platform.utils.ReturnName;
import com.cobiscorp.ecobis.business.commons.platform.utils.ServiceId;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountRequest;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountResponse;

public class AmountManager extends BaseEvent {
	private static final String AMOUNT_RESPONSE = "returnGroupLoanAmountResponse";
	private static final String AMOUNT_REQUEST = "inGroupLoanAmountRequest";
	private static final String SEARCH_AMOUNT = "LoanGroup.GroupLoanAmountMaintenance.ListLoanAmount";
	private static final ILogger LOGGER = LogFactory.getLogger(AmountManager.class);

	public AmountManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public GroupLoanAmountResponse[] searchAmount(GroupLoanAmountRequest amountRequest, ICommonEventArgs arg1) {
		LOGGER.logDebug("Inicio Servicio searchAmount");
		CallServices callService = new CallServices(getServiceIntegration());
		return (GroupLoanAmountResponse[]) callService.callServiceWithReturnArray(AMOUNT_REQUEST, amountRequest,
				SEARCH_AMOUNT, AMOUNT_RESPONSE, arg1);
	}

}
