package com.cobiscorp.cobis.busin.flcre.commons.services;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.EconomicActivityDataRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.EconomicActivityDataResponse;
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
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class EconomicActivityManagement extends BaseEvent {
	private static final ILogger logger = LogFactory.getLogger(EconomicActivityManagement.class);

	public EconomicActivityManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public String getEconomicActivityDescription(String economicActivityCode, ICommonEventArgs arg1, BehaviorOption options) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("getEconomicActivityDescription start");
		}
		String economicDescription = "";
		EconomicActivityDataRequest economicActivityRequest = new EconomicActivityDataRequest();
		economicActivityRequest.setCodigo(economicActivityCode);
		economicActivityRequest.setModo(0);
		economicActivityRequest.setOperacion('V');

		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INECONOMICACTIVITYDATA, economicActivityRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEECONOMICACTIVITYDESCRIPTION, serviceRequestApplicationTO);
		if(serviceResponse.isResult()){
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			EconomicActivityDataResponse[] economicResponse = (EconomicActivityDataResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNECONOMICACTIVITYDATA);
			for (EconomicActivityDataResponse iteratorEconomic : economicResponse) {
				economicDescription = iteratorEconomic.getDescripcion();
			}
			return economicDescription;
		} else{
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}
	
	public EconomicActivityDataResponse[] getEconomicActivityLastLevel(String filtro, String segment, String destination, ICommonEventArgs arg1, BehaviorOption options) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("getEconomicActivityLastLevel start");
		}
		EconomicActivityDataRequest economicActivityRequest = new EconomicActivityDataRequest();
		economicActivityRequest.setCodigo("");
		economicActivityRequest.setDestinoBce(destination);
		economicActivityRequest.setModo(0);
		economicActivityRequest.setOperacion('X');
		economicActivityRequest.setSegmento(segment);
		economicActivityRequest.setFiltro(filtro);
		
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INECONOMICACTIVITYDATA, economicActivityRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEECONOMICACTIVITYLASTLEVEL, serviceRequestApplicationTO);
		if(serviceResponse.isResult()){
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			EconomicActivityDataResponse[] economicResponse = (EconomicActivityDataResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNECONOMICACTIVITYDATA);
			return economicResponse;
		} else{
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}
}
