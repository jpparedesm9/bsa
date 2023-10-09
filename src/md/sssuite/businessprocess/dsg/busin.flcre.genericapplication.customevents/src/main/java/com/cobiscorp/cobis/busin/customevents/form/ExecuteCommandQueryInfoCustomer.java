package com.cobiscorp.cobis.busin.customevents.form;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.model.Aval;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ExecuteCommandQueryInfoCustomer extends BaseEvent implements IExecuteCommand {
	private static ILogger LOGGER = LogFactory.getLogger(ExecuteCommandQueryInfoCustomer.class);

	public ExecuteCommandQueryInfoCustomer(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@SuppressWarnings({ "unchecked", "unused" })
	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {

		try {
			LOGGER.logDebug("---->Entra al ExecuteCommandQueryInfoCustomer");

			DataEntity aval = entities.getEntity(Aval.ENTITY_NAME);
			TransactionManagement transactionManagement = new TransactionManagement(getServiceIntegration());

			int avalId = aval.get(Aval.IDCUSTOMER);

			CustomerRequest customerRequest = new CustomerRequest();

			customerRequest.setCustomerId(avalId);
			customerRequest.setModo(0);

			CustomerResponse customerResponse = transactionManagement.readDataCustomer(customerRequest, args, new BehaviorOption(true));
			if (customerResponse != null) {
				LOGGER.logDebug("---->Entra al ExecuteCommandQueryInfoCustomer - getCustomerRFC:" + customerResponse.getCustomerRFC());
				aval.set(Aval.RFC, customerResponse.getCustomerRFC());
			}

		} catch (Exception ex) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_SEARCH_CLIENT, ex, args, LOGGER);
		}

	}
}
