package com.cobiscorp.cobis.asscr.customevents.form.events;

import com.cobiscorp.cobis.asscr.model.LoginCallCenter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.callcenter.commons.services.LoginCallCenterManager;

import cobiscorp.ecobis.bussinescallcenter.dto.LoginCallCenterRequest;
import cobiscorp.ecobis.bussinescallcenter.dto.LoginCallCenterResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class SearchDataClient extends BaseEvent implements IExecuteCommand {

	private static final ILogger logger = LogFactory.getLogger(SearchDataClient.class);

	public SearchDataClient(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	@Override
	public void executeCommand(DynamicRequest arg0, IExecuteCommandEventArgs arg1) {

		logger.logDebug("--------------->>> Inicia executeCommand SearchDataClients");

		DataEntity loginClient = arg0.getEntity(LoginCallCenter.ENTITY_NAME);
		
		logger.logDebug("DataEntity loginClient -->" + loginClient);
		logger.logDebug("LoginCallCenter.IDCLIENTE -->" + loginClient.get(LoginCallCenter.IDCLIENTE));

		Integer codigoCliente = loginClient.get(LoginCallCenter.IDCLIENTE);
		
		logger.logDebug("Código del Cliente: "+ codigoCliente);
		
		LoginCallCenterRequest loginCallCenterRequest = new LoginCallCenterRequest();

		loginCallCenterRequest.setIdCodCliente(codigoCliente);
		loginCallCenterRequest.setProcedencia("R");

		LoginCallCenterManager loginCallCenterManager = new LoginCallCenterManager(getServiceIntegration());

		//logger.logDebug("loginCallCenterManager1-->");
		//logger.logDebug("loginCallCenterManager-->" + loginCallCenterManager.searchLoginClient(loginCallCenterRequest, arg1));
		//logger.logDebug("Despues CenterManager-->");

		LoginCallCenterResponse loginCallCenterResponse = loginCallCenterManager.searchLoginClient(loginCallCenterRequest, arg1);

		if (loginCallCenterResponse != null) {
			logger.logDebug("loginCallCenterResponse.getcodigoRegistro-->" + loginClient.get(LoginCallCenter.IDCODREGISTER));
			logger.logDebug("loginCallCenterResponse.getIdClient()-->" + loginCallCenterResponse.getIdClient());
			logger.logDebug("loginCallCenterResponse.getInstProc()-->" + loginCallCenterResponse.getInstProc());
			logger.logDebug("loginCallCenterResponse.getAccount()-->" + loginCallCenterResponse.getAccount());
			loginClient.set(LoginCallCenter.IDCLIENTE, loginCallCenterResponse.getIdClient());
			loginClient.set(LoginCallCenter.PROCESSINST, loginCallCenterResponse.getInstProc());
			loginClient.set(LoginCallCenter.OPRATION, loginCallCenterResponse.getAccount());
		}else {
			logger.logDebug("loginCallCenterResponse: "+ loginCallCenterResponse);
			logger.logDebug("Entidad: " + loginClient.getData());
			loginClient.set(LoginCallCenter.IDCLIENTE, null);
			arg1.setSuccess(false);
		}
		
		logger.logDebug("--------------->>> Finaliza executeCommand SearchDataClients");

	}

}
