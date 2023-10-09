package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.TelephoneRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.TelephoneResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.Phone;
import com.cobiscorp.cobis.cstmr.model.PhysicalAddress;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.PhoneManager;
import com.cobiscorp.ecobis.business.commons.platform.services.ParameterManager;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

public class SearchTelephones extends BaseEvent implements IInitDataEvent {
	private static final ILogger LOGGER = LogFactory
			.getLogger(SearchTelephones.class);

	public SearchTelephones(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {
		// DataEntityList phonesList=entities.getEntityList(Phone.ENTITY_NAME);
		ParameterManager parameterManagement = new ParameterManager(getServiceIntegration());
		ParameterResponse parameterDto;
		String paraVASMS = "N";
		try {
			LOGGER.logInfo("consulta de parametro: VASMS");
			parameterDto = parameterManagement.getParameter(4, "VPSMS", "CLI", args);
			LOGGER.logInfo("valor de parametro VASMS: " + parameterDto.getParameterValue());
			paraVASMS = parameterDto.getParameterValue();
		} catch (Exception e) {
			ExceptionUtils.showError("Error al consultar parámetro VASMS", e, args, LOGGER);
		}
		
		try {
			DataEntity addressEntity = entities
					.getEntity(PhysicalAddress.ENTITY_NAME);

			TelephoneRequest phoneRequest = new TelephoneRequest();
			phoneRequest.setAddress(addressEntity
					.get(PhysicalAddress.ADDRESSID));
			phoneRequest.setCustomerId(addressEntity
					.get(PhysicalAddress.PERSONSECUENTIAL));

			PhoneManager phoneManager = new PhoneManager(
					getServiceIntegration());
			TelephoneResponse phones[];

			phones = phoneManager.searchPhones(phoneRequest, args);

			DataEntityList phoneListEntity = new DataEntityList();
			for (TelephoneResponse phone : phones) {
				DataEntity phoneEntity = new DataEntity();
				phoneEntity.set(Phone.ADDRESSID, phone.getAddressId());
				phoneEntity.set(Phone.PHONEID, phone.getTelephoneId());
				phoneEntity.set(Phone.PERSONSECUENTIAL, phone.getCustomerId());
				phoneEntity.set(Phone.PHONENUMBER, phone.getNumber());
				phoneEntity.set(Phone.PHONETYPE, phone.getType());
				phoneEntity.set(Phone.AREACODE, phone.getCodeArea());
				phoneEntity.set(Phone.ISCHECKED, phone.getVerification());
				phoneListEntity.add(phoneEntity);

			}
			entities.setEntityList(Phone.ENTITY_NAME, phoneListEntity);			
			addressEntity.set(PhysicalAddress.PARAMVASMS, paraVASMS);
			args.setSuccess(true);
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.SEARCH_TELEPHONES, e, args, LOGGER);
		}
	}

}
