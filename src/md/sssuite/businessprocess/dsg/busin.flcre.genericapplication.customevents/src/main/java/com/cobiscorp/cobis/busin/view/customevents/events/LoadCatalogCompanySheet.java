package com.cobiscorp.cobis.busin.view.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.systemconfiguration.dto.CityRequest;
import cobiscorp.ecobis.systemconfiguration.dto.CityResponse;
import cobiscorp.ecobis.systemconfiguration.dto.CityResponseList;

import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.model.ArrearsInfo;
import com.cobiscorp.cobis.busin.model.HeaderGuaranteesTicket;
import com.cobiscorp.cobis.busin.model.OfficerAnalysis;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class LoadCatalogCompanySheet extends BaseEvent implements ILoadCatalog{

	private static final ILogger LOGGER = LogFactory
			.getLogger(LoadCatalogCompanySheet.class);
	
	public LoadCatalogCompanySheet(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public List<ItemDTO> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs args) {
		
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start executeCommand method in LoadCatalogCompanySheet class");
		}
		
		DataEntity original = entities.getEntity(OriginalHeader.ENTITY_NAME);
		ServiceResponse serviceResponse = new ServiceResponse();
		ServiceResponseTO serviceResponseTo = new ServiceResponseTO();
		List<ItemDTO> items = new ArrayList<ItemDTO>();
	
		try {
			
			CustomerRequest customerReq=new  CustomerRequest();
			customerReq.setNit(original.get(OriginalHeader.APPLICATIONNUMBER));
			
			ServiceRequestTO serviceRequestTOException = new ServiceRequestTO();
			serviceRequestTOException.getData().put("inCustomerRequest", customerReq);
			
			serviceResponse = execute(LOGGER, ServiceId.SERVICESEARCHCOMPANYSHEET, serviceRequestTOException);
			
			if (serviceResponse.isResult() && serviceResponse != null) {
				serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
				CustomerResponse[] customer = (CustomerResponse[]) serviceResponseTo.getValue(ReturnName.RETURNCUSTOMERRESPONSE);
				
				for (CustomerResponse customerResponse : customer) {
					ItemDTO item = new ItemDTO();
					item.setCode(customerResponse.getCustomerIdentificaction());
					item.setValue(customerResponse.getCustomerName());
					items.add(item);
				}
			}
			
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_CATALOG_COMPANY, e, args, LOGGER);
		}finally {

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finish executeCommand method in LoadCatalogCompanySheet class");

			}
		}
					
		return items;
	}
	
}
