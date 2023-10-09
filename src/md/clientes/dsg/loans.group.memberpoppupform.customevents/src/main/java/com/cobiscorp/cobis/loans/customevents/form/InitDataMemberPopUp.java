package com.cobiscorp.cobis.loans.customevents.form;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.MemberRequest;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.commons.loansgroup.services.MemberManager;
import com.cobiscorp.cobis.loans.model.Member;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class InitDataMemberPopUp extends BaseEvent implements IInitDataEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(InitDataMemberPopUp.class);

	final static String QUERY_MEMBER = "LoanGroup.MemberMaintenance.QueryMember";
	final static String MEMBER_REQUEST = "inMemberRequest";
	final static String MEMBER_RESPONSE = "returnMemberResponse";

	public InitDataMemberPopUp(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
		LOGGER.logDebug("------------->> InitDataMemberPopUpActaulizado1 -- Inicio");
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("------------->> InitDataMemberPopUpActaulizado -- Inicio");

		DataEntity memberEntity = entities.getEntity(Member.ENTITY_NAME);

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("------------->> InitDataMemberPopUp -- memberEntity" + memberEntity);
		}
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("------------->> InitDataMemberPopUp -- memberEntity" + memberEntity.getData());
		}
		CatalogManagement catalogManagement = new CatalogManagement(getServiceIntegration());
		ParameterResponse parameterDto = catalogManagement.getParameter(4, "ESTVIG", "CLI", arg1, new BehaviorOption(false, false));
		try {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("------------->> InitDataMemberPopUp -- Codigo del Miembroactualizado:" + memberEntity.get(Member.CUSTOMERID));
			}
			if (memberEntity.get(Member.CUSTOMERID) != null) {
				LOGGER.logDebug("------------->> InitDataMemberPopUp -- Entra a validacion ustumer Id:");
				MemberRequest memberRequest = new MemberRequest();
				LOGGER.logDebug("------------->> InitDataMemberPopUp -- Member GroupId:" + memberEntity.get(Member.GROUPID));
				LOGGER.logDebug("------------->> InitDataMemberPopUp -- Member GroupId:" + memberEntity.get(Member.CUSTOMERID));
				memberRequest.setGroupId(memberEntity.get(Member.GROUPID));
				memberRequest.setCustomerId(memberEntity.get(Member.CUSTOMERID));

				MemberManager memberManager = new MemberManager(super.getServiceIntegration());
				MemberResponse memberResponse = memberManager.queryMember(memberRequest, arg1, new BehaviorOption(true));
				String paramStateVig = "V";
				if (parameterDto != null) {
					if (parameterDto.getParameterValue() != null) {
						paramStateVig = parameterDto.getParameterValue().trim();
					}
				}
				LOGGER.logDebug("------------->> InitDataMemberPopUp -- Valor del Estado:" + paramStateVig);
				if (memberResponse != null) {
					memberEntity.set(Member.CUSTOMER, memberResponse.getCustomer());
					memberEntity.set(Member.ROLEID, memberResponse.getRoleId());

					if (memberResponse.getStateId() == null) {
						memberEntity.set(Member.STATEID, paramStateVig);
					} else {
						memberEntity.set(Member.STATEID, memberResponse.getStateId());
					}
					memberEntity.set(Member.QUALIFICATIONID, memberResponse.getQualificationId());

					if (memberResponse.getMembershipDate() != null) {
						memberEntity.set(Member.MEMBERSHIPDATE, memberResponse.getMembershipDate().getTime());
					} else {
						memberEntity.set(Member.MEMBERSHIPDATE, null);
					}

					if (LOGGER.isDebugEnabled())
						LOGGER.logDebug("------------->> InitDataMemberPopUp -- Fecha de desconexion:" + memberResponse.getDisconnectionDate());

					if (memberResponse.getDisconnectionDate() != null) {
						memberEntity.set(Member.DISCONNECTIONDATE, memberResponse.getDisconnectionDate().getTime());
					} else {
						memberEntity.set(Member.DISCONNECTIONDATE, null);
					}
				} else {
					LOGGER.logDebug("----------->>>>CAMBIOS =null");
					memberEntity.set(Member.STATEID, paramStateVig);
				}
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Clients.INIT_DATA_MEMBER_POP_UP, e, arg1, LOGGER);
		}
	}

}
