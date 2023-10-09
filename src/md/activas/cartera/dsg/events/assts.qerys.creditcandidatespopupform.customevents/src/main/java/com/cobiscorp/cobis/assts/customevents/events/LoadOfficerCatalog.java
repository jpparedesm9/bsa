package com.cobiscorp.cobis.assts.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.CreditCandidatesRequest;
import cobiscorp.ecobis.assets.cloud.dto.OfficerCreditCandidatesResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.services.CreditCandidatesManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class LoadOfficerCatalog extends BaseEvent implements ILoadCatalog {

	private static final ILogger LOGGER = LogFactory.getLogger(LoadOfficerCatalog.class);

	public LoadOfficerCatalog(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs eventArgs) {
		List<ItemDTO> items = new ArrayList<ItemDTO>();
		try {
			CreditCandidatesRequest candidatesRequest = new CreditCandidatesRequest();

			CreditCandidatesManagement candidatesManager = new CreditCandidatesManagement(getServiceIntegration());
			OfficerCreditCandidatesResponse[] documentTypeList = candidatesManager.officerCandidates(candidatesRequest, eventArgs);
			for (OfficerCreditCandidatesResponse item : documentTypeList) {
				LOGGER.logDebug("-->OfficerCandidates");
				ItemDTO itemDTO = new ItemDTO();
				LOGGER.logDebug("item [code:" + item.getCode() + ", value: " + item.getName() + "]");
				itemDTO.setCode(Integer.toString(item.getCode()));
				itemDTO.setValue(item.getName());
				items.add(itemDTO);
			}

		} catch (Exception e) {
			ExceptionUtils.showError("Error al consultar funcionarios", e, eventArgs, LOGGER);
		}
		return items;
	}

}
