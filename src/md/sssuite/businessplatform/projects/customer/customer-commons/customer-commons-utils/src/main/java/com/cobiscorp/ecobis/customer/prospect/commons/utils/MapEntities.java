package com.cobiscorp.ecobis.customer.prospect.commons.utils;

import java.util.Calendar;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.designer.api.DataEntity;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;

public class MapEntities {
	private static final ILogger LOGGER = LogFactory.getLogger(MapEntities.class);

	public static CustomerTotalRequest mapNaturalPersonForRenapo(DataEntity naturalPerson, String renapo, Integer mode) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start mapNaturalProspect in MapEntities");
		}
		CustomerTotalRequest customerTotalRequest = new CustomerTotalRequest();
		try {
			customerTotalRequest.setCodePerson(naturalPerson.get(NaturalPerson.PERSONSECUENTIAL));
			customerTotalRequest.setName(naturalPerson.get(NaturalPerson.FIRSTNAME));
			customerTotalRequest.setSecondName(naturalPerson.get(NaturalPerson.SECONDNAME));
			customerTotalRequest.setFirstSurname(naturalPerson.get(NaturalPerson.SURNAME));
			customerTotalRequest.setSecondSurname(naturalPerson.get(NaturalPerson.SECONDSURNAME));
			customerTotalRequest.setIdentification(mode == 0 ? null : naturalPerson.get(NaturalPerson.DOCUMENTNUMBER));
			customerTotalRequest.setIdentificationType(naturalPerson.get(NaturalPerson.DOCUMENTTYPE));
			customerTotalRequest.setGender(naturalPerson.get(NaturalPerson.GENDERCODE));
			customerTotalRequest.setCountyOfBirth(naturalPerson.get(NaturalPerson.COUNTYOFBIRTH));
			if (mode == 0) {
				customerTotalRequest.setBioIdentificationType(naturalPerson.get(NaturalPerson.BIOIDENTIFICATIONTYPE));
				customerTotalRequest.setBioCIC(naturalPerson.get(NaturalPerson.BIOCIC));
				customerTotalRequest.setBioEmissionNumber(naturalPerson.get(NaturalPerson.BIOEMISSIONNUMBER));
				customerTotalRequest.setBioHasFingerprinter(String.valueOf(naturalPerson.get(NaturalPerson.BIOHASFINGERPRINT)));
				customerTotalRequest.setBioOCR(naturalPerson.get(NaturalPerson.BIOOCR));
				customerTotalRequest.setBioReaderKey(naturalPerson.get(NaturalPerson.BIOREADERKEY));
			}
			customerTotalRequest.setCheckRenapo(renapo);
			customerTotalRequest.setMode(mode);
			if (naturalPerson.get(NaturalPerson.BIRTHDATE) == null) {
				customerTotalRequest.setBirthDate(null);
			} else {
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(naturalPerson.get(NaturalPerson.BIRTHDATE));
				customerTotalRequest.setBirthDate(calendar);
			}
			if (naturalPerson.get(NaturalPerson.EXPIRATIONDATE) == null) {
				customerTotalRequest.setExpirationDate(null);
			} else {
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(naturalPerson.get(NaturalPerson.EXPIRATIONDATE));
				customerTotalRequest.setExpirationDate(calendar);
			}
		} catch (Exception ex) {
			LOGGER.logError("Exception Map Entities: " + ex);

		} finally {

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finish mapNaturalProspect in MapEntities");
			}
		}
		return customerTotalRequest;

	}
}
