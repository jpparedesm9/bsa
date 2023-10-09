package com.cobiscorp.cobis.busin.custonevents.loadCatalog;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.collateral.dto.CollateralTypeRequest;
import cobiscorp.ecobis.collateral.dto.CollateralTypeResponse;
import cobiscorp.ecobis.collateral.dto.CollateralTypeResponseList;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

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

public class LoadCatalogType extends BaseEvent implements ILoadCatalog{

	public final static String INCOLLATERALTYPEREQUEST = "inCollateralTypeRequest";
	public final static String OUTCOLLATERALTYPERESPONSELIST = "outCollateralTypeResponseList";
	public final static String RETURNCOLLATERALTYPERESPONSE = "returnCollateralTypeResponse";
	public final static String SERVICERSEARCHCOLLATERALTYPE = "Collateral.CollateralQuery.SearchCollateralType";
	
	private static final ILogger LOGGER = LogFactory
			.getLogger(VW_WRRNTSEACH85_ViewEvent.class);
	
	public LoadCatalogType(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0,
			ILoadCatalogDataEventArgs arg1) {
		ItemDTO itemDTO;
List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();	
		
		CollateralTypeRequest collateralTypeRequest = new CollateralTypeRequest();
		CollateralTypeResponseList collateralTypeResponseList = new CollateralTypeResponseList();
		
		collateralTypeRequest.setMode(0);
		collateralTypeRequest.setOperation("N");
		//collateralTypeRequest.setType("GARCUS");
		
		ServiceRequestTO serviceRequestCollateralTypeTO = new ServiceRequestTO();
		ServiceResponse serviceResponseCollateralType = new ServiceResponse();
		
		serviceRequestCollateralTypeTO.getData().put(INCOLLATERALTYPEREQUEST, collateralTypeRequest);
		serviceRequestCollateralTypeTO.getData().put(OUTCOLLATERALTYPERESPONSELIST, collateralTypeResponseList);
		try{
			serviceResponseCollateralType = execute(getServiceIntegration(), LOGGER,
					SERVICERSEARCHCOLLATERALTYPE, serviceRequestCollateralTypeTO);
			itemDTO = new ItemDTO();
			itemDTO.setCode("0");
			itemDTO.setValue("Todos");
			listItemDTO.add(itemDTO);
			if (serviceResponseCollateralType.isResult()) {
				ServiceResponseTO serviceResponseCollateralTypeTO = new ServiceResponseTO();
				serviceResponseCollateralTypeTO = (ServiceResponseTO)serviceResponseCollateralType.getData();
				
				CollateralTypeResponse[]  collateralTypeResponses = null;
				if(serviceResponseCollateralTypeTO.getValue(RETURNCOLLATERALTYPERESPONSE) != null){
					collateralTypeResponses =(CollateralTypeResponse[]) serviceResponseCollateralTypeTO.getValue(RETURNCOLLATERALTYPERESPONSE);
				}else{
					collateralTypeResponses = new CollateralTypeResponse[0]; 
				}
				
				for (CollateralTypeResponse collateralTypeResponse : collateralTypeResponses) {
					
					itemDTO = new ItemDTO();
					
					itemDTO.setCode(collateralTypeResponse.getType());
					itemDTO.setValue(collateralTypeResponse.getDescription());
					
					listItemDTO.add(itemDTO);
				}		
			}
			return listItemDTO;
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GUARANTEE_CATALOG_TYPE, e, arg1, LOGGER);
		}
		return listItemDTO;
	}

}
