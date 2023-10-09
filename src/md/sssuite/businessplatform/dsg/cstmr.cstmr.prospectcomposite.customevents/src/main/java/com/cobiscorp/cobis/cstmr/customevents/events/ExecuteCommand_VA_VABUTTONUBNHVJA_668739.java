package com.cobiscorp.cobis.cstmr.customevents.events;

import java.util.HashMap;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.CustomerManager;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
import com.cobiscorp.cobis.cstmr.customevents.utils.MapEntities;
import com.cobiscorp.cobis.cstmr.model.Context;
import com.cobiscorp.cobis.cstmr.model.LegalPerson;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.cobis.cstmr.model.Person;
import com.cobiscorp.cobis.cstmr.model.SpousePerson;
import com.cobiscorp.cobis.cstmr.model.VirtualAddress;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.LegalProspectManager;
import com.cobiscorp.ecobis.customer.commons.prospect.services.NaturalProspectManager;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.Constants;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.Outputs;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.LegalProspectRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.NaturalProspectRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.SpouseProspectRequest;

public class ExecuteCommand_VA_VABUTTONUBNHVJA_668739 extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(ExecuteCommand_VA_VABUTTONUBNHVJA_668739.class);

	public ExecuteCommand_VA_VABUTTONUBNHVJA_668739(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs arg1) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start executeCommand in ExecuteCommand_VA_VABUTTONUBNHVJA_668739");
		}
		try {
			DataEntity person = entities.getEntity(Person.ENTITY_NAME);
			DataEntity context = entities.getEntity(Context.ENTITY_NAME);
			DataEntity naturalPerson = entities.getEntity(NaturalPerson.ENTITY_NAME);

			Integer secuentialMainProspect = 0, secuentialSpouse = 0, official = 100;
			String curp = "", curpC = "", rfc = "", rfcC = "", registroRenapo = "N", listaNegra = "N";
			NaturalProspectManager naturalProspectManager = new NaturalProspectManager(getServiceIntegration());
			
			if (naturalPerson.get(NaturalPerson.PERSONSECUENTIAL) == null || naturalPerson.get(NaturalPerson.PERSONSECUENTIAL) == 0) {
				
				if (person.get(Person.TYPEPERSON) != null && 'P' == person.get(Person.TYPEPERSON).charValue()) {

					NaturalProspectRequest naturalProspectRequest = MapEntities.mapNaturalProspect(naturalPerson, String.valueOf(person.get(Person.TYPEPERSON)),
							naturalPerson.get(NaturalPerson.MARITALSTATUSCODE));

					if (naturalPerson.get(NaturalPerson.FIRSTNAME) != null) {
						naturalPerson.set(NaturalPerson.FIRSTNAME, naturalProspectRequest.getFirstName());
					}
					if (naturalPerson.get(NaturalPerson.SECONDNAME) != null) {
						naturalPerson.set(NaturalPerson.SECONDNAME, naturalProspectRequest.getSecondName());
					}
					if (naturalPerson.get(NaturalPerson.SURNAME) != null) {
						naturalPerson.set(NaturalPerson.SURNAME, naturalProspectRequest.getSurname());
					}
					if (naturalPerson.get(NaturalPerson.SECONDSURNAME) != null) {
						naturalPerson.set(NaturalPerson.SECONDSURNAME, naturalProspectRequest.getSecondSurname());
					}

					naturalProspectRequest.setOfficial(person.get(Person.OFFICIAL));
					naturalProspectRequest.setOffice(person.get(Person.OFFICE) == null ? 0 : Integer.valueOf(person.get(Person.OFFICE)));
					naturalProspectRequest.setEmailAddress(naturalPerson.get(NaturalPerson.EMAIL));
					naturalProspectRequest.setCityBirth(naturalPerson.get(NaturalPerson.COUNTYOFBIRTH));
					LOGGER.logDebug("EmailPersonaNatural--" + naturalPerson.get(NaturalPerson.EMAIL));
					LOGGER.logDebug("numcyclesPersonaNatural--" + naturalPerson.get(NaturalPerson.NUMCYCLES));
					LOGGER.logDebug("entidad de nac >>>>" + naturalPerson.get(NaturalPerson.COUNTYOFBIRTH));

					// naturalProspectRequest.setSantanderCode(naturalPerson.get(NaturalPerson.SANTANDERCODE));
					// LOGGER.logDebug("crea codigo santander
					// >>>>"+naturalPerson.get(NaturalPerson.SANTANDERCODE));

					naturalProspectRequest.setCollective(naturalPerson.get(NaturalPerson.COLECTIVO));
					naturalProspectRequest.setCollectiveLevel(naturalPerson.get(NaturalPerson.NIVELCOLECTIVO));
					LOGGER.logDebug("Tipo de Mercado >>>>" + naturalPerson.get(NaturalPerson.COLECTIVO));
					LOGGER.logDebug("Nivel de Cliente >>>>" + naturalPerson.get(NaturalPerson.NIVELCOLECTIVO));
					LOGGER.logDebug("Consulta RENAPO por CURP >>>>" + context.get(Context.RENAPOBYCURP));
					LOGGER.logDebug("Valor Renapo >>>>" + context.get(Context.RENAPO));
					
					if (naturalPerson.get(NaturalPerson.NUMCYCLES) != null) {
						naturalProspectRequest.setNumCycles(naturalPerson.get(NaturalPerson.NUMCYCLES));
					}
					if (person.get(Person.OPERATION) != null && "I".equals(person.get(Person.OPERATION))) {
						SpouseProspectRequest spouseProspectRequest = new SpouseProspectRequest();
						DataEntity spousePerson = entities.getEntity(SpousePerson.ENTITY_NAME);
						if ("CA".equals(naturalPerson.get(NaturalPerson.MARITALSTATUSCODE))) {
							spouseProspectRequest = MapEntities.mapSpouseProspect(spousePerson, String.valueOf(person.get(Person.TYPEPERSON)),
									naturalPerson.get(NaturalPerson.MARITALSTATUSCODE));
						}

						naturalProspectRequest.setCheckRenapo(naturalPerson.get(NaturalPerson.BIORENAPORESULT));
						
						HashMap<String, String> outputs = naturalProspectManager.createNaturalProspectAndSpouse(naturalProspectRequest, spouseProspectRequest, arg1);

						if (outputs != null) {
							secuentialMainProspect = Integer.valueOf(outputs.get(Outputs.PROSPECTID));
							curp = outputs.get(Outputs.CURP);
							rfc = outputs.get(Outputs.RFC);
							curpC = outputs.get(Outputs.CURPC);
							rfcC = outputs.get(Outputs.RFCC);
							listaNegra = outputs.get(Outputs.LISTA_NEGRA);

							naturalPerson.set(NaturalPerson.PERSONSECUENTIAL, secuentialMainProspect);
							naturalPerson.set(NaturalPerson.DOCUMENTNUMBER, curp);
							LOGGER.logDebug("curp >>>>" + naturalPerson.get(NaturalPerson.DOCUMENTNUMBER));
							naturalPerson.set(NaturalPerson.IDENTIFICATIONRFC, rfc);

							if (Parameter.INACTIVE.equals(context.get(Context.RENAPOBYCURP))) {
								naturalPerson.set(NaturalPerson.BIORENAPORESULT, Parameter.RENAPO_PENDING);
							}

							naturalPerson.set(NaturalPerson.HASLISTBLACK, listaNegra == null ? false : (listaNegra.charAt(0) == 'N' ? false : true));
							LOGGER.logDebug("LISTAS NEGRAS >>" + naturalPerson.get(NaturalPerson.HASLISTBLACK));
							DataEntity virtualAddress = new DataEntity();
							virtualAddress.set(VirtualAddress.ADDRESSID, Integer.valueOf(outputs.get(Outputs.ADDRESSID)));
							virtualAddress.set(VirtualAddress.ADDRESSDESCRIPTION, naturalPerson.get(NaturalPerson.EMAIL));
							virtualAddress.set(VirtualAddress.PERSONSECUENTIAL, secuentialMainProspect);
							virtualAddress.set(VirtualAddress.ADDRESSTYPE, Constants.VIRTUALADRESSTYPE);

							DataEntityList virtualAddresses = new DataEntityList();
							virtualAddresses.add(virtualAddress);
							entities.setEntityList(VirtualAddress.ENTITY_NAME, virtualAddresses);

							if (!"000".equals(outputs.get(Outputs.SPOUSEID))) {
								spousePerson.set(SpousePerson.PERSONSECUENTIAL, Integer.valueOf(outputs.get(Outputs.SPOUSEID)));
								spousePerson.set(SpousePerson.DOCUMENTNUMBER, curpC);
								spousePerson.set(SpousePerson.IDENTIFICATIONRFC, rfcC);

							}

						}

					} else if (person.get(Person.OPERATION) != null && "U".equals(person.get(Person.OPERATION))) {
						secuentialMainProspect = naturalProspectManager.updateNaturalProspect(naturalProspectRequest, arg1);
						if (secuentialMainProspect == null) {
							arg1.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_SEPRODUAO_46136");
						} else {
							naturalPerson.set(NaturalPerson.PERSONSECUENTIAL, secuentialMainProspect);
						}

					}

				} else if (person.get(Person.TYPEPERSON) != null && 'C' == person.get(Person.TYPEPERSON).charValue()) {
					DataEntity legalPerson = entities.getEntity(LegalPerson.ENTITY_NAME);
					LegalProspectRequest legalProspectRequest = MapEntities.mapLegalProspect(legalPerson);
					LegalProspectManager legalProspectManager = new LegalProspectManager(getServiceIntegration());

					legalProspectRequest.setOfficial(person.get(Person.OFFICIAL));
					legalProspectRequest.setOffice(person.get(Person.OFFICE) == null ? 0 : Integer.valueOf(person.get(Person.OFFICE)));

					if (person.get(Person.OPERATION) != null && "I".equals(person.get(Person.OPERATION))) {
						HashMap<String, String> outputs = legalProspectManager.createLegalProspect(legalProspectRequest, arg1);
						if (outputs != null) {

							secuentialMainProspect = Integer.valueOf(outputs.get(Outputs.PROSPECTID));
							legalPerson.set(LegalPerson.PERSONSECUENTIAL, secuentialMainProspect);

							DataEntity virtualAddress = new DataEntity();
							virtualAddress.set(VirtualAddress.ADDRESSID, Integer.valueOf(outputs.get(Outputs.ADDRESSID)));
							virtualAddress.set(VirtualAddress.ADDRESSDESCRIPTION, legalPerson.get(LegalPerson.EMAILADDRESS));
							virtualAddress.set(VirtualAddress.PERSONSECUENTIAL, secuentialMainProspect);
							virtualAddress.set(VirtualAddress.ADDRESSTYPE, Constants.VIRTUALADRESSTYPE);

							DataEntityList virtualAddresses = new DataEntityList();
							virtualAddresses.add(virtualAddress);
							entities.setEntityList(VirtualAddress.ENTITY_NAME, virtualAddresses);
						}
					} else if (person.get(Person.OPERATION) != null && "U".equals(person.get(Person.OPERATION))) {
						legalPerson.set(NaturalPerson.PERSONSECUENTIAL, legalProspectManager.updateLegalProspectManager(legalProspectRequest, arg1));
					}

				}
			} else {

				CustomerManager customerManager = new CustomerManager(getServiceIntegration());
				CustomerTotalRequest customerTotalRequest = com.cobiscorp.ecobis.customer.prospect.commons.utils.MapEntities.mapNaturalPersonForRenapo(naturalPerson,
						context.get(Context.RENAPO), 0);
				HashMap<String, String> outputs = customerManager.updateCustomerRENAPO(customerTotalRequest, arg1);

				if (outputs != null) {

					curp = outputs.get(Outputs.CURP);
					rfc = outputs.get(Outputs.RFC);
					listaNegra = outputs.get(Outputs.LISTA_NEGRA);
					naturalPerson.set(NaturalPerson.DOCUMENTNUMBER, "000000".equals(curp) ? naturalPerson.get(NaturalPerson.DOCUMENTNUMBER) : curp);
					LOGGER.logDebug("curp >>>>" + naturalPerson.get(NaturalPerson.DOCUMENTNUMBER));
					naturalPerson.set(NaturalPerson.IDENTIFICATIONRFC, "000000".equals(rfc) ? naturalPerson.get(NaturalPerson.DOCUMENTNUMBER) : rfc);
					naturalPerson.set(NaturalPerson.HASLISTBLACK, listaNegra == null ? false : (listaNegra.charAt(0) == 'N' ? false : true));
					LOGGER.logDebug("LISTAS NEGRAS >>" + naturalPerson.get(NaturalPerson.HASLISTBLACK));

				}

			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.SAVE_CUSTOMER, e, arg1, LOGGER);
		}

	}
}
