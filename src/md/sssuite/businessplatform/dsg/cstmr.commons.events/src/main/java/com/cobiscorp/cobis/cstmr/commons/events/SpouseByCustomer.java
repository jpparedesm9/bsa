package com.cobiscorp.cobis.cstmr.commons.events;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.SpouseProspectRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.SpouseProspectResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.cobis.cstmr.model.SpousePerson;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.prospect.services.NaturalSpouseManager;

public class SpouseByCustomer extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(SpouseByCustomer.class);

	public SpouseByCustomer(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	public void searchSpouseByCustomer(DynamicRequest entities, ICommonEventArgs args) throws ParseException {
		
		LOGGER.logDebug("Start searchSpouseByCustomer in SpouseByCustomer");
		
		DataEntity customerTmp = entities.getEntity(NaturalPerson.ENTITY_NAME);
		int customerCode = customerTmp.get(NaturalPerson.PERSONSECUENTIAL);
		DataEntity spouseEntity = entities.getEntity(SpousePerson.ENTITY_NAME);
		
		SpouseProspectRequest request = new SpouseProspectRequest();
		request.setPersonSecuencial(customerCode);
		NaturalSpouseManager businessManager = new NaturalSpouseManager(getServiceIntegration());
		SpouseProspectResponse resp = businessManager.searchSpouse(request, args);
		
		
		spouseEntity.set(SpousePerson.PERSONSECUENTIAL, resp.getProspectId());
		LOGGER.logDebug("SpousePersonList PoupForm Code>>" + resp.getProspectId());
		Date dateTmp = null;
		Date birthDateTmp = null;
		SimpleDateFormat formatDate = new SimpleDateFormat("dd/MM/yyyy");
		
		spouseEntity.set(SpousePerson.FIRSTNAME, resp.getFirstName());
		spouseEntity.set(SpousePerson.SECONDNAME, resp.getSecondName());
		
		
		
		spouseEntity.set(SpousePerson.SURNAME, resp.getSurname());
		spouseEntity.set(SpousePerson.SECONDSURNAME, resp.getSecondSurname());
		spouseEntity.set(SpousePerson.DOCUMENTTYPE, resp.getDocumentType());
		spouseEntity.set(SpousePerson.DOCUMENTNUMBER, resp.getDocumentNumber());
		
		spouseEntity.set(SpousePerson.GENDERCODE, resp.getGender());
		spouseEntity.set(SpousePerson.COUNTRYOFBIRTH, resp.getCityBirth());
		spouseEntity.set(SpousePerson.IDENTIFICATIONRFC, resp.getPassportNumber()); //RFC
		spouseEntity.set(SpousePerson.PHONE, resp.getPhone());
		
		if (resp.getExpirationDate() != null) {
			dateTmp = formatDate.parse(resp.getExpirationDate());
		}
		
		spouseEntity.set(SpousePerson.EXPIRATIONDATE, dateTmp);
		
		if (resp.getBirthDate() != null) {
			birthDateTmp = formatDate.parse(resp.getBirthDate());
		}
		
		spouseEntity.set(SpousePerson.BIRTHDATE, birthDateTmp);

		entities.setEntity(SpousePerson.ENTITY_NAME, spouseEntity);
	}

}
