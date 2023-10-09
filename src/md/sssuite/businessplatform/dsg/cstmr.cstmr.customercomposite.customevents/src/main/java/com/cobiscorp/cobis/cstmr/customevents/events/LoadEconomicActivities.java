package com.cobiscorp.cobis.cstmr.customevents.events;

import java.text.SimpleDateFormat;
import java.util.Date;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.EconomicActivityDataRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.EconomicActivityDataResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.EconomicActivity;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class LoadEconomicActivities extends BaseEvent {

	private static final ILogger LOGGER = LogFactory
			.getLogger(LoadEconomicActivities.class);

	public LoadEconomicActivities(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public void loadEconomicActivities(DynamicRequest entities) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Inicia LoadEconomicActivityData");
		}

		ServiceRequestTO request = new ServiceRequestTO();
		DataEntityList economicActivityList = new DataEntityList(); 
		DataEntity naturalPerson = entities.getEntity(NaturalPerson.ENTITY_NAME);
		EconomicActivityDataRequest economicActivityDataRequest = new EconomicActivityDataRequest();
		economicActivityDataRequest.setCustomer(naturalPerson.get(NaturalPerson.PERSONSECUENTIAL));
		
		int recordCount;
		Integer sequential = 0;
		Integer mode = 0;
		SimpleDateFormat simpleDateFormat;

		do {
			recordCount = 0;
			economicActivityDataRequest.setSequential(sequential);
			economicActivityDataRequest.setMode(mode);
			request.addValue("inEconomicActivityDataRequest",
					economicActivityDataRequest);
			ServiceResponse response = this
					.execute(
							LOGGER,
							"CustomerDataManagementService.CustomerManagement.SearchEconomicActivity",
							request);
			try {
				if (response.isResult()) {
					ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
					EconomicActivityDataResponse[] economicActivityDataResponseList = (EconomicActivityDataResponse[]) resultado
							.getValue("returnEconomicActivityDataResponse");
					for (EconomicActivityDataResponse r : economicActivityDataResponseList) {
						DataEntity item = new DataEntity();
						LOGGER.logDebug("r.getClient() -->");
						LOGGER.logDebug(r.getClient());
						item.set(EconomicActivity.PERSONSECUENTIAL, r.getClient());
						item.set(EconomicActivity.SECUENTIAL, r.getSequential());
						item.set(EconomicActivity.ECONOMICSECTOR, r.getSector());
						item.set(EconomicActivity.SUBSECTOR, r.getSubSector());
						item.set(EconomicActivity.DESCRIPTION, r.getDescription());
						item.set(EconomicActivity.PRINCIPAL, r.getPrincipal());

						simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy");
						Date date = null;

						if (r.getStartdate() != null)
							date = simpleDateFormat.parse(r.getStartdate());

						item.set(EconomicActivity.STARTDATEACTIVITY, date);
						item.set(EconomicActivity.AUTHORIZED, r.getAuthorized());
						item.set(EconomicActivity.ECONOMICACTIVITY, r.getEconomicActivity());
						item.set(EconomicActivity.ANTIQUITY, r.getAntiquity());
						item.set(EconomicActivity.NUMBEREMPLOYEES,r.getNumberEmployees());
						item.set(EconomicActivity.AFFILIATE, r.getAffiliated());
						item.set(EconomicActivity.PLACEAFFILIATION,r.getAffiliationPlace());
						item.set(EconomicActivity.ENVIRONMENT,r.getEnviroment());
						item.set(EconomicActivity.PROPERTYTYPE, r.getPropertyType());
						item.set(EconomicActivity.SUBACTIVITY,r.getActivityFie());
						item.set(EconomicActivity.INCOMESOURCE, r.getIncomeSource());
						item.set(EconomicActivity.ATENTIONDAYS,r.getAtentionDays());
						item.set(EconomicActivity.ATTENTIONSCHEDULE, r.getAtentionSchedule());
						item.set(EconomicActivity.ACTIVITYSCHEDULE,r.getActivitySchedule());
						item.set(EconomicActivity.ACTIVITYSTATUS,r.getActivityStatus());
						item.set(EconomicActivity.CAEDEC, r.getCaedec());
						item.set(EconomicActivity.VERIFIED, r.getVerified());
						item.set(EconomicActivity.VERFICATIONSOURCE, r.getVerificationSource());
						item.set(EconomicActivity.PRINCIPAL, r.getPrincipal());
						LOGGER.logDebug("r.getPrincipal() --> " + r.getPrincipal());

						if (r.getVerficationDate() != null)
							date = simpleDateFormat.parse(r.getVerficationDate());

						item.set(EconomicActivity.VERIFICATIONDATE, date);
						economicActivityList.add(item);
						sequential = r.getSequential();
						mode = 1;
						recordCount = recordCount + 1;
					}
				}

			} catch (Exception e) {
				LOGGER.logError(e);
				this.manageException(e, LOGGER);
			}
		} while (recordCount == 20);
		
		//entities.getEntityList(EconomicActivity.ENTITY_NAME).clear();
		//entities.setEntityList(EconomicActivity.ENTITY_NAME, economicActivityList);

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Finaliza LoadEconomicActivityData");
		}
	}
}
