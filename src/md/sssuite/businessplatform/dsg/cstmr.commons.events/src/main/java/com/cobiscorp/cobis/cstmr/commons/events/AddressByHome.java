package com.cobiscorp.cobis.cstmr.commons.events;

import java.text.ParseException;
import java.util.Date;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerBusinessRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerBusinessResp;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.Business;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.prospect.services.BusinessManager;

public class AddressByHome extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(AddressByHome.class);

	public AddressByHome(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public void searchAdressByHome(DynamicRequest entities, ICommonEventArgs args) throws ParseException {
		
		LOGGER.logDebug("Start searchBusinessByCustomer in SearchBusinessByCustomer");
		DataEntity addressHome = entities.getEntity(Business.ENTITY_NAME);
		LOGGER.logDebug("customerTmp Business---" + addressHome);
		int customerCode = addressHome.get(Business.CUSTOMERCODE);
		LOGGER.logDebug("customerCode Business---" + customerCode);
		String localType = addressHome.get(Business.TYPELOCAL);
		LOGGER.logDebug("Local Type---" + localType);
		
		
		int code = addressHome.get(Business.CODE);
		String names = addressHome.get(Business.NAMES);
		String turnaround = addressHome.get(Business.TURNAROUND);
		Date datebusiness = addressHome.get(Business.DATEBUSINESS);
		String phone = addressHome.get(Business.PHONE);
		String economicactivity = addressHome.get(Business.ECONOMICACTIVITY);
		int timeactivity = addressHome.get(Business.TIMEACTIVITY);
		int timebusinessaddress = addressHome.get(Business.TIMEBUSINESSADDRESS);
		boolean areentrepreneur = addressHome.get(Business.AREENTREPRENEUR);
		String resources = addressHome.get(Business.RESOURCES);
		double mountlyincomes = addressHome.get(Business.MOUNTLYINCOMES);
		
		CustomerBusinessRequest request = new CustomerBusinessRequest();
		request.setCustomerCode(customerCode);
		BusinessManager businessManager = new BusinessManager(getServiceIntegration());
		CustomerBusinessResp home = businessManager.searchAddressHome(request, args);
		
		
		DataEntity addressHomeEntity = new DataEntity();
		
		addressHomeEntity.set(Business.CUSTOMERCODE, customerCode);
		addressHomeEntity.set(Business.STREET, home.getStreet());
		addressHomeEntity.set(Business.NUMBEROFBUSINESS, home.getNumberOfBusiness());
		addressHomeEntity.set(Business.COLONY, home.getColony());
		addressHomeEntity.set(Business.MUNICIPALITY, home.getMunicipality());
		addressHomeEntity.set(Business.STATE, home.getState());
		addressHomeEntity.set(Business.POSTALCODE, home.getPostalCode());
		addressHomeEntity.set(Business.COUNTRY, home.getCountry());
		addressHomeEntity.set(Business.TYPELOCAL, localType);
		
		addressHomeEntity.set(Business.CODE, code);
		addressHomeEntity.set(Business.NAMES, names);
		addressHomeEntity.set(Business.TURNAROUND, turnaround);
		addressHomeEntity.set(Business.DATEBUSINESS, datebusiness);
		addressHomeEntity.set(Business.PHONE, phone);
		addressHomeEntity.set(Business.ECONOMICACTIVITY, economicactivity);
		addressHomeEntity.set(Business.TIMEACTIVITY, timeactivity);
		addressHomeEntity.set(Business.TIMEBUSINESSADDRESS, timebusinessaddress);
		addressHomeEntity.set(Business.AREENTREPRENEUR, areentrepreneur);
		addressHomeEntity.set(Business.RESOURCES, resources);
		addressHomeEntity.set(Business.MOUNTLYINCOMES, mountlyincomes);
		
		entities.setEntity(Business.ENTITY_NAME, addressHomeEntity);
	}

}
