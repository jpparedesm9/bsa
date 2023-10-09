package com.cobiscorp.cobis.cstmr.commons.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.RelationRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.RelationResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.EconomicActivity;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.customer.commons.prospect.services.NaturalProspectManager;
import com.cobiscorp.ecobis.customer.commons.prospect.services.NaturalProspectRelationManager;

public class LoadRelationCatalog extends BaseEvent implements ILoadCatalog {

	private static final ILogger logger = LogFactory
			.getLogger(LoadRelationCatalog.class);

	public LoadRelationCatalog(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0,
			ILoadCatalogDataEventArgs arg1) {

		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia LoadRelationCatalog");
		}

		List<ItemDTO> items = new ArrayList<ItemDTO>();

		NaturalProspectRelationManager naturalProspectRelationManager = new NaturalProspectRelationManager(
				getServiceIntegration());
		try {
			RelationRequest relationRequest = new RelationRequest();
			relationRequest.setMode(0);
			RelationResponse[] relationsList = naturalProspectRelationManager
					.searchRelation(relationRequest, arg1);
			for (RelationResponse relationItem : relationsList) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("-->relationItem " + relationItem);
				}
				ItemDTO itemDTO = new ItemDTO();
				if (logger.isDebugEnabled()) {
					logger.logDebug("item [id:" + relationItem.getCode()
							+ ", value: " + relationItem.getDescription() + "]");
				}
				itemDTO.setCode(String.valueOf(relationItem.getCode()));
				itemDTO.setValue(relationItem.getDescription());
				items.add(itemDTO);
			}
			arg1.setSuccess(true);

		} catch (Exception ex) {
			arg1.setSuccess(false);
			 logger.logError("Error en la carga de catalogo de relaciones--> ",ex);
		}

		return items;
	}

}
