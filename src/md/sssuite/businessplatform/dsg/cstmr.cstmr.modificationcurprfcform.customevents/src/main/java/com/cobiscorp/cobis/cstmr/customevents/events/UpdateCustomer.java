package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.CustomerManager;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class UpdateCustomer extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(UpdateCustomer.class);

	public UpdateCustomer(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs eventArgs) {
		DataEntity naturalPerson = entities.getEntity(NaturalPerson.ENTITY_NAME);
		LOGGER.logDebug("Inicio executeCommand de UpdateCustomer");

		CustomerManager customerManager = new CustomerManager(getServiceIntegration(), Parameter.MODECUSTOMER.TOTAL);

		try {

			CustomerTotalRequest customerTotalRequest = new CustomerTotalRequest();
			customerTotalRequest.setOperation('R');
			customerTotalRequest.setCodePerson(naturalPerson.get(NaturalPerson.PERSONSECUENTIAL));
			customerTotalRequest.setCustomerRFC(naturalPerson.get(NaturalPerson.IDENTIFICATIONRFC));
			customerTotalRequest.setIdentification(naturalPerson.get(NaturalPerson.DOCUMENTNUMBER));
			customerTotalRequest.setAccountIndividual(naturalPerson.get(NaturalPerson.ACCOUNTINDIVIDUAL));
			customerTotalRequest.setSantanderCode(naturalPerson.get(NaturalPerson.SANTANDERCODE));

			customerManager.updateCustomerRFCRUC(customerTotalRequest, eventArgs);

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.UPDATE_CUSTOMER, e, eventArgs, LOGGER);
		}
	}

}
