package com.cobiscorp.cobis.busin.view.customevents.change;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.model.EntidadInfo;
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

public class ChangeSegment extends BaseEvent implements IChangedEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(ChangeSegment.class);

	public ChangeSegment(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@SuppressWarnings("unchecked")
	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {

		try {

			LOGGER.logDebug("---->Entra al ChangeSegment");
			String productType = (String) args.getNewValue();

			LOGGER.logDebug("---->Recupera entidades");
			DataEntity generalData = entities.getEntity("generalData");
			DataEntity entidadInfo = entities.getEntity(EntidadInfo.ENTITY_NAME);

			QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());

			LOGGER.logError("---->Recupero el tipo de destino si en hipotecario o de consumo para enviar parametro");
			String segment = entidadInfo.get(EntidadInfo.SECTOR);
			String destinationType = "";

			if (segment != null && !segment.equals("labelOtroDestino")) {

				for (CatalogDto catalogDto : queryStoredProcedureManagement.getOtherDestinationBySegment(segment, null, args,
						new BehaviorOption(true))) {
					destinationType = catalogDto.getDescription1();
					break;
				}

				if (destinationType.equalsIgnoreCase("SCON")) {
					generalData.set(new Property<String>("labelOtroDestino", String.class), "Destino Consumo");
				} else if (destinationType.equalsIgnoreCase("SVIV")) {
					generalData.set(new Property<String>("labelOtroDestino", String.class), "Destino Hipotecario");
				} else {
					generalData.set(new Property<String>("labelOtroDestino", String.class), "Destino");
				}

			} else {
				generalData.set(new Property<String>("labelOtroDestino", String.class), "Destino");
			}

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.CHANGE_SEGMENT, e, args, LOGGER);
		}

	}

}
