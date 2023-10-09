package com.cobiscorp.cobis.loans.customevents.events;

import java.util.Calendar;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.MemberRequest;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.commons.loansgroup.services.MemberManager;
import com.cobiscorp.cobis.loans.commons.services.utils.Convert;
import com.cobiscorp.cobis.loans.model.Group;
import com.cobiscorp.cobis.loans.model.Member;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ExecuteCommand_VA_VABUTTONXYNUHPG_895132 extends BaseEvent implements IExecuteCommand {
	private static ILogger LOGGER = LogFactory.getLogger(ExecuteCommand_VA_VABUTTONXYNUHPG_895132.class);

	public ExecuteCommand_VA_VABUTTONXYNUHPG_895132(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest arg0, IExecuteCommandEventArgs arg1) {
		DataEntity member = arg0.getEntity(Member.ENTITY_NAME);
		DataEntity group = arg0.getEntity(Group.ENTITY_NAME);
		LOGGER.logDebug("-->grupos" + group);
		try {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("-->ExecuteCommand_VA_VABUTTONXYNUHPG_895132: Ingreso");
			Convert convert = new Convert();
			MemberRequest memberRequest = new cobiscorp.ecobis.loangroup.dto.MemberRequest();
			if (member.get(Member.CUSTOMERID) != null) {
				memberRequest.setCustomerId(member.get(Member.CUSTOMERID));
			}

			memberRequest.setRoleId(member.get(Member.ROLEID));

			if (member.get(Member.GROUPID) != null) {
				memberRequest.setGroupId(member.get(Member.GROUPID));
			} else {
				arg1.getMessageManager().showErrorMsg("NO EXISTE EL CODIGO DE GRUPO");
				arg1.setSuccess(false);
				return;
			}
			LOGGER.logDebug("numero de tramite insertar>>>> " + member.get(Member.CREDITCODE));
			if (member.get(Member.CREDITCODE) != null) {
				memberRequest.setApplicationCode(member.get(Member.CREDITCODE));// mta
			}

			memberRequest.setStateId(member.get(Member.STATEID));
			memberRequest.setQualificationId(member.get(Member.QUALIFICATIONID));
			memberRequest.setSavingVoluntary(member.get(Member.SAVINGVOLUNTARY));
			memberRequest.setMeetingPlace(String.valueOf(member.get(Member.MEETINGPLACE)));
			LOGGER.logDebug("CustomerID:>>>>" + memberRequest.getCustomerId());
			LOGGER.logDebug("GroupId:>>>>" + memberRequest.getGroupId());
			LOGGER.logDebug("savingVoluntary:>>>>" + memberRequest.getSavingVoluntary());
			LOGGER.logDebug("meetingPlace:>>>>" + memberRequest.getMeetingPlace());
			if (member.get(Member.MEMBERSHIPDATE) != null) {
				Calendar membershipDate = convert.toCalendar(member.get(Member.MEMBERSHIPDATE));
				memberRequest.setMembershipDate(membershipDate);
			}

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("-->ExecuteCommand_VA_VABUTTONXYNUHPG_895132: getGroupId:" + memberRequest.getGroupId());

			if (member.get(Member.DISCONNECTIONDATE) != null) {
				Calendar disconnetionDate = convert.toCalendar(member.get(Member.DISCONNECTIONDATE));
				memberRequest.setDisconnetionDate(disconnetionDate);
			}
			LOGGER.logDebug("Fuera member.get CTAINDIVIDUAL : >>>>" + member.get(Member.CTAINDIVIDUAL));
			LOGGER.logDebug("Fuera hasCTAINDIVIDUAL : >>>>" + member.get(Member.HASINDIVIDUALACCOUNTAUX));
			if (member.get(Member.CTAINDIVIDUAL) != null) {
				if (member.get(Member.HASINDIVIDUALACCOUNTAUX) == true) {
					LOGGER.logDebug(" member.get CTAINDIVIDUAL : >>>>" + member.get(Member.CTAINDIVIDUAL));
					memberRequest.setIndividualAccount(member.get(Member.CTAINDIVIDUAL));
					LOGGER.logDebug("getIndividualAccount: >>>>" + memberRequest.getIndividualAccount());
				}

			}
			LOGGER.logDebug("MEMBERSHIPDATE:>>>>" + memberRequest.getMembershipDate());
			LOGGER.logDebug("DISCONNECTIONDATE:>>>>" + memberRequest.getDisconnetionDate());
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("-->ExecuteCommand_VA_VABUTTONXYNUHPG_895132: Antes de Llamada a servicios, operacion:"
						+ member.get(Member.OPERATION));

			MemberManager memberManager = new MemberManager(super.getServiceIntegration());

			if (member.get(Member.OPERATION) != null) {
				if (member.get(Member.OPERATION) == 'I') {

					if (LOGGER.isDebugEnabled())
						LOGGER.logDebug("-->ExecuteCommand_VA_VABUTTONXYNUHPG_895132: Operacion I cambio de metodo");

					if (!memberManager.createMember(memberRequest, arg1, new BehaviorOption(true))) {
						arg1.setSuccess(false);
					} else {
						arg1.getMessageManager().showSuccessMsg("LOANS.LBL_LOANS_REGISTRAD_40101");
						arg1.setSuccess(true);
					}

				} else if (member.get(Member.OPERATION) == 'U') {
					if (LOGGER.isDebugEnabled())
						LOGGER.logDebug("-->ExecuteCommand_VA_VABUTTONXYNUHPG_895132: Operacion U");

					if (!memberManager.updateMember(memberRequest, arg1, new BehaviorOption(true))) {

						arg1.setSuccess(false);
					} else {
						arg1.getMessageManager().showSuccessMsg("LOANS.LBL_LOANS_REGISTRDE_81762");
						arg1.setSuccess(true);
					}

				}
			} else {
				arg1.setSuccess(false);
			}

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Clients.CREATE_MEMBER, e, arg1, LOGGER);
		}

	}

}
