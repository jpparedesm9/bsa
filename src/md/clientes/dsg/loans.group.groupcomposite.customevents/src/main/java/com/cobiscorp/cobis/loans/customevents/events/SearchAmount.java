package com.cobiscorp.cobis.loans.customevents.events;

import java.math.BigDecimal;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountRequest;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.commons.loansgroup.services.AmountManager;
import com.cobiscorp.cobis.loans.model.Amount;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class SearchAmount extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchGroup.class);

	public SearchAmount(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		LOGGER.logDebug("Ingreso executeCommand SearchAmount");

		try {
			GroupLoanAmountRequest serviceRequest = new GroupLoanAmountRequest();
			DataEntity amountEntity = entities.getEntity(Amount.ENTITY_NAME);

			int amountCustomerId = amountEntity.get(Amount.MEMBERID);
			serviceRequest.setCustomerId(amountCustomerId);
			serviceRequest.setSolicitude(amountEntity.get(Amount.CREDIT));

			AmountManager amountManager = new AmountManager(getServiceIntegration());
			DataEntityList amounts = entities.getEntityList(Amount.ENTITY_NAME);

			GroupLoanAmountResponse responseAmountList[];
			LOGGER.logDebug(" Llama al servicio CalcAmount-->: ");
			amountManager.calcAmount(serviceRequest, args);
			LOGGER.logDebug(" Llama al servicio SearchAmount-->: ");
			responseAmountList = amountManager.searchAmount(serviceRequest, args);
			DataEntityList amountListEntity = new DataEntityList();

			for (GroupLoanAmountResponse amount : responseAmountList) {
				LOGGER.logDebug(" Recuperando data SearchAmount-->: ");
				amountEntity.set(Amount.MEMBERID, amount.getCustomerId());
				amountEntity.set(Amount.MEMBERNAME, amount.getCustumerName());
				if (amount.getAuthorizedAmount() != null) {
					amountEntity.set(Amount.AMOUNT, new BigDecimal(amount.getAmount()));
				} else {
					amountEntity.set(Amount.AMOUNT, new BigDecimal(0));
				}

				if (amount.getAmount() != null) {
					amountEntity.set(Amount.AUTHORIZEDAMOUNT, new BigDecimal(amount.getAuthorizedAmount()));
				} else {
					amountEntity.set(Amount.AUTHORIZEDAMOUNT, new BigDecimal(0));
				}

				// Nuevos campos
				amountEntity.set(Amount.CYCLEPARTICIPATION, amount.getCycleParticipation());

				if (amount.getVoluntarySavings() != null) {
					amountEntity.set(Amount.VOLUNTARYSAVINGS, new BigDecimal(amount.getVoluntarySavings()));
				} else {
					amountEntity.set(Amount.VOLUNTARYSAVINGS, new BigDecimal(0));
				}

				if (amount.getProposedMaximumSaving() != null) {
					amountEntity.set(Amount.PROPOSEDMAXIMUMSAVING, new BigDecimal(amount.getProposedMaximumSaving()));
				} else {
					amountEntity.set(Amount.PROPOSEDMAXIMUMSAVING, new BigDecimal(0));
				}
				LOGGER.logDebug(amount.getCheckRenapo());
				amountEntity.set(Amount.CHECKRENAPO, amount.getCheckRenapo());
				amountListEntity.add(amountEntity);
			}
			LOGGER.logDebug("Mapeando entidad designer SearchAmount-->: ");
			entities.setEntityList(Amount.ENTITY_NAME, amounts);
		}

		catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Clients.SEARCH_AMOUNT, e, args, LOGGER);
		}
	}
}
