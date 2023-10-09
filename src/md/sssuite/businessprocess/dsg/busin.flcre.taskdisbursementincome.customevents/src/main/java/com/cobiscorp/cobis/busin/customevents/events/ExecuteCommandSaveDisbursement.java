package com.cobiscorp.cobis.busin.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.LoanRequest;
import cobiscorp.ecobis.loan.dto.ReadDisbursementFormResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.DisbursementManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.Validate;
import com.cobiscorp.cobis.busin.model.DisbursementIncome;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ExecuteCommandSaveDisbursement extends BaseEvent implements
		IExecuteCommand {
	private static final ILogger LOGGER = LogFactory
			.getLogger(DisbursementManagement.class);

	public ExecuteCommandSaveDisbursement(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		try {
			LoanRequest loanRequest = new LoanRequest();
			DataEntity entityDisbursement = entities
					.getEntity(DisbursementIncome.ENTITY_NAME);

			loanRequest.setRoyalBank(entityDisbursement
					.get(DisbursementIncome.OPERATIONID));
			loanRequest.setShellbank(entityDisbursement
					.get(DisbursementIncome.OPERATIONID));
			// loanRequest.setCotizOp(entityDisbursement.get(DisbursementIncome.QUOTATION));
			loanRequest.setAccount(entityDisbursement
					.get(DisbursementIncome.ACCOUNT));
			loanRequest.setOfficeChg(Integer.parseInt(entityDisbursement
					.get(DisbursementIncome.OFFICE)));
			if (Validate.Strings
					.isNotNullOrEmptyOrWhiteSpace(entityDisbursement
							.get(DisbursementIncome.IMPOFFICE))) {
				loanRequest.setOfficePrinterChg(Integer
						.parseInt(entityDisbursement
								.get(DisbursementIncome.IMPOFFICE)));
			}
			loanRequest.setBeneficiary(entityDisbursement
					.get(DisbursementIncome.COMMENT));
			loanRequest.setAmountDs(entityDisbursement
					.get(DisbursementIncome.DISBURSEMENTVALUE));
			loanRequest.setCurrencyDs(Integer.parseInt(entityDisbursement
					.get(DisbursementIncome.CURRENCY)));
			loanRequest.setCotizDs(entityDisbursement
					.get(DisbursementIncome.QUOTATION));
			loanRequest.setCurrencyOP(Integer.parseInt(entityDisbursement
					.get(DisbursementIncome.CURRENCYOP)));
			loanRequest.setCotizOp(entityDisbursement.get(
					DisbursementIncome.QUOTATIONOP).doubleValue());
			loanRequest.setDescription(entityDisbursement
					.get(DisbursementIncome.DESCRIPTION));
			loanRequest.setObservation(entityDisbursement
					.get(DisbursementIncome.OBSERVATIONS));
			loanRequest.setAmountDsDec(entityDisbursement
					.get(DisbursementIncome.DISBURSEMENTVALUEDEC));

			String[] disbursementForm = entityDisbursement.get(
					DisbursementIncome.DISBURSEMENTFORM).split("/");
			loanRequest.setProduct(disbursementForm[0]);
			loanRequest.setTcotizOp(Mnemonic.CHAR_N);
			loanRequest.setTCotisDs(Mnemonic.CHAR_N);

			// desde el front-end llega el valor correcto
			loanRequest.setIsGroup(entityDisbursement
					.get(DisbursementIncome.ISGROUP));
			// en interciclos no llega groupId
			if (entityDisbursement.get(DisbursementIncome.GROUPID) != null) {
				loanRequest.setGroupId(entityDisbursement
						.get(DisbursementIncome.GROUPID));
			}

			loanRequest.setOperationNumber(entityDisbursement
					.get(DisbursementIncome.OPERATIONNUMBER));

			DisbursementManagement disbursementMngmt = new DisbursementManagement(
					super.getServiceIntegration());
			ReadDisbursementFormResponse[] listDisbursementForm = disbursementMngmt
					.createDisbursementForm(loanRequest, args,
							new BehaviorOption(true));
			if (listDisbursementForm != null) {
				for (ReadDisbursementFormResponse readDisbursementFormResponse : listDisbursementForm) {
					entityDisbursement.set(DisbursementIncome.SEQUENTIAL,
							readDisbursementFormResponse.getSequential());
					entityDisbursement.set(DisbursementIncome.DISBURSEMENTID,
							readDisbursementFormResponse.getDisbursementId());
					// entityDisbursement.set(DisbursementIncome.VALUEML,
					// Convert.DoubleToBigDecimal(readDisbursementFormResponse.getAmountmn(),
					// new BigDecimal(0)));
					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug(":>:>ExecuteCommandSaveDisbursement xx getDisbursementId:>:>"
								+ readDisbursementFormResponse
										.getDisbursementId());
						LOGGER.logDebug(":>:>ExecuteCommandSaveDisbursement: getDisbursementrate>:>"
								+ readDisbursementFormResponse
										.getDisbursementrate());
						LOGGER.logDebug(":>:>ExecuteCommandSaveDisbursement: getCurrency>:>"
								+ readDisbursementFormResponse.getCurrency());
						LOGGER.logDebug(":>:>ExecuteCommandSaveDisbursement: getCurrencyDescription>:>"
								+ readDisbursementFormResponse
										.getCurrencyDescription());
						LOGGER.logDebug(":>:>ExecuteCommandSaveDisbursement: getAmount>:>"
								+ readDisbursementFormResponse.getAmount());
						LOGGER.logDebug(":>:>ExecuteCommandSaveDisbursement: getContributionRate>:>"
								+ readDisbursementFormResponse
										.getContributionRate());
						LOGGER.logDebug(":>:>ExecuteCommandSaveDisbursement: getSequential>:>"
								+ readDisbursementFormResponse.getSequential());

					}
				}
			}
			args.setSuccess(true);
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.DISBURSEMENTINCOME_EXECUTE_SAVE, e, args, LOGGER);
		}

	}

}
