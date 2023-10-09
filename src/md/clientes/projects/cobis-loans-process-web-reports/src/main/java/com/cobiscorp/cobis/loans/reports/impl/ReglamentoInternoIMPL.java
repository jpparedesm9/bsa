package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.AdditionalDataGroupResponse;
import cobiscorp.ecobis.loangroup.dto.GroupResponse;
import cobiscorp.ecobis.loangroup.dto.LoanGroupResponse;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;
import cobiscorp.ecobis.loangroup.dto.ReportResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.commons.Functions;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dto.ReglamentDTO;
import com.cobiscorp.cobis.loans.reports.utils.UtilFunctions;

public class ReglamentoInternoIMPL {
	private static final ILogger logger = LogFactory.getLogger(ReglamentoInternoIMPL.class);
	static Services service = new Services();

	public static List<ReglamentDTO> getReglamentList(MemberResponse[] members, MemberResponse[] membersAmount, LoanGroupResponse loanGroup, AdditionalDataGroupResponse additionalData, GroupResponse groupData,
			ICTSServiceIntegration serviceIntegration, String sessionId) {
		if (members != null && membersAmount != null && loanGroup != null && additionalData != null) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Inicia Mapeo de Datos Reglamento Interno CC");
			}

			ReportResponse reportResponseHeader = service.getAmortizationTableHeader(sessionId, "", serviceIntegration);

			List<ReglamentDTO> returnList = new ArrayList<ReglamentDTO>();
			//for (MemberResponse me : membersAmount) {
			for (MemberResponse me : members) {
				logger.logDebug("Inicia Mapeo de Datos - me.getCustomerId():" + me.getCustomerId());
				ReglamentDTO reglamentData = new ReglamentDTO();
				reglamentData.setAddress(additionalData.getAddressMeeting());
				reglamentData.setAmount(Functions.getStringCurrencyFormated(loanGroup.getAmount()));
				reglamentData.setCustomerMeeting(additionalData.getHostCustomerName() != null ? additionalData.getHostCustomerName() : "");
				reglamentData.setDay(UtilFunctions.getDay(reportResponseHeader.getDate()));
				reglamentData.setGroupName(groupData.getNameGroup());
				reglamentData.setHour(UtilFunctions.getHours(Calendar.getInstance()));
				reglamentData.setMeetingAddress(additionalData.getAddressMeeting());
				reglamentData.setMeetingHour(UtilFunctions.getHours(groupData.getTime()));
				reglamentData.setMeetingDay(additionalData.getMeetingDay());
				reglamentData.setMonth(UtilFunctions.getMonth(reportResponseHeader.getDate()));
				reglamentData.setPercent(me.getPercent() != null ? me.getPercent().toString() : "");
				reglamentData.setPlaceName(additionalData.getColony() != null ? additionalData.getColony() : "");
				reglamentData.setRole(getRoleFromRepresent(members, additionalData));
				reglamentData.setYear(UtilFunctions.getYear(reportResponseHeader.getDate()));
				reglamentData.setAmountString(additionalData.getAmountString());
				returnList.add(reglamentData);
				break;
			}
			return returnList;

		}
		return null;
	}

	private static String getRoleFromRepresent(MemberResponse[] memberResponse, AdditionalDataGroupResponse additionalData) {
		for (MemberResponse member : memberResponse) {
			if (member.getCustomerId() == additionalData.getHostCustomer()) {
				return member.getRole();
			}
		}
		return "";
	}
}
