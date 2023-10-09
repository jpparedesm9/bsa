package com.cobiscorp.cobis.cstmr.customevents.events;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.CustomerManagerQuery;
import com.cobiscorp.cobis.cstmr.commons.events.GeneralFunction;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
import com.cobiscorp.cobis.cstmr.model.Parameters;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.ParameterReques;
import cobiscorp.ecobis.customerdatamanagement.dto.ParameterResponse;

public class CustomerInitDataEvent extends BaseEvent implements IInitDataEvent {

	public CustomerInitDataEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	private static final ILogger LOGGER = LogFactory.getLogger(CustomerInitDataEvent.class);

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {
		Map<String, Object> result = new HashMap<String, Object>();
		String mesage = Parameter.EMPTY_VALUE;

		CustomerManagerQuery customerManagerQuery = new CustomerManagerQuery(getServiceIntegration(), Parameter.MODECUSTOMER.TOTAL);
		try {
			result = customerManagerQuery.getCustomerInfo(entities);
			mesage = GeneralFunction.getMessageError((List<Message>) result.get(Parameter.MESSAGESERVERLIST), (List<String>) result.get(Parameter.MESSAGEVALIDATIONLIST));
			if (!Parameter.EMPTY_VALUE.equals(mesage)) {
				args.getMessageManager().showErrorMsg(mesage);
			} else {

				// Cargar datos de actividades economicas
				LoadEconomicActivities loadEconomicActivitiesList = new LoadEconomicActivities(getServiceIntegration());
				loadEconomicActivitiesList.loadEconomicActivities(entities);
			}

			// Lee parametros de edad minima y fecha vencimiento de documento
			readMinimumAgeParameter(entities);
			readIDExpirationParameter(entities);
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.INIT_DATA_CUSTOMER, e, args, LOGGER);
		}
	}

	public void readMinimumAgeParameter(DynamicRequest entities) {
		ServiceRequestTO request = new ServiceRequestTO();
		ServiceResponse response;

		DataEntity naturalPerson = entities.getEntity(Parameters.ENTITY_NAME);
		naturalPerson.set(Parameters.MINIMUMAGE, null);

		ParameterReques parameterRequest = new ParameterReques();
		parameterRequest.setOperation(Parameter.OPERATION_QUERY);
		parameterRequest.setProduct("CLI");
		parameterRequest.setNemonic("EMRCLI");
		parameterRequest.setDateFormat(101);
		request.addValue("inParameterReques", parameterRequest);

		response = this.execute(LOGGER, Parameter.READ_MINIMUM_AGE, request);

		if (response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
			if (resultado.isSuccess()) {
				ParameterResponse[] parameterList = (ParameterResponse[]) resultado.getValue("returnParameterResponse");
				for (ParameterResponse item : parameterList) {
					naturalPerson.set(Parameters.MINIMUMAGE, item.getIntTypeParameter());
				}
			}
		}
	}

	public void readIDExpirationParameter(DynamicRequest entities) {
		ServiceRequestTO request = new ServiceRequestTO();
		ServiceResponse response;

		DataEntity parameters = entities.getEntity(Parameters.ENTITY_NAME);
		parameters.set(Parameters.IDEXPIRATION, null);

		ParameterReques parameterRequest = new ParameterReques();
		parameterRequest.setOperation(Parameter.OPERATION_QUERY);
		parameterRequest.setProduct("CLI");
		parameterRequest.setNemonic("FVDI");
		parameterRequest.setDateFormat(101);
		request.addValue("inParameterReques", parameterRequest);

		response = this.execute(LOGGER, Parameter.READ_ID_EXPIRATION, request);

		if (response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
			if (resultado.isSuccess()) {
				ParameterResponse[] parameterList = (ParameterResponse[]) resultado.getValue("returnParameterResponse");
				for (ParameterResponse item : parameterList) {
					LOGGER.logDebug("item.getDateTypeParameter() --> ");
					LOGGER.logDebug(item.getDateTypeParameter());
					parameters.set(Parameters.IDEXPIRATION, item.getDateTypeParameter().getTime());
				}
			}
		}
	}

}
