package com.cobiscorp.cobis.wrrnt.event;

import cobiscorp.ecobis.collateral.dto.GuaranteeTranRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.wrrnt.commons.utils.Constant;
import com.cobiscorp.cobis.wrrnt.commons.utils.Function;
import com.cobiscorp.cobis.wrrnt.model.GenericTransaction;
import com.cobiscorp.cobis.wrrnt.model.Warranty;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.api.util.SessionUtil;
import com.cobiscorp.designer.common.BaseEvent;

public class ExecuteCommandSave extends BaseEvent implements IExecuteCommand {

	public ExecuteCommandSave(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}


	private static final ILogger LOGGER = LogFactory
			.getLogger(ExecuteCommandSave.class);
	

	public void liberateGuarantee(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		if (LOGGER.isDebugEnabled()){
			LOGGER.logDebug("LIBERATE GUARANTEE***");
		}
		
		Integer filial=1;
		Integer office=1;
		
		
		if (SessionUtil.getFilial()!=null)
		{
		filial = Integer.parseInt(SessionUtil.getFilial());
		}
		if (SessionUtil.getOffice()!=null)
		{
		office = Integer.parseInt(SessionUtil.getOffice());
		}
		
		DataEntity warranty = entities.getEntity(Warranty.ENTITY_NAME);
		DataEntity genericTransaction = entities.getEntity(GenericTransaction.ENTITY_NAME);
		
		
		if (LOGGER.isDebugEnabled()){
			LOGGER.logDebug("SessionUtil.getFilial()"+SessionUtil.getFilial());
			LOGGER.logDebug("SessionUtil.getUser()"+SessionUtil.getUser());
			LOGGER.logDebug("SessionUtil.getOffice()"+SessionUtil.getOffice());
						
		}
		
		ServiceRequestTO request = new ServiceRequestTO();
		GuaranteeTranRequest guaranteeTranRequest = new GuaranteeTranRequest();
		guaranteeTranRequest.setCompany(filial);
		guaranteeTranRequest.setOffice(office);;
		guaranteeTranRequest.setCustody(warranty.get(Warranty.CUSTODY));
		guaranteeTranRequest.setCustodyType(warranty.get(Warranty.TYPE));
		guaranteeTranRequest.setExternalCode(warranty.get(Warranty.EXTERNALCODE));
		guaranteeTranRequest.setQuery(Constant.CHAR_N);
		guaranteeTranRequest.setPass(Constant.CHAR_S);
		guaranteeTranRequest.setLogin(SessionUtil.getUser());
		guaranteeTranRequest.setDescription(genericTransaction.get(GenericTransaction.CAUSE));
		guaranteeTranRequest.setOperation(Constant.CHAR_S);
		guaranteeTranRequest.setMode(Constant.INT_0);
		guaranteeTranRequest.setOperation(Constant.CHAR_S);
		guaranteeTranRequest.setWeb(Constant.CHAR_S);
		
		request.addValue("inGuaranteeTranRequest", guaranteeTranRequest);
		ServiceResponse response = this.execute(getServiceIntegration(), LOGGER,
				com.cobiscorp.cobis.wrrnt.commons.utils.Constant.SERVICEGUARANTEELIBERATION, request);
		
		Function.handleResponse(args, response, null);
		
		
	}


	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		liberateGuarantee(entities, args);
		
	}

}
