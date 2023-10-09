package com.cobiscorp.cobis.cstmr.commons.events;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerBusinessRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerBusinessResp;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.Business;
import com.cobiscorp.cobis.cstmr.model.CustomerTmpBusiness;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.prospect.services.BusinessManager;

public class BusinessByCustomer extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(BusinessByCustomer.class);

	public BusinessByCustomer(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	public void searchBusinessByCustomer(DynamicRequest entities, ICommonEventArgs args) throws ParseException {
		
		LOGGER.logDebug("Start searchBusinessByCustomer in SearchBusinessByCustomer");
		DataEntity customerTmp = entities.getEntity(CustomerTmpBusiness.ENTITY_NAME);
		LOGGER.logDebug("customerTmp Business---" + customerTmp);
		int customerCode = customerTmp.get(CustomerTmpBusiness.CODE);
		LOGGER.logDebug("customerCode Business---" + customerCode);
		
		CustomerBusinessRequest request = new CustomerBusinessRequest();
		request.setCustomerCode(customerCode);
		BusinessManager businessManager = new BusinessManager(getServiceIntegration());
		CustomerBusinessResp[] business = businessManager.searchBusiness(request, args);
		
		//DataEntityList businessList = entities.getEntityList(Business.ENTITY_NAME);
		DataEntityList businessList = new DataEntityList();
		
		LOGGER.logDebug("addresses ---" + business);
		for (CustomerBusinessResp resp : business) {
			DataEntity businessEntity = new DataEntity();
			businessEntity.set(Business.CODE, resp.getCode());
			LOGGER.logDebug("businessList PoupForm Code>>" + resp.getCode());
			Date dateTmp = null;
			SimpleDateFormat formatDate = new SimpleDateFormat("dd/MM/yyyy");
			
			businessEntity.set(Business.CUSTOMERCODE, customerCode);
			businessEntity.set(Business.NAMES, resp.getName());
			businessEntity.set(Business.TURNAROUND, resp.getTurnaround());
			
			if (resp.getDateBusiness() != null) {
				dateTmp = formatDate.parse(resp.getDateBusiness());
			}
			
			businessEntity.set(Business.DATEBUSINESS, dateTmp);
			
			businessEntity.set(Business.STREET, resp.getStreet());
			businessEntity.set(Business.NUMBEROFBUSINESS, resp.getNumberOfBusiness());
			businessEntity.set(Business.COLONY, resp.getColony());
			businessEntity.set(Business.LOCATIONS, resp.getLocation());
			businessEntity.set(Business.MUNICIPALITY, resp.getMunicipality());
			businessEntity.set(Business.STATE, resp.getState());
			businessEntity.set(Business.POSTALCODE, resp.getPostalCode());
			businessEntity.set(Business.COUNTRY, resp.getCountry());
			businessEntity.set(Business.PHONE, resp.getPhone());
			businessEntity.set(Business.ECONOMICACTIVITY, resp.getEconomicActivity());
			businessEntity.set(Business.TIMEACTIVITY, resp.getTimeActivity());
			businessEntity.set(Business.TIMEBUSINESSADDRESS, resp.getTimeBusinessAddress());
			
			businessEntity.set(Business.AREENTREPRENEUR, ("S".equals(resp.getAreEntrepreneur()) ? true : false));
			
			businessEntity.set(Business.RESOURCES, resp.getResources());
			businessEntity.set(Business.MOUNTLYINCOMES, resp.getMountlyIncomes());
			businessEntity.set(Business.TYPELOCAL, resp.getTypeLocal());
			businessEntity.set(Business.CREDITDESTINATION, resp.getCreditDestination());
			businessEntity.set(Business.ECONOMICACTIVITYDESC, resp.getEconomicActivityDesc());
			businessEntity.set(Business.WHICHRESOURCE, resp.getWhichResource());
			
			
			businessList.add(businessEntity);
		}
		LOGGER.logDebug("businessList PoupForm Size>>" + businessList.size());

		entities.setEntityList(Business.ENTITY_NAME, businessList);
	}

}
