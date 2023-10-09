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

public class LoadNaturalCatalogDocumenType extends BaseEvent implements ILoadCatalog {

	private static final ILogger LOGGER = LogFactory.getLogger(LoadNaturalCatalogDocumenType.class);

	public LoadNaturalCatalogDocumenType(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs arg1) {

		try {

			LOGGER.logDebug("----->LoadCatalogDocumenType");
			LoadDocument loadDocument = new LoadDocument();
			return loadDocument.loadDocumentCatalogByPersonType('P', arg1, getServiceIntegration());

		} catch (BusinessException bex) {
			LOGGER.logError("BusinessException: " + bex);
			arg1.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_OCURRIONR_93100");
		} catch (Exception ex) {
			LOGGER.logError("Exception: " + ex);
			arg1.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_OCURRIONR_93100");
		}  finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("---> Finish LoadNaturalCatalogDocumenType");
			}
		}
		return new ArrayList<ItemDTO>();
	}
}
