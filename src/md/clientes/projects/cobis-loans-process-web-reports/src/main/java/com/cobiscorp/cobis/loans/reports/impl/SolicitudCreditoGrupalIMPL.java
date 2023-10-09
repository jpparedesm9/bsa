package com.cobiscorp.cobis.loans.reports.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.dto.LoanGroupDetail;

import cobiscorp.ecobis.loangroup.dto.MemberResponse;

public class SolicitudCreditoGrupalIMPL {
	private static final ILogger logger = LogFactory.getLogger(SolicitudCreditoGrupalIMPL.class);

	public static List<LoanGroupDetail> getDetailList(MemberResponse[] membersAmount) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia Mapea de Datos");
		}
		if (membersAmount != null) {
			logger.logDebug("SolicitudCreditoGrupalIMPL-getDetailList-membersAmount.toString():"+membersAmount.toString());
			List<LoanGroupDetail> returnList = new ArrayList<LoanGroupDetail>();
			int i = 0;
			for (MemberResponse ma : membersAmount) {
				i = i + 1;
				LoanGroupDetail loanGroupDetail = new LoanGroupDetail();
				loanGroupDetail.setAuthorizedAmount(new BigDecimal(ma.getAprovedAmount()));
				loanGroupDetail.setRequestAmount(new BigDecimal(ma.getRequestAmount()));
				if(ma.getCycleByApplication() != 0){
					loanGroupDetail.setCicle(String.valueOf(ma.getCycleByApplication()));
				}else{
				loanGroupDetail.setCicle(ma.getCicle() != null ? ma.getCicle().toString() : "");				
				}
				loanGroupDetail.setCustomerId(ma.getCustomerId());
				loanGroupDetail.setCustomerName(ma.getCustomerName());
				loanGroupDetail.setRole(ma.getRoleId());
				loanGroupDetail.setVoluntarySaving(BigDecimal.valueOf(ma.getSavingVoluntary()));
				loanGroupDetail.setSequential(i);				
				returnList.add(loanGroupDetail);
			}
			return returnList;
		}

		return null;
	}
}
