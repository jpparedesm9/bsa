package com.cobiscorp.cobis.busin.customevents.executeCommand;

//import javax.ejb.TransactionManagement;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.LoanRequest;

import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.model.GeneralParameterLoan;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

/**
 * @author srojas
 * 
 */
public class ExecuteCommandVA_VWPAYMENLA2621_0000855 extends BaseEvent implements IExecuteCommand {
	private static ILogger LOGGER = LogFactory.getLogger(ExecuteCommandVA_VWPAYMENLA2621_0000855.class);

	public ExecuteCommandVA_VWPAYMENLA2621_0000855(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs arg1) {
		// TODO Auto-generated method stub
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("ExecuteCommandVA_VWPAYMENLA2621_0000855 starts executeCommand");
		try {

			DataEntity generalParameterLoan = entities.getEntity(GeneralParameterLoan.ENTITY_NAME);
			DataEntity paymentPlanHeader = entities.getEntity(PaymentPlanHeader.ENTITY_NAME);

			LoanRequest loanRequestDTO = new LoanRequest();
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("paymentPlanHeader.get(PaymentPlanHeader.WAYTOPAY)" + paymentPlanHeader.get(PaymentPlanHeader.WAYTOPAY));

			if (paymentPlanHeader.get(PaymentPlanHeader.WAYTOPAY) == null) {
				loanRequestDTO.setPaymentWay("--");
			} else {
				loanRequestDTO.setPaymentWay(paymentPlanHeader.get(PaymentPlanHeader.WAYTOPAY).trim());
			}

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("paymentPlanHeader.get(PaymentPlanHeader.DEBITACCOUNT)" + paymentPlanHeader.get(PaymentPlanHeader.DEBITACCOUNT));
			loanRequestDTO.setAccount(paymentPlanHeader.get(PaymentPlanHeader.DEBITACCOUNT) == null ? "" : paymentPlanHeader.get(PaymentPlanHeader.DEBITACCOUNT));

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED)" + paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED));
			loanRequestDTO.setBank(paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED) + "");
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("generalParameterLoan.get(GeneralParameterLoan.PAYMENT)" + generalParameterLoan.get(GeneralParameterLoan.PAYMENT));
			loanRequestDTO.setApplicationType(generalParameterLoan.get(GeneralParameterLoan.PAYMENT));

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("generalParameterLoan.get(GeneralParameterLoan.ALLOWSRENEWAL)" + generalParameterLoan.get(GeneralParameterLoan.ALLOWSRENEWAL));
			if (generalParameterLoan.get(GeneralParameterLoan.ALLOWSRENEWAL) != null && !"".equals(generalParameterLoan.get(GeneralParameterLoan.ALLOWSRENEWAL))) {
				loanRequestDTO.setRenovation(generalParameterLoan.get(GeneralParameterLoan.ALLOWSRENEWAL).charAt(0));
			} else {
				loanRequestDTO.setRenovation('\0');
			}

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("generalParameterLoan.get(GeneralParameterLoan.ALLOWSPREPAY)" + generalParameterLoan.get(GeneralParameterLoan.ALLOWSPREPAY));
			if (generalParameterLoan.get(GeneralParameterLoan.ALLOWSPREPAY) != null && !"".equals(generalParameterLoan.get(GeneralParameterLoan.ALLOWSPREPAY))) {
				loanRequestDTO.setPrecancelation(generalParameterLoan.get(GeneralParameterLoan.ALLOWSPREPAY).charAt(0));
			} else {
				loanRequestDTO.setPrecancelation('\0');
			}

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("generalParameterLoan.get(GeneralParameterLoan.ACCEPTSADDITIONALPAYMENTS)" + generalParameterLoan.get(GeneralParameterLoan.ACCEPTSADDITIONALPAYMENTS));
			loanRequestDTO.setAcceptsAdditionalPayments((generalParameterLoan.get(GeneralParameterLoan.ACCEPTSADDITIONALPAYMENTS)==null)?'N':generalParameterLoan.get(GeneralParameterLoan.ACCEPTSADDITIONALPAYMENTS));

