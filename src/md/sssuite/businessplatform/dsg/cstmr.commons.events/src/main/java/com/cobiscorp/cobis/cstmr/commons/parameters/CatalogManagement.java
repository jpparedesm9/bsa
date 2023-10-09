package com.cobiscorp.cobis.cstmr.commons.parameters;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterRequest;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;
import cobiscorp.ecobis.systemconfiguration.dto.CatalogResponse;
import cobiscorp.ecobis.systemconfiguration.dto.TableRequest;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.BehaviorOption;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.MessageManagement;
import com.cobiscorp.ecobis.business.commons.platform.utils.RequestName;
import com.cobiscorp.ecobis.business.commons.platform.utils.ReturnName;
import com.cobiscorp.ecobis.business.commons.platform.utils.ServiceId;

public class CatalogManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(CatalogManagement.class);

	public CatalogManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	
	public ParameterResponse getParameter(int mode, String parameterNemonic, String productNemonic, ICommonEventArgs arg1, BehaviorOption options) {
		ParameterRequest parameterRequest = new ParameterRequest();
		parameterRequest.setMode(mode);
		parameterRequest.setParameterNemonic(parameterNemonic);
		parameterRequest.setProductNemonic(productNemonic);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INPARAMETERREQUEST, parameterRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.PARAMETERMANAGEMENT, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Parametro recuperados para Mode:" + mode + " parameterNemonic:" + parameterNemonic + " productNemonic:" + productNemonic);
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (ParameterResponse) serviceItemsResponseTO.getValue(ReturnName.RETURNPARAMETERRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public CatalogResponse[] getAllItemsByTable(String tableName, ICommonEventArgs arg1, BehaviorOption options) {
		List<CatalogResponse> catalogResponseList = new ArrayList();
		boolean hasValue = false;
		String nextValue = "";
	
		// Primera ejecucion
		CatalogResponse[] catalogResponseArray = this.getItemsByTable(0, tableName, null, arg1, options);
		if (catalogResponseArray != null) {
			for (CatalogResponse item : catalogResponseArray) {
				catalogResponseList.add(item);
			}
			hasValue = true;
		}
		// Siguientes ejecuciones
		while (catalogResponseArray != null && catalogResponseArray.length == 20) {
			nextValue = catalogResponseArray[catalogResponseArray.length - 1].getCode();
			catalogResponseArray = this.getItemsByTable(1, tableName, nextValue, arg1, options);
			if (catalogResponseArray != null) {
				for (CatalogResponse item : catalogResponseArray) {
					catalogResponseList.add(item);
				}
			}
		}
		if (hasValue) {
			return catalogResponseList.toArray(new CatalogResponse[catalogResponseList.size()]);
		}
		return null;
	}

	private CatalogResponse[] getItemsByTable(int mode, String tableName, String nextCode, ICommonEventArgs arg1, BehaviorOption options) {
		TableRequest tableDTO = new TableRequest();
		tableDTO.setMode(mode);
		tableDTO.setName(tableName);
		if (nextCode != null && nextCode.length() > 0) {
			tableDTO.setNextCode(nextCode);
		}

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put("inTableRequest", tableDTO);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, "SystemConfiguration.CatalogManagement.Search", serviceRequestTO);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Productos recuperados para - ca_toperacion");
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (CatalogResponse[]) serviceItemsResponseTO.getValue("returnCatalogResponse");
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

}
