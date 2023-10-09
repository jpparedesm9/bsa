package com.cobiscorp.cobis.cstmr.commons.events;

import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.OfficeResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.Office;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.TransferManager;

public class SearchOffice extends BaseEvent implements IExecuteQuery {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchOffice.class);

	public SearchOffice(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, IExecuteQueryEventArgs arg1) {
		LOGGER.logDebug("Ingreso executeQuery SearchOffice ");

		DataEntityList lista = new DataEntityList();
	    DataEntity item = new DataEntity();
	    TransferManager transferManager = new TransferManager(this.getServiceIntegration());
	    try {
			//Seteo del código del Grupo
			LOGGER.logDebug("data: "+arg0.getData().toString());
			for ( OfficeResponse officeResponse : transferManager.searchOffice("admuser", arg1)) {
				item = new DataEntity();
				item.set(Office.IDOFFICE,officeResponse.getOfficeId() );
				item.set(Office.NAMEOFFICE,officeResponse.getOfficeName());
				lista.add(item);			
			}
			
		}catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.SEARCH_OFFICE, e, arg1, LOGGER);
		}
		return lista.getDataList();
	}
}
