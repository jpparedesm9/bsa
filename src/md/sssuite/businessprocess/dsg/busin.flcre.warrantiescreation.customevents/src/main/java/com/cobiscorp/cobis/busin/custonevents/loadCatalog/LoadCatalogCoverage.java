package com.cobiscorp.cobis.busin.custonevents.loadCatalog;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.collateral.dto.CoverageCustodyRequest;
import cobiscorp.ecobis.collateral.dto.CoverageCustodyResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.model.WarrantyGeneral;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class LoadCatalogCoverage extends BaseEvent implements ILoadCatalog {

	private static final ILogger LOGGER = LogFactory.getLogger(LoadCatalogCoverage.class);

	public LoadCatalogCoverage(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);		
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0,
			ILoadCatalogDataEventArgs arg1) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Ingreso LoadCatalogCoverage");
		String typeWarranty="";
		CoverageCustodyRequest coverageCustodyRequest = new CoverageCustodyRequest();
		DataEntity warrantyGeneral = arg0.getEntity(WarrantyGeneral.ENTITY_NAME);

		if(warrantyGeneral.get(WarrantyGeneral.WARRANTYTYPE) != null){
			typeWarranty = warrantyGeneral.get(WarrantyGeneral.WARRANTYTYPE);
		}else{
			Map<String, Object> currentRow = (Map<String, Object>) arg1.getParameters().getCustomParameters().get("currentRow");
			if(currentRow != null){		//Carga de tipo de garantía para edición
				typeWarranty = currentRow.get("Type").toString();
			}
		}

		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Warranty Type:" + typeWarranty);

		coverageCustodyRequest.setType(typeWarranty);
		ServiceRequestTO serviceRequestItemsTO = new ServiceRequestTO();						
		serviceRequestItemsTO.getData().put(RequestName.INCOVERAGECUSTODYREQUEST, coverageCustodyRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), LOGGER, ServiceId.SERVICEGETCOVERAGECUSTODY, serviceRequestItemsTO);
		List<ItemDTO> coverageList = new ArrayList<ItemDTO>();
		try{
			if(serviceResponse.isResult()){
				if (LOGGER.isDebugEnabled())				
					LOGGER.logDebug("Resultado Exitoso LoadCatalogCoverage");

				ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
				CoverageCustodyResponse[] listCoverageCustodyResponse = (CoverageCustodyResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNCOVERAGECUSTODYRESPONSE);

				for (CoverageCustodyResponse iteratorCoverageCustody : listCoverageCustodyResponse) {
					LOGGER.logDebug("Entra For coverage");
					ItemDTO itemDTO = new ItemDTO();
					itemDTO.setCode(iteratorCoverageCustody.getCoverage());
					itemDTO.setValue(iteratorCoverageCustody.getDescription() + " - " + iteratorCoverageCustody.getValue().toString());								
					itemDTO.setAttributes(Arrays.asList(iteratorCoverageCustody.getValue()));
					coverageList.add(itemDTO);				
				}				

			} else {
				List<Message> errorMessage = serviceResponse.getMessages();
				for (Message message : errorMessage) {
					arg1.getMessageManager().showErrorMsg(message.getMessage() + " - [" + message.getCode() + "]");
				}
			}
			return coverageList;
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.WARRANTIES_CATALOG_COVARAGE, e, arg1, LOGGER);
		}
		return coverageList;
	}



}
