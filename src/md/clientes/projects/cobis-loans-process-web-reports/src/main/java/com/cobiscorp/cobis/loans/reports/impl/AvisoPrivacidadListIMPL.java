package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.felix.scr.annotations.Reference;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.dto.MemberDTO;

public class AvisoPrivacidadListIMPL {
	private static final ILogger logger = LogFactory.getLogger(AvisoPrivacidadListIMPL.class);

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	public static List<MemberDTO> getAllGroupMembers(MemberResponse[] memberResponses, String sessionId, ICTSServiceIntegration serviceIntegration) {
		ArrayList<MemberDTO> dataBeanList = new ArrayList<MemberDTO>();
		if (logger.isDebugEnabled() ) {
			logger.logDebug("*****>>Inicia getAllGroupMembers");
		}

		if (memberResponses != null && memberResponses.length > 0) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("*****>>getAllGroupMembers - size:" + memberResponses.length);
			}

			for (int i = 0; i < memberResponses.length; i++) {
				MemberDTO memberDTO = new MemberDTO();
				if (memberResponses[i].getCustomer() != null) {
					memberDTO.setNombresMiembro(memberResponses[i].getCustomer());
				} else {
					memberDTO.setNombresMiembro("");
				}
				dataBeanList.add(memberDTO);
			}
			return dataBeanList;

		}
		return null;
	}
}
