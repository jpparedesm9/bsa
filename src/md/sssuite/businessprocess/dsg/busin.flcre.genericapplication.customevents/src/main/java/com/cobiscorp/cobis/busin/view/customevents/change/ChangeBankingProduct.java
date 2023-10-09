package com.cobiscorp.cobis.busin.view.customevents.change;

import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.model.EntidadInfo;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.Property;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.fpm.bo.Sector;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;

public class ChangeBankingProduct extends BaseEvent implements IChangedEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(ChangeBankingProduct.class);

	public ChangeBankingProduct(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@SuppressWarnings("unchecked")
	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {

		try {

			LOGGER.logDebug("---->Entra al ChangeBankingProduct");
			String productType = (String) args.getNewValue();

			LOGGER.logDebug("---->Recupera entidades");
			DataEntity generalData = entities.getEntity("generalData");
			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
			DataEntity entidadInfo = entities.getEntity(EntidadInfo.ENTITY_NAME);

			LOGGER.logDebug("---->Transacition Manager");
			BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(getServiceIntegration());
			QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());

			LOGGER.logDebug("---->Recupera el nombre del producto que se esta atendiendo");
			String productName = bankingProductManager.getProductName(args, productType);
			generalData.set(new Property<String>("productTypeName", String.class, false), productName);
			originalHeader.set(OriginalHeader.PRODUCTTYPE, productType);
			entidadInfo.set(EntidadInfo.TIPOPRODUCTO, productType);

			LOGGER.logDebug("---->Recupera los parametros configurados en el apf si el tramite es nulo");

			LOGGER.logDebug("---->Recupero los parametros del plazo");
			List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(args, productType,
					"Plazo");
			for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
				originalHeader.set(OriginalHeader.TERM, generalParametersValuesHistory.getValue());
			}

			LOGGER.logDebug("---->Recupero los parametros del tipo de frecuencia");
			generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(args, productType, "Tipo de cuota");
			for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
				originalHeader.set(OriginalHeader.PAYMENTFREQUENCY, generalParametersValuesHistory.getValue());
			}
			
			LOGGER.logDebug("---->Ejecucion de servicio para recuperar el sector");
			Sector sector = bankingProductManager.getBankingProductSector(args, productType);
			originalHeader.set(OriginalHeader.PORTFOLIOTYPE, sector.getCode());
			generalData.set(new Property<String>("loanType", String.class, false), sector.getDescription());

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.CHANGE_BAKING_PRODUCT, e, args, LOGGER);
		}

	}

}