			if (generalParameterLoan.get(GeneralParameterLoan.ACCEPTSADDITIONALPAYMENTS) == 'S') {
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("generalParameterLoan.get(GeneralParameterLoan.PAYMENTTYPE)" + generalParameterLoan.get(GeneralParameterLoan.PAYMENTTYPE));
				if ("N".equals(generalParameterLoan.get(GeneralParameterLoan.PAYMENTTYPE))) {
					if (LOGGER.isDebugEnabled())
						LOGGER.logDebug("generalParameterLoan.get(GeneralParameterLoan.PAYMENTTYPE)" + generalParameterLoan.get(GeneralParameterLoan.PAYMENTTYPE));
					loanRequestDTO.setReductionType(generalParameterLoan.get(GeneralParameterLoan.PAYMENTTYPE).charAt(0));
				} else if ("E".equals(generalParameterLoan.get(GeneralParameterLoan.PAYMENTTYPE))) {
					if (LOGGER.isDebugEnabled())
						LOGGER.logDebug("generalParameterLoan.get(GeneralParameterLoan.EXTRAORDINARYEFFECTPAYMENT)"
								+ generalParameterLoan.get(GeneralParameterLoan.EXTRAORDINARYEFFECTPAYMENT));
					loanRequestDTO.setReductionType(generalParameterLoan.get(GeneralParameterLoan.EXTRAORDINARYEFFECTPAYMENT));
				}
			} else if (generalParameterLoan.get(GeneralParameterLoan.ACCEPTSADDITIONALPAYMENTS) == 'N') {
				loanRequestDTO.setReductionType(generalParameterLoan.get(GeneralParameterLoan.PAYMENTTYPE) == null ? '\0' : generalParameterLoan.get(
						GeneralParameterLoan.PAYMENTTYPE).charAt(0));
			}

			loanRequestDTO.setReadjustable(generalParameterLoan.get(GeneralParameterLoan.EXCHANGERATE));
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("generalParameterLoan.get(GeneralParameterLoan.PERIODICITY)" + generalParameterLoan.get(GeneralParameterLoan.PERIODICITY));
			loanRequestDTO.setReadjustmentPeriod(generalParameterLoan.get(GeneralParameterLoan.PERIODICITY));
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("generalParameterLoan.get(GeneralParameterLoan.READJUSTMENTPERIODICITY)" + generalParameterLoan.get(GeneralParameterLoan.READJUSTMENTPERIODICITY));
			loanRequestDTO.setDailyReadjustment(generalParameterLoan.get(GeneralParameterLoan.READJUSTMENTPERIODICITY));
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("generalParameterLoan.get(GeneralParameterLoan.ESPECIALREADJUSTMENT)" + generalParameterLoan.get(GeneralParameterLoan.ESPECIALREADJUSTMENT));
			loanRequestDTO.setEspecialReadjustment(generalParameterLoan.get(GeneralParameterLoan.ESPECIALREADJUSTMENT));

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("generalParameterLoan.get(GeneralParameterLoan.INTERESTPAYMENT)" + generalParameterLoan.get(GeneralParameterLoan.INTERESTPAYMENT));
			loanRequestDTO.setPaymentType(generalParameterLoan.get(GeneralParameterLoan.INTERESTPAYMENT));

			loanRequestDTO.setCompleteQuota('N');
			loanRequestDTO.setCalculateTable('N');

			TransactionManagement transactionManagement = new TransactionManagement(getServiceIntegration());
			if (transactionManagement.UpdateLoanTmp(loanRequestDTO, arg1)) {
				arg1.getMessageManager().showSuccessMsg("BUSIN.DLB_BUSIN_OPINCSATE_87941");
			} else {
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("Error UpdateLoanTmp in ExecuteCommandVA_VWPAYMENLA2621_0000855");
				arg1.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_UJERDOEAN_89022");
			}
			
		} catch (Exception ex) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_CATALOG_OPERATIONS, ex, arg1, LOGGER);
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("ExecuteCommandVA_VWPAYMENLA2621_0000855 finishes executeCommand");
		}

	}
}
