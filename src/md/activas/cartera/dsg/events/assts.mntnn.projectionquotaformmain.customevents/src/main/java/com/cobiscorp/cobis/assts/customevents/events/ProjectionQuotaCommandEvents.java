package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.assets.cloud.dto.LoanResponse;
import cobiscorp.ecobis.assets.cloud.dto.LoanResponseRep;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.ProjectionQuota;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ProjectionQuotaCommandEvents extends BaseEvent implements
		IExecuteCommand {

	public ProjectionQuotaCommandEvents(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	private static final ILogger logger = LogFactory
			.getLogger(ProjectionQuotaCommandEvents.class);

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {

		DataEntity projection = entities.getEntity(ProjectionQuota.ENTITY_NAME);
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);

		applyProjecctionQuota(loan, projection, args);

	}

	public ServiceResponse applyProjecctionQuota(DataEntity loan,
			DataEntity projection, IExecuteCommandEventArgs args) {

		ServiceResponse response = null;
		ServiceRequestTO request = new ServiceRequestTO();
		LoanRequest loanRequestProjecctionQuota = new LoanRequest();
		loanRequestProjecctionQuota.setBank(loan.get(Loan.LOANBANKID));

		if (projection.get(ProjectionQuota.PROJECTIONDATE) != null

		|| projection.get(ProjectionQuota.PROJECTIONDAYS) != null) {

			loanRequestProjecctionQuota.setInitDate(GeneralFunction
					.convertDateToString(
							projection.get(ProjectionQuota.PROJECTIONDATE),
							true));
			loanRequestProjecctionQuota.setExpirationDays(projection
					.get(ProjectionQuota.PROJECTIONDAYS));
			if (projection.get(ProjectionQuota.TYPECALCULATION).equals("N")) {
				loanRequestProjecctionQuota.setTypeCharges('A');
			} else {
				loanRequestProjecctionQuota.setTypeCharges('P');
			}

			loanRequestProjecctionQuota.setDividend(Parameter.DIVIDEND);
			loanRequestProjecctionQuota.setDateFormat(Parameter.CODEDATEFORMAT);

			request.addValue("inLoanRequest", loanRequestProjecctionQuota);
			response = execute(getServiceIntegration(), logger,
					Parameter.PROCESSPROJECTIONQUOTA, request);
			if (response != null && response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();

				LoanResponse[] clResponseList = (LoanResponse[]) resultado
						.getValue("returnLoanResponse");

				logger.logDebug("RESPONSE  " + clResponseList);
				if (clResponseList != null) {
					for (LoanResponse clResponse : clResponseList) {

						projection.set(ProjectionQuota.CURRENTAMOUNTDUE,
								clResponse.getTotalValue());
						projection.set(ProjectionQuota.AMOUNTOVERDUE,
								clResponse.getAffectValue());

					}
				}

				LoanResponseRep[] clResponseLists = (LoanResponseRep[]) resultado
						.getValue("returnLoanResponseRep");
				if (clResponseLists != null) {
					for (LoanResponseRep clResponse : clResponseLists) {

						projection.set(ProjectionQuota.PREPAYMENTAMOUNT,
								clResponse.getPrepaymentAmount());
					}
				}

			} else {
				if (response != null && response.getMessages() != null) {
					logger.logDebug("*****************************************************Response"
							+ response.getMessages().toString());
					projection.set(ProjectionQuota.CURRENTAMOUNTDUE, null);
					projection.set(ProjectionQuota.AMOUNTOVERDUE, null);
					projection.set(ProjectionQuota.PREPAYMENTAMOUNT, null);

				}
			}

		} else {
			args.getMessageManager().showErrorMsg(
					"ASSTS.MSG_ASSTS_LAFECHAAI_30725");
			projection.set(ProjectionQuota.PROJECTIONDATE, null);
			projection.set(ProjectionQuota.PROJECTIONDAYS, null);
		}

		return response;

	}

}
