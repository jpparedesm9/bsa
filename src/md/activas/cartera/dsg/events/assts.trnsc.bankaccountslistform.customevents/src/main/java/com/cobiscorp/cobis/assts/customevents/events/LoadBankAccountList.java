package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.ItemResponse;
import cobiscorp.ecobis.assets.cloud.dto.LoanPayEntryRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.BankAccount;
import com.cobiscorp.cobis.assts.model.Payment;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class LoadBankAccountList extends BaseEvent implements IInitDataEvent {

	private static final ILogger logger = LogFactory
			.getLogger(LoadBankAccountList.class);

	public LoadBankAccountList(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
		
		ServiceResponse response = null;
		ServiceRequestTO request = new ServiceRequestTO();

		DataEntity payment = entities.getEntity(Payment.ENTITY_NAME);
		DataEntityList itemList = new DataEntityList();

		LoanPayEntryRequest loanPayEntryRequest = new LoanPayEntryRequest();

		loanPayEntryRequest.setAction("H");
		loanPayEntryRequest.setSequentialEntry(payment.get(Payment.CUSTOMERID));
		loanPayEntryRequest.setApplicationType(payment.get(Payment.PAYMENTTYPE));

		request.addValue("inLoanPayEntryRequest", loanPayEntryRequest);
		response = this.execute(getServiceIntegration(), logger,
				Parameter.PROCESS_BANKACCOUNTLIST, request);

		if (response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
			ItemResponse[] clResponse = (ItemResponse[]) resultado.getValue("returnItemResponse");

			if (clResponse != null) {
				for (ItemResponse r : clResponse) {
					DataEntity item = new DataEntity();
					
					item.set(BankAccount.ACCOUNT, r.getProduct());
					item.set(BankAccount.CUSTOMERCODE, r.getCode());
					item.set(BankAccount.ACCOUNTNAME, r.getDescription());
					itemList.add(item);
				}
				entities.setEntityList(BankAccount.ENTITY_NAME, itemList );
			}
		}
		arg1.setSuccess(true);
	}

}
