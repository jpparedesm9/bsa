package com.cobiscorp.cobis.cstmr.customevents.events;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.LegalPersonRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.EconomicInformationLegalPerson;
import com.cobiscorp.cobis.cstmr.model.LegalPerson;
import com.cobiscorp.cobis.cstmr.model.LegalRepresentative;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.api.util.ServerParamUtil;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.utils.Util;
import com.cobiscorp.ecobis.customer.commons.prospect.services.LegalPersonManager;

public class UpdateLegalPerson extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(UpdateLegalPerson.class);

	public UpdateLegalPerson(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		try {
			DataEntity legalPerson = entities.getEntity(LegalPerson.ENTITY_NAME);
			DataEntity economicInformation = entities.getEntity(EconomicInformationLegalPerson.ENTITY_NAME);
			DataEntity legalRepresentative = entities.getEntity(LegalRepresentative.ENTITY_NAME);

			LegalPersonRequest legalPersonRequest = new LegalPersonRequest();

			Calendar calendar = Calendar.getInstance();
			calendar.setTime(legalRepresentative.get(LegalRepresentative.EFFECTIVEDATE));
			calendar.set(Calendar.HOUR_OF_DAY, 0);
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			LOGGER.logDebug("---> calendar"+calendar);
			Calendar calendarProcessDate = Calendar.getInstance();
			calendarProcessDate.setTime(Util.getProcessDate());
			calendarProcessDate.set(Calendar.HOUR_OF_DAY, 0);
			calendarProcessDate.set(Calendar.MINUTE, 0);
			calendarProcessDate.set(Calendar.SECOND, 0);
			
			LOGGER.logDebug("---> calendarProcessDate"+calendarProcessDate);
			char undefinedDate = legalRepresentative.get(LegalRepresentative.UNDEFINEDEFFECTIVEDATE) ? 'S' : 'N';
			int substractDates = 0;
			// Validación Fecha de proceso
			if (calendar != null && undefinedDate == 'N') {
				substractDates = Util.substractsDates(calendarProcessDate.getTime(), calendar.getTime(), args);
			}
			if (substractDates >= 0) {
				legalPersonRequest.setAcronym(legalPerson.get(LegalPerson.ACRONYM));
				legalPersonRequest.setBusinessName(legalPerson.get(LegalPerson.BUSINESSNAME));
				legalPersonRequest.setCompanyCode(legalPerson.get(LegalPerson.PERSONSECUENTIAL));
				legalPersonRequest.setCompanyName(legalPerson.get(LegalPerson.TRADENAME));
				// constitutionPlace
				legalPersonRequest.setCountry(legalPerson.get(LegalPerson.CONSTITUTIONPLACECODE));
				legalPersonRequest.setCoverage(legalPerson.get(LegalPerson.COVERAGECODE));
				legalPersonRequest.setLegalPersonType(legalPerson.get(LegalPerson.LEGALPERSONTYPECODE));
				legalPersonRequest.setSegment(legalPerson.get(LegalPerson.SEGMENTCODE));

				legalPersonRequest.setRuc(legalPerson.get(LegalPerson.DOCUMENTNUMBER));
				String sipla = legalPerson.get(LegalPerson.SIPLA) != null && legalPerson.get(LegalPerson.SIPLA).equals("S") ? "S" : "N";
				legalPersonRequest.setSipla(sipla);
				String validatedDoc = legalPerson.get(LegalPerson.SIPLA) != null && legalPerson.get(LegalPerson.VALIDATEDDOC).equals("S") ? "S" : "N";
				legalPersonRequest.setValidatedDoc(validatedDoc);

				// TODO:validar null
				legalPersonRequest.setLegalRepresentative(legalRepresentative.get(LegalRepresentative.LEGALREPRESENTATIVECODE));
				// TODO:colocar la fecha

				legalPersonRequest.setEffectiveDate(calendar);

				legalPersonRequest.setUndefinedEffectiveDate(undefinedDate);
				legalPersonRequest.setNotary(legalRepresentative.get(LegalRepresentative.NOTARY));
				legalPersonRequest.setNotaryOffice(legalRepresentative.get(LegalRepresentative.NOTARYOFFICE));

				legalPersonRequest.setComment(economicInformation.get(EconomicInformationLegalPerson.COMMENT));
				legalPersonRequest.setExpenses(economicInformation.get(EconomicInformationLegalPerson.EXPENSES));
				legalPersonRequest.setRevenues(economicInformation.get(EconomicInformationLegalPerson.REVENUES));
				legalPersonRequest.setNumberOfEmployees(economicInformation.get(EconomicInformationLegalPerson.NUMBEROFEMPLOYESS));
				legalPersonRequest.setNetWorth(economicInformation.get(EconomicInformationLegalPerson.NETWORTH));
				legalPersonRequest.setTotalCapital(economicInformation.get(EconomicInformationLegalPerson.TOTALCAPITAL));
				legalPersonRequest.setRelationType(economicInformation.get(EconomicInformationLegalPerson.RELATION));
				char retention = economicInformation.get(EconomicInformationLegalPerson.RETENTIONTAX) ? 'S' : 'N';
				legalPersonRequest.setRetentionTax(retention);

				LegalPersonManager legalPersonManager = new LegalPersonManager(getServiceIntegration());

				legalPersonManager.updateLegalPerson(legalPersonRequest, args);
			}

		} catch (BusinessException e) {
			args.setSuccess(false);
			LOGGER.logError(e.getMessage(), e);
			throw e;
		} catch (Exception e) {
			args.setSuccess(false);
			LOGGER.logError("Error al actualizar los datos", e);
		}
	}
}
