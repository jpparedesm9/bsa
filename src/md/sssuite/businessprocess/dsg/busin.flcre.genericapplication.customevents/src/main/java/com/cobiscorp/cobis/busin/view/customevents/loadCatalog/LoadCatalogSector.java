package com.cobiscorp.cobis.busin.view.customevents.loadCatalog;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.fpm.bo.Sector;

public class LoadCatalogSector extends BaseEvent implements ILoadCatalog {
	private static final ILogger LOGGER = LogFactory.getLogger(LoadCatalogSector.class);

	public LoadCatalogSector(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs args) {

		LOGGER.logDebug("---->Variables");
		List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();

		try {

			LOGGER.logDebug("---->Entra al LoadCatalogSector");

			LOGGER.logError("---->Declaracion de TransactionManagement");
			QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());
			BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(getServiceIntegration());

			LOGGER.logDebug("---->Recupera entidades");
			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
			DataEntity generalData = entities.getEntity("generalData");
			String bankingProductID = originalHeader.get(OriginalHeader.PRODUCTTYPE) == null ? "" : originalHeader.get(OriginalHeader.PRODUCTTYPE);

			LOGGER.logDebug("---->Ejecucion de servicio para recuperar el sector desde apf");

			LOGGER.logDebug("LoadCatalogSector---->bankingProductID: " + bankingProductID);

			Sector sector = bankingProductManager.getBankingProductSector(args, bankingProductID);
			String portfolioType = sector.getCode();
			LOGGER.logDebug("LoadCatalogSector---->portfolioType: " + portfolioType);
			LOGGER.logDebug("LoadCatalogSector---->portfolioType: " + sector.getCode());

			LOGGER.logDebug("---->Ejecucion de servicio para recuperar lo segmentos");

			for (CatalogDto catalogDto : queryStoredProcedureManagement.getSegmentListByPortfolioType(portfolioType, args, new BehaviorOption(true))) {
				ItemDTO item = new ItemDTO();
				item.setCode(catalogDto.getCode().trim());
				item.setValue(catalogDto.getName());
				listItemDTO.add(item);
			}

			return listItemDTO;

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_CATALOG_SECTOR, e, args, LOGGER);
		}

		return listItemDTO;
	}

}
