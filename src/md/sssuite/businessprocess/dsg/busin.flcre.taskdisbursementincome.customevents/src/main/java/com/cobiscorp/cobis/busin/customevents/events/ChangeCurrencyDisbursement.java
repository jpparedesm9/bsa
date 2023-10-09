package com.cobiscorp.cobis.busin.customevents.events;

import java.math.BigDecimal;
import java.math.RoundingMode;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.QuoteRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterRequest;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.model.DisbursementIncome;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ChangeCurrencyDisbursement extends BaseEvent implements IChangedEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(ChangeCurrencyDisbursement.class);

	public ChangeCurrencyDisbursement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs arg1) {
		if(LOGGER.isDebugEnabled()){
			LOGGER.logDebug("Inicia ChangeCurrencyDisbursement");
		}
		try{
			BigDecimal balance = new BigDecimal(0);
			BigDecimal quotationOP = new BigDecimal(0);
			BigDecimal quotationDS = new BigDecimal(0);
			BigDecimal disbursementValue = new BigDecimal(0);
			BigDecimal disbursementValueDec = new BigDecimal(0);
			Double cotization = null;

			// Obteniendo el parametro de la moneda Local
			ServiceResponse serviceResponse = new ServiceResponse();
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			ServiceResponseTO serviceResponseTO = new ServiceResponseTO();

			ParameterRequest parameterRequest = new ParameterRequest();
			ParameterResponse parameterResponse = new ParameterResponse();
			parameterRequest.setMode(4);
			parameterRequest.setParameterNemonic("MLO");
			parameterRequest.setProductNemonic("ADM");
			
			LOGGER.logDebug(":>ChangeCurrencyDisbursement:> obteniendo el parametro de la moneda local");
			
			serviceRequestTO.getData().put(RequestName.INPARAMETERREQUEST, parameterRequest);
			serviceResponse = execute(getServiceIntegration(), LOGGER, ServiceId.PARAMETERMANAGEMENT, serviceRequestTO);
			String localMoney = null;
			
			if (serviceResponse.isResult()) {
				LOGGER.logDebug(":>ChangeCurrencyDisbursement:> Servicio Ok");
				serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
				parameterResponse = (ParameterResponse) serviceResponseTO.getValue(ReturnName.RETURNPARAMETERRESPONSE);
				localMoney = parameterResponse.getParameterValue();
			}

			DataEntity disbursementIncome = entities.getEntity(DisbursementIncome.ENTITY_NAME);
			TransactionManagement tranManager = new TransactionManagement(super.getServiceIntegration());
			QuoteRequest quoteRequest = new QuoteRequest();

			serviceResponse = new ServiceResponse();
			serviceRequestTO = new ServiceRequestTO();

			/* Consumo de Cotizacion de la moneda */
			serviceResponse = null;
			serviceRequestTO = new ServiceRequestTO();
			serviceResponseTO = new ServiceResponseTO();
					
			quoteRequest.setCurrencyOrigin(Integer.parseInt(disbursementIncome.get(DisbursementIncome.CURRENCY)));
			quoteRequest.setCurrencyDestination(Integer.parseInt(localMoney));

			// traer oficina
			quoteRequest.setOffice(1);
			quoteRequest.setModule(Mnemonic.MODULE);
			LOGGER.logDebug(":>ChangeCurrencyDisbursement:> envio a servicio de cotizacion");
			//if (disbursementIncome.get(DisbursementIncome.CURRENCY).equals(localMoney))
				cotization = tranManager.getQuote(quoteRequest, arg1, new BehaviorOption(true));
			/*else
				cotization = tranManager.getQuote(quoteRequest, arg1, new BehaviorOption(true));*/
					
			balance = new BigDecimal(disbursementIncome.get(DisbursementIncome.DISBURSEMENTVALUE));// disbursementIncome.get(DisbursementIncome.BALANCEOPERATION);
			quotationOP = disbursementIncome.get(DisbursementIncome.QUOTATIONOP);
			quotationDS = new BigDecimal(cotization);

			disbursementValue = (balance.multiply(quotationOP)).divide(quotationDS, 2, RoundingMode.HALF_UP);
			disbursementValueDec = (balance.multiply(quotationOP)).divide(quotationDS, 10, RoundingMode.HALF_UP);
			
			LOGGER.logDebug(":>ChangeCurrencyDisbursement:> Seteo de datos en la entidad");
			
			disbursementIncome.set(DisbursementIncome.QUOTATION, Double.parseDouble(cotization.toString()));
			disbursementIncome.set(DisbursementIncome.DISBURSEMENTVALUE, Double.parseDouble(disbursementValue.toString()));
			disbursementIncome.set(DisbursementIncome.DISBURSEMENTVALUEDEC, Double.parseDouble(disbursementValueDec.toString()));
			if (disbursementIncome.get(DisbursementIncome.CURRENCY).equals(disbursementIncome.get(DisbursementIncome.CURRENCYOP))) {
				disbursementIncome.set(DisbursementIncome.CURRENTBALANCE, new BigDecimal(disbursementIncome.get(DisbursementIncome.DISBURSEMENTVALUE)));
			} else {
				if (disbursementIncome.get(DisbursementIncome.CURRENCY).equals(localMoney)) {
					disbursementIncome.set(DisbursementIncome.CURRENTBALANCE, balance.divide(quotationDS, 2, RoundingMode.HALF_UP));
				} else {
					disbursementIncome.set(DisbursementIncome.CURRENTBALANCE, disbursementValueDec.multiply(quotationDS).setScale(2, BigDecimal.ROUND_HALF_UP));
				}
			}

			if (disbursementIncome.get(DisbursementIncome.CURRENCY) != localMoney) {
				disbursementIncome.set(DisbursementIncome.VALUEML,
						new BigDecimal(disbursementIncome.get(DisbursementIncome.DISBURSEMENTVALUEDEC)).multiply(new BigDecimal(cotization)).setScale(2, BigDecimal.ROUND_HALF_UP));
			} else {
				disbursementIncome.set(DisbursementIncome.VALUEML, new BigDecimal(disbursementIncome.get(DisbursementIncome.DISBURSEMENTVALUE)));
			}
			if(LOGGER.isDebugEnabled()){
				LOGGER.logDebug(":>ChangeCurrencyDisbursement:> Entidad cargada:>"+disbursementIncome.getData());
				LOGGER.logDebug("Finaliza ChangeCurrencyDisbursement");
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.DISBURSEMENTINCOME_CHANGE_CURRENCY, e, arg1, LOGGER);
		}
		
	}

}
