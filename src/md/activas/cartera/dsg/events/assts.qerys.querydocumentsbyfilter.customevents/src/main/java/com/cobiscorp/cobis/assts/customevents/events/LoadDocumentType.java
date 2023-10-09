package com.cobiscorp.cobis.assts.customevents.events;

import java.util.List;
import java.util.ArrayList;

import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.assets.cloud.dto.DocumentTypeResponse;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;

public class LoadDocumentType extends BaseEvent implements ILoadCatalog {
	private static final ILogger LOGGER = LogFactory.getLogger(LoadDocumentType.class);

	public LoadDocumentType(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs args) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Ingreso executeDataEvent clase LoadDocumentType");
		}

		List<ItemDTO> lista = new ArrayList<ItemDTO>();
		ServiceRequestTO request = new ServiceRequestTO();
		try {

			ServiceResponse response = this.execute(getServiceIntegration(), LOGGER, Parameter.QUERYDOCUMENTTYPES, request);

			if (response != null && response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response.getData();

				DocumentTypeResponse[] docTypeResponses = (DocumentTypeResponse[]) resultado.getValue(Parameter.RETURNDOCUMENTTYPES);

				if (docTypeResponses != null) {
					for (DocumentTypeResponse docType : docTypeResponses) {
						if (LOGGER.isDebugEnabled()) {
							LOGGER.logDebug("INGRESA MAPEO");
						}
						ItemDTO item = new ItemDTO();
						item.setCode(docType.getCode() == null ? null : docType.getCode());
						item.setValue(docType.getValue());
						lista.add(item);
					}
				}
			} else {
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("INCORRECTO");
				}
			}
		} catch (Exception ex) {

			LOGGER.logError("Error en la clase LoadDocumentType: " + ex);

		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finaliza executeDataEvent clase LoadDocumentType");
			}

		}
		args.setSuccess(true);

		return lista;
	}

}
