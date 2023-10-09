package com.cobiscorp.cobis.assets.commons.events;

import java.text.SimpleDateFormat;

import cobiscorp.ecobis.assets.cloud.dto.LoanExtendsQuota;
import cobiscorp.ecobis.assets.cloud.dto.LoanExtendsQuotaRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.CurrentQuotas;
import com.cobiscorp.cobis.assts.model.ExtendsQuota;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class ExtendsQuotaEvent extends BaseEvent {
	
	private static final ILogger logger = LogFactory
			.getLogger(AmortizationTable.class);

	public ExtendsQuotaEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	

	public void extendscuotaQ(DynamicRequest entities) {

		ServiceRequestTO request = new ServiceRequestTO();
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		DataEntity extedsQuota = entities.getEntity(ExtendsQuota.ENTITY_NAME);
		LoanExtendsQuotaRequest loanExtendsQuotaRequest = new LoanExtendsQuotaRequest();
		loanExtendsQuotaRequest.setOperation(Parameter.OPERATIONQ);
		loanExtendsQuotaRequest.setBank(loan.get(Loan.LOANBANKID));
		loanExtendsQuotaRequest.setDate(GeneralFunction.convertDateToString(
				extedsQuota.get(ExtendsQuota.EXTENDSDATE), true));
		loanExtendsQuotaRequest.setDateFormat(Parameter.CODEDATEFORMAT);

		request.addValue("inLoanExtendsQuotaRequest", loanExtendsQuotaRequest);
		ServiceResponse response = this.execute(logger,
				Parameter.PROCESSEXTENDSQUOTA, request);
		loansResponse(entities, response);
		extedsQuota.set(ExtendsQuota.NUMBERQUOTA, null);


	}

	private void loansResponse(DynamicRequest entities, ServiceResponse response) {
		try {

			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();
				if (resultado.isSuccess()) {

					LoanExtendsQuota[] itemsResponseArray = (LoanExtendsQuota[]) resultado
							.getValue("returnLoanExtendsQuota");

					DataEntityList actualList = entities
							.getEntityList(CurrentQuotas.ENTITY_NAME);
					actualList.clear();
					SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy"); 

					
					  DataEntityList listaLoanExtendsQuota = entities
					  .getEntityList(CurrentQuotas.ENTITY_NAME);
					 
					for (LoanExtendsQuota r : itemsResponseArray) {
						DataEntity item = new DataEntity();
						item.set(CurrentQuotas.QUOTA, r.getQuotaNumber());
						item.set(CurrentQuotas.STARTDATE, r.getStartDate());
						item.set(CurrentQuotas.ENDDATE, formatter.parse(r.getExpirationDate()));
						item.set(CurrentQuotas.CAPITAL, r.getCapitalPayment());
						item.set(CurrentQuotas.INTEREST, r.getInterestPayment());
						item.set(CurrentQuotas.OTHERS, r.getOthersPayment());
						item.set(CurrentQuotas.TOTAL, r.getFullPayment());
						item.set(CurrentQuotas.STATE, r.getState());
						listaLoanExtendsQuota.add(item);
					}
					
					
					

				}
			} else {
				String mensaje = GeneralFunction.getMessageError(
						response.getMessages(), null);
				logger.logError(mensaje);
			}
		} catch (Exception ex) {
			logger.logError("ERROR: " + ex);
		}

	}

}
