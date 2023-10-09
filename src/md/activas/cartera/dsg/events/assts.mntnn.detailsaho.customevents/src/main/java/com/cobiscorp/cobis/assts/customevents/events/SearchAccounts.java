package com.cobiscorp.cobis.assts.customevents.events;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.CuentaGrupal;
import com.cobiscorp.cobis.assts.model.DetailsAho;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.assets.cloud.dto.GroupAccountRequest;
import cobiscorp.ecobis.assets.cloud.dto.GroupAccountResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class SearchAccounts extends BaseEvent implements IExecuteCommand {
	private static final ILogger logger = LogFactory
			.getLogger(SearchAccounts.class);

	public SearchAccounts(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		DataEntity searchAccounts = entities
				.getEntity(CuentaGrupal.ENTITY_NAME);
		DataEntityList searchAccountsGrid = entities
				.getEntityList(DetailsAho.ENTITY_NAME);

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		GroupAccountRequest requestInLoanRequest = new GroupAccountRequest();
		requestInLoanRequest.setGrupoAccount(searchAccounts
				.get(CuentaGrupal.CUENTAGRUPAL));
		serviceRequest.addValue("inGroupAccountRequest", requestInLoanRequest);

		ServiceResponse response = this.execute(logger,
				Parameter.SEARCHDETAILSACCOUNTS, serviceRequest);
		if (logger.isDebugEnabled()) {
			logger.logDebug("EJECUTA ACCION");
		}
		if (response.isResult()) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("TRAE DATA");
			}
			ServiceResponseTO resultado = (ServiceResponseTO) response
					.getData();
			searchAccountsGrid.clear();
			if (resultado.isSuccess()) {
				GroupAccountResponse[] clResponseList = (GroupAccountResponse[]) resultado
						.getValue("returnGroupAccountResponse");
				for (GroupAccountResponse r : clResponseList) {
					DataEntity item = new DataEntity();
					item.set(DetailsAho.OPERATION,
							r.getOperation());
					item.set(DetailsAho.ENTE, r.getClient());
					item.set(DetailsAho.NAMEENTE,
							r.getNameClient());
					item.set(DetailsAho.SALDO, r.getBalance());
					item.set(DetailsAho.INCENTIVE,
							r.getIncentive());
					item.set(DetailsAho.GAIN, r.getGain());
					searchAccountsGrid.add(item);
				}
				entities.setEntityList(DetailsAho.ENTITY_NAME, searchAccountsGrid);
			}

		} else {
			if (logger.isDebugEnabled()) {
				logger.logDebug("NO TRAE NADA");				
				logger.logDebug(response.getMessages());
			}
			String mensaje = GeneralFunction.getMessageError(
					response.getMessages(), null);

			args.getMessageManager().showErrorMsg(mensaje);
		}

	}

}
