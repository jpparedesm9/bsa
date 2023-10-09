package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.customevents.utils.Utils;
import com.cobiscorp.cobis.cstmr.model.LegalPerson;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class Change_VA_TEXTINPUTBOXDXR_200739 extends BaseEvent implements IChangedEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(Change_VA_TEXTINPUTBOXDXR_200739.class);

	public Change_VA_TEXTINPUTBOXDXR_200739(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs arg1) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("---> Start Change_VA_TEXTINPUTBOXDXR_200739");
		}
		try {
			DataEntity legalPerson = entities.getEntity(LegalPerson.ENTITY_NAME);

			String documentType = legalPerson.get(LegalPerson.DOCUMENTTYPE);
			String documentNumber = legalPerson.get(LegalPerson.DOCUMENTNUMBER);

			Utils utils = new Utils();
			legalPerson.set(LegalPerson.DOCUMENTNUMBER, utils.validateDocumentNumber(documentType, documentNumber, getServiceIntegration(), arg1));

		}catch (Exception e) {
        	ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.VALIDATE_DOCUMENT_NUMBER, e, arg1, LOGGER);
		}

	}

}
