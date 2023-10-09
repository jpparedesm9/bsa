package com.cobiscorp.cobis.busin.custonevents.loadCatalog;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.OfficerRequest;
import cobiscorp.ecobis.systemconfiguration.dto.OfficerResponse;
import cobiscorp.ecobis.systemconfiguration.dto.OfficerResponseList;

import com.cobiscorp.cobis.busin.customevents.view.VW_WRRNTSEACH85_ViewEvent;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class LoadCatalogOfficer extends BaseEvent implements ILoadCatalog {

	public final static String INOFFICERREQUEST       = "inOfficerRequest";
	public final static String OUTOFFICERRESPONSELIST = "outOfficerResponseList";
	public final static String SERVICERSEARCHOFFICER  = "SystemConfiguration.OfficerManagement.SearchOfficer";
	public final static String RETURNOFFICERRESPONSE  = "returnOfficerResponse";
	
	public LoadCatalogOfficer(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}
	
	private static final ILogger LOGGER = LogFactory
			.getLogger(VW_WRRNTSEACH85_ViewEvent.class);

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0,
			ILoadCatalogDataEventArgs arg1) {
		
List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();		
ItemDTO itemDTO;
		
		OfficerResponseList officerResponseList = new OfficerResponseList(); 
		OfficerRequest officerRequest = new OfficerRequest();
		officerRequest.setType("R");
		
		
		ServiceRequestTO serviceRequestOfficerTO = new ServiceRequestTO();
		ServiceResponseTO serviceResponseOfficeTO = new ServiceResponseTO();
		ServiceResponse serviceResponseOfficer = new ServiceResponse();
		try{
			//workloadOfficerRequest.setConnectionOffice(52);
			serviceRequestOfficerTO.getData().put(INOFFICERREQUEST,officerRequest);
			serviceRequestOfficerTO.getData().put(OUTOFFICERRESPONSELIST,officerResponseList);
			
			serviceResponseOfficer = execute(getServiceIntegration(), LOGGER,
					SERVICERSEARCHOFFICER, serviceRequestOfficerTO);
			/*se carga una opcion adicional para Todos*/
			itemDTO = new ItemDTO();
			itemDTO.setCode("0");
			itemDTO.setValue("Todos");
			listItemDTO.add(itemDTO);
			
			if (serviceResponseOfficer.isResult()) {
				serviceResponseOfficeTO = (ServiceResponseTO) serviceResponseOfficer
						.getData();
				
				OfficerResponse[]  officerResponses = null;
				
				if((OfficerResponse[]) serviceResponseOfficeTO.getValue(RETURNOFFICERRESPONSE) != null)
				{
					officerResponses =(OfficerResponse[]) serviceResponseOfficeTO.getValue(RETURNOFFICERRESPONSE);
				}
				else{
					officerResponses = new OfficerResponse[0]; 
				}
				
				for (OfficerResponse officerResponse : officerResponses) {
					itemDTO = new ItemDTO();
					itemDTO.setCode(officerResponse.getOfficerId().toString());
					itemDTO.setValue(officerResponse.getOfficerName());

					listItemDTO.add(itemDTO);				
				}
			}
			
			return listItemDTO;
			
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GUARANTEE_CATALOG_OFFICIAL, e, arg1, LOGGER);
		}
		
		return listItemDTO;
	}

}