package com.cobiscorp.cobis.loans.reports.impl;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.apache.felix.scr.annotations.Reference;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.GroupLoanInfResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Functions;
import com.cobiscorp.cobis.loans.reports.commons.Services;
import com.cobiscorp.cobis.loans.reports.dto.CreditPaymentsDTO;
import com.cobiscorp.cobis.loans.reports.dto.MemberDTO;

public class FormatoPagareGrupalListIMPL {
	private static final ILogger logger = LogFactory.getLogger(FormatoPagareGrupalListIMPL.class);

	// private Services services = new Services();

	@Reference
	private ICTSServiceIntegration serviceIntegration;

	public static List<MemberDTO> getAllGroupMembers(GroupLoanInfResponse[] aPromissoryNoteInfResp, String aSessionId, ICTSServiceIntegration aServiceIntegration, Services aServices) {
		ArrayList<MemberDTO> dataBeanList = new ArrayList<MemberDTO>();
		if (logger.isDebugEnabled()) {
			logger.logDebug("*****>>Inicia getAllGroupMembers");
		}

		GroupLoanInfResponse[] wGroupLoanInfResponseList;
		MemberDTO wMemberDTO;
		String wApplication = "";
		CreditPaymentsDTO wPayment = new CreditPaymentsDTO();
		List<CreditPaymentsDTO> aPaymentsList;

		if (aPromissoryNoteInfResp != null && aPromissoryNoteInfResp.length > 0) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("*****>>getAllGroupMembers - size:" + aPromissoryNoteInfResp.length);
			}
			for (int i = 0; i < aPromissoryNoteInfResp.length; i++) {
				wMemberDTO = new MemberDTO();

				if (logger.isDebugEnabled()) {
					logger.logDebug("promissoryNoteInfResp[i].getNumberSeq()= " + aPromissoryNoteInfResp[i].getNumberSeq());
					logger.logDebug("promissoryNoteInfResp[i].getCustomerName()= " + aPromissoryNoteInfResp[i].getCustomerName());
				}

				if (aPromissoryNoteInfResp[i].getIndivSolicitudeId() != 0) {
					wApplication = String.valueOf(aPromissoryNoteInfResp[i].getIndivSolicitudeId());
					aPaymentsList = new ArrayList<CreditPaymentsDTO>();
					if (logger.isDebugEnabled()) {
						logger.logDebug("Iniciando Consulta de Tabla Amortizacion: " + aPromissoryNoteInfResp[i].getIndivSolicitudeId());
					}
					wGroupLoanInfResponseList = aServices.getSearchGroupCreditPaymentList(aSessionId, wApplication, aServiceIntegration);
					if (logger.isDebugEnabled()) {
						logger.logDebug("Items Tabla Amort: " + wGroupLoanInfResponseList.length);
					}
					for (int j = 0; j < wGroupLoanInfResponseList.length; j++) {
						wPayment = new CreditPaymentsDTO();
						wPayment.setNumberSeq(wGroupLoanInfResponseList[j].getNumberSeq());
						wPayment.setAmount(Functions.getStringCurrencyFormated(wGroupLoanInfResponseList[j].getMaxAmount()));
						wPayment.setDueDate(Functions.convertCalendarToString(wGroupLoanInfResponseList[j].getDueDate(), ConstantValue.valueConstant.DF_DDMMYYYY));
						if (logger.isDebugEnabled()) {
							logger.logDebug("FormatoPagareGrupalListIMPL.getPaymentsList - FOR INI ");
							logger.logDebug("groupLoanInfResponseList - NumberSeq:" + wGroupLoanInfResponseList[j].getNumberSeq());
							logger.logDebug("groupLoanInfResponseList - DueDate: " + wGroupLoanInfResponseList[j].getDueDate());
						}
						aPaymentsList.add(wPayment);
					}
					wMemberDTO.setListaPagos(aPaymentsList);

				}
				if (aPromissoryNoteInfResp[i].getCustomerName() != null) {
					wMemberDTO.setNombresMiembro(aPromissoryNoteInfResp[i].getCustomerName());
				} else {
					wMemberDTO.setNombresMiembro("");
				}
				if (aPromissoryNoteInfResp[i].getMaxAmount() != null) {
					wMemberDTO.setMonto(Functions.getStringCurrencyFormated(aPromissoryNoteInfResp[i].getMaxAmount()));
				} else {
					wMemberDTO.setMonto("");
				}
				if (aPromissoryNoteInfResp[i].getAmountInLetter() != null) {
					wMemberDTO.setMontoLetras(aPromissoryNoteInfResp[i].getAmountInLetter());
				} else {
					wMemberDTO.setMontoLetras("");
				}
				if (aPromissoryNoteInfResp[i].getInterest() != null) {
					wMemberDTO.setPorcentajeAnual(String.valueOf(aPromissoryNoteInfResp[i].getInterest()));
				} else {
					wMemberDTO.setPorcentajeAnual("");
				}
				if (aPromissoryNoteInfResp[i].getAddress() != null) {
					wMemberDTO.setDireccion(String.valueOf(aPromissoryNoteInfResp[i].getAddress()));
				} else {
					wMemberDTO.setDireccion("");
				}

				wMemberDTO.setFechaLetras(Functions.fechaN(Calendar.getInstance()));

				dataBeanList.add(wMemberDTO);
			}
			return dataBeanList;

		}
		return null;
	}
}
