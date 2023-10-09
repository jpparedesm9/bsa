package com.cobiscorp.cobis.cstmr.customevents.utils;

import java.util.Calendar;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
import com.cobiscorp.cobis.cstmr.model.LegalPerson;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.cobis.cstmr.model.SpousePerson;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CharactersUtil;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.Constants;

import cobiscorp.ecobis.customerdatamanagement.dto.AddressRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.LegalProspectRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.NaturalProspectRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.SpouseProspectRequest;

public class MapEntities {
	private static final ILogger LOGGER = LogFactory.getLogger(MapEntities.class);

	public static NaturalProspectRequest mapNaturalProspect(DataEntity naturalPerson, String personType, String maritalStatus) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start mapNaturalProspect in MapEntities");
		}
		CharactersUtil util = new CharactersUtil();
		NaturalProspectRequest naturalProspectRequest = new NaturalProspectRequest();

		try {
			naturalProspectRequest.setProspectId(naturalPerson.get(NaturalPerson.PERSONSECUENTIAL) == null || naturalPerson.get(NaturalPerson.PERSONSECUENTIAL) == 0 ? null
					: naturalPerson.get(NaturalPerson.PERSONSECUENTIAL));

			//
			String FIRSTNAME = naturalPerson.get(NaturalPerson.FIRSTNAME);
			String SECONDNAME = naturalPerson.get(NaturalPerson.SECONDNAME);
			String SURNAME = naturalPerson.get(NaturalPerson.SURNAME);
			String SECONDSURNAME = naturalPerson.get(NaturalPerson.SECONDSURNAME);
			LOGGER.logDebug("mapNaturalProspect - FIRSTNAME antes:" + FIRSTNAME);
			LOGGER.logDebug("mapNaturalProspect - SECONDNAME antes:" + SECONDNAME);
			LOGGER.logDebug("mapNaturalProspect - SURNAME antes:" + SURNAME);
			LOGGER.logDebug("mapNaturalProspect - SECONDSURNAME antes:" + SECONDSURNAME);

			if (FIRSTNAME != null) {
				String FIRSTNAME2 = util.replaceSpecialCharacters(FIRSTNAME);
				String FIRSTNAME3 = util.removeDiacritics(FIRSTNAME2);
				FIRSTNAME = FIRSTNAME3;
				LOGGER.logDebug("mapNaturalProspect - FIRSTNAME despues:" + FIRSTNAME);
			}
			if (SECONDNAME != null) {
				String SECONDNAME2 = util.replaceSpecialCharacters(SECONDNAME);
				String SECONDNAME3 = util.removeDiacritics(SECONDNAME2);
				SECONDNAME = SECONDNAME3;
				LOGGER.logDebug("mapNaturalProspect - SECONDNAME despues:" + SECONDNAME);
			}
			if (SURNAME != null) {
				String SURNAME2 = util.replaceSpecialCharacters(SURNAME);
				String SURNAME3 = util.removeDiacritics(SURNAME2);
				SURNAME = SURNAME3;
				LOGGER.logDebug("mapNaturalProspect - SURNAME despues:" + SURNAME);
			}
			if (SECONDSURNAME != null) {
				String SECONDSURNAME2 = util.replaceSpecialCharacters(SECONDSURNAME);
				String SECONDSURNAME3 = util.removeDiacritics(SECONDSURNAME2);
				SECONDSURNAME = SECONDSURNAME3;
				LOGGER.logDebug("mapNaturalProspect - SECONDSURNAME despues:" + SECONDSURNAME);
			}

			naturalProspectRequest.setFirstName(FIRSTNAME);
			naturalProspectRequest.setSecondName(SECONDNAME);
			naturalProspectRequest.setSurname(SURNAME);
			naturalProspectRequest.setSecondSurname(SECONDSURNAME);

			// naturalProspectRequest.setFirstName(naturalPerson.get(NaturalPerson.FIRSTNAME));
			// naturalProspectRequest.setSecondName(naturalPerson.get(NaturalPerson.SECONDNAME));
			// naturalProspectRequest.setSurname(naturalPerson.get(NaturalPerson.SURNAME));
			// naturalProspectRequest.setSecondSurname(naturalPerson.get(NaturalPerson.SECONDSURNAME));

			naturalProspectRequest.setDocumentNumber(naturalPerson.get(NaturalPerson.DOCUMENTNUMBER));
			naturalProspectRequest.setDocumentType(naturalPerson.get(NaturalPerson.DOCUMENTTYPE));
			naturalProspectRequest.setGender(naturalPerson.get(NaturalPerson.GENDERCODE));
			naturalProspectRequest.setMaritalStatus(naturalPerson.get(NaturalPerson.MARITALSTATUSCODE));

			if (naturalPerson.get(NaturalPerson.GENDERCODE) != null && 'F' == naturalPerson.get(NaturalPerson.GENDERCODE)
					&& naturalPerson.get(NaturalPerson.MARITALSTATUSCODE) != null && "CA".equals(naturalPerson.get(NaturalPerson.MARITALSTATUSCODE))) {
				naturalProspectRequest.setMarriedSurname(naturalPerson.get(NaturalPerson.MARRIEDSURNAME));
			}
			if (naturalPerson.get(NaturalPerson.BIRTHDATE) == null) {
				naturalProspectRequest.setBirthDate(null);
			} else {
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(naturalPerson.get(NaturalPerson.BIRTHDATE));
				naturalProspectRequest.setBirthDate(calendar);
			}
			if (naturalPerson.get(NaturalPerson.EXPIRATIONDATE) == null) {
				naturalProspectRequest.setExpirationDate(null);
			} else {
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(naturalPerson.get(NaturalPerson.EXPIRATIONDATE));
				naturalProspectRequest.setExpirationDate(calendar);
			}
			naturalProspectRequest.setEmailAddress(naturalPerson.get(NaturalPerson.EMAIL));
			naturalProspectRequest.setPersonType(personType);
			// Biometrico
			naturalProspectRequest.setBioIdentificationType(naturalPerson.get(NaturalPerson.BIOIDENTIFICATIONTYPE));
			naturalProspectRequest.setBioCIC(naturalPerson.get(NaturalPerson.BIOCIC));
			naturalProspectRequest.setBioOCR(naturalPerson.get(NaturalPerson.BIOOCR));
			naturalProspectRequest.setBioEmissionNumber(naturalPerson.get(NaturalPerson.BIOEMISSIONNUMBER));
			naturalProspectRequest.setBioReaderKey(naturalPerson.get(NaturalPerson.BIOREADERKEY));
			naturalProspectRequest.setBioHasFingerprinter(naturalPerson.get(NaturalPerson.BIOHASFINGERPRINT));
			naturalProspectRequest.setBioRenapoResponse(Parameter.RENAPO_PENDING.charAt(0));
			// filial quemado temporalmente
			naturalProspectRequest.setFilial(1);

		} catch (Exception ex) {
			LOGGER.logError("Exception Map Entities: " + ex);

		} finally {

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finish mapNaturalProspect in MapEntities");
			}
		}
		return naturalProspectRequest;

	}

	public static SpouseProspectRequest mapSpouseProspect(DataEntity spousePerson, String personType, String maritalStatus) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start mapSpouseProspect in MapEntities");
		}
		SpouseProspectRequest spouseProspectRequest = new SpouseProspectRequest();
		try {
			LOGGER.logDebug("!isMainProspect");
			spouseProspectRequest.setDocumentType(spousePerson.get(SpousePerson.DOCUMENTTYPE));
			spouseProspectRequest.setDocumentNumber(spousePerson.get(SpousePerson.DOCUMENTNUMBER));
			spouseProspectRequest.setFirstName(spousePerson.get(SpousePerson.FIRSTNAME));
			spouseProspectRequest.setSecondName(spousePerson.get(SpousePerson.SECONDNAME));
			spouseProspectRequest.setSurname(spousePerson.get(SpousePerson.SURNAME));
			spouseProspectRequest.setSecondSurname(spousePerson.get(SpousePerson.SECONDSURNAME));
			spouseProspectRequest.setGender(spousePerson.get(SpousePerson.GENDERCODE));
			spouseProspectRequest.setCityBirth(spousePerson.get(SpousePerson.COUNTRYOFBIRTH));
			if (spousePerson.get(SpousePerson.BIRTHDATE) == null) {
				spouseProspectRequest.setBirthDate(null);
			} else {
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(spousePerson.get(SpousePerson.BIRTHDATE));
				spouseProspectRequest.setBirthDate(calendar);
			}

			if (spousePerson.get(SpousePerson.EXPIRATIONDATE) == null) {
				spouseProspectRequest.setExpirationDate(null);
			} else {
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(spousePerson.get(SpousePerson.EXPIRATIONDATE));
				spouseProspectRequest.setExpirationDate(calendar);
			}
			spouseProspectRequest.setPersonType(personType);
			spouseProspectRequest.setMaritalStatus(maritalStatus);
			// filial quemado temporalmente
			spouseProspectRequest.setFilial(1);
		} catch (Exception ex) {
			LOGGER.logError("Exception mapSpouseProspect in MapEntities: " + ex);
		} finally {

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finish mapSpouseProspect in MapEntities");
			}
		}
		return spouseProspectRequest;

	}

	public static LegalProspectRequest mapLegalProspect(DataEntity legalPerson) {
		LegalProspectRequest legalProspectRequest = new LegalProspectRequest();
		LOGGER.logDebug("Start mapLegalProspect in MapEntities");
		try {
			LOGGER.logDebug("legalPerson--->" + legalPerson);
			legalProspectRequest.setName(legalPerson.get(LegalPerson.BUSINESSNAME));
			legalProspectRequest.setBusinessName(legalPerson.get(LegalPerson.TRADENAME));
			legalProspectRequest.setDocumentNumber(legalPerson.get(LegalPerson.DOCUMENTNUMBER));
			// filial quemado temporalmente
			legalProspectRequest.setFilial(1);
			legalProspectRequest.setDocumentType(legalPerson.get(LegalPerson.DOCUMENTTYPE));
			if (legalPerson.get(LegalPerson.CONSTITUTIONDATE) == null) {
				legalProspectRequest.setConstitutionDate(null);
			} else {
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(legalPerson.get(LegalPerson.CONSTITUTIONDATE));
				legalProspectRequest.setConstitutionDate(calendar);
			}

			legalProspectRequest.setExpirationDate(null);

		} catch (Exception ex) {
			LOGGER.logError("Exception mapLegalProspect in MapEntities: " + ex);
		} finally {

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finish mapLegalProspect in MapEntities");
			}
		}
		return legalProspectRequest;
	}

	public static AddressRequest mapVirtualAddress(Integer secuential, String emailAddress) {

		AddressRequest addressRequest = new AddressRequest();
		try {
			addressRequest.setCustomerId(secuential);
			addressRequest.setAddressType(Constants.VIRTUALADRESSTYPE);
			addressRequest.setAddressDesc(emailAddress);
		} catch (Exception ex) {
			LOGGER.logError("Exception mapVirtualAddress in MapEntities: " + ex);
		} finally {

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finish mapVirtualAddress in MapEntities");
			}
		}
		return addressRequest;
	}

}
