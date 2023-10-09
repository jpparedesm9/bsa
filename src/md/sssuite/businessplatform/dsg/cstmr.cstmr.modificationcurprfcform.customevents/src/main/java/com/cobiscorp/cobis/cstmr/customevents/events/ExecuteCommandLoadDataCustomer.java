package com.cobiscorp.cobis.cstmr.customevents.events;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.CustomerManagerQuery;
import com.cobiscorp.cobis.cstmr.commons.events.GeneralFunction;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
import com.cobiscorp.cobis.cstmr.model.Context;
import com.cobiscorp.cobis.cstmr.model.DemographicData;
import com.cobiscorp.cobis.cstmr.model.EconomicInformation;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.cobis.cstmr.model.Person;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ExecuteCommandLoadDataCustomer extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(ExecuteCommandLoadDataCustomer.class);
	private static final String RENAPO_STATE_VALIDATE = "S";

	public ExecuteCommandLoadDataCustomer(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {

		LOGGER.logDebug("****Inicia executeCommand de ExecuteCommandLoadDataCustomer*****");

		DataEntity naturalPerson = entities.getEntity(NaturalPerson.ENTITY_NAME);

		LOGGER.logInfo(">>>>>> Inicio ExecuteCommandLoadDataCustomer - idCLiente"
				+ naturalPerson.get(NaturalPerson.PERSONSECUENTIAL));

		Map<String, Object> result = new HashMap<String, Object>();

		String mesage = Parameter.EMPTY_VALUE;

		try {

			Integer personCode = naturalPerson.get(NaturalPerson.PERSONSECUENTIAL);

			// First-Part
			CustomerRequest customerRequest = new CustomerRequest();
			customerRequest.setOperation('Q');
			customerRequest.setModo(0);
			customerRequest.setFormatDate(101);
			customerRequest.setCustomerId(personCode);
			result = getCustomerInfoFirstPart(entities, customerRequest);
			// Second-Part
			customerRequest.setModo(1);
			result = getCustomerInfoSecondPart(entities, customerRequest);

		} catch (Exception e) {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("*****>>XXXXXXX", e);
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.INIT_DATA_CUSTOMER, e, args, LOGGER);
		}

	}

	private Map<String, Object> getCustomerInfoFirstPart(DynamicRequest entities, CustomerRequest customerRequest) {

		LOGGER.logDebug("****Inicia getCustomerInfoFirstPart de ExecuteCommandLoadDataCustomer*****");

		Map<String, Object> result = new HashMap<String, Object>();

		ServiceRequestTO request = new ServiceRequestTO();
		request.addValue("inCustomerRequest", customerRequest);

		ServiceResponse response = this.execute(LOGGER,
				"CustomerDataManagementService.CustomerManagement.ReadDataCustomer", request);

		if (response != null) {
			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
				CustomerResponse customerResponseFirstPart = (CustomerResponse) resultado
						.getValue("returnCustomerResponse");
				customerResponseFirstPart.setCustomerId(customerRequest.getCustomerId());
				loadCustomerInfo(entities, customerResponseFirstPart, '1');
				validateFields(entities, customerResponseFirstPart);
			} else {
				result.put(Parameter.MESSAGESERVERLIST, response.getMessages());
			}
		}
		return result;
	}

	private void validateFields(DynamicRequest entities, CustomerResponse customerResponseFirstPart) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("BANDERA REANPO: " + customerResponseFirstPart.getCheckRenapo());
		}
		DataEntity contextEntity = entities.getEntity(Context.ENTITY_NAME);
		if(contextEntity==null){
			contextEntity = new DataEntity();
		}
		if (!RENAPO_STATE_VALIDATE.equals(customerResponseFirstPart.getCheckRenapo())) {			
			contextEntity.set(Context.FLAG3, "S");			
		}else{
			contextEntity.set(Context.FLAG3, "N");
		}
		entities.setEntity(Context.ENTITY_NAME, contextEntity);
	}

	private Map<String, Object> getCustomerInfoSecondPart(DynamicRequest entities, CustomerRequest customerRequest) {

		LOGGER.logDebug("****Inicia getCustomerInfoSecondPart de ExecuteCommandLoadDataCustomer*****");

		Map<String, Object> result = new HashMap<String, Object>();
		ServiceRequestTO request = new ServiceRequestTO();

		request.addValue("inCustomerRequest", customerRequest);

		ServiceResponse response = this.execute(LOGGER,
				"CustomerDataManagementService.CustomerManagement.ReadCustomerInfo", request);

		if (response != null) {
			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response.getData();

				CustomerResponse customerResponseSecondPart = (CustomerResponse) resultado
						.getValue("returnCustomerResponse");
				loadCustomerInfo(entities, customerResponseSecondPart, '2');
			} else {
				result.put(Parameter.MESSAGESERVERLIST, response.getMessages());
			}
		}
		return result;
	}

	private void loadCustomerInfo(DynamicRequest entities, CustomerResponse customerResponse, char part) {
		LOGGER.logDebug("****Inicia loadCustomerInfo de ExecuteCommandLoadDataCustomer*****");
		DataEntity naturalPerson = entities.getEntity(NaturalPerson.ENTITY_NAME);
		setGeneralInfo(customerResponse, naturalPerson, part);

	}

	private void setGeneralInfo(CustomerResponse customerResponse, DataEntity naturalPerson, char part) {
		LOGGER.logDebug("****Inicia setGeneralInfo de ExecuteCommandLoadDataCustomer*****");
		try {
			if (part == '1') {
				SimpleDateFormat formatDate = new SimpleDateFormat("MM/dd/yyyy");
				Date birthDate = null;
				Date expirationDate = null;

				if (customerResponse.getCustomerBirthdate() != null) {
					birthDate = formatDate.parse(customerResponse.getCustomerBirthdate());
				}
				if (customerResponse.getExpirationDate() != null) {
					naturalPerson.set(NaturalPerson.INDEFINITE, false);
					expirationDate = formatDate.parse(customerResponse.getExpirationDate());
				} else {
					naturalPerson.set(NaturalPerson.INDEFINITE, true);
				}

				// person.set(Person.TYPEPERSON, 'P');
				naturalPerson.set(NaturalPerson.PERSONSECUENTIAL, customerResponse.getCustomerId());
				naturalPerson.set(NaturalPerson.BIRTHDATE, birthDate);
				naturalPerson.set(NaturalPerson.DOCUMENTTYPE, customerResponse.getIdentificationtype());
				naturalPerson.set(NaturalPerson.SPOUSE, customerResponse.getCustomerFullName());

				naturalPerson.set(NaturalPerson.DOCUMENTNUMBER, customerResponse.getCustomerIdentificaction());
				naturalPerson.set(NaturalPerson.EXPIRATIONDATE, expirationDate);

				naturalPerson.set(NaturalPerson.FIRSTNAME, customerResponse.getCustomerName());
				naturalPerson.set(NaturalPerson.SECONDSURNAME, customerResponse.getCustomerSecondLastName());
				naturalPerson.set(NaturalPerson.SURNAME, customerResponse.getCustomerLastName());
				if (customerResponse.getGender() != null) {
					naturalPerson.set(NaturalPerson.GENDERCODE, customerResponse.getGender().charAt(0));
				}
				if (customerResponse.getCustomerMaritalStatus() != null) {
					naturalPerson.set(NaturalPerson.MARITALSTATUSCODE,
							customerResponse.getCustomerMaritalStatus().trim());
				}

				naturalPerson.set(NaturalPerson.OFFICERCODE, customerResponse.getOfficial());
				naturalPerson.set(NaturalPerson.BRANCHCODE, customerResponse.getOfficeOrigin());
				naturalPerson.set(NaturalPerson.SECONDNAME, customerResponse.getCustomerSecondName());
				naturalPerson.set(NaturalPerson.MARRIEDSURNAME, customerResponse.getMarriedLastName());
				naturalPerson.set(NaturalPerson.NATIONALITYCODE, customerResponse.getNationalityCountry());

				/* Mostrando nuevos valores */
				naturalPerson.set(NaturalPerson.IDENTIFICATIONRFC, customerResponse.getCustomerRFC());

				LOGGER.logDebug("Valor de getCustomerRFC: " + customerResponse.getCustomerRFC());
				LOGGER.logDebug("Numero de ciclos: " + customerResponse.getNumCycles());
				naturalPerson.set(NaturalPerson.CHARGEPUB, customerResponse.getChargePub());
				naturalPerson.set(NaturalPerson.RELCHARGEPUB, customerResponse.getRelChargePub());
				naturalPerson.set(NaturalPerson.COUNTYOFBIRTH, customerResponse.getCountyOfBirth());
				naturalPerson.set(NaturalPerson.NATIONALITYCODE, customerResponse.getCountryCode());
				naturalPerson.set(NaturalPerson.NATIONALITYCODEAUX, customerResponse.getNationalityCodeAux());
				naturalPerson.set(NaturalPerson.NUMCYCLES, customerResponse.getNumCycles());
				naturalPerson.set(NaturalPerson.MONTHSINFORCE, customerResponse.getMonthsInForce());
				LOGGER.logDebug("MONTHSINFORCE: " + customerResponse.getMonthsInForce());
				if (customerResponse.getMonthsInForce() == 1) {
					LOGGER.logDebug("Información No Vigente, por favor actualizar datos del cliente");
				}
				boolean publicPerson = "S".equals(customerResponse.getPublicPerson()) ? true : false;
				naturalPerson.set(NaturalPerson.PUBLICPERSON, publicPerson);

				LOGGER.logDebug("{88} >>" + customerResponse.getHasProblems());
				LOGGER.logDebug("{89} >>" + customerResponse.getMonthlyTrxAmount());
				LOGGER.logDebug("{90} >>" + customerResponse.getPepPerson());

				boolean hasProblems = "S".equals(customerResponse.getHasProblems()) ? true : false;
				naturalPerson.set(NaturalPerson.HASPROBLEMS, hasProblems);

				boolean pepPerson = "S".equals(customerResponse.getPepPerson()) ? true : false;
				naturalPerson.set(NaturalPerson.PERSONPEP, pepPerson);

				LOGGER.logDebug(" se obtiene cuenta individual >>" + customerResponse.getAccountIndividual());

				naturalPerson.set(NaturalPerson.ACCOUNTINDIVIDUAL, customerResponse.getAccountIndividual());

				LOGGER.logDebug(" se obtiene el codigo santander >>" + customerResponse.getAccountIndividual());

				naturalPerson.set(NaturalPerson.SANTANDERCODE, customerResponse.getSantanderCode());
				// Para cambio de anadir el nombre e id del grupo
				naturalPerson.set(NaturalPerson.IDGROUP, customerResponse.getIdGroup());
				naturalPerson.set(NaturalPerson.NAMEGROUP, customerResponse.getNameGroup());
				LOGGER.logDebug(" Se obtiene customerResponse.getIdGroup()>>***" + customerResponse.getIdGroup());

				LOGGER.logDebug(" Se obtiene TecnologicalDegree >>" + customerResponse.getTechnologicalDegree());
				naturalPerson.set(NaturalPerson.TECHNOLOGICALDEGREE, customerResponse.getTechnologicalDegree());
				boolean hasPartner = "S".equals(customerResponse.getPartner());
				naturalPerson.set(NaturalPerson.HASPARTNER, Boolean.valueOf(hasPartner));
				boolean hasListBlack = "S".equals(customerResponse.getListBlack());
				naturalPerson.set(NaturalPerson.HASLISTBLACK, Boolean.valueOf(hasListBlack));
				naturalPerson.set(NaturalPerson.BIORENAPORESULT, customerResponse.getCheckRenapo());

			} else if (part == '2') {

				naturalPerson.set(NaturalPerson.STATUSCODE, customerResponse.getStatus());
				/*
				 * if (customerResponse.getStatus() != null) { person.set(Person.STATUSCODE,
				 * customerResponse.getStatus().charAt(0)); }
				 */
				naturalPerson.set(NaturalPerson.KNOWNAS, customerResponse.getKnownAs());

				LOGGER.logDebug("RISKLEVEL: " + customerResponse.getRiskLevel());
				LOGGER.logDebug("CREDITBUREAU: " + customerResponse.getCreditBureau());
				naturalPerson.set(NaturalPerson.RISKLEVEL, customerResponse.getRiskLevel());
				naturalPerson.set(NaturalPerson.CREDITBUREAU, customerResponse.getCreditBureau());

				LOGGER.logDebug("part2 {88} >>" + customerResponse.getHasProblems());
				LOGGER.logDebug("part2 {89} >>" + customerResponse.getMonthlyTrxAmount());
				LOGGER.logDebug("part2 {90} >>" + customerResponse.getPepPerson());

				boolean hasProblems = "S".equals(customerResponse.getHasProblems()) ? true : false;
				naturalPerson.set(NaturalPerson.HASPROBLEMS, hasProblems);

				boolean pepPerson = "S".equals(customerResponse.getPepPerson()) ? true : false;
				naturalPerson.set(NaturalPerson.PERSONPEP, pepPerson);

			}

		} catch (ParseException e) {
			LOGGER.logDebug("Error en setGeneralInfo" + e);
		}
	}

}
