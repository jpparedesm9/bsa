package com.cobiscorp.cobis.busin.customevents.events;

import java.math.BigDecimal;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.QuoteManagement;
import com.cobiscorp.cobis.busin.model.DisbursementIncome;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ChangeDisbursementValue extends BaseEvent implements IChangedEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(ChangeDisbursementValue.class);

	public ChangeDisbursementValue(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs arg1) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Ingreso -> IChangedEvent -> ChangeDisbursementValue");
		try{
			DataEntity disbursementIncome = entities.getEntity(DisbursementIncome.ENTITY_NAME);
			BigDecimal balanceOperation = new BigDecimal(0);
			balanceOperation = disbursementIncome.get(DisbursementIncome.BALANCEOPERATION).setScale(2, BigDecimal.ROUND_HALF_UP);
			LOGGER.logDebug("balanceOperation: " + balanceOperation + "Valor DESembolso:"  + disbursementIncome.get(DisbursementIncome.DISBURSEMENTVALUE));
			/*if (!balanceOperation.equals(new BigDecimal(disbursementIncome.get(DisbursementIncome.DISBURSEMENTVALUE)).setScale(2, BigDecimal.ROUND_HALF_UP))) {
				return;
			} else {*/
				int currencyLoan = Integer.parseInt(disbursementIncome.get(DisbursementIncome.CURRENCYOP));
				int currencyDisbursement = Integer.parseInt(disbursementIncome.get(DisbursementIncome.CURRENCY));
				Double disbursementValue = disbursementIncome.get(DisbursementIncome.DISBURSEMENTVALUE);

				disbursementIncome.set(DisbursementIncome.DISBURSEMENTVALUEDEC, disbursementValue);
				CatalogManagement catalogMngmnt = new CatalogManagement(super.getServiceIntegration());
				int localCurrency = Integer.parseInt(catalogMngmnt.getParameter("MLO", "ADM", arg1, new BehaviorOption(true)).getParameterValue());

				if (currencyLoan == currencyDisbursement) {
					disbursementIncome.set(DisbursementIncome.CURRENTBALANCE, new BigDecimal(disbursementValue));
				} else {
					QuoteManagement quoteManager = new QuoteManagement(super.getServiceIntegration());
					Double valueInCurrencyLoan;
					if (currencyLoan == localCurrency) { // SI <MONEDA_OPERACION> ESTA EN <MONEDA_LOCAL> - OBTENGO EL MONTO EN <MONEDA_LOCAL>
						valueInCurrencyLoan = quoteManager.exchangeForeignToLocal(currencyLoan, currencyDisbursement, disbursementValue, arg1, new BehaviorOption(true));
					} else { // SI<MONEDA_OPERACION> ESTA EN <OTRA_MONEDA> - OBTENGO EL MONTO EN <MONEDA_OPERACION>
						valueInCurrencyLoan = quoteManager.exchangeLocalToForeign(currencyDisbursement, currencyLoan, disbursementValue, arg1, new BehaviorOption(true));
					}
					LOGGER.logDebug("valueInCurrencyLoan: " + valueInCurrencyLoan);
					disbursementIncome.set(DisbursementIncome.CURRENTBALANCE, new BigDecimal(valueInCurrencyLoan));
				}
				LOGGER.logDebug("currencyDisbursement: " + currencyDisbursement + " " + "localCurrency" + localCurrency);
				if (currencyDisbursement != localCurrency) {
					BigDecimal quotationDS = new BigDecimal(disbursementIncome.get(DisbursementIncome.QUOTATION));
					BigDecimal disbursementValueDec = new BigDecimal(disbursementIncome.get(DisbursementIncome.DISBURSEMENTVALUEDEC));
					disbursementIncome.set(DisbursementIncome.VALUEML, disbursementValueDec.multiply(quotationDS).setScale(2, BigDecimal.ROUND_HALF_UP));
				} else {
					disbursementIncome.set(DisbursementIncome.VALUEML, new BigDecimal(disbursementIncome.get(DisbursementIncome.DISBURSEMENTVALUE)));
				}
			//}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.DISBURSEMENTINCOME_CHANGE_VALUE, e, arg1, LOGGER);
		}

		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Salida -> IChangedEvent -> ChangeDisbursementValue");
	}

}
