package com.cobiscorp.cobis.assts.customevents.events;

import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assts.customevents.baseevents.QuotaDetailBaseEvent;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class QuotaInitDataEvents extends BaseEvent implements IInitDataEvent {

	private static final ILogger logger = LogFactory
			.getLogger(QuotaInitDataEvents.class);

	public QuotaInitDataEvents(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities,
			IDataEventArgs eventArgs) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia executeDataEvent de QuotaInitDataEvents");
		}

		try {

			QuotaDetailBaseEvent quotaDetail = new QuotaDetailBaseEvent(
					getServiceIntegration());
			DataEntityList quotaPayment = quotaDetail.quotaDetailPayment(entities);
			if (quotaPayment != null) {
				eventArgs.setSuccess(true);
			}

		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Exception --> " + e);
			}
			this.manageException(e, logger);
		}
	}

	public String getSpsMessages(List<Message> messages) {
		if (messages != null) {
			StringBuilder messagesString = new StringBuilder();
			for (Message message : messages) {
				messagesString.append(message.getMessage());
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug(" MENSAJES: " + messagesString);
			}
			return messagesString.toString();
		}
		return null;
	}
}
