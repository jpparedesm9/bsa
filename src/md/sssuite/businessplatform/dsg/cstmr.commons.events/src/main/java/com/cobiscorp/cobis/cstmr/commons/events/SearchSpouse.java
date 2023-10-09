package com.cobiscorp.cobis.cstmr.commons.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class SearchSpouse extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchSpouse.class);

	public SearchSpouse(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		try {
			LOGGER.logDebug("Start executeCommand in SearchSpouse");
			SpouseByCustomer searchBusiness = new SpouseByCustomer(getServiceIntegration());
			searchBusiness.searchSpouseByCustomer(entities, args);
		} catch (BusinessException e) {
			LOGGER.logDebug("Error al Recuperar Conyuge" , e);
			args.setSuccess(false);
			//args.getMessageManager().showErrorMsg("Error al Recuperar Conyuge del Cliente "+e.getMessage());
		} catch (Exception e) {
			LOGGER.logDebug("Error al Recuperar Negocios" , e);
			args.setSuccess(false);
			//args.getMessageManager().showErrorMsg("Error al Recuperar Conyuge del Cliente ");
		} finally {
			LOGGER.logDebug("Finish executeCommand in SearchSpouse");			
		}
	}

}
