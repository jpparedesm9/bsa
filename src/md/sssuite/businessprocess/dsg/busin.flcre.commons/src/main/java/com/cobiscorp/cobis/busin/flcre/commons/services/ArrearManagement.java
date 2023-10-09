package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.math.BigDecimal;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ArrearsDetailResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ArrearsDetailResponseList;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ArrearsRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ArrearsResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.ArrearsRangeResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.ArrearsDetail;
import com.cobiscorp.cobis.busin.model.ArrearsInfo;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ArrearManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(ArrearManagement.class);

	public ArrearManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	public boolean createArrears(ArrearsRequest arrearsRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INARREARSREQUEST, arrearsRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICECREATEARREARS, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return serviceResponseTO.isSuccess();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			return false;
		}

	}

	public boolean updateArrears(ArrearsRequest arrearsRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INARREARSREQUEST, arrearsRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEUPDATEARREARS, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return serviceResponseTO.isSuccess();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			return false;
		}

	}

	public ServiceResponseTO queryArrears(ArrearsRequest arrearsRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ArrearsDetailResponseList arrearsDetailResponseList = new ArrearsDetailResponseList();
		ArrearsResponse arrearsResponse = new ArrearsResponse();
		serviceRequestTO.getData().put(RequestName.INARREARSREQUEST, arrearsRequest);
		serviceRequestTO.getData().put(ReturnName.OUTARREARSRESPONSE, arrearsResponse);
		serviceRequestTO.getData().put(ReturnName.OUTARREARSDETAILRESPONSELIST, arrearsDetailResponseList);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEQUERYARREARS, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return serviceResponseTO;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			return null;
		}

	}

	public void queryArrearsMapping(ArrearsRequest arrearsRequest, DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {

		ServiceResponseTO serviceResponseTO = this.queryArrears(arrearsRequest, arg1, options);
		if (serviceResponseTO != null) {

			ArrearsResponse arrearsResponse = (ArrearsResponse) serviceResponseTO.getValue(ReturnName.RETURNARREARSRESPONSE);
			ArrearsDetailResponse[] arrearsDetailResponseList = (ArrearsDetailResponse[]) serviceResponseTO.getValue(ReturnName.RETURNARREARSDETAILRESPONSE);			
			
			//falta mapeo
			DataEntity arrearsInfo = entities.getEntity(ArrearsInfo.ENTITY_NAME);
			DataEntity arrearsDetailInfo = entities.getEntity(ArrearsDetail.ENTITY_NAME);
			if(arrearsResponse != null){
				arrearsInfo.set(ArrearsInfo.COMMITTEDAMOUNT, new BigDecimal(arrearsResponse.getCommittedAmount()) );
				arrearsDetailInfo.set(ArrearsDetail.APPLICATIONTYPE, arrearsResponse.getTypeArrears().toString());
				arrearsDetailInfo.set(ArrearsDetail.PROBLEMSANDNEGOTIATIONS, arrearsResponse.getProblemNeg());
				arrearsDetailInfo.set(ArrearsDetail.PERSONALGUARANTORSTATUS, arrearsResponse.getSituationGar());				
				arrearsDetailInfo.set(ArrearsDetail.CONSISTENCYCOMMENTS, arrearsResponse.getObservations());
			}
			
			if(arrearsDetailResponseList != null && arrearsDetailResponseList.length>0){
				for (ArrearsDetailResponse arrearsDetailResponse : arrearsDetailResponseList) {
					
					if(arrearsDetailResponse.getConcept()!=null && arrearsDetailResponse.getConcept().equals(Mnemonic.CAPITAL)){
						arrearsDetailInfo.set(ArrearsDetail.CAPITALAMORTIZATION, arrearsDetailResponse.getPaymentPorcentage().intValue());
					}
					if(arrearsDetailResponse.getConcept()!=null && arrearsDetailResponse.getConcept().equals(Mnemonic.INTEREST)){
						arrearsDetailInfo.set(ArrearsDetail.RATEAMORTIZATION, arrearsDetailResponse.getPaymentPorcentage().intValue());
					}
				}	
			}
			
			
		}
	}

	public void changedApplicationType(DynamicRequest entities, ICommonEventArgs arg1) {
		logger.logInfo("Ingreso a changedApplicationType");
		DataEntity arrearsDetail = entities.getEntity(ArrearsDetail.ENTITY_NAME);				
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse  = execute(getServiceIntegration(), logger, ServiceId.SERVICEREADARREARSRANGE, serviceRequestTO);
		
		if (serviceResponse.isResult()) {	
			ServiceResponseTO serviceResponseData = new ServiceResponseTO();
			serviceResponseData = (ServiceResponseTO) serviceResponse.getData();
			
			ArrearsRangeResponse[] list   = (ArrearsRangeResponse[])  serviceResponseData.getValue(ReturnName.RETURNARREARSRANGERESPONSE);
			int diaInicial, diaFinal;
			int dia =entities.getEntity(ArrearsInfo.ENTITY_NAME).get(ArrearsInfo.OVERDUEDAYS);
			for (ArrearsRangeResponse item : list) {
				diaInicial = 	item.getInitialDay();
				diaFinal = 	item.getFinalDay();
				if(dia >= diaInicial&&  dia <= diaFinal){
					arrearsDetail.set(ArrearsDetail.RATEAMORTIZATION,item.getPercentageInterest().intValue());
					arrearsDetail.set(ArrearsDetail.CAPITALAMORTIZATION,item.getPercentageCaptal().intValue());
					arrearsDetail.set(ArrearsDetail.RANGEARREARS,diaInicial+" - "+diaFinal);//
				}
			}
		}else{
			logger.logInfo("isResult false");
		}
	}
}

