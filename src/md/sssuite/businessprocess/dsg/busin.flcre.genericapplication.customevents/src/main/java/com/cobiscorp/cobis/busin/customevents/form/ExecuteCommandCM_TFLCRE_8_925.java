package com.cobiscorp.cobis.busin.customevents.form;

import com.cobiscorp.cobis.busin.model.Context;
import com.cobiscorp.cobis.busin.model.EntidadInfo;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.InsuranceManager;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loansbusiness.dto.InsuranceRequest;

public class ExecuteCommandCM_TFLCRE_8_925 extends BaseEvent implements IExecuteCommand {

	private final static String INDIVIDUAL = "INDIVIDUAL";

	public ExecuteCommandCM_TFLCRE_8_925(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		InsuranceManager insuranceManager = new InsuranceManager(getServiceIntegration());
		InsuranceRequest insuranceRequest = new InsuranceRequest();
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		DataEntity context = entities.getEntity(Context.ENTITY_NAME);
		DataEntity entidadInfo = entities.getEntity(EntidadInfo.ENTITY_NAME);

		String tramite = originalHeader.get(OriginalHeader.IDREQUESTED);
		Integer cliente = context.get(Context.CUSTOMERID);
		Integer plazoAsisMed = entidadInfo.get(EntidadInfo.TERMMEDICALASSISTANCE) != null ? Integer.valueOf(entidadInfo.get(EntidadInfo.TERMMEDICALASSISTANCE)) : null;
		if (tramite != null && cliente != null) {
			insuranceRequest.setSeCliente(String.valueOf(cliente));
			insuranceRequest.setSeTramite(Integer.valueOf(tramite));
			insuranceRequest.setSeGrupo(0);
			insuranceRequest.setSeProducto(INDIVIDUAL);
			insuranceRequest.setSeTipoSeguro(entidadInfo.get(EntidadInfo.INSURANCEPACKAGE));
			insuranceRequest.setSePlazoAsisMed(plazoAsisMed);
			insuranceManager.maintainInsurance(getServiceIntegration(), args, insuranceRequest);
		}
	}
}