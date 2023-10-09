package com.cobiscorp.cobis.assts.customevents.events;

import java.util.Date;

import cobiscorp.ecobis.assets.cloud.dto.LoanExtendsQuota;
import cobiscorp.ecobis.assets.cloud.dto.LoanExtendsQuotaRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.ExtendsQuota;
import com.cobiscorp.cobis.assts.model.ExtendsQuotaExt;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.api.util.ServerParamUtil;
import com.cobiscorp.designer.common.BaseEvent;

public class ExtendsQuotaChangeEvent extends BaseEvent implements IChangedEvent {

	private static final ILogger logger = LogFactory
			.getLogger(ExtendsQuotaChangeEvent.class);

	public ExtendsQuotaChangeEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {
		try {

			ServiceRequestTO request = new ServiceRequestTO();
			DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
			DataEntity extedsQuota = entities
					.getEntity(ExtendsQuota.ENTITY_NAME);

			Date parseProcessDate = GeneralFunction.convertStringToDate(
					ServerParamUtil.getProcessDate(),
					Parameter.TYPEDATEFORMAT.MMDDYYYY);

			if (extedsQuota.get(ExtendsQuota.EXTENDSDATE).compareTo(
					extedsQuota.get(ExtendsQuota.EXPIRATIONDATE)) > 0) {

				LoanExtendsQuotaRequest loanExtendsQuotaRequest = new LoanExtendsQuotaRequest();
				loanExtendsQuotaRequest.setOperation(Parameter.OPERATIONI);
				loanExtendsQuotaRequest.setMode(Parameter.MODEA);
				loanExtendsQuotaRequest.setBank(loan.get(Loan.LOANBANKID));
				loanExtendsQuotaRequest.setDate(GeneralFunction
						.convertDateToString(parseProcessDate, true));
				loanExtendsQuotaRequest.setDateFormat(Parameter.CODEDATEFORMAT);

				loanExtendsQuotaRequest.setQuota(extedsQuota
						.get(ExtendsQuota.NUMBERQUOTA));

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
				loansResponse(entities, response, args);
			} else {

				args.getMessageManager()
						.showErrorMsg(
								"ASSTS.MSG_ASSTS_LAFECHARR_87749");

			}
		} catch (Exception ex) {
			logger.logError("ERROR: " + ex);
		}

	}

	private void loansResponse(DynamicRequest entities,
			ServiceResponse response, IChangedEventArgs args) {
		try {

			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();
				if (resultado.isSuccess()) {

					LoanExtendsQuota[] itemsResponseArray = (LoanExtendsQuota[]) resultado
							.getValue("returnLoanExtendsQuota");

					DataEntityList listaLoanExtendsQuota = entities
							.getEntityList(ExtendsQuotaExt.ENTITY_NAME);
					listaLoanExtendsQuota.clear();
					
									
					for (LoanExtendsQuota r : itemsResponseArray) {
						DataEntity item = new DataEntity();
						item.set(ExtendsQuotaExt.QUOTAEXT, r.getQuotaNumber());
						item.set(ExtendsQuotaExt.STARTDATEEXT, r.getStartDate());
						item.set(ExtendsQuotaExt.ENDDATEEXT,
								r.getExpirationDate());
						item.set(ExtendsQuotaExt.CAPITALEXT,
								r.getCapitalPayment());
						item.set(ExtendsQuotaExt.INTERESTEXT,
								r.getInterestPayment());
						item.set(ExtendsQuotaExt.OTHERS, r.getOthersPayment());
						item.set(ExtendsQuotaExt.TOTAL, r.getFullPayment());
						item.set(ExtendsQuotaExt.STATE, r.getState());

						listaLoanExtendsQuota.add(item);
					}

				}

			} else {
				String mensaje = GeneralFunction.getMessageError(
						response.getMessages(), null);
				args.getMessageManager().showErrorMsg(mensaje);
			}
		} catch (Exception ex) {
			logger.logError("ERROR: " + ex);
		}

	}
}
