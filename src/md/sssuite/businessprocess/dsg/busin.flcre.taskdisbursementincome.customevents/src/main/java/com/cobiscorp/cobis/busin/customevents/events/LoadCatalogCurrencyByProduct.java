package com.cobiscorp.cobis.busin.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.busin.model.DistributionEntity;
import com.cobiscorp.cobis.busin.model.LoanHeader;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
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

		LOGGER.logDebug("---->Entra al LoadCatalogSector");

		LOGGER.logError("---->Declaracion de TransactionManagement");
		CatalogManagement catalogManagement = new CatalogManagement(this.getServiceIntegration());
		BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(getServiceIntegration());

		LOGGER.logDebug("---->Recupera entidades");
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		DataEntity loanHeader = entities.getEntity(LoanHeader.ENTITY_NAME);// en la etapa de formas de desembolso-> detalle
		DataEntity distributionEntity = entities.getEntity(DistributionEntity.ENTITY_NAME);

		LOGGER.logDebug("---->Variables");
		String bankingProductID = "";
		if (originalHeader != null && originalHeader.get(OriginalHeader.PRODUCTTYPE) != null) {
			bankingProductID = originalHeader.get(OriginalHeader.PRODUCTTYPE) == null ? "" : originalHeader.get(OriginalHeader.PRODUCTTYPE);
		} else if (loanHeader != null && loanHeader.get(LoanHeader.PRODUCTTYPE) != null) {
			bankingProductID = loanHeader.get(LoanHeader.PRODUCTTYPE) == null ? "" : loanHeader.get(LoanHeader.PRODUCTTYPE);
		}else if(distributionEntity !=null && distributionEntity.get(DistributionEntity.TIPOOPERACION)!=null){
			bankingProductID = distributionEntity.get(DistributionEntity.TIPOOPERACION) == null ? "" : distributionEntity.get(DistributionEntity.TIPOOPERACION);
		}

		List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();

		try {
                        if (LOGGER.isDebugEnabled()) { 
			     LOGGER.logDebug("---->Recupero las monedas configuaradas en el  catalogo");
                        }
			List<ItemDTO> listItemCurrencies = (List<ItemDTO>) catalogManagement.getCurrencyByProduct("", args);

                        if (LOGGER.isDebugEnabled()) { 
			     LOGGER.logDebug("---->Recupero las monedas configuaradas en el  APF");
			     LOGGER.logDebug("---->getCurrencybyProduct------>" + bankingProductID);
                        }

			List<CurrencyProductHistory> bankingProducthistoryCurrencies = bankingProductManager.getCurrencybyProduct(args, bankingProductID);

			for (ItemDTO currencies : listItemCurrencies) {
                                if (LOGGER.isDebugEnabled()) {
				     LOGGER.logDebug("currencies 1"+currencies.getCode());
				     LOGGER.logDebug("currencies 2"+currencies.getValue());
                                }

				for (CurrencyProductHistory currencyProductHistory : bankingProducthistoryCurrencies) {
					LOGGER.logDebug("currencyProductHistory 1"+currencyProductHistory.getCurrencyId());
					if (currencies.getCode().trim().equalsIgnoreCase(currencyProductHistory.getCurrencyId().trim())) {
						listItemDTO.add(currencies);
					}
				}
			}

			return listItemDTO;

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.DISBURSEMENTINCOME_CATALOG_CURRENCY, e, args, LOGGER);
		}

		return listItemDTO;
	}

}
