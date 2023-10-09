package com.cobiscorp.cobis.busin.view.customevents.events;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.busin.flcre.commons.bli.Expromission_BLI;
import com.cobiscorp.cobis.busin.flcre.commons.bli.VW_ORIAHEADER86_BLI;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
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
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ChangeVA_ORIAHEADER8602_URQT595 extends BaseEvent implements IChangedEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(ChangeVA_ORIAHEADER8602_URQT595.class);

	public ChangeVA_ORIAHEADER8602_URQT595(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {
		try{
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Ingreso IChangedEvent -> ChangeVA_ORIAHEADER8602_URQT595");

			String taskId = args.getParameters().getTaskId();
			if (taskId.equals("T_FLCRE_97_EXOSO06")) {
				Expromission_BLI.changeCurrencyRequested(entities, args, super.getServiceIntegration());
			} else if (taskId.equals("T_FLCRE_69_EFNCY93")) {
				VW_ORIAHEADER86_BLI.changeCurrencyRequestedInReprogramming(entities, args, super.getServiceIntegration());
			} else if(taskId.equals("T_FLCRE_82_OIIRL51"))
			{
				LOGGER.logDebug("---->Entra al ChangeVA_ORIAHEADER8602_URQT595");

				LOGGER.logError("---->Declaracion de TransactionManagement");
				QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());

				LOGGER.logDebug("---->Recupera entidades");
				DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
				DataEntity generalData = entities.getEntity("generalData");
				LOGGER.logDebug("---->Variables");
				List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();

				if (originalHeader != null) {

					//String segment = originalHeader.get(EntidadInfo.SECTOR) == null ? "" : entidadInfo.get(EntidadInfo.SECTOR);
					//String destination = originalHeader.get(EntidadInfo.DESTINOFINANCIERO) == null ? "" : entidadInfo.get(EntidadInfo.DESTINOFINANCIERO);
					
					String moneda = originalHeader.get(OriginalHeader.CURRENCYREQUESTED);
					LOGGER.logDebug("Valor de la moneda"+moneda);
					LOGGER.logDebug("---->Ejecucion de servicio para recuperar lo segmentos");

					try {
						LOGGER.logDebug("---->Entra a recuperar valores change");
						for (CatalogDto catalogDto : queryStoredProcedureManagement.getNemonic(args,
								new BehaviorOption(true))) {
							if(catalogDto.getCode().trim().equals(moneda)){
								LOGGER.logDebug("getCode: "+catalogDto.getCode());
								LOGGER.logDebug("getName: "+catalogDto.getName());
								LOGGER.logDebug("getDescription1: "+catalogDto.getDescription1());
								LOGGER.logDebug("getDescription2: "+catalogDto.getDescription2());
								generalData.set(new Property<String>("symbolCurrency", String.class, false), catalogDto.getDescription1());
								generalData.set(new Property<String>("mnemonicCurrency", String.class, false), catalogDto.getDescription2());
							}
						}

					} catch (Exception e) {
						LOGGER.logError("Error al cargar ChangeVA_ORIAHEADER8602_URQT595", e);
					}
				}
			}else{
				VW_ORIAHEADER86_BLI.changeCurrencyRequested(entities, args, super.getServiceIntegration());
			}

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Salida IChangedEvent -> ChangeVA_ORIAHEADER8602_URQT595");
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_CHANGE_MONEDA_595, e, args, LOGGER);
		}
		
	}

}