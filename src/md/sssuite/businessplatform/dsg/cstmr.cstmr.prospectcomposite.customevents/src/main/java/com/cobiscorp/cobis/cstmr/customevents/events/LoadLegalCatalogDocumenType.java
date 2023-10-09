package com.cobiscorp.cobis.cstmr.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.LoadDocument;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class LoadLegalCatalogDocumenType extends BaseEvent implements ILoadCatalog {

	private static final ILogger LOGGER = LogFactory.getLogger(LoadLegalCatalogDocumenType.class);

	public LoadLegalCatalogDocumenType(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);		
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs arg1) {

		try {

			LOGGER.logDebug("----->LoadCatalogDocumenType");
			LoadDocument loadDocument = new LoadDocument();
			return loadDocument.loadDocumentCatalogByPersonType('C', arg1, getServiceIntegration());

		} catch (Exception e) {
        	ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.LOADCATALOG_DOCUMENT_TYPE, e, arg1, LOGGER);
		}
		return new ArrayList<ItemDTO>();
	}
}
