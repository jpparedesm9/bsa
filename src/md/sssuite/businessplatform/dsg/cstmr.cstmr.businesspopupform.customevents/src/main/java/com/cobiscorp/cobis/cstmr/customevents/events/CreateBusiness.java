package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerBusinessRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.GeneralFunction;
import com.cobiscorp.cobis.cstmr.model.Business;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.BusinessManager;

public class CreateBusiness extends BaseEvent implements IExecuteCommand{
	
	private static final ILogger LOGGER = LogFactory
			.getLogger(CreateBusiness.class);

	public CreateBusiness(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		// TODO Auto-generated method stub
		try {
			
			LOGGER.logDebug("Funciona");
			
			
			
			DataEntity requestEntity = entities.getEntity(Business.ENTITY_NAME);
			int customerId = requestEntity.get(Business.CUSTOMERCODE);
			
			CustomerBusinessRequest businessRequest = new CustomerBusinessRequest();
			
			businessRequest.setCustomerCode(customerId);
			businessRequest.setName(requestEntity.get(Business.NAMES));
			businessRequest.setTurnaround(requestEntity.get(Business.TURNAROUND));
			
			if(requestEntity.get(Business.DATEBUSINESS) != null){
				businessRequest.setDateBusiness(GeneralFunction.convertDateToCalendar(requestEntity.get(Business.DATEBUSINESS)));
			}	
			
			businessRequest.setStreet(requestEntity.get(Business.STREET));
			businessRequest.setNumberOfBusiness(requestEntity.get(Business.NUMBEROFBUSINESS));
			businessRequest.setColony(requestEntity.get(Business.COLONY));
			businessRequest.setLocation(requestEntity.get(Business.LOCATIONS));
			businessRequest.setMunicipality(requestEntity.get(Business.MUNICIPALITY));
			businessRequest.setState(requestEntity.get(Business.STATE));
			businessRequest.setPostalCode(requestEntity.get(Business.POSTALCODE));
			businessRequest.setCountry(requestEntity.get(Business.COUNTRY));
			businessRequest.setPhone(requestEntity.get(Business.PHONE));
			businessRequest.setEconomicActivity(requestEntity.get(Business.ECONOMICACTIVITY));
			businessRequest.setTimeActivity(requestEntity.get(Business.TIMEACTIVITY));
			businessRequest.setTimeBusinessAddress(requestEntity.get(Business.TIMEBUSINESSADDRESS));
			
			businessRequest.setAreEntrepreneur(requestEntity
					.get(Business.AREENTREPRENEUR) ? "S"
					: "N");
			
			businessRequest.setResources(requestEntity.get(Business.RESOURCES));
			businessRequest.setMountlyIncomes(requestEntity.get(Business.MOUNTLYINCOMES));
			businessRequest.setTypeLocal(requestEntity.get(Business.TYPELOCAL));
			businessRequest.setCreditDestination(requestEntity.get(Business.CREDITDESTINATION));
			businessRequest.setWhichResource(requestEntity.get(Business.WHICHRESOURCE));
			
			BusinessManager businessManager = new BusinessManager(getServiceIntegration());

			Integer actualBusinessCode = requestEntity.get(Business.CODE);
			Integer businessCode = 0;
			if (actualBusinessCode == 0) {
				businessCode = businessManager.createBusiness(businessRequest, args);
				//Esta validacion se aniade por que el usuario se conecta desde la web con oficina que esta creada para la movil
				if(businessCode == null){
					businessCode = 0;
				}
				requestEntity.set(Business.CODE, businessCode);
				LOGGER.logDebug("CODIGO SETEADO " + requestEntity.get(Business.CODE));
			} else{
				businessRequest.setCode(actualBusinessCode);
				businessManager.updateBusiness(businessRequest, args);
			}
			
			args.setSuccess(true);
		}catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.CREATE_BUSSINESS, e, args, LOGGER);
		}
		
	}

}
