package com.cobiscorp.cobis.loans.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.business.commons.platform.services.OfficerManagement;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.BehaviorOption;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class LoadBussinessOfficer extends BaseEvent implements ILoadCatalog {

	private static final ILogger LOGGER = LogFactory.getLogger(LoadBussinessOfficer.class);

	public LoadBussinessOfficer(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, ILoadCatalogDataEventArgs arg1) {
		LOGGER.logDebug("---->LoadBussinessOfficer -- Ingreso");
		List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();

		try {

			OfficerManagement officerManagement = new OfficerManagement(getServiceIntegration());

			LOGGER.logDebug("---->Ejecucion de servicio para recuperar los Ejecutivos");

			for (CatalogDto catalogDto : officerManagement.getExecutive(arg1, new BehaviorOption(true))) {
				ItemDTO item = new ItemDTO();
				item.setCode(catalogDto.getCode().trim());
				item.setValue(catalogDto.getName());
				listItemDTO.add(item);
			}

			arg1.setSuccess(true);
			return listItemDTO;

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Clients.LOAD_BUSSINES_OFFICER, e, arg1, LOGGER);
		}

		return listItemDTO;
	}

}
