package com.cobiscorp.cobis.assts.customevents.events;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.assets.cloud.dto.LoanPaymentHeadboard;
import cobiscorp.ecobis.assets.cloud.dto.LoanPaymentPriorities;
import cobiscorp.ecobis.assets.cloud.dto.LoanPaymentRequest;
import cobiscorp.ecobis.assets.cloud.dto.LoanPaymentTotal;
import cobiscorp.ecobis.assets.cloud.dto.LoanPaymentValues;
import cobiscorp.ecobis.assets.cloud.dto.LoanResponse;
import cobiscorp.ecobis.assets.cloud.dto.LoanResponseRep;
import cobiscorp.ecobis.assets.cloud.dto.Product;
import cobiscorp.ecobis.assets.cloud.dto.ProductListRequest;
import cobiscorp.ecobis.assets.cloud.dto.ReadGlobalVariablesResponse;
import cobiscorp.ecobis.assets.cloud.dto.TrnDetailRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assets.commons.sessions.AssetsSessionManager;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanInstancia;
import com.cobiscorp.cobis.assts.model.Negotiation;
import com.cobiscorp.cobis.assts.model.Payment;
import com.cobiscorp.cobis.assts.model.Priorities;
import com.cobiscorp.cobis.assts.model.QuotationCurrency;
import com.cobiscorp.cobis.assts.model.QuoteDetails;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

public class InitPaymentManager extends BaseEvent implements IInitDataEvent, ILoadCatalog {

	private static final ILogger logger = LogFactory.getLogger(InitPaymentManager.class);

