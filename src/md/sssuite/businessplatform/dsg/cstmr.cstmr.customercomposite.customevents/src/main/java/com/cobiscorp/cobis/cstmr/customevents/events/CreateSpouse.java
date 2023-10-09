package com.cobiscorp.cobis.cstmr.customevents.events;

import java.text.MessageFormat;
import java.util.HashMap;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.SpouseProspectRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.GeneralFunction;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.cobis.cstmr.model.SpousePerson;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.NaturalSpouseManager;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.Outputs;

public class CreateSpouse extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(CreateSpouse.class);

	public CreateSpouse(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		try {

			LOGGER.logDebug("Inicio de CreateSpouse executeCommand ");

			Integer secuentialSpouse = 0, official = 100;
			String curp = "", curpC = "", rfc = "", rfcC = "";

			DataEntity naturalPersonEntity = entities.getEntity(NaturalPerson.ENTITY_NAME);
			DataEntity spousePersonEntity = entities.getEntity(SpousePerson.ENTITY_NAME);
			int customerCode = naturalPersonEntity.get(NaturalPerson.PERSONSECUENTIAL);
			int spouseSecuencial = spousePersonEntity.get(SpousePerson.PERSONSECUENTIAL);

			SpouseProspectRequest spouseRequest = new SpouseProspectRequest();

			
			spouseRequest.setPersonSecuencial(customerCode);
			spouseRequest.setProspectId(spouseSecuencial);
			spouseRequest.setFirstName(spousePersonEntity.get(SpousePerson.FIRSTNAME));
			spouseRequest.setSecondName(spousePersonEntity.get(SpousePerson.SECONDNAME));
			spouseRequest.setSurname(spousePersonEntity.get(SpousePerson.SURNAME));
			spouseRequest.setSecondSurname(spousePersonEntity.get(SpousePerson.SECONDSURNAME));
			spouseRequest.setPhone(spousePersonEntity.get(SpousePerson.PHONE));
			
			if (spousePersonEntity.get(SpousePerson.BIRTHDATE) != null) {
				spouseRequest.setBirthDate(GeneralFunction.convertDateToCalendar(spousePersonEntity.get(SpousePerson.BIRTHDATE)));
			}
			NaturalSpouseManager spouseManager = new NaturalSpouseManager(getServiceIntegration());
			
			Integer actualSpouseCode = spousePersonEntity.get(SpousePerson.PERSONSECUENTIAL);
			
			HashMap<String, String> outputs = spouseManager.createNaturalSpouse(spouseRequest, args);
			spouseRequest.setProspectId(actualSpouseCode);
			String spouseName = MessageFormat.format("{0} {1} {2} {3}", 
					spouseRequest.getFirstName(), 
					(spouseRequest.getSecondName()!=null ? spouseRequest.getSecondName() : ""), 
					spouseRequest.getSurname(), 
					(spouseRequest.getSecondSurname()!=null ?spouseRequest.getSecondSurname() : "")) ;
			naturalPersonEntity.set(NaturalPerson.SPOUSE, spouseName);
			if (args.isSuccess()) {
				args.getMessageManager().showSuccessMsg("Cónyuge actualizado");
			}
			
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.CREATE_SPOUSE, e, args, LOGGER);
		}

	}

}
