package com.cobiscorp.cobis.assts.customevents.events;

import java.math.BigDecimal;
import java.util.Date;

import cobiscorp.ecobis.assets.cloud.dto.LoanExtendsQuotaRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.ExtendsQuotaEvent;
import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.ExtendsQuota;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.api.util.ServerParamUtil;
import com.cobiscorp.designer.common.BaseEvent;

public class ExtendsQuotaCommandEvent extends BaseEvent implements
		IExecuteCommand {

	public ExtendsQuotaCommandEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	private static final ILogger logger = LogFactory
			.getLogger(ExtendsQuotaInitDataEvent.class);

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		try {

			ServiceRequestTO request = new ServiceRequestTO();
			DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
			DataEntity extedsQuota = entities
					.getEntity(ExtendsQuota.ENTITY_NAME);
			Date parseProcessDate = GeneralFunction.convertStringToDate(
					ServerParamUtil.getProcessDate(),
					Parameter.TYPEDATEFORMAT.MMDDYYYY);

			if (extedsQuota.get(ExtendsQuota.NUMBERQUOTA) != null) {

				LoanExtendsQuotaRequest loanExtendsQuotaRequest = new LoanExtendsQuotaRequest();
				loanExtendsQuotaRequest.setOperation(Parameter.OPERATIONI);
				loanExtendsQuotaRequest.setMode(Parameter.MODEB);
				loanExtendsQuotaRequest.setBank(loan.get(Loan.LOANBANKID));
				loanExtendsQuotaRequest.setDate(GeneralFunction
						.convertDateToString(parseProcessDate, true));
				loanExtendsQuotaRequest.setDateFormat(Parameter.CODEDATEFORMAT);
				loanExtendsQuotaRequest.setQuota(extedsQuota
						.get(ExtendsQuota.NUMBERQUOTA));

				loanExtendsQuotaRequest.setCalculateValue(BigDecimal
						.valueOf(Parameter.CALCULATEVALUE));

				loanExtendsQuotaRequest.setExpirationDate(GeneralFunction
						.convertDateToString(
								extedsQuota.get(ExtendsQuota.EXPIRATIONDATE),
								true));

				loanExtendsQuotaRequest.setDateMaxExtension(GeneralFunction
						.convertDateToString(extedsQuota
								.get(ExtendsQuota.MAXIMUMDATEEXTENDED), true));

				loanExtendsQuotaRequest
						.setDateExtension(GeneralFunction.convertDateToString(
								extedsQuota.get(ExtendsQuota.EXTENDSDATE), true));

				request.addValue("inLoanExtendsQuotaRequest",
						loanExtendsQuotaRequest);
				ServiceResponse response = this.execute(logger,
						Parameter.PROCESSQUERYLOANEXTENDSQUOTA, request);
				loansResponse(response, args);

				ExtendsQuotaEvent extendsQuotaEvent = new ExtendsQuotaEvent(
						this.getServiceIntegration());
				extendsQuotaEvent.extendscuotaQ(entities);
			}

			else {

				args.getMessageManager().showErrorMsg(
						"ASSTS.MSG_ASSTS_ELNMEROEB_37843");

			}
		} catch (Exception ex) {
			manageException(ex, logger);
			args.getMessageManager().showErrorMsg("ASSTS.MSG_ASSTS_ERRORALTO_67419");

		}
	}

	private void loansResponse(ServiceResponse response, IExecuteCommandEventArgs args) {
		GeneralFunction.handleResponse(args, response, null);

	}
}
