package com.cobiscorp.cobis.assts.customevents.events;

import java.math.BigDecimal;

import cobiscorp.ecobis.assets.cloud.dto.LoanPaymentRequest;
import cobiscorp.ecobis.assets.cloud.dto.LoanPaymentTotal;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.Negotiation;
import com.cobiscorp.cobis.assts.model.QuoteDetails;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IOnCloseModalEvent;
import com.cobiscorp.designer.api.customization.arguments.ICloseModalEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class PaymentCloseModalEvent extends BaseEvent implements IOnCloseModalEvent{

	private static final ILogger logger = LogFactory.getLogger(PaymentCloseModalEvent.class);
	
	public PaymentCloseModalEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void onCloseModalEvent(DynamicRequest entities, ICloseModalEventArgs closeModalEventArgs) {
		
		BigDecimal ex = new BigDecimal(0);
		BigDecimal ac = new BigDecimal(0);
		BigDecimal in = new BigDecimal(0);
		BigDecimal total = new BigDecimal(0);
		
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		DataEntity negotiation = entities.getEntity(Negotiation.ENTITY_NAME); 
		
		LoanPaymentRequest loanPaymentRequest = new LoanPaymentRequest();
		loanPaymentRequest.setPaymentType(negotiation.get(Negotiation.INTERESTTYPE));
		loanPaymentRequest.setCalculateReturn(negotiation.get(Negotiation.CALCULATERETURN));
		loanPaymentRequest.setPaymentTypeCan("A");
		loanPaymentRequest.setCancel("N");
		loanPaymentRequest.setDateFormat(Parameter.CODEDATEFORMAT);
		loanPaymentRequest.setBank(loan.get(Loan.LOANBANKID));
		
		serviceRequestTO.addValue("inLoanPaymentRequest", loanPaymentRequest);

		ServiceResponse serviceResponse = this.execute(logger,Parameter.PROCESS_QUERYLOANPAYMENT, serviceRequestTO);
		
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse
					.getData();
			if (serviceResponseTO.isSuccess()) {
				LoanPaymentTotal[] loanPaymentTotals = (LoanPaymentTotal[]) serviceResponseTO
						.getValue("returnLoanPaymentTotal");

				DataEntityList dataEntityList = new DataEntityList();
				
				for (LoanPaymentTotal loanPaymentTotal : loanPaymentTotals) {
					DataEntity dataEntity = new DataEntity();
					
					dataEntity.set(QuoteDetails.DESCRIPTION, loanPaymentTotal.getDescription().toUpperCase());
					dataEntity.set(QuoteDetails.EXPIRED, BigDecimal.valueOf(loanPaymentTotal.getBeaten()));
					dataEntity.set(QuoteDetails.ACTIVE, BigDecimal.valueOf(loanPaymentTotal.getValid()));
					dataEntity.set(QuoteDetails.INACTIVE, BigDecimal.valueOf(loanPaymentTotal.getRecono()));
					dataEntity.set(QuoteDetails.TOTAL, loanPaymentTotal.getTotal());
					
					ex = ex.add(BigDecimal.valueOf(loanPaymentTotal.getBeaten()));
					ac = ac.add(BigDecimal.valueOf(loanPaymentTotal.getValid()));
					in = in.add(BigDecimal.valueOf(loanPaymentTotal.getRecono()));
					total = total.add(loanPaymentTotal.getTotal());
					dataEntityList.add(dataEntity);
				}
				
				DataEntity dataEntity = new DataEntity();
				dataEntity.set(QuoteDetails.DESCRIPTION, "TOTAL");
				dataEntity.set(QuoteDetails.EXPIRED, ex);
				dataEntity.set(QuoteDetails.ACTIVE, ac);
				dataEntity.set(QuoteDetails.INACTIVE, in);
				dataEntity.set(QuoteDetails.TOTAL, total);
				dataEntityList.add(dataEntity);
				
				entities.setEntityList(QuoteDetails.ENTITY_NAME, dataEntityList);
				
			} else {
				String mensaje = GeneralFunction.getMessageError(
						serviceResponse.getMessages(), null);
				closeModalEventArgs.getMessageManager().showErrorMsg(mensaje);
			}
		}
	}

}
