package com.cobiscorp.cobis.busin.view.customevents.change;

import java.util.List;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
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
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.fpm.bo.Sector;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class ChangeOffice extends BaseEvent implements IChangedEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(ChangeOffice.class);

	public ChangeOffice(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@SuppressWarnings("unchecked")
	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {

		try {

			LOGGER.logDebug("---->Entra al ChangeOffice");
			String productType = (String) args.getNewValue();

			LOGGER.logDebug("---->Recupera entidades");
			DataEntity entidadInfo = entities.getEntity(EntidadInfo.ENTITY_NAME);

			QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());

			LOGGER.logError("---->Recupero el tipo de destino si en hipotecario o de consumo para enviar parametro");
			String office = entidadInfo.get(EntidadInfo.OFICINA);
			String nameLocation = "";
			String codeLocation = "";
			LOGGER.logDebug("office: "+office);
			if (office != null) {

				for (CatalogDto catalogDto : queryStoredProcedureManagement.getLocationByOffice(office, args,
						new BehaviorOption(true))) {
					nameLocation = catalogDto.getName();
					codeLocation = catalogDto.getCode();
					break;
				}
				entidadInfo.set(EntidadInfo.UBICACION, codeLocation);
				LOGGER.logDebug("UBICACION NOMBRE: "+entidadInfo.get(EntidadInfo.UBICACION));
				LOGGER.logDebug("UBICACION CODIGO: "+codeLocation);

			} else {
				entidadInfo.set(EntidadInfo.UBICACION, "");
			}

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.CHANGE_OFFICE, e, args, LOGGER);
		}


	}
}
