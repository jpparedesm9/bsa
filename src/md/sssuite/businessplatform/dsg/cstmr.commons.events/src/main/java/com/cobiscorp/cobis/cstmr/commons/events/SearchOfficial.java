package com.cobiscorp.cobis.cstmr.commons.events;

import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.OfficialRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.OfficialResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.Official;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.TransferManager;

public class SearchOfficial extends BaseEvent implements IExecuteQuery {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchOfficial.class);

	public SearchOfficial(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, IExecuteQueryEventArgs arg1) {
		LOGGER.logDebug("Ingreso executeQuery SearchOfficial ");

		DataEntityList lista = new DataEntityList();
		DataEntity item = new DataEntity();
		int officeId =Integer.parseInt(arg0.getData().get("idOffice").toString());
		TransferManager transferManager = new TransferManager(this.getServiceIntegration());
		char esOrigen = arg0.getArgs().get("controlId").toString().equals("VA_OFFICIALORIGIII_648231")?'S':'N';
		
		LOGGER.logDebug("args controlId es: " + arg0.getArgs().get("controlId").toString());
		LOGGER.logDebug("esOrigen es: " + esOrigen);
		
		OfficialRequest officialRequest = new OfficialRequest();
		officialRequest.setOffice(officeId);
		officialRequest.setFlag(esOrigen);
		
		try {
			// Seteo del código del Grupo
			for (OfficialResponse officialResponse : transferManager.searchOfficial(officialRequest, arg1)) {
				item = new DataEntity();
				item.set(Official.NAMEOFFICIAL, officialResponse.getName());
				item.set(Official.STATUSOFFICIAL, officialResponse.getStatus());
				item.set(Official.USERNAMEOFFICIAL, officialResponse.getLogin());
				lista.add(item);
			}

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.SEARCH_OFFICER, e, arg1, LOGGER);
		}
		return lista.getDataList();
	}

}
