package com.cobiscorp.cobis.busin.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.htm.api.dto.ProcessDTO;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
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

public class LoadCatalogTypeFlow extends BaseEvent implements ILoadCatalog{

	private static final ILogger LOGGER = LogFactory
			.getLogger(LoadCatalogTypeFlow.class);
	
	public LoadCatalogTypeFlow(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0,
			ILoadCatalogDataEventArgs arg1) {
		
		List<ItemDTO> listProcess = new ArrayList<ItemDTO>();
		
		ProcessDTO processDTOQuery = new ProcessDTO();				
		processDTOQuery.setFilial(1);//(filterApplications.get(FilterApplications.SUBSIDIARY));
		processDTOQuery.setTemplateNamespace("CRE");
		
		try{
			CatalogManagement catalogManagement = new CatalogManagement(this.getServiceIntegration());
			LOGGER.logDebug("catalogManagement"+catalogManagement);
			ParameterResponse parametroClaims = catalogManagement.getParameter(4, "GESTRE", "CRE", arg1, new BehaviorOption(true));
			LOGGER.logDebug("parametroClaims"+parametroClaims);					
			ServiceRequestTO requestTO = new ServiceRequestTO();
			requestTO.getData().put("inProcessDTO", processDTOQuery);
			
			ServiceResponse serviceResponse = null;
			serviceResponse = execute(getServiceIntegration(), LOGGER,
							"HTM.API.HumanTask.GetProcessesList", requestTO);			

			if (serviceResponse != null) {
				ServiceResponseTO serviceTOResponse = new ServiceResponseTO();
				serviceTOResponse = (ServiceResponseTO) serviceResponse
							.getData();
				if (serviceTOResponse.isSuccess()) {
					ProcessDTO[] processDTOs = (ProcessDTO[]) serviceTOResponse
								.getValue("returnProcessDTO");
					for (ProcessDTO processDTO : processDTOs) {
						ItemDTO itemDto = new ItemDTO();
						itemDto.setCode(processDTO.getProcessId());
						itemDto.setValue(processDTO.getTemplateName());
						//para diferenciar al item gestion de reclamos
						if(processDTO.getNemonic()!=null&&parametroClaims!=null&&processDTO.getNemonic().equals(parametroClaims.getParameterValue())){
							itemDto.setCode(processDTO.getNemonic());
						}	
						listProcess.add(itemDto);
					}
				}
			}
			return listProcess;
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.REPRINT_CATALOG_FLOW, e, arg1, LOGGER);
		}
		return listProcess;
	}

}
