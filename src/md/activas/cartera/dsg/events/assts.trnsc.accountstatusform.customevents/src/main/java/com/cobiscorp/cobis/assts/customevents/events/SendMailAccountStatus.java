package com.cobiscorp.cobis.assts.customevents.events;

import java.util.Calendar;

import cobiscorp.ecobis.assets.cloud.dto.AccountStatusRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assets.commons.services.AccounStateManagement;
import com.cobiscorp.cobis.assts.model.AccountStatus;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class SendMailAccountStatus extends BaseEvent implements IExecuteCommand {

	private static final ILogger logger = LogFactory.getLogger(SendMailAccountStatus.class);

	public SendMailAccountStatus(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		try {
			boolean flag = true;
			AccounStateManagement accounStateManagement = new AccounStateManagement(getServiceIntegration());
			args.setSuccess(true);
			logger.logDebug("Ingresa a executeCommand de SendMailAccountStatus");
			char state = 'P';

			DataEntityList accountStatus = entities.getEntityList(AccountStatus.ENTITY_NAME);

			AccountStatusRequest accountStatusRequest = new AccountStatusRequest();

			for (DataEntity debtorEntity : accountStatus) {
				if (debtorEntity.get(AccountStatus.TOPRINT) == true) {
					accountStatusRequest.setBanco(debtorEntity.get(AccountStatus.BANKNUMBER));
					accountStatusRequest.setEmail(debtorEntity.get(AccountStatus.EMAIL));
					logger.logDebug("ExecuteCommand de SendMailAccountStatus-debtorEntity.get(AccountStatus.DATE):" + debtorEntity.get(AccountStatus.DATE) + " Num Banco:"
							+ debtorEntity.get(AccountStatus.BANKNUMBER));
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(debtorEntity.get(AccountStatus.DATE));
					logger.logDebug("ExecuteCommand de SendMailAccountStatus-calendar:" + calendar);
					accountStatusRequest.setFecha(calendar);
					accountStatusRequest.setState(state);

					if (!accounStateManagement.getCreateStateAccount(accountStatusRequest, args, new BehaviorOption(true))) {
						flag = false;
						args.getMessageManager().showErrorMsg(
								"Error con: " + debtorEntity.get(AccountStatus.CLIENTID) + " - " + debtorEntity.get(AccountStatus.CLIENTNAME) + " - " + debtorEntity.get(AccountStatus.BANKNUMBER));
					}
				}
			}
			logger.logDebug("ExecuteCommand de SendMailAccountStatus-valor de flag:" + flag);
			if (flag) {
				args.getMessageManager().showInfoMsg(Parameter.SUCCESSFUL_TRANSACTION);
			}
		} catch (Exception e) {
			ExceptionUtils.showError("Error al ejecutar", e, args, logger);
		}
	}
}
