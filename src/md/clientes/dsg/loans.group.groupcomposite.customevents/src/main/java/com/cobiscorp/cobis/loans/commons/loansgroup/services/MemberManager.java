package com.cobiscorp.cobis.loans.commons.loansgroup.services;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;
import cobiscorp.ecobis.loangroup.dto.MemberRequest;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.loansgroup.commons.constants.RequestName;
import com.cobiscorp.cobis.loans.loansgroup.commons.constants.ReturnName;
import com.cobiscorp.cobis.loans.loansgroup.commons.constants.ServiceId;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;

public class MemberManager extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(MemberManager.class);

	public MemberManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public boolean createMember(MemberRequest memberRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.MEMBER_REQUEST, memberRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), LOGGER, ServiceId.INSERT_MEMBER, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			return serviceResponse.isResult();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			return false;
		}
	}

	public boolean updateMember(MemberRequest memberRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.MEMBER_REQUEST, memberRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), LOGGER, ServiceId.UPDATE_MEMBER, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {

			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				LOGGER.logDebug("updateMember serviceResponseTo success");
				return true;
			} else {
				LOGGER.logDebug("updateMember serviceResponseTo doesn't success");
				throw new BusinessException(703037, raiseException(serviceResponse));
			}

		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			return false;
		}
	}

	public void disassociateMember(MemberRequest memberRequest, ICommonEventArgs arg1) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Inicio Servicio disassociateMember");

		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.MEMBER_REQUEST, memberRequest, ServiceId.DELETE_MEMBER, arg1);
	}

	public MemberResponse[] searchMember(MemberRequest memberRequest, ICommonEventArgs arg1) {
		LOGGER.logDebug("arg1: " + arg1);
		LOGGER.logDebug("getServiceIntegration(): " + getServiceIntegration());
		CallServices callServices = new CallServices(getServiceIntegration());
		return (MemberResponse[]) callServices.callServiceWithReturnArray(RequestName.MEMBER_REQUEST, memberRequest, ServiceId.SEARCH_MEMBER, ReturnName.MEMBER_RESPONSE, arg1);

	}

	public MemberResponse queryMember(MemberRequest memberRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestMemberTO = new ServiceRequestTO();
		serviceRequestMemberTO.addValue(RequestName.MEMBER_REQUEST, memberRequest);

		ServiceResponse serviceMemberResponse = execute(getServiceIntegration(), LOGGER, ServiceId.SERVICE_QUERY_MEMBER, serviceRequestMemberTO);
		if (serviceMemberResponse.isResult()) {
			ServiceResponseTO serviceMemberResponseTO = (ServiceResponseTO) serviceMemberResponse.getData();
			return (MemberResponse) serviceMemberResponseTO.getValue(ReturnName.MEMBER_RESPONSE);
		} else {
			MessageManagement.show(serviceMemberResponse, arg1, options);
		}
		return null;
	}

	public MemberResponse searchCalificationMember(MemberRequest memberRequest, ICommonEventArgs arg1) {
		LOGGER.logDebug("GroupManager serviceIntegration " + getServiceIntegration());
		CallServices callService = new CallServices(getServiceIntegration());
		MemberResponse memberResponse = (MemberResponse) callService.callServiceWithReturn(RequestName.MEMBER_REQUEST, memberRequest, ServiceId.SERVICE_QUERY_CALIFICATION_MENBER,
				ReturnName.MEMBER_RESPONSE, arg1);
		return memberResponse;
	}

	public String raiseException(ServiceResponse serviceResponse) {
		if (serviceResponse != null && serviceResponse.getMessages() != null) {
			StringBuffer errors = new StringBuffer();
			for (Message message : serviceResponse.getMessages()) {
				errors.append("Error ");
				errors.append(message.getCode());
				errors.append(": ");
				errors.append(message.getMessage());
				errors.append("\n");
			}
			return errors.toString();
		}
		return "";
	}

	public CustomerResponse queryMemberInformation(CustomerRequest customerRequest, ICommonEventArgs arg1) {
		LOGGER.logDebug("arg1: " + arg1);
		LOGGER.logDebug("getServiceIntegration(): " + getServiceIntegration());
		CallServices callServices = new CallServices(getServiceIntegration());
		return (CustomerResponse) callServices.callServiceWithReturn(RequestName.CUSTOMER_REQUEST, customerRequest, ServiceId.QUERY_MEMBER, ReturnName.CUSTOMER_RESPONSE, arg1);
	}

	public boolean updateMemberRenapo(CustomerTotalRequest customerRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.CUSTOMER_TOTAL_REQUEST, customerRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), LOGGER, ServiceId.UPDATE_RENAPO_MEMBER, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				LOGGER.logDebug("updateMemberRENAPO serviceResponseTo success");
				return true;
			} else {
				LOGGER.logError("updateMemberRENAPO serviceResponseTo isn't success");
				throw new BusinessException(2103057, raiseException(serviceResponse));
			}

		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			return false;
		}
	}

}
