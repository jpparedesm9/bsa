package com.cobiscorp.cobis.assts.customevents.events;

import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;

import cobiscorp.ecobis.assets.cloud.dto.AccountStatusRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

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

public class GenerateSequential extends BaseEvent implements IExecuteCommand {
	private static final ILogger LOGGER = LogFactory.getLogger(GenerateSequential.class);

	public GenerateSequential(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs arg1) {
		LOGGER.logDebug("Start GenerateSequential");
		try {
			AccounStateManagement accounStateManagement = new AccounStateManagement(getServiceIntegration());
			Integer sequential = 0;
			DataEntityList accountStatus = entities.getEntityList(AccountStatus.ENTITY_NAME);

			AccountStatusRequest accountStatusRequest = new AccountStatusRequest();
			accountStatusRequest.setSequential(sequential);

			for (DataEntity accountStatusEntity : accountStatus) {

				if (accountStatusEntity.get(AccountStatus.TOPRINT)) {
					LOGGER.logDebug("--->> GenerateSequential - NumBanco:" + accountStatusEntity.get(AccountStatus.BANKNUMBER));
					Calendar date = DateToCalendar(accountStatusEntity.get(AccountStatus.DATE));
					accountStatusRequest.setFecha(date);

					accountStatusRequest.setBanco(accountStatusEntity.get(AccountStatus.BANKNUMBER));
					accountStatusRequest.setOperacion("S");
					sequential = accounStateManagement.generateSequential(accountStatusRequest, arg1, new BehaviorOption(true));
					accountStatusEntity.set(AccountStatus.SEQUENTIAL, sequential);
				}
			}
		} catch (Exception e) {
			ExceptionUtils.showError("Error al ejecutar", e, arg1, LOGGER);
		}
	}

	public static Calendar DateToCalendar(Date date) throws ParseException {
		Calendar cal = null;
		cal = Calendar.getInstance();
		cal.setTime(date);
		return cal;
	}
}
