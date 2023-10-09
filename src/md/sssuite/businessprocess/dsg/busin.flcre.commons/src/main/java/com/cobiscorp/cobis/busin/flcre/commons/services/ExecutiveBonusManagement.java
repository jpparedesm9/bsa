package com.cobiscorp.cobis.busin.flcre.commons.services;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RiskDataRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RiskDataResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ExecutiveBonusManagement extends BaseEvent{

	private static final ILogger logger = LogFactory.getLogger(ExecutiveBonusManagement.class);
			
	public ExecutiveBonusManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	public void updateRisk(RiskDataRequest riskDataRequest, ICommonEventArgs arg1, BehaviorOption options){
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INRISKDATAREQUEST, riskDataRequest);
		
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEUPDATERISKDATA, serviceRequestTO);
		if (!serviceResponse.isResult()) {
			logger.logDebug(" ***** update FALLO");
			MessageManagement.show(serviceResponse, arg1, options);
		}
	}
	
	public Integer createRisk(RiskDataRequest riskDataRequest, ICommonEventArgs arg1, BehaviorOption options){
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INRISKDATAREQUEST, riskDataRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICECREATERISKDATA, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			RiskDataResponse[] riskDataResponseList = (RiskDataResponse[]) serviceResponseTO.getValue(ReturnName.RETURNRISKDATARESPONSE);
			DataEntityList riskEntity = new DataEntityList();			
			for (RiskDataResponse riskDataResponse : riskDataResponseList) {
				return riskDataResponse.getAgencyId();
			}
		}else{
			logger.logDebug(" ***** insert FALLO");
			MessageManagement.show(serviceResponse, arg1, options);
			return null;
		}
		return null;
	}
}
