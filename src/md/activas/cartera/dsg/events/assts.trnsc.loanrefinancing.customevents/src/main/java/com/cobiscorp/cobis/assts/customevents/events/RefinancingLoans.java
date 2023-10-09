package com.cobiscorp.cobis.assts.customevents.events;

import java.math.BigDecimal;

import cobiscorp.ecobis.assets.cloud.dto.RenewalCurrency;
import cobiscorp.ecobis.assets.cloud.dto.RenewalDetail;
import cobiscorp.ecobis.assets.cloud.dto.RenewalProcedureConsulted;
import cobiscorp.ecobis.assets.cloud.dto.RenewalSelectedConcepts;
import cobiscorp.ecobis.assets.cloud.dto.SearchLoanRefinancingRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assets.commons.sessions.AssetsSessionManager;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanInstancia;
import com.cobiscorp.cobis.assts.model.RefinanceDetailLoans;
import com.cobiscorp.cobis.assts.model.RefinanceLoans;
import com.cobiscorp.cobis.assts.model.RefinanceLoansItems;
import com.cobiscorp.cobis.assts.model.RefinanceTransaction;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class RefinancingLoans extends BaseEvent implements IInitDataEvent {

	public RefinancingLoans(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	private static final ILogger logger = LogFactory
			.getLogger(RefinancingLoans.class);

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Start executeDataEvent - RL");
		}
		DataEntity loanInstance = entities.getEntity(LoanInstancia.ENTITY_NAME);
		DataEntity loanSession = (DataEntity) AssetsSessionManager.getLoan(loanInstance.get(LoanInstancia.IDINSTANCIA));
		if (loanSession != null) {
			entities.setEntity(Loan.ENTITY_NAME, loanSession);
		}
		RefinanceQuery(entities, arg1);
		if (getServiceIntegration() == null && logger.isDebugEnabled()) {
			logger.logInfo("getServiceIntegration is null - RL ");
		}
	}

	public void RefinanceQuery(DynamicRequest entities, IDataEventArgs arg1) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("RefinanceQuery - RL");
		}
		ServiceRequestTO request = new ServiceRequestTO();
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		SearchLoanRefinancingRequest refinanceRequest = new SearchLoanRefinancingRequest();
		refinanceRequest.setBanco(loan.get(Loan.LOANBANKID));
		if (logger.isDebugEnabled()) {
			logger.logDebug("inReadLoanAmortizationTableRequest - RL ");
		}
		request.addValue("inSearchLoanRefinancingRequest", refinanceRequest);
		ServiceResponse response = this.execute(logger,Parameter.PROCESSREFINANCELOANS, request);
		loansResponse(entities, response, arg1);
	}

	public void loansResponse(DynamicRequest entities,
			ServiceResponse response, IDataEventArgs arg1) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logInfo("loansResponse - RL0 >>");
			}
			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
				if (resultado.isSuccess()) {
					RenewalDetail[] itemsResponseArray = (RenewalDetail[]) resultado.getValue("returnRenewalDetail");
					RenewalCurrency[] itemsResponseCurrency = (RenewalCurrency[]) resultado.getValue("returnRenewalCurrency");
					RenewalSelectedConcepts[] itemsResponseConcepts = (RenewalSelectedConcepts[]) resultado.getValue("returnRenewalSelectedConcepts");
					RenewalProcedureConsulted[] itemsResponseConsulted = (RenewalProcedureConsulted[]) resultado.getValue("returnRenewalProcedureConsulted");
					
					BigDecimal acumulador = new BigDecimal(0);
					Integer cont_suspen = 0;
					String mensaje = "";
										
					//Grid Operaciones
					DataEntityList listaRenewalDetail = entities.getEntityList(RefinanceLoans.ENTITY_NAME);
					for (RenewalDetail r : itemsResponseArray) {
						DataEntity item = new DataEntity();
						item.set(RefinanceLoans.LOAN, r.getNroOperacion());
						item.set(RefinanceLoans.LINE, r.getLinea());
						item.set(RefinanceLoans.INITIALAMOUNT, r.getMontoOriginal());
						item.set(RefinanceLoans.TOTALTOREFINANCE, r.getTotalRenovar());
						item.set(RefinanceLoans.TOTALBALANCE, r.getSaldoTotal());
						item.set(RefinanceLoans.CURRENCYCODE, r.getMonedaOp());
						item.set(RefinanceLoans.QUOTATION, r.getCotizacion());
						acumulador = acumulador.add(r.getSaldoTotal());
						listaRenewalDetail.add(item);
						mensaje = mensaje + r.getNroOperacion().trim() + ", ";						
					}

					//Grid Rubros para Cancelar
					DataEntityList listaSelectedConcepts = entities.getEntityList(RefinanceLoansItems.ENTITY_NAME);
					for (RenewalSelectedConcepts t : itemsResponseConcepts) {
						DataEntity item = new DataEntity();
						item.set(RefinanceLoansItems.CONCEPT, t.getConcepto());
						item.set(RefinanceLoansItems.CONCEPTSTATUS,t.getEstadoConcepto());
						item.set(RefinanceLoansItems.PREVIOWSDUTY,t.getObligAnterior());
						item.set(RefinanceLoansItems.QUOTASTATUS,t.getEstadoCuota());
						listaSelectedConcepts.add(item);

						if (t.getEstadoConcepto().equals("SUSPENSO")){
							cont_suspen = cont_suspen + 1 ;
						}
					}

					if (cont_suspen == 0){
						mensaje = "";
					}

					//Data Operacion Renovar
					DataEntity renewalCurrency = entities.getEntity(RefinanceDetailLoans.ENTITY_NAME);
					for (RenewalCurrency s : itemsResponseCurrency) {
						renewalCurrency.set(RefinanceDetailLoans.LOANAMOUNT,s.getMonto());
						renewalCurrency.set(RefinanceDetailLoans.AMOUNTTOCANCEL,acumulador);
						renewalCurrency.set(RefinanceDetailLoans.DELIVERCUSTOMER, s.getMonto().subtract(acumulador));
						renewalCurrency.set(RefinanceDetailLoans.OBSERVATIONS,mensaje);
					}

					//Nro. Tramite
					DataEntity procedureConsulted = entities
							.getEntity(RefinanceTransaction.ENTITY_NAME);
					for (RenewalProcedureConsulted u : itemsResponseConsulted) {
						procedureConsulted.set(RefinanceTransaction.REFINANCETRANSACTIONINT,u.getTramite());
					}
					
				}
			} else {
				String mensaje = GeneralFunction.getMessageError(
						response.getMessages(), null);
				arg1.getMessageManager().showErrorMsg(mensaje);
			}

		} catch (Exception e) {
			logger.logError(e);
		}
	}
}
