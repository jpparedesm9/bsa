package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.util.ArrayList;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.MemberRequest;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.MemberQuestion;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class MemberManagement extends BaseEvent {
	private static final ILogger logger = LogFactory.getLogger(MemberManagement.class);

	public MemberManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public MemberResponse[] searchMember(MemberRequest memberRequest, ICommonEventArgs arg1, BehaviorOption options) {
		logger.logDebug("-----Inicio MemberManagement - searchMember");
		
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.MEMBER_REQUEST, memberRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SEARCH_MEMBER, serviceRequestTO);// trn 21413

		if (serviceResponse.isResult()) {

			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (MemberResponse[]) serviceItemsResponseTO.getValue(ReturnName.MEMBER_RESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}
	
	public MemberResponse[] searchDebtor(MemberRequest memberRequest, ICommonEventArgs arg1, BehaviorOption options) {
		logger.logDebug("-----Inicio MemberManagement - searchMember");
		
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.MEMBER_REQUEST, memberRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SEARCH_DEBTOR, serviceRequestTO);// trn 21413

		if (serviceResponse.isResult()) {

			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (MemberResponse[]) serviceItemsResponseTO.getValue(ReturnName.MEMBER_RESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}
	
	
	public DataEntityList mappingMember (MemberResponse[] memberResponse, DynamicRequest entities){
		logger.logDebug("------>> Inicio mappingMember");
		if (memberResponse != null) {
			DataEntityList memberEntity = new DataEntityList();
			for (MemberResponse member : memberResponse) {
				DataEntity eMember = new DataEntity();
				eMember.set(MemberQuestion.CODEMEMBER, member.getCustomerId());
				eMember.set(MemberQuestion.NAMEMEMBER, member.getCustomer());
				eMember.set(MemberQuestion.ANSWER, member.getResult());
				logger.logDebug("------>> Inicio InitDataVerificationQuestion - +member.getResult():" + member.getResult());
				memberEntity.add(eMember);
			}
			logger.logDebug(":>:>getMembersEntityList -> memberEntity:>:>" + memberEntity.getDataList());
			return memberEntity;
		}
		return null;
	}

}