	public InitPaymentManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs dataEvents) {

		Map<String, Object> customParameters = dataEvents.getParameters().getCustomParameters();
		Map<String, Object> parameters = null;
		DataEntity loanSession = null;
		String screenCall = "";
		if (customParameters != null) {
			parameters = (Map<String, Object>) customParameters.get("parameters");
			if (parameters != null) {
				screenCall = (String) parameters.get("screenCall");
			}
		}
		DataEntity loanInstance = entities.getEntity(LoanInstancia.ENTITY_NAME);

		if (screenCall != null && screenCall.equals(Parameter.REFINANCE)) {
			loanSession = (DataEntity) AssetsSessionManager.getLoanRefinance(loanInstance.get(LoanInstancia.IDINSTANCIA));
		} else {
			loanSession = (DataEntity) AssetsSessionManager.getLoan(loanInstance.get(LoanInstancia.IDINSTANCIA));
		}
		if (loanSession != null) {
			entities.setEntity(Loan.ENTITY_NAME, loanSession);
		}

		priorityQuery(entities, dataEvents);
		negotiationQuery(entities);
		balanceCancellationQuery(entities);
		prepayRateQuery(entities);
		balancePrepaymentQuery(entities);
		paymentQuery(entities, dataEvents);
		quotationCurrencyQuery(entities);

	}

	public void negotiationQuery(DynamicRequest entities) {

		PaymentHeadboardEvent paymentHeadboardEvent = new PaymentHeadboardEvent(getServiceIntegration());

		LoanPaymentHeadboard headboard = paymentHeadboardEvent.paymentHeadboar(entities);
		if (headboard == null) {
			return;
		}

		DataEntity negotiation = entities.getEntity(Negotiation.ENTITY_NAME);
		DataEntity payment = entities.getEntity(Payment.ENTITY_NAME);
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);

		boolean fullFee = "S".equals(headboard.getFullFee()) ? true : false;
		boolean acceptAdvances = "S".equals(headboard.getAcceptAdvances()) ? true : false;

		negotiation.set(Negotiation.FULLFEE, fullFee);
		negotiation.set(Negotiation.ADDITIONALPAYMENTS, acceptAdvances);
		negotiation.set(Negotiation.INTERESTTYPE, headboard.getReceiveType());
		negotiation.set(Negotiation.PAYMENTTYPE, headboard.getApplicationType());
		negotiation.set(Negotiation.CALCULATERETURN, headboard.getCalculateReturn());
		negotiation.set(Negotiation.REDUCTIONTYPE, headboard.getReductionType());

		Date lastProcecessDate = GeneralFunction.convertStringToDate(headboard.getDateUltProcess(), Parameter.TYPEDATEFORMAT.DDMMYYYY);

		payment.set(Payment.CURRENCYTYPE, headboard.getCurrency());
		payment.set(Payment.OPERATIONCURRENCYTYPE, headboard.getCurrency());
		payment.set(Payment.DATE, lastProcecessDate);
		payment.set(Payment.ENTIREFEE, headboard.getFullFee());
		payment.set(Payment.ADVANCE, headboard.getAcceptAdvances());
		loan.set(Loan.LASTPROCESSDATE, headboard.getDateUltProcess());

	}

	public void balanceCancellationQuery(DynamicRequest entities) {

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		DataEntity payment = entities.getEntity(Payment.ENTITY_NAME);
		LoanPaymentRequest loanPaymentRequest = new LoanPaymentRequest();

		loanPaymentRequest.setDateFormat(103);
		loanPaymentRequest.setBank(loan.get(Loan.LOANBANKID));

		serviceRequestTO.addValue("inLoanPaymentRequest", loanPaymentRequest);
		ServiceResponse serviceResponse = this.execute(logger, Parameter.PROCESS_LOAN_PAYMENT, serviceRequestTO);

		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTO.isSuccess()) {
				LoanResponse[] loanResponse = (LoanResponse[]) serviceResponseTO.getValue("returnLoanResponse");
				if (loanResponse != null) {
					for (LoanResponse l : loanResponse) {
						payment.set(Payment.AMOUNT, l.getAmount());
					}
				}
			}
		}
	}

	public void prepayRateQuery(DynamicRequest entities) {

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		DataEntity payment = entities.getEntity(Payment.ENTITY_NAME);
		LoanPaymentRequest loanPaymentRequest = new LoanPaymentRequest();

		loanPaymentRequest.setDateFormat(103);
		loanPaymentRequest.setBank(loan.get(Loan.LOANBANKID));

		serviceRequestTO.addValue("inLoanPaymentRequest", loanPaymentRequest);
		ServiceResponse serviceResponse = this.execute(logger, Parameter.PROCESS_LOAN_PAYMENT, serviceRequestTO);

		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTO.isSuccess()) {
				LoanPaymentValues[] prepayRate = (LoanPaymentValues[]) serviceResponseTO.getValue("returnLoanPaymentValues");
				if (prepayRate != null) {
					for (LoanPaymentValues p : prepayRate) {
						payment.set(Payment.PREPAYRATE, p.getPercentage());
					}
				}
			}
		}
	}

	public void balancePrepaymentQuery(DynamicRequest entities) {

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		DataEntity payment = entities.getEntity(Payment.ENTITY_NAME);
		LoanPaymentRequest loanPaymentRequest = new LoanPaymentRequest();

		loanPaymentRequest.setDateFormat(103);
		loanPaymentRequest.setBank(loan.get(Loan.LOANBANKID));

		serviceRequestTO.addValue("inLoanPaymentRequest", loanPaymentRequest);
		ServiceResponse serviceResponse = this.execute(logger, Parameter.PROCESS_LOAN_PAYMENT, serviceRequestTO);

		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTO.isSuccess()) {
				LoanResponseRep[] loanResponseRep = (LoanResponseRep[]) serviceResponseTO.getValue("returnLoanResponseRep");
				if (loanResponseRep != null) {
					for (LoanResponseRep l : loanResponseRep) {
                        payment.set(Payment.FINEPREPAYMENT, l.getPrepaymentFine());
						payment.set(Payment.AMOUNTPREPAYMENT, l.getPrepaymentAmount());
					}
				}
			}
		}
	}
	
	public void quotationCurrencyQuery(DynamicRequest entities) {

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		DataEntityList quotationCurrencyList = entities.getEntityList(QuotationCurrency.ENTITY_NAME);
		TrnDetailRequest trnDetailRequest = new TrnDetailRequest();

		Date lastProcecessDate = GeneralFunction.convertStringToDate(loan.get(Loan.LASTPROCESSDATE), Parameter.TYPEDATEFORMAT.DDMMYYYY);
		Calendar calendar = Calendar.getInstance();
		if (lastProcecessDate != null) {
			calendar.setTime(lastProcecessDate);
			trnDetailRequest.setDateValue(calendar);
		}

		serviceRequestTO.addValue("inTrnDetailRequest", trnDetailRequest);
		ServiceResponse serviceResponse = this.execute(logger, "Loan.ReadDisbursementForm.ReadGlobalVariablesSearch", serviceRequestTO);

		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();

			if (serviceResponseTO.isSuccess()) {

				ReadGlobalVariablesResponse[] readGlobalVariablesResponse = (ReadGlobalVariablesResponse[]) serviceResponseTO.getValue("returnReadGlobalVariablesResponse");

				for (ReadGlobalVariablesResponse q : readGlobalVariablesResponse) {
					DataEntity quotationCurrency = new DataEntity();
					quotationCurrency.set(QuotationCurrency.CURRENCYTYPE, q.getCurrency());
					quotationCurrency.set(QuotationCurrency.DATE, q.getDate().getTime());
					quotationCurrency.set(QuotationCurrency.VALUE, BigDecimal.valueOf(q.getAmount()));
					quotationCurrency.set(QuotationCurrency.RESULT, q.getDecimalNumber());
					quotationCurrencyList.add(quotationCurrency);
				}
				entities.setEntityList(QuotationCurrency.ENTITY_NAME, quotationCurrencyList);
			}
		}
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs catalogDataEventArgs) {
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		List<ItemDTO> lista = new ArrayList<ItemDTO>();
		ProductListRequest productListRequest = new ProductListRequest();
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse;
		productListRequest.setLineaCre(loan.get(Loan.OPERATIONTYPEID));
		productListRequest.setMoneda(0);
		productListRequest.setOperacion('A');
		productListRequest.setTipo(2);
		serviceRequestTO.addValue("inProductListRequest", productListRequest);
		serviceResponse = this.execute(logger, Parameter.PROCESS_QUERYPRODUCTLIST, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTO.isSuccess()) {
				Product[] products = (Product[]) serviceResponseTO.getValue("returnProduct");
				for (Product product : products) {
					ItemDTO itemDTO = new ItemDTO();
					itemDTO.setCode(product.getProducto().trim());
					itemDTO.setValue(product.getDescripcion().trim());
					lista.add(itemDTO);
				}
			}
		} else {
			String mensaje = GeneralFunction.getMessageError(serviceResponse.getMessages(), null);
			catalogDataEventArgs.getMessageManager().showErrorMsg(mensaje);
		}
		return lista;

	}

	public void paymentQuery(DynamicRequest entities, IDataEventArgs dataEventArgs) {

		// SUMATORIAS DETALLE DE CUOTA
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

		ServiceResponse serviceResponse = this.execute(logger, Parameter.PROCESS_QUERYLOANPAYMENT, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTO.isSuccess()) {
				LoanPaymentTotal[] loanPaymentTotals = (LoanPaymentTotal[]) serviceResponseTO.getValue("returnLoanPaymentTotal");

				DataEntityList dataEntityList = entities.getEntityList(QuoteDetails.ENTITY_NAME);
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
			} else {
				String mensaje = GeneralFunction.getMessageError(serviceResponse.getMessages(), null);
				dataEventArgs.getMessageManager().showErrorMsg(mensaje);
			}
		}
	}

	public void priorityQuery(DynamicRequest entities, IDataEventArgs dataEventArgs) {

		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		LoanPaymentRequest loanPaymentRequest = new LoanPaymentRequest();
		loanPaymentRequest.setPaymentType("A");
		loanPaymentRequest.setPaymentTypeCan("A");
		loanPaymentRequest.setCancel("N");
		loanPaymentRequest.setDateFormat(Parameter.CODEDATEFORMAT);
		loanPaymentRequest.setBank(loan.get(Loan.LOANBANKID));

		serviceRequestTO.addValue("inLoanPaymentRequest", loanPaymentRequest);
		ServiceResponse serviceResponse = this.execute(logger, Parameter.PROCESS_QUERYLOANPAYMENT, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTO.isSuccess()) {
				LoanPaymentPriorities[] loanPaymentPriorities = (LoanPaymentPriorities[]) serviceResponseTO.getValue("returnLoanPaymentPriorities");
				// GRID PRIORITIES
				DataEntityList dataEntityList = new DataEntityList();

				for (LoanPaymentPriorities r : loanPaymentPriorities) {
					DataEntity item = new DataEntity();
					item.set(Priorities.ITEM, r.getDescription());
					item.set(Priorities.PRIORITY, r.getPriority());
					dataEntityList.add(item);
				}
				entities.setEntityList(Priorities.ENTITY_NAME, dataEntityList);
			}
		} else {
			String mensaje = GeneralFunction.getMessageError(serviceResponse.getMessages(), null);
			dataEventArgs.getMessageManager().showErrorMsg(mensaje);
		}
	}

}
