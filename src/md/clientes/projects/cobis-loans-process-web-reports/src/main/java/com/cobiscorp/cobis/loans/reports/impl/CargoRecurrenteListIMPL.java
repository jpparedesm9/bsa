package com.cobiscorp.cobis.loans.reports.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.apache.felix.scr.annotations.Reference;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.GroupLoanInfResponse;

//import com.cobiscorp.cobis.busin.flcre.commons.utiles.SessionContext;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Functions;
import com.cobiscorp.cobis.loans.reports.dto.MemberChargesDTO;

public class CargoRecurrenteListIMPL {
	private static final ILogger logger = LogFactory.getLogger(CargoRecurrenteListIMPL.class);
	@Reference
	private ICTSServiceIntegration serviceIntegration;

	public static List<MemberChargesDTO> getAllRecurringChargeMembers(GroupLoanInfResponse[] recurringChargeResponses, String sessionId, ICTSServiceIntegration serviceIntegration2) {
		ArrayList<MemberChargesDTO> dataBeanList = new ArrayList<MemberChargesDTO>();
		logger.logDebug("*****>>Inicia CargoRecurrenteListIMPL.getAllRecurringChargeMembers(..) ");

		if (recurringChargeResponses != null && recurringChargeResponses.length > 0) {

			logger.logDebug("*****>>CargoRecurrenteListIMPL- getAllRecurringChargeMembers(..) :: recurringChargeResponses.length= " + recurringChargeResponses.length);

			for (int i = 0; i < recurringChargeResponses.length; i++) {
				MemberChargesDTO memberChargesDTO = new MemberChargesDTO();
				if (recurringChargeResponses[i].getCustomerName() != null) {
					memberChargesDTO.setNombreCliente(recurringChargeResponses[i].getCustomerName());
				} else {
					memberChargesDTO.setNombreCliente("");
				}
				if (recurringChargeResponses[i].getAccountNumber() != null) {
					memberChargesDTO.setNumeroTarjetaCuenta(recurringChargeResponses[i].getAccountNumber());
				} else {
					memberChargesDTO.setNumeroTarjetaCuenta("");
				}
				if (recurringChargeResponses[i].getMaxAmount() != null) {
					memberChargesDTO.setMontoMaximoFijo(Functions.getStringCurrencyFormated(recurringChargeResponses[i].getMaxAmount()));
				} else {
					memberChargesDTO.setMontoMaximoFijo(String.valueOf(0));
				}
				if (recurringChargeResponses[i].getPeriodicity() != null) {
					memberChargesDTO.setPeriodicidadPago(recurringChargeResponses[i].getPeriodicity());
				} else {
					memberChargesDTO.setPeriodicidadPago("");
				}
				if (recurringChargeResponses[i].getDueDate() != null) {
					memberChargesDTO.setFechaVencimiento(Functions.convertCalendarToString(recurringChargeResponses[i].getDueDate(), ConstantValue.valueConstant.DF_DDMMYYYY));
				} else {
					memberChargesDTO.setFechaVencimiento("");
				}
				if (recurringChargeResponses[i].getCreditNumber() != null) {
					memberChargesDTO.setNumeroCredito(recurringChargeResponses[i].getCreditNumber());
				} else {
					memberChargesDTO.setNumeroCredito("");
				}
				if (recurringChargeResponses[i].getWeeklyAmountToPay() != null) {
					memberChargesDTO.setImporteSemanaAPagar(Functions.getStringCurrencyFormated(recurringChargeResponses[i].getWeeklyAmountToPay()));
				}
				// if (SessionContext.getProcessDate() != null) {
				memberChargesDTO.setFechaProceso(Functions.convertCalendarToString(recurringChargeResponses[i].getSettlementDate(), ConstantValue.valueConstant.DF_DDMMYYYY));
				// }
				memberChargesDTO.setClaveBancariaEst("");
				dataBeanList.add(memberChargesDTO);
			}
			return dataBeanList;
		}
		return null;
	}

}
