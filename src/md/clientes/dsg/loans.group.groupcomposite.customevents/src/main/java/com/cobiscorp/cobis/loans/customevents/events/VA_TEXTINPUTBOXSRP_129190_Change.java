package com.cobiscorp.cobis.loans.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountRequest;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.commons.loansgroup.services.AmountManager;
import com.cobiscorp.cobis.loans.model.Amount;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class VA_TEXTINPUTBOXSRP_129190_Change extends BaseEvent implements IChangedEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(VA_TEXTINPUTBOXSRP_129190_Change.class);

	public VA_TEXTINPUTBOXSRP_129190_Change(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs arg1) {
		DataEntityList amount = entities.getEntityList(Amount.ENTITY_NAME);
		try {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("----------Ingreso a VA_TEXTINPUTBOXSRP_129190_Change");

			GroupLoanAmountRequest amountRequest = new GroupLoanAmountRequest();

			for (DataEntity row : amount) {
				amountRequest.setSolicitude(row.get(Amount.CREDIT));
				amountRequest.setCustomerId(row.get(Amount.MEMBERID));
				if (row.get(Amount.AMOUNT) != null) {
					amountRequest.setAmount(row.get(Amount.AMOUNT).doubleValue());
				}

				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("----------Ingreso a VA_TEXTINPUTBOXSRP_129190_Change - amount cambiado: " + row.get(Amount.AMOUNT));
				amountRequest.setGroupId(row.get(Amount.GROUPID));
			}

			AmountManager amountManager = new AmountManager(getServiceIntegration());

			String mensaje = amountManager.updateAmount(amountRequest, 2, arg1, new BehaviorOption(false, false));
			LOGGER.logDebug("<<<mensaje del registrar " + mensaje);

			if (mensaje.equals(null)) {
				arg1.getMessageManager().showErrorMsg("LOANS.LBL_LOANS_ERRORALAU_20688");
				arg1.setSuccess(false);
			} else {
				arg1.getMessageManager().showInfoMsg("LOANS.LBL_LOANS_REGISTRDE_81762");
				arg1.setSuccess(true);
			}

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Clients.UPDATE_AMOUNT, e, arg1, LOGGER);

		}
	}

}
