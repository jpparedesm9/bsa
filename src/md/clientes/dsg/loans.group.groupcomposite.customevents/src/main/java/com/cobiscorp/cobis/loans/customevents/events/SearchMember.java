package com.cobiscorp.cobis.loans.customevents.events;

import java.util.Date;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.MemberRequest;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.commons.loansgroup.services.MemberManager;
import com.cobiscorp.cobis.loans.commons.services.utils.Convert;
import com.cobiscorp.cobis.loans.model.Group;
import com.cobiscorp.cobis.loans.model.Member;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class SearchMember {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchMember.class);

	public void searhMemberList(DynamicRequest entities, IExecuteCommandEventArgs args, ICTSServiceIntegration serviceIntegration) {

		int idCode = 0;
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("---------------------->>> Ingreso a searhMemberList");

		try {
			if (entities != null) {
				DataEntity group = entities.getEntity(Group.ENTITY_NAME);
				MemberRequest memberRequest = new cobiscorp.ecobis.loangroup.dto.MemberRequest();

				if (group != null) {
					idCode = group.get(Group.CODE);
				}

				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("---------------------->>> SearhMemberList - idCode:" + idCode);
				memberRequest.setGroupId(idCode);
				DataEntityList memberList = getMemberEntityList(memberRequest, args, serviceIntegration);

				if (memberList != null) {
					entities.setEntityList(Member.ENTITY_NAME, memberList);
				}
			}

		} catch (Exception e) {
			
			ExceptionUtils.showError(ExceptionMessage.Clients.SEARCH_GROUP, e, args, LOGGER);
		}
	}

	public DataEntityList getMemberEntityList(MemberRequest memberRequest, ICommonEventArgs arg1, ICTSServiceIntegration serviceIntegration) {

		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("---------------------->>> Ingreso a getMemberEntityList");

		try {

			MemberManager memberManager = new MemberManager(serviceIntegration);
			MemberResponse[] memberResponses = memberManager.searchMember(memberRequest, arg1);

			if (memberResponses != null) {

				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("getMemberEntityList -- memberResponses !=null");

				DataEntityList membersEntity = new DataEntityList();
				int indice = 0;
				for (MemberResponse member : memberResponses) {
					DataEntity eMember = new DataEntity();

					eMember.set(Member.CUSTOMERID, member.getCustomerId());
					eMember.set(Member.QUALIFICATION, member.getQualification());

					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("getMemberEntityList -- !=null---getCustomer: " + member.getCustomer());
						LOGGER.logDebug("getMemberEntityList -- !=null---getQualification: " + member.getQualification());
						LOGGER.logDebug("getMemberEntityList -- !=null---getCustomer: " + member.getCustomer());
						LOGGER.logDebug("getMemberEntityList -- !=null---getCustomerId: " + member.getCustomerId());
						LOGGER.logDebug("getMemberEntityList -- !=null---getCheckRenapo: " + member.getCheckRenapo());
					}

					Date membershipDate = new Date();
					Date disconnectionDate = new Date();
					if (member.getMembershipDate() != null) {
						membershipDate = Convert.calendarToDate(member.getMembershipDate());
					}
					eMember.set(Member.MEMBERSHIPDATE, membershipDate);
					eMember.set(Member.STATE, member.getState());
					eMember.set(Member.ROLE, member.getRole());
					eMember.set(Member.QUALIFICATIONID, member.getQualificationId());
					eMember.set(Member.SECUENTIAL, 1);
					eMember.set(Member.ROLEID, member.getRoleId());
					if (member.getDisconnectionDate() != null) {
						disconnectionDate = Convert.calendarToDate(member.getDisconnectionDate());
					}
					eMember.set(Member.DISCONNECTIONDATE, disconnectionDate);
					eMember.set(Member.STATEID, member.getStateId());
					eMember.set(Member.CUSTOMER, member.getCustomer());
					indice += 1;
					eMember.set(Member.SECUENTIAL, indice);
					LOGGER.logDebug("Saving Voluntary>>" + member.getSavingVoluntary());
					LOGGER.logDebug("MeetingPlace>>" + member.getMeetingPlace());
					eMember.set(Member.SAVINGVOLUNTARY, member.getSavingVoluntary());
					eMember.set(Member.MEETINGPLACE, member.getMeetingPlace());
					eMember.set(Member.CTAINDIVIDUAL, member.getIndividualAccount());
					eMember.set(Member.RISKLEVEL, member.getRiskLevel());
					eMember.set(Member.CHECKRENAPO, member.getCheckRenapo());
					membersEntity.add(eMember);
				}

				return membersEntity;

			} else {
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("getMemberEntityList -- ==null");
				return null;
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Clients.SEARCH_MEMBER, e, arg1, LOGGER);
			return null;
		}
	}

}
