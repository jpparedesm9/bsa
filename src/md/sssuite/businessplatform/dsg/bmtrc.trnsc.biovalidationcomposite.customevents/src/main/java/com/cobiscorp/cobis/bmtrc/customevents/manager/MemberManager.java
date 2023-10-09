package com.cobiscorp.cobis.bmtrc.customevents.manager;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.BehaviorOption;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.MessageManagement;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.MemberRequest;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;

public class MemberManager extends BaseEvent {
	private static final String MEMBER_RESPONSE = "returnMemberResponse";
	private static final String MEMBER_REQUEST = "inMemberRequest";
	private static final String SEARCH_MEMBER = "LoanGroup.MemberMaintenance.SearchMember";//cob_pac..sp_miembro_grupo_busin - opcion S
	private static final String SERVICE_QUERY_MEMBER = "LoanGroup.MemberMaintenance.QueryMember";//cob_pac..sp_miembro_grupo_busin - opcion Q

	private static final ILogger LOGGER = LogFactory.getLogger(MemberManager.class);

	public MemberManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public MemberResponse[] searchMember(MemberRequest memberRequest, ICommonEventArgs arg1) {
		LOGGER.logDebug("arg1: " + arg1);
		LOGGER.logDebug("getServiceIntegration(): " + getServiceIntegration());
		CallServices callServices = new CallServices(getServiceIntegration());
		return (MemberResponse[]) callServices.callServiceWithReturnArray(MEMBER_REQUEST, memberRequest,
				SEARCH_MEMBER, MEMBER_RESPONSE, arg1);

	}

	public MemberResponse queryMember(MemberRequest memberRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestMemberTO = new ServiceRequestTO();
		serviceRequestMemberTO.addValue(MEMBER_REQUEST, memberRequest);

		ServiceResponse serviceMemberResponse = execute(getServiceIntegration(), LOGGER, SERVICE_QUERY_MEMBER,
				serviceRequestMemberTO);
		if (serviceMemberResponse.isResult()) {
			ServiceResponseTO serviceMemberResponseTO = (ServiceResponseTO) serviceMemberResponse.getData();
			return (MemberResponse) serviceMemberResponseTO.getValue(MEMBER_RESPONSE);
		} else {
			MessageManagement.show(serviceMemberResponse, arg1, options);
		}
		return null;
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
}
