package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerChildrenResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class LoadSpouse extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(LoadSpouse.class);

	public LoadSpouse(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public void loadSpouse(DynamicRequest entities) {
		String secondName;
		String marriedSurname;
		String mothersLastName;

		ServiceRequestTO request = new ServiceRequestTO();
		ServiceResponse response;

		DataEntity customer = entities.getEntity(NaturalPerson.ENTITY_NAME);
		CustomerRequest customerRequest = new CustomerRequest();
		customerRequest.setCustomerId(customer.get(NaturalPerson.PERSONSECUENTIAL));
		customerRequest.setOperation(Parameter.OPERATION_SEARCH);
		customerRequest.setFormatDate(101);
		request.addValue("inCustomerRequest", customerRequest);

		StringBuilder spouseStr = new StringBuilder("");

		response = this.execute(LOGGER, Parameter.READ_SPOUSE, request);
		if (response != null && response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
			CustomerChildrenResponse[] customerChildrenList = (CustomerChildrenResponse[]) resultado.getValue("returnCustomerChildrenResponse");
			for (CustomerChildrenResponse item : customerChildrenList) {
				if (item.getType() == 'C') {
					secondName = item.getSecondName() == null ? "" : item.getSecondName();
					marriedSurname = item.getMarriedSurname() == null ? "" : item.getMarriedSurname();
					mothersLastName = item.getMothersLastName() == null ? "" : item.getMothersLastName();

					spouseStr.append(item.getName());
					spouseStr.append(" ");
					spouseStr.append(secondName);
					spouseStr.append(" ");
					spouseStr.append(item.getLastName());
					spouseStr.append(" ");
					spouseStr.append(mothersLastName);
					if (!"".equals(marriedSurname)) {
						spouseStr.append(" DE ");
						spouseStr.append(marriedSurname);
					}
					break;
				}
			}
			customer.set(NaturalPerson.SPOUSE, spouseStr.toString());
		}
	}
}