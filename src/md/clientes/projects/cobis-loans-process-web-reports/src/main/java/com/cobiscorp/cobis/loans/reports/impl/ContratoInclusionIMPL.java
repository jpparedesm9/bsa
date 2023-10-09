package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Functions;
import com.cobiscorp.cobis.loans.reports.dto.ContratoInclusionDTO;
import com.cobiscorp.designer.api.util.ServerParamUtil;

import cobiscorp.ecobis.loangroup.dto.AdditionalDataGroupResponse;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;

public class ContratoInclusionIMPL {
	private static final ILogger logger = LogFactory.getLogger(ContratoInclusionIMPL.class);

	public static List<ContratoInclusionDTO> getContratList(MemberResponse[] membersAmount, AdditionalDataGroupResponse[] additionalData) {
		if (membersAmount != null && additionalData != null) {
			List<ContratoInclusionDTO> returnList=new ArrayList<ContratoInclusionDTO>();
			for(int i=0;i<membersAmount.length;i++){
				ContratoInclusionDTO contrat=new ContratoInclusionDTO();
				contrat.setAccountName(membersAmount[i].getAccountNumber()!=null?membersAmount[i].getAccountNumber():"");
				contrat.setAmount(Functions.getStringCurrencyFormated(membersAmount[i].getAprovedAmount()));
				contrat.setAmountLetter(membersAmount[i].getLetterAmount());
				contrat.setCity(additionalData[0].getCity());
				contrat.setCustomerName(membersAmount[i].getCustomerName());
				contrat.setDate(Functions.changeStringDateFormat(ServerParamUtil.getProcessDate(), ConstantValue.valueConstant.DF_MMDDYYYY, ConstantValue.valueConstant.DF_DDMMYYYY));
				contrat.setNumeroReca(null);
				contrat.setOfficeAddress(additionalData[0].getOfficeAddress());
				contrat.setRepresentative(additionalData[0].getRepresentative());
				
				returnList.add(contrat);
			}
			return returnList;
		}
		return null;
	}
}
