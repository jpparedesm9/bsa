package com.cobiscorp.cobis.busin.view.customevents.loadCatalog;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.busin.model.LoanHeader;
import com.cobiscorp.cobis.busin.model.OfficerAnalysis;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.fpm.model.CurrencyProductHistory;

public class LoadCatalogCurrencyByProduct extends BaseEvent implements ILoadCatalog {
	private static final ILogger LOGGER = LogFactory.getLogger(LoadCatalogCurrencyByProduct.class);

	public LoadCatalogCurrencyByProduct(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs args) {

		LOGGER.logDebug("---->Entra al LoadCatalogCurrencyByProduct");

		LOGGER.logError("---->Declaracion de TransactionManagement");
		CatalogManagement catalogManagement = new CatalogManagement(this.getServiceIntegration());
		BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(getServiceIntegration());

		LOGGER.logDebug("---->Recupera entidades");
		DataEntity officer = entities.getEntity(OfficerAnalysis.ENTITY_NAME);
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		DataEntity loanHeader = entities.getEntity(LoanHeader.ENTITY_NAME);// en la etapa de formas de desembolso-> detalle
		DataEntity paymentPlanHeader = entities.getEntity(PaymentPlanHeader.ENTITY_NAME);

		LOGGER.logDebug("---->Variables");
		String bankingProductID = "";
		if (originalHeader != null && originalHeader.get(OriginalHeader.PRODUCTTYPE) != null) {
			bankingProductID = originalHeader.get(OriginalHeader.PRODUCTTYPE) == null ? "" : originalHeader.get(OriginalHeader.PRODUCTTYPE);
		} else if (loanHeader != null && loanHeader.get(LoanHeader.PRODUCTTYPE) != null) {
			bankingProductID = loanHeader.get(LoanHeader.PRODUCTTYPE) == null ? "" : loanHeader.get(LoanHeader.PRODUCTTYPE);
		}

		List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();

		try {

			LOGGER.logDebug("---->Recupero las monedas configuaradas en el  catalogo");
			List<ItemDTO> listItemCurrencies = (List<ItemDTO>) catalogManagement.getCurrencyByProduct("", args);

			LOGGER.logDebug("---->Recupero las monedas configuaradas en el  APF");
			LOGGER.logDebug("---->getCurrencybyProduct------>" + bankingProductID);

			List<CurrencyProductHistory> bankingProducthistoryCurrencies = bankingProductManager.getCurrencybyProduct(args, bankingProductID);

			for (ItemDTO currencies : listItemCurrencies) {
				for (CurrencyProductHistory currencyProductHistory : bankingProducthistoryCurrencies) {
					currencies.getValue();
					LOGGER.logDebug("MonedagetCode: "+currencies.getCode());
					LOGGER.logDebug("MonedagetValue: "+currencies.getValue());
					LOGGER.logDebug("MonedagetCurrencyId: "+currencyProductHistory.getCurrencyId());
					LOGGER.logDebug("MonedagetgetStatus: "+currencyProductHistory.getStatus());
					if (currencies.getCode().trim().equalsIgnoreCase(currencyProductHistory.getCurrencyId().trim())) {
						listItemDTO.add(currencies);
					}
				}
			}

			return listItemDTO;

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_CATALOG_CURRENCY_PRODUCT, e, args, LOGGER);
		}

		return listItemDTO;
	}

}
