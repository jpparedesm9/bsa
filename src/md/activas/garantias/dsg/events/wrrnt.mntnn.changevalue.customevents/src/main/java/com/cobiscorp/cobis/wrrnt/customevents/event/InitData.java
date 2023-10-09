package com.cobiscorp.cobis.wrrnt.customevents.event;

import java.util.HashMap;
import java.util.Map;

import cobiscorp.ecobis.collateral.dto.GuaranteeTranRequest;
import cobiscorp.ecobis.collateral.dto.GuaranteeTranResponse;
import cobiscorp.ecobis.collateral.dto.TypeGuaranteeData;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.wrrnt.commons.utils.Constant;
import com.cobiscorp.cobis.wrrnt.commons.utils.Function;
import com.cobiscorp.cobis.wrrnt.model.Warranty;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.api.util.SessionUtil;
import com.cobiscorp.designer.common.BaseEvent;

public class InitData extends BaseEvent implements IInitDataEvent {

	public InitData(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	private static final ILogger LOGGER = LogFactory
			.getLogger(InitData.class);
	
	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {
		if (LOGGER.isDebugEnabled()){
			LOGGER.logDebug("initData***");
		}
		getGuaranteeType(entities, args);
		
	}

	private void getGuaranteeType(DynamicRequest entities, IDataEventArgs args) {
		if (LOGGER.isDebugEnabled()){
			LOGGER.logDebug("getTransactionData***");
		}
		
		TypeGuaranteeData typeGuaranteeData = new TypeGuaranteeData();
		
		ServiceRequestTO request = new ServiceRequestTO();
		GuaranteeTranRequest guaranteeTranRequest = new GuaranteeTranRequest();
		DataEntity warranty = entities.getEntity(Warranty.ENTITY_NAME);
		
		
		guaranteeTranRequest.setCustodyType(warranty.get(Warranty.TYPE));
		guaranteeTranRequest.setOperation(Constant.CHAR_Q);
		
		request.addValue("inGuaranteeTranRequest", guaranteeTranRequest);
		ServiceResponse response = this.execute(getServiceIntegration(), LOGGER,
				Constant.SERVICE_READTYPEGUARANTEE, request);

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("response.getData()"
					+ response.getData());
		}
		if (response != null && response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response
					.getData();
			
            TypeGuaranteeData[] typeGuaranteeDataList = (TypeGuaranteeData[]) resultado.getValue(Constant.RETURN_TYPEGUARANTEEDATA);
			
			if (typeGuaranteeDataList != null && typeGuaranteeDataList.length > 0 ) {
				typeGuaranteeData = typeGuaranteeDataList[0];
		        warranty.set(Warranty.PERCENT, typeGuaranteeData.getPercentage());
		        
			}
			
		} else {
			Function.handleResponse(args, response, null);
		}
		
		
	}

	

}
