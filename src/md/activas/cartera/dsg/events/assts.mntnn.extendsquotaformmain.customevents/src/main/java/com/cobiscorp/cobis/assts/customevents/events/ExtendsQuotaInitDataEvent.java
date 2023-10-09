package com.cobiscorp.cobis.assts.customevents.events;

import java.text.SimpleDateFormat;
import java.util.Date;

import cobiscorp.ecobis.assets.cloud.dto.LoanExtendsQuota;
import cobiscorp.ecobis.assets.cloud.dto.LoanExtendsQuotaRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assets.commons.sessions.AssetsSessionManager;
import com.cobiscorp.cobis.assts.model.CurrentQuotas;
import com.cobiscorp.cobis.assts.model.ExtendsQuota;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanInstancia;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.api.util.ServerParamUtil;
import com.cobiscorp.designer.common.BaseEvent;

public class ExtendsQuotaInitDataEvent extends BaseEvent implements
		IInitDataEvent {

	public ExtendsQuotaInitDataEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	private static final ILogger logger = LogFactory
			.getLogger(ExtendsQuotaInitDataEvent.class);

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Start executeDataEvent - RL");
		}

		DataEntity loanInstance = entities.getEntity(LoanInstancia.ENTITY_NAME);
		DataEntity loanSession = (DataEntity) AssetsSessionManager
				.getLoan(loanInstance.get(LoanInstancia.IDINSTANCIA));
		if (loanSession != null) {
			entities.setEntity(Loan.ENTITY_NAME, loanSession);
		}
		ExtendsQuota(entities, args);
		if (getServiceIntegration() == null && logger.isDebugEnabled()) {
				logger.logInfo("getServiceIntegration is null - RL ");
		}

	}

	private void ExtendsQuota(DynamicRequest entities, IDataEventArgs args) {
		try {

			ServiceRequestTO request = new ServiceRequestTO();
			DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
			DataEntity extedsQuota = entities
					.getEntity(ExtendsQuota.ENTITY_NAME);

			Date parseProcessDate = GeneralFunction.convertStringToDate(
					ServerParamUtil.getProcessDate(),
					Parameter.TYPEDATEFORMAT.MMDDYYYY);

			extedsQuota.set(ExtendsQuota.EXTENDSDATE, parseProcessDate);
			extedsQuota.set(ExtendsQuota.PROCESSDATE, parseProcessDate);
			extedsQuota.set(ExtendsQuota.MAXIMUMDATEEXTENDED,
					loan.get(Loan.EXPIRATIONDATE));

			LoanExtendsQuotaRequest loanExtendsQuotaRequest = new LoanExtendsQuotaRequest();
			loanExtendsQuotaRequest.setOperation(Parameter.OPERATIONQ);
			loanExtendsQuotaRequest.setBank(loan.get(Loan.LOANBANKID));
			loanExtendsQuotaRequest.setDate(GeneralFunction
					.convertDateToString(
							extedsQuota.get(ExtendsQuota.EXTENDSDATE), true));
			loanExtendsQuotaRequest.setDateFormat(Parameter.CODEDATEFORMAT);

			request.addValue("inLoanExtendsQuotaRequest",
					loanExtendsQuotaRequest);
			ServiceResponse response = this.execute(logger,
					Parameter.PROCESSEXTENDSQUOTA, request);
			loansResponse(entities, response, args);
		} catch (Exception ex) {
			manageException(ex, logger);
			args.getMessageManager().showErrorMsg("ASSTS.MSG_ASSTS_ERRORALTO_67419");

		}
	}

	private void loansResponse(DynamicRequest entities,
			ServiceResponse response, IDataEventArgs args) {
		try {

			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();
				if (resultado.isSuccess()) {

					LoanExtendsQuota[] itemsResponseArray = (LoanExtendsQuota[]) resultado
							.getValue("returnLoanExtendsQuota");

					DataEntityList listaLoanExtendsQuota = entities
							.getEntityList(CurrentQuotas.ENTITY_NAME);

					SimpleDateFormat formatter = new SimpleDateFormat(

					"dd/MM/yyyy");

					for (LoanExtendsQuota r : itemsResponseArray) {
						DataEntity item = new DataEntity();
						item.set(CurrentQuotas.QUOTA, r.getQuotaNumber());
						item.set(CurrentQuotas.STARTDATE, r.getStartDate());
						item.set(CurrentQuotas.ENDDATE,
								formatter.parse(r.getExpirationDate()));
						item.set(CurrentQuotas.CAPITAL, r.getCapitalPayment());
						item.set(CurrentQuotas.INTEREST, r.getInterestPayment());
						item.set(CurrentQuotas.OTHERS, r.getOthersPayment());
						item.set(CurrentQuotas.TOTAL, r.getFullPayment());
						item.set(CurrentQuotas.STATE, r.getState());
						listaLoanExtendsQuota.add(item);
					}
				}
			} else {
				args.setSuccess(false);
				String mensaje = GeneralFunction.getMessageError(
						response.getMessages(), null);
				args.getMessageManager().showErrorMsg(mensaje);
			}
		} catch (Exception ex) {
			logger.logError("ERROR: " + ex);
		}

	}

}
