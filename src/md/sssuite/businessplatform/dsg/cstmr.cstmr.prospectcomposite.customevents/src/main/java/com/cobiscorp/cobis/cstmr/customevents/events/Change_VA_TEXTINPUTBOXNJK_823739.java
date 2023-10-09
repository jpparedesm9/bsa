package com.cobiscorp.cobis.cstmr.customevents.events;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.customevents.utils.Utils;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class Change_VA_TEXTINPUTBOXNJK_823739 extends BaseEvent implements IChangedEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(Change_VA_TEXTINPUTBOXNJK_823739.class);

	public Change_VA_TEXTINPUTBOXNJK_823739(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs arg1) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("---> Start Change_VA_TEXTINPUTBOXNJK_823739");
		}
		try {
			DataEntity naturalPerson = entities.getEntity(NaturalPerson.ENTITY_NAME);

			String documentType = naturalPerson.get(NaturalPerson.DOCUMENTTYPE);
			String documentNumber = naturalPerson.get(NaturalPerson.DOCUMENTNUMBER);

			Utils utils = new Utils();
			naturalPerson.set(NaturalPerson.DOCUMENTNUMBER, utils.validateDocumentNumber(documentType, documentNumber, getServiceIntegration(), arg1));

		} catch (Exception e) {
        	ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.VALIDATE_DOCUMENT_NUMBER, e, arg1, LOGGER);
		}

	}

}
