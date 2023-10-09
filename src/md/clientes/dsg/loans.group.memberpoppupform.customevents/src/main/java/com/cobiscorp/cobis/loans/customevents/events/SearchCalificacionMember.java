package com.cobiscorp.cobis.loans.customevents.events;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.MemberRequest;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;
import cobiscorp.ecobis.loangroup.dto.RiskLevelRequest;
import cobiscorp.ecobis.loangroup.dto.RiskResultResponse;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.commons.loansgroup.services.MemberManager;
import com.cobiscorp.cobis.loans.model.Member;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class SearchCalificacionMember extends BaseEvent implements IExecuteCommand {
	private static ILogger LOGGER = LogFactory.getLogger(SearchCalificacionMember.class);

	public SearchCalificacionMember(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs arg) {
		// TODO Auto-generated method stub
		DataEntity member = entities.getEntity(Member.ENTITY_NAME);
		try {
			LOGGER.logDebug("-->ExecuteCommand_VA_VABUTTONTPUAZVF_333132: busca de calificacion del miembro ");
			MemberRequest memberRequest = new cobiscorp.ecobis.loangroup.dto.MemberRequest();
			if (member.get(Member.CUSTOMERID) != null) {
				memberRequest.setCustomerId(member.get(Member.CUSTOMERID));
			}

			MemberManager memberManager = new MemberManager(super.getServiceIntegration());
			MemberResponse memberResponse;
			LOGGER.logDebug("miembro serviceIntegration " + getServiceIntegration());
			LOGGER.logDebug(" Llama al servicio buscar Calificacion Miembro-->: ");
			memberResponse = memberManager.searchCalificationMember(memberRequest, arg);
			member.set(Member.QUALIFICATIONID, memberResponse.getQualificationId());

            RiskResultResponse riskResultResponse = getRiskResultResponse(memberRequest.getCustomerId(), arg);
            member.set(Member.LEVEL, riskResultResponse.getRate());
            member.set(Member.POINTS, riskResultResponse.getPoints());

			arg.setSuccess(true);
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Clients.SEARCH_CALIFICATION_MEMBER, e, arg, LOGGER);
		}

	}

    private RiskResultResponse getRiskResultResponse(long customerId, ICommonEventArgs args) {
        LOGGER.logDebug("Start getRiskResultResponse");
        RiskLevelRequest riskLevelRequest = new RiskLevelRequest();
        riskLevelRequest.setCustomerId(customerId);
        ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
        serviceRequestTO.addValue("inRiskLevelRequest", riskLevelRequest);

        ServiceResponse serviceResponse =
                execute(getServiceIntegration(), LOGGER, "LoanGroup.RiskLevelManagement.QueryRiskMatrix", serviceRequestTO);

        LOGGER.logDebug("ServiceResponse >> " + serviceResponse);
        LOGGER.logDebug("ServiceResponse result >> " + serviceResponse != null ? serviceResponse.isResult() : null);

        RiskResultResponse[] riskResultResponses = null;
        if (serviceResponse.isResult()) {
            ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
            riskResultResponses = (RiskResultResponse[]) serviceItemsResponseTO.getValue("returnRiskResultResponse");
        } else {
            MessageManagement.show(serviceResponse, args, new BehaviorOption());
        }

        return riskResultResponses != null && riskResultResponses.length > 0 ?
                riskResultResponses[0] :
                new RiskResultResponse();

    }
}
