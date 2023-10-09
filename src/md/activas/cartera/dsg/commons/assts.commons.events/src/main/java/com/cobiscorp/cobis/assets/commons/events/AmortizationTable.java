package com.cobiscorp.cobis.assets.commons.events;

import cobiscorp.ecobis.assets.cloud.dto.LoanSummaryResponse;
import cobiscorp.ecobis.assets.cloud.dto.ReadLoanAmortizationTableRequest;
import cobiscorp.ecobis.assets.cloud.dto.ReadLoanAmortizationTableResponse;
import cobiscorp.ecobis.assets.cloud.dto.ReadLoanAmortizationTableResponseTable;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Amortization;
import com.cobiscorp.cobis.assts.model.ConsolidatedLoanStatus;
import com.cobiscorp.cobis.assts.model.ItemsLoan;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class AmortizationTable extends BaseEvent {
	public AmortizationTable(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	private static final ILogger logger = LogFactory
			.getLogger(AmortizationTable.class);

	public void amortizationQuery(DynamicRequest entities) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingresa amortizationQuery >>>");
		}
		ServiceRequestTO request = new ServiceRequestTO();

		if (logger.isDebugEnabled()) {
			logger.logDebug("ENTIDADES>>>>: ");
			logger.logDebug(entities.getData());
		}

		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);

		ReadLoanAmortizationTableRequest amortRequest = new ReadLoanAmortizationTableRequest();

		amortRequest.setBank(loan.get(Loan.LOANBANKID));
		
		if (logger.isDebugEnabled()) {
			logger.logDebug("inReadLoanAmortizationTableRequest>>>>: ");
		}

		request.addValue("inReadLoanAmortizationTableRequest", amortRequest);

		ServiceResponse response = this.execute(getServiceIntegration(),
				logger, Parameter.PROCESSAMORTIZATIONTABLE, request);

		// llena la entidad de rubros
		itemsReponse (entities,response);

		// LLena la entidad de Amortizacion
		amortReponse(entities,response);
			
	}
	
	public void itemsReponse (DynamicRequest entities,ServiceResponse response) {
		try {
			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();
				if (logger.isDebugEnabled()) {
					logger.logInfo("resultado>>>>>" + resultado.toString());
				}

				ReadLoanAmortizationTableResponse[] itemsResponseArray = (ReadLoanAmortizationTableResponse[]) resultado
						.getValue("returnReadLoanAmortizationTableResponse");

				DataEntityList listaItem = new DataEntityList();
				for (ReadLoanAmortizationTableResponse r : itemsResponseArray) {
					DataEntity item = new DataEntity();
					item.set(ItemsLoan.CONCEPT, r.getConcept());
					item.set(ItemsLoan.DESCRIPTION, r.getDescription());

					listaItem.add(item);
				}
				entities.setEntityList(ItemsLoan.ENTITY_NAME, listaItem);
			}
		} catch (Exception e) {
			logger.logError(e);
		}
	
	}
	
	public void amortReponse (DynamicRequest entities,ServiceResponse response) {
		try {
			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();

				ReadLoanAmortizationTableResponseTable[] amortResponseArray = (ReadLoanAmortizationTableResponseTable[]) resultado
						.getValue("returnReadLoanAmortizationTableResponseTable");

				DataEntityList lista = new DataEntityList();
				for (ReadLoanAmortizationTableResponseTable amorrespont : amortResponseArray) {
					DataEntity item = new DataEntity();
					item.set(Amortization.SHARE, amorrespont.getDividend());
					item.set(Amortization.EXPIRATION, GeneralFunction
							.convertCalendarToDate(amorrespont
									.getExpirationDate()));
					item.set(Amortization.DAYS, amorrespont.getDays());
					item.set(Amortization.BALANCECAP, amorrespont.getBalance());
					item.set(Amortization.ITEMS1, amorrespont.getItem1());
					item.set(Amortization.ITEMS1, amorrespont.getItem1());
					item.set(Amortization.ITEMS2, amorrespont.getItem2());
					item.set(Amortization.ITEMS3, amorrespont.getItem3());
					item.set(Amortization.ITEMS4, amorrespont.getItem4());
					item.set(Amortization.ITEMS5, amorrespont.getItem5());
					item.set(Amortization.ITEMS6, amorrespont.getItem6());
					item.set(Amortization.ITEMS7, amorrespont.getItem7());
					item.set(Amortization.ITEMS8, amorrespont.getItem8());
					item.set(Amortization.ITEMS9, amorrespont.getItem9());
					item.set(Amortization.ITEMS10, amorrespont.getItem10());
					item.set(Amortization.ITEMS11, amorrespont.getItem11());
					item.set(Amortization.ITEMS12, amorrespont.getItem12());
					item.set(Amortization.ITEMS13, amorrespont.getItem13());
					item.set(Amortization.ITEMS14, amorrespont.getItem14());
					item.set(Amortization.ITEMS15, amorrespont.getItem15());
					item.set(Amortization.SHAREVALUE,
							amorrespont.getShareValue());
					item.set(Amortization.STATE, amorrespont.getState());
					item.set(Amortization.PORROGA, amorrespont.getPorroga());
					lista.add(item);
				}

				entities.setEntityList(Amortization.ENTITY_NAME, lista);
			}
		} catch (Exception e) {
			logger.logError(e);
		}
	}
	
	
	public void summaryAmortizationQuery(DynamicRequest entities) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingresa summaryAmortizationQuery >>>");
		}
		ServiceRequestTO request = new ServiceRequestTO();

		if (logger.isDebugEnabled()) {
			logger.logDebug("ENTIDADES>>>>: ");
			logger.logDebug(entities.getData());
		}

		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);

		ReadLoanAmortizationTableRequest amortRequest = new ReadLoanAmortizationTableRequest();

		amortRequest.setBank(loan.get(Loan.LOANBANKID));
		
		if (logger.isDebugEnabled()) {
			logger.logDebug("inReadLoanAmortizationTableRequest>>>>: ");
		}

		request.addValue("inReadLoanAmortizationTableRequest", amortRequest);

		//Obtener el resumen de la operacion
		ServiceResponse summaryResponse = this.execute(getServiceIntegration(),
				logger, Parameter.PROCESSLOANSUMMARY, request);
		
		// LLena la entidad de Amortizacion
		summaryResponse(entities,summaryResponse);
	}
	
	
	
	private void summaryResponse (DynamicRequest entities,ServiceResponse response) {
		try {
			if (response.isResult()) {
				
				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();
				DataEntityList lista = new DataEntityList(); 
				LoanSummaryResponse[] summaryResponse = (LoanSummaryResponse[]) resultado.getValue("returnLoanSummaryResponse");
				if (summaryResponse != null) {
					if (summaryResponse.length > 0) {
						for (LoanSummaryResponse responde : summaryResponse) {
							DataEntity consolidated = new DataEntity();
							consolidated.set(ConsolidatedLoanStatus.AMORTIZATIONSTATUS, responde.getStatus());
							consolidated.set(ConsolidatedLoanStatus.CAPITAL, responde.getCapital());
							consolidated.set(ConsolidatedLoanStatus.INTEREST, responde.getInterest());
							consolidated.set(ConsolidatedLoanStatus.ARREAR, responde.getArrear());
							consolidated.set(ConsolidatedLoanStatus.INTERESTARREAR, responde.getInterest());
							consolidated.set(ConsolidatedLoanStatus.OTHERITEMS, responde.getOthers());
							consolidated.set(ConsolidatedLoanStatus.TOTAL, responde.getTotal());
							consolidated.set(ConsolidatedLoanStatus.NUMBERPAYMENTS, responde.getNumberPayment());
							lista.add(consolidated);
							
							if (logger.isDebugEnabled()) {
								logger.logDebug("Valores Entidad>>>>: ");
								logger.logDebug("AMORTIZATIONSTATUS>>>>: " +  consolidated.get(ConsolidatedLoanStatus.AMORTIZATIONSTATUS));
								logger.logDebug("CAPITAL>>>>: " +  consolidated.get(ConsolidatedLoanStatus.CAPITAL));
								logger.logDebug("INTEREST>>>>: " +  consolidated.get(ConsolidatedLoanStatus.INTEREST));
								logger.logDebug("INTERESTARREAR>>>>: " +  consolidated.get(ConsolidatedLoanStatus.INTERESTARREAR));
								logger.logDebug("ARREAR>>>>: " +  consolidated.get(ConsolidatedLoanStatus.ARREAR));
								logger.logDebug("OTHERITEMS>>>>: " +  consolidated.get(ConsolidatedLoanStatus.OTHERITEMS));
								logger.logDebug("TOTAL>>>>: " +  consolidated.get(ConsolidatedLoanStatus.TOTAL));
								logger.logDebug("NUMBERPAYMENTS>>>>: " +  consolidated.get(ConsolidatedLoanStatus.NUMBERPAYMENTS));
							}
							
						}
						entities.setEntityList(ConsolidatedLoanStatus.ENTITY_NAME, lista);						
					}
				}
		
			}
		} catch (Exception e) {
			logger.logError(e);
		}
	}
	
}


